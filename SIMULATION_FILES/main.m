%
% IEEE-VTS: Motor Vehicle Challenge 2027
% Simulation of a 4-In-wheel-motor vehicle with Active-front-steering

% Organizers:  The University of Tokyo, Japan
%              Universidad Nacional de Río Cuarto, Argentina
%              Politecnico di Torino, Italy

clear; close all; clc;
%

% 1. Driving condition
flag.wind = 1;  % (0: without lateral wind, 1: with lateral wind)
flag.road = 1;  % (0: only high friction surface, 1: with road friction change)

% 2. Selection of the motion control & energy management strategy
% "1"-baseline strategy, "2"-improved strategy
control_strategy = 2;     

% 3. Parameter setting
sim_para;          % parameters of physical model
driving_condition; % driving condition
meso_para;         % parameters of energy management & motion control

% 4. Weighting of scoring function
sigma = [12 200 30 100];

% 5. Run the simulation
simout = sim('MVC27_Sim.slx');

% 6. Plot the result
sim_result_plot;

% 7. Calculate the score
scoring;