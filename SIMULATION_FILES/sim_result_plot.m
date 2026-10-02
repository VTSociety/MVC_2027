% 
% Code to plot the simulation results 
%

%
%
figure();
subplot(3,1,1);
plot(simout.time,simout.Pos_X);
xlabel('Time [s]'), ylabel('Longitudinal Position [m]');
%
subplot(3,1,2);
plot(simout.time,simout.Vx_ref,'k:');
hold on;
plot(simout.time,simout.Vx);
legend('Reference speed', 'Actual speed');
xlabel('Time [s]'), ylabel('Speed [m/s]');
%
subplot(3,1,3);
plot(simout.time,simout.road_friction);
xlabel('Time [s]'), ylabel('Road friction');

%
%
figure();
%
subplot(3,1,1);
plot(simout.time,simout.DWPT_power);
xlabel('Time [s]'), ylabel('DWPT power [W]');
%
subplot(3,1,2);
plot(simout.time,simout.DWPT_efficient);
xlabel('Time [s]'), ylabel('DWPT efficient');
%
subplot(3,1,3);
plot(simout.time,simout.Pos_Y);
xlabel('Time [s]'), ylabel('Lateral position [m]');

%
%
figure();
subplot(4,1,1);
plot(simout.time,simout.delta_f);
xlabel('Time [s]'), ylabel('Steer angle [rad]');
%
subplot(4,1,2);
plot(simout.time,simout.ay);
xlabel('Time [s]'), ylabel('Lateral acceleration [m/s^2]');
%
subplot(4,1,3);
plot(simout.time,simout.gamma);
xlabel('Time [s]'), ylabel('Yaw rate [rad/s]');
%
subplot(4,1,4);
plot(simout.time,simout.Pos_Y);
xlabel('Time [s]'), ylabel('Lateral position [m]');

%
%
figure();
subplot(4,1,1);
plot(simout.time,simout.Vx_ref,'k:');
hold on;
plot(simout.time,simout.Vx);
legend('Reference speed', 'Actual speed')
xlabel('Time [s]'), ylabel('Speed [m/s]');
%
subplot(4,1,2);
plot(simout.time,simout.Total_Driving_command);
xlabel('Time [s]'), ylabel('Total command [Nm]');
hold on;
%
subplot(4,1,3);
plot(simout.time,simout.Fx_FL);
hold on;
plot(simout.time,simout.Fx_FR);
hold on;
plot(simout.time,simout.Fx_RL);
hold on;
plot(simout.time,simout.Fx_RR);
legend('FL','FR','RL','RR')
xlabel('Time [s]'), ylabel('Driving force [N]');
%
subplot(4,1,4);
plot(simout.time,simout.lambda_FL);
hold on;
plot(simout.time,simout.lambda_FR);
hold on;
plot(simout.time,simout.lambda_RL);
hold on;
plot(simout.time,simout.lambda_RR);
legend('FL','FR','RL','RR')
xlabel('Time [s]'), ylabel('Slip ratio');

figure();
plot(simout.time,simout.Id_FL);
hold on;
plot(simout.time,simout.Id_FR);
hold on;
plot(simout.time,simout.Id_RL);
hold on;
plot(simout.time,simout.Id_RR);
legend('FL','FR','RL','RR')
xlabel('Time [s]'), ylabel('D-axis currents of the motors [A]');

%
%
figure();
subplot(2,1,1);
plot(simout.time,simout.W_in);
xlabel('Time [s]'), ylabel('Motor input energy [Wh]');
%
subplot(2,1,2);
plot(simout.time,simout.DWPT_efficient);
xlabel('Time [s]'), ylabel('DWPT efficient');