%
% Parameter of the simulator

% 1. Constant
g            =  9.81;                      % acceleration of gravity [m/s^2]
pi           =  3.14;                      % number pi
eps          =  0.05;                      % small value for anti-division-by-zero in slip ratio model
%

%
% 2. Vehicle body parameter
Vehicle.M    =  880;                       % total mass [kg]
Vehicle.I    =  617.0;                     % yaw moment of inertia [kg.m^2]
Vehicle.lf   =  0.988;                     % distance from CG to front axle [m]
Vehicle.lr   =  0.712;                     % distance from CG to rear axle [m]
Vehicle.l    =  Vehicle.lf + Vehicle.lr;   % wheelbase [m]
Vehicle.d    =  1.3;                       % track width 
Vehicle.df   =  Vehicle.d;                 % track width (front) [m]
Vehicle.dr   =  Vehicle.d;                 % track width (rear) [m]
Vehicle.hg   =  0.46;                      % height of CG [ m ]
Vehicle.mu0  =  0.0128;                    % rolling-friction resistance
Vehicle.rho  =  1.205;                     % air density 
Vehicle.Cd   =  0.48;                      % drag coefficient
Vehicle.Afpa =  2.4;                       % frontal projected area [m^2]
Vehicle.Nf   =  (Vehicle.M/2)*g*Vehicle.lr/Vehicle.l;  % nominal load (front) [N]
Vehicle.Nr   =  (Vehicle.M/2)*g*Vehicle.lf/Vehicle.l;  % nominal load (rear) [N]

% 3. Wheel parameter
Wheel.R      =  0.302;                     % wheel radius [m] 
Wheel.Jw_f   =  1.24;                      % wheel inertia (front) [kgm^2]
Wheel.Jw_r   =  1.26;                      % wheel inertia (rear) [kgm^2]

% 4. Steering model
EPS.tau      =  0.01;                      % time constant of the EPS [s]
EPS.Del_max  =  (pi/3)/20;                 % maximum steering angle [rad]


% 5. Motor parameter
% Remark 1: The transfer function from torque command to actual torque is simplified
% as 1/(Tm*s + 1)
% Remark 2: The equivalent core-loss resistance is given as
% (1/Rc) = (1/Rce) + [1/(Rch*sqrt(w_e))
% where w_e is the electrical angular velocity
Motor.Tmax_f =  500;                       % maximum torque (front) [N.m]
Motor.Tmax_r =  530;                       % maximum torque (rear) [N.m]
Motor.Ra_f   =  0.086;                     % armature winding resistance (front) [Ohm]
Motor.Ra_r   =  0.143;                     % armature winding resistance (rear) [Ohm]
Motor.Rce_f  =  300.13;                    % eddy current loss resistance (front) [Ohm]
Motor.Rce_r  =  300.15;                    % eddy current loss resistance (rear) [Ohm]
Motor.Psi_f  =  0.18;                      % inter-linkage magnetic flux (front) [Wb]
Motor.Psi_r  =  0.125;                     % inter-linkage magnetic flux (rear) [Wb]
Motor.pn_f   =  10;                        % number of pole pairs (front)
Motor.pn_r   =  12;                        % number of pole pairs (rear)
Motor.Lq_f   =  0.00069;                   % q-axis inductance (front) [H]
Motor.Lq_r   =  0.00150;                   % q-axis inductance (rear) [H]
Motor.Ld_f   =  0.00063;                   % d-axis inductance (front) [H]
Motor.Ld_r   =  0.00130;                   % d-axis inductance (rear) [H]
Motor.rho_f  =  Motor.Lq_f/Motor.Ld_f;     % salient coefficient (front)
Motor.rho_r  =  Motor.Lq_r/Motor.Ld_r;     % salient coefficient (rear)
Motor.tau    =  0.01;                      % time constant of the dynamics from torque command to actual torque [s]

% 6. Control parameter
Ctl.rho      =  -0.8;                      % Pole of the vehicle velocity control loop
Ctl.Kp_v     =  -2*Ctl.rho*Vehicle.M;      % P gain of vehicle velocity controller
Ctl.Ki_v     =  ((Ctl.rho)^2)*Vehicle.M;   % I gain of vehicle velocity controller
Ctl.tau_ff_v =  0.01;                      % time constant of feed forward velocity controller [s]
Ctl.Fmax = 2*(Motor.Tmax_f+Motor.Tmax_r)/Wheel.R;  % maximum driving force command [N]

% 7. Simulation setting
Sim.Tsim     =  120;                       % simulation time [s]
Sim.Ts       =  0.0002;                    % sampling time [s]
Sim.Ini_V    =  0;                         % initial vehicle velocity [m/s]
Sim.Ini_W    =  (Sim.Ini_V/Wheel.R);       % initial wheel rotational velocity [rad]
Sim.Ini_YR   =  0;                         % initial yaw-rate [rad/s]
Sim.Ini_Yaw  =  0;                         % initial yaw angle [rad]
Sim.Ini_X    =  0;                         % initial X position [m]
Sim.Ini_Y    =  0;                         % initial Y position [m]

% 8. Dynamic wireless power transfer
% Mutual inductance
x = [-400 -350 -300 -250 -200 -150 -100 -50 0 50 100 150 200 250 300 350 400]; % mm
y = [-150 -100 -50 0 50 100 150]; % mm
z000 = [18.366 18.12075 18.2285 18.62175 19.4505 22.78625 21.99725 18.1625 12.584];
z050 = [16.16075 15.495 15.44675 15.71575 18.70275 19.3575 18.8615 15.5565 10.6605];
z100 = [9.85675 9.60925 10.05325 10.28375 11.30575 13.352 13.16575 10.59525 6.935];
z150 = [4.81875 4.1325 4.1535 5.24425 6.22225 7.28925 6.64025 5.4515 3.44175];
z000f = flip(z000); z050f = flip(z050); z100f = flip(z100); z150f = flip(z150); 
z000f(9) = []; z050f(9) = []; z100f(9) = []; z150f(9) = [];
z = [z150f z150;
     z100f z100;
     z050f z050;
     z000f z000;
     z050f z050;
     z100f z100;
     z150f z150];          % mutual inductance map [uH]
WPT.freq = 85000;          % Frequency of the inverter [Hz]
WPT.L1 = 142.326e-6;       % GA coil inductance [H]
WPT.L2 = 54.2047e-6;       % VA coil inductance [H]
WPT.R1 = 85.02/1000;       % GA coil resistance [Ohm]
WPT.R2 = 39.88/1000;       % VA coil resistance [Ohm]
WPT.P  = 10000;            % Rated power of the DWPT system [W]
[X, Y] = meshgrid(x, y);
figure
contourf(X, Y, z, 20, 'LineColor','none')
colorbar
xlabel('x (mm)')
ylabel('y (mm)')
title('Mutual Inductance (Filled Contour)')
axis equal