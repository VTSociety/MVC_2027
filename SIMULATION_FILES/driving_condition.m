%
% Driving condition of the vehicle
%

% 1. Road condition
% Road.flag    =  1;                        % flag = 1: mu-change
% Road.flag    =  0;                        % flag = 0; high-mu only
Road.Mu_h    =  0.85;                       % friction coefficient (high)
Road.Mu_l    =  0.25;                       % friction coefficient (low)
Road.Mu_m    =  0.60;                       % friction coefficient (medium)
Road.L_in    =  12.5;                       % position the vehicle enters the low-friction-surface [m]
Road.L_out   =  42.5;                       % position the vehicle leaves the low-friction-surface [m]
Road.M_in    =  1976.99;                    % position the vehicle enters the medium-friction-surface [m]
Road.M_out   =  2011.03;                    % position the vehicle leaves the medium-friction-surface [m]

% 2. Lateral wind disturbance
Wind.time_start = 45;                       % starting time [s]
Wind.time_stop  = 55;                       % stoping time [s]
Wind.force      = 1600;                     % wind lateral force [N]
Wind.moment     = 160;                      % wind lateral moment [N.m]