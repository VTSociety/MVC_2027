function [sys,x0,str,ts] = sfuntmpl(t,x,u,flag)
%SFUNTMPL General M-file S-function template
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
%      in "A Proposition of the Simple Tire Model for the Vehicle Stability 
%          Assist System," Proceedings of Spring Congress
%          of Society of Automotive Engineers of Japan, No. 64-98 (1998).
%
switch flag,

  %%%%%%%%%%%%%%%%%%
  % Initialization %
  %%%%%%%%%%%%%%%%%%
  case 0,
    [sys,x0,str,ts]=mdlInitializeSizes;

  %%%%%%%%%%%%%%%
  % Derivatives %
  %%%%%%%%%%%%%%%
  case 1,
    sys=mdlDerivatives(t,x,u);

  %%%%%%%%%%
  % Update %
  %%%%%%%%%%
  case 2,
    sys=mdlUpdate(t,x,u);

  %%%%%%%%%%%
  % Outputs %
  %%%%%%%%%%%
  case 3,
    sys=mdlOutputs(t,x,u);

  %%%%%%%%%%%%%%%%%%%%%%%
  % GetTimeOfNextVarHit %
  %%%%%%%%%%%%%%%%%%%%%%%
  case 4,
    sys=mdlGetTimeOfNextVarHit(t,x,u);

  %%%%%%%%%%%%%
  % Terminate %
  %%%%%%%%%%%%%
  case 9,
    sys=mdlTerminate(t,x,u);

  %%%%%%%%%%%%%%%%%%%%
  % Unexpected flags %
  %%%%%%%%%%%%%%%%%%%%
  otherwise
    error(['Unhandled flag = ',num2str(flag)]);

end

% end sfuntmpl

%
%=============================================================================
% mdlInitializeSizes
% Return the sizes, initial conditions, and sample times for the S-function.
%=============================================================================
%
function [sys,x0,str,ts]=mdlInitializeSizes

%
% call simsizes for a sizes structure, fill it in and convert it to a
% sizes array.
%
% Note that in this example, the values are hard coded.  This is not a
% recommended practice as the characteristics of the block are typically
% defined by the S-function parameters.
%
sizes = simsizes;

sizes.NumContStates  = 0;
sizes.NumDiscStates  = 0;
sizes.NumOutputs     = 3;
sizes.NumInputs      = 5;
sizes.DirFeedthrough = 1;
sizes.NumSampleTimes = 1;   % at least one sample time is needed

sys = simsizes(sizes);

%
% initialize the initial conditions
%
x0  = [];

%
% str is always an empty matrix
%
str = [];

%
% initialize the array of sample times
%
ts  = [0 0];

% end mdlInitializeSizes

%
%=============================================================================
% mdlDerivatives
% Return the derivatives for the continuous states.
%=============================================================================
%
function sys=mdlDerivatives(t,x,u)

sys = [];

% end mdlDerivatives

%
%=============================================================================
% mdlUpdate
% Handle discrete state updates, sample time hits, and major time step
% requirements.
%=============================================================================
%
function sys=mdlUpdate(t,x,u)

sys = [];

% end mdlUpdate

%
%=============================================================================
% mdlOutputs
% Return the block outputs.
%=============================================================================
%
function sys=mdlOutputs(t,x,u)
	V = u(1); Vw = u(2); alpha  = u(3); mu = u(4); Fz = u(5);
	abs_V = abs(V);
	if (abs_V < 0.05)
        if( abs(Vw)<0.05 )   
            lambda_x = 0;
            Fx = 0;
            Fy = 0;
            sys = [Fx,Fy,lambda_x];
            return;
        else 
            lambda_x = 1.0;
            % Magic Formula for Fx
            B = 10; C = 1.9; D = 1; E = 0.97;
            tmp1 = B * (1-E) * 1 ...
                    + E * atan(B*1);
            tmp2 = C * atan(tmp1);
            Fx    = D * sin(tmp2);

            Fx = Fx*mu*Fz;
            Fy = 0;
            sys = [Fx,Fy,lambda_x];
            return;
        end
	else 
        K = abs(Vw)/abs_V;
        A  = [cos(alpha), -sin(alpha); sin(alpha), cos(alpha)];
        V_vec = A*[V,0]';
        Vw_vec = [Vw,0]';
        Vs = Vw_vec-V_vec;
        lambda = Vs/max(norm(V_vec),norm(Vw_vec)); 
        norm_lambda = norm(lambda);

        if (norm_lambda>1.0) 
            norm_lambda=1.0;
        end
    
        if abs(Vs(1)) < 10^-6
            lambda_x = 0;
            Fx = 0;
            Fy = 0;
        else
            lambda_x = Vs(1)/max( abs(V_vec(1)), abs(Vw_vec(1)) );
            if abs(lambda_x) > 1.0
                if sign(lambda_x)>0.0
                    lambda_x = 1.0;
                else
                    lambda_x = -1.0;
                end
            end
      
            % Magic Formula for Fx
            B = 10; C = 1.9; D = 1; E = 0.97;
            tmp1 = B * (1-E) * norm_lambda ...
                    + E * atan(B*norm_lambda);
            tmp2 = C * atan(tmp1);
            F    = mu*Fz* D * sin(tmp2)*Vs/norm(Vs);
            Fx   = F(1);

            % Magic Formula for Fy
            tmp1 = B * (1-E) * norm_lambda ...
                    + E * atan(B*norm_lambda);
            tmp2 = C * atan(tmp1);
            F    = mu*Fz* D * sin(tmp2)*Vs/norm(Vs);
            Fy   = F(2); 
        end
	end

sys = [Fx,Fy,lambda_x];

% end mdlOutputs

%
%=============================================================================
% mdlGetTimeOfNextVarHit
% Return the time of the next hit for this block.  Note that the result is
% absolute time.  Note that this function is only used when you specify a
% variable discrete-time sample time [-2 0] in the sample time array in
% mdlInitializeSizes.
%=============================================================================
%
function sys=mdlGetTimeOfNextVarHit(t,x,u)

sampleTime = 1;    %  Example, set the next hit to be one second later. 
sys = t + sampleTime;

% end mdlGetTimeOfNextVarHit

%
%=============================================================================
% mdlTerminate
% Perform any end of simulation tasks.
%=============================================================================
%
function sys=mdlTerminate(t,x,u)

sys = [];

% end mdlTerminate
