%
% Calculation of the scoring
%

Ts = Sim.Ts;

%% Phi1: Drivetrain energy consumption [Wh]
P_all = simout.P_in;   % [W]

Phi1 = sum(P_all) * Ts / 3600;   % [Wh]


%% Phi2: Safe traction - wheel slip penalty [s]
lambda_FL = simout.lambda_FL;
lambda_FR = simout.lambda_FR;
lambda_RL = simout.lambda_RL;
lambda_RR = simout.lambda_RR;

Phi2 = sum(lambda_FL.^2 + ...
           lambda_FR.^2 + ...
           lambda_RL.^2 + ...
           lambda_RR.^2) * Ts;


%% Phi3: DWPT efficiency penalty [s]
eta_DWPT = simout.DWPT_efficient / 100;

Phi3 = sum((1 - eta_DWPT).^2) * Ts;


%% Phi4: Driving comfort - lateral acceleration penalty [m^2/s^3]
ay = simout.ay;   % [m/s^2]

Phi4 = sum(ay.^2) * Ts;


%% Total score
Phi = sigma(1)*Phi1 + ...
      sigma(2)*Phi2 + ...
      sigma(3)*Phi3 + ...
      sigma(4)*Phi4;


%% Determine control strategy name
if control_strategy == 1
    strategy_name = 'Baseline Strategy';
    strategy_file = 'Baseline';

elseif control_strategy == 2
    strategy_name = 'Improved Strategy';
    strategy_file = 'Improved';

else
    strategy_name = sprintf('Strategy %d', control_strategy);
    strategy_file = sprintf('Strategy_%d', control_strategy);
end


%% Date and time of simulation
simulation_datetime = datetime('now');

% String used in the output file
datetime_display = datestr(simulation_datetime, 'yyyy-mm-dd HH:MM:SS');

% String used in the file name
datetime_filename = datestr(simulation_datetime, 'yyyymmdd_HHMMSS');


%% Display results in MATLAB Command Window
fprintf('\n');
fprintf('================ Motor Vehicle Challenge Score ================\n');
fprintf('Control Strategy: %s\n', strategy_name);
fprintf('Simulation Date-Time: %s\n', datetime_display);
fprintf('Phi1 (Energy consumption)     = %.6f Wh\n', Phi1);
fprintf('Phi2 (Wheel slip penalty)     = %.6f s\n', Phi2);
fprintf('Phi3 (DWPT efficiency penalty)= %.6f s\n', Phi3);
fprintf('Phi4 (Lateral accel. penalty) = %.6f m^2/s^3\n', Phi4);
fprintf('---------------------------------------------------------------\n');
fprintf('Total score Phi               = %.6f\n', Phi);
fprintf('===============================================================\n');


%% Write results to text file

% Generate file name
filename = sprintf('MVC27_Score_%s_%s.txt', ...
                   strategy_file, datetime_filename);

% Open file
fid = fopen(filename, 'w');

% Check whether the file was successfully opened
if fid == -1
    error('Unable to create the score output file.');
end

% Write scoring results
fprintf(fid, '================ Motor Vehicle Challenge Score ================\n');
fprintf(fid, 'Control Strategy: %s\n', strategy_name);
fprintf(fid, 'Simulation Date-Time: %s\n', datetime_display);
fprintf(fid, 'Phi1 (Energy consumption)     = %.6f Wh\n', Phi1);
fprintf(fid, 'Phi2 (Wheel slip penalty)     = %.6f s\n', Phi2);
fprintf(fid, 'Phi3 (DWPT efficiency penalty)= %.6f s\n', Phi3);
fprintf(fid, 'Phi4 (Lateral accel. penalty) = %.6f m^2/s^3\n', Phi4);
fprintf(fid, '---------------------------------------------------------------\n');
fprintf(fid, 'Total score Phi               = %.6f\n', Phi);
fprintf(fid, '===============================================================\n');

% Close file
fclose(fid);

fprintf('Score file saved as: %s\n', filename);