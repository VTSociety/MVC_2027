%
% Parameter of the Energy Management & Motion Control Strategy
%
% 
if (control_strategy == 1)
    flag.DYC = 0; flag.current = 0;
end
if (control_strategy == 2)
    flag.DYC = 1; flag.current = 1;
end
% "1": Baseline strategy (BS): 
% The vehicle is controlled by active front steering
% The torque distribution ratios: tdis_FR = tdis_FL = 0.27; 
%                                 tdis_RR = tdis_RL = 0.23
%                            (No yaw moment control is applied)
% The d-axis currents of all motors are zero

% "2": Improved strategy (IS):
% The vehicle is controlled by active front steering
% In addition, yaw moment control is applied to distribute motor torques
% The d-axis currents are calculated to reduce the motor losses, 
% under the assumption that the salient coefficient of motor is
% approximately by 1 (Morimoto, 1994).
% S. Morimoto, Y. Tong, Y. Takeda, and T. Hirasa, "Loss Minimization 
% Control of Permanent Magnet Synchronous Motor Drives," IEEE 
% Transactions on Industrial Electronics, Vol. 41, No. 5, pp. 511-517, 1994

%

% 1. Active front steering
Steer.Kp_pos =  0.02;                      % P gain of the lateral position control via front steering
Steer.Kp_yaw =  0.2;                       % P gain of the yaw angle control control via front steering

% 2. Yaw moment control (Improved strategy)
DYC.Kp_pos   =  4000;                      % P gain of lateral position control via DYC
DYC.Ki_pos   =  20;                        % I gain of lateral position control via DYC
DYC.Kd_pos   =  1000;                      % D gain of lateral position control via DYC
DYC.Taud_pos =  0.005;                     % Time constant of Derivative terms
DYC.Kp_yaw   =  5000;                      % P gain of yaw angle control via DYC

% 3. Torque distribution (Baseline strategy)
tdis_FR      =  0.27;                      % torque distribution gain (front right)
tdis_FL      =  0.27;                      % torque distribution gain (front left)
tdis_RR      =  0.23;                      % torque distribution gain (rear right)
tdis_RL      =  1 - (tdis_FR + tdis_FL + tdis_RR);  % torque distribution gain (rear left)
