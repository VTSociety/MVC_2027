function LambdaMethod(block)
%LambdaMethod Level-2 S-function
%      2D Tire Model Based on Lambda-Method.    
%      This S-Function is to caluclate the
%      Longtitudal (Driving) Force Fx 
%      and Lateral Force Fy
%      
%      based on the Magic Formula, proposed by H. B. Pacejka
%      in "Tire and Vehicle Dynamics," 
%      Elsevier Science, 2005.
%      
%      and based on the "Lambda Method", proposed by Y. Horiuchi.
%      in "A Proposition of the Simple Tire Model for the Vehicle Stability Assist System," 
%      Proceedings of Spring Congress
%      of Society of Automotive Engineers of Japan, No. 64-98 (1998).
%

setup(block);

% =========================================================================
% S-Function Initial Setup
% =========================================================================
function setup(block)

  % Register number of input and output ports
  block.NumInputPorts  = 1; % 1 vector input port (width 5)
  block.NumOutputPorts = 1; % 1 vector output port (width 3)

    % Set default port properties to dynamic
  block.SetPreCompInpPortInfoToDynamic;
  block.SetPreCompOutPortInfoToDynamic;

  % Input port configuration: [V, Vw, alpha, mu, Fz]
  block.InputPort(1).Dimensions        = 5;
  block.InputPort(1).DatatypeID        = 0; % double
  block.InputPort(1).Complexity        = 'Real';
  block.InputPort(1).DirectFeedthrough = true;

  % Output port configuration: [Fx, Fy, lambda_x]
  block.OutputPort(1).Dimensions       = 3;
  block.OutputPort(1).DatatypeID       = 0; % double
  block.OutputPort(1).Complexity       = 'Real';

  % Block parameters (no dialog parameters)
  block.NumDialogPrms     = 0;

  % Continuous sample time [0, 0]
  block.SampleTimes = [0 0];

  % Register simulation methods
  block.SimStateCompliance = 'DefaultSimState';
  block.RegBlockMethod('Outputs',   @Outputs);
  block.RegBlockMethod('Terminate', @Terminate);

% =========================================================================
% Compute Outputs
% =========================================================================
function Outputs(block)

  % Inputs: u = [V, Vw, alpha, mu, Fz]
  u     = block.InputPort(1).Data;
  V     = u(1);
  Vw    = u(2);
  alpha = u(3);
  mu    = u(4);
  Fz    = u(5);

  abs_V = abs(V);
  
  if (abs_V < 0.05)
      if (abs(Vw) < 0.05)
          lambda_x = 0;
          Fx       = 0;
          Fy       = 0;
      else
          lambda_x = 1.0;
          
          % Magic Formula for Fx
          B    = 10; C = 1.9; D = 1; E = 0.97;
          tmp1 = B * (1-E) * 1 + E * atan(B*1);
          tmp2 = C * atan(tmp1);
          Fx   = D * sin(tmp2);

          Fx   = Fx * mu * Fz;
          Fy   = 0;
      end
  else
      A      = [cos(alpha), -sin(alpha); sin(alpha), cos(alpha)];
      V_vec  = A * [V; 0];
      Vw_vec = [Vw; 0];
      Vs     = Vw_vec - V_vec;
      
      lambda      = Vs / max(norm(V_vec), norm(Vw_vec));
      norm_lambda = norm(lambda);

      if (norm_lambda > 1.0)
          norm_lambda = 1.0;
      end

      if abs(Vs(1)) < 1e-6
          lambda_x = 0;
          Fx       = 0;
          Fy       = 0;
      else
          lambda_x = Vs(1) / max(abs(V_vec(1)), abs(Vw_vec(1)));
          if abs(lambda_x) > 1.0
              if sign(lambda_x) > 0.0
                  lambda_x = 1.0;
              else
                  lambda_x = -1.0;
              end
          end

          % Magic Formula for Fx and Fy
          B    = 10; C = 1.9; D = 1; E = 0.97;
          tmp1 = B * (1-E) * norm_lambda + E * atan(B*norm_lambda);
          tmp2 = C * atan(tmp1);
          F    = mu * Fz * D * sin(tmp2) * Vs / norm(Vs);
          
          Fx   = F(1);
          Fy   = F(2);
      end
  end

  % Assign results to output port: [Fx; Fy; lambda_x]
  block.OutputPort(1).Data = [Fx; Fy; lambda_x];

% =========================================================================
% Simulation Termination (Terminate)
% =========================================================================
function Terminate(block)
  % No cleanup operations required