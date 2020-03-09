clc; close all;


plot(mean_capture(1,:),mean_capture(2,:),'.')
hold on;
plot(sensor_data(1,:),sensor_data(2,:),'r.')
legend('{\mu_x}','z_x');
title('{\mu_x} and z_x');
%%%%%%%%%%%%%%%%%%%%%%%%
figure; 
plot(mean_capture(1,:),mean_capture(3,:),'.')
hold on;
plot(sensor_data(1,:),sensor_data(3,:))
legend('{\mu_y}','z_y');
title('{\mu_y} and z_y');
%%%%%%%%%%%%%%%%%%%%%%%%%%
figure;
plot(mean_capture(1,:),mean_capture(4,:),'.')
hold on;
plot(sensor_data(1,:),sensor_data(4,:)) 
%xlim([30 60]);
legend('{\mu_\theta}','z_{\theta}');
title('{\mu_\theta} and z_{\theta}');
%%%%%%%%%%%%%%%%%%%%%%%%%%
figure; 
plot(mean_capture(2,:),mean_capture(3,:),'.')
hold on;
plot(sensor_data(2,:),sensor_data(3,:))
legend('{\mu_x} and {\mu_y}','z_x and z_y');
title('{\mu_x} and {\mu_y} vs z_x and z_y');
%%%%%%%%%%%%%%%%%%%%%%%%%%
figure; 
plot(sigma_capture(1,:),sigma_capture(2,:),'.')

max(mean_capture(4,:))
min(mean_capture(4,:))
