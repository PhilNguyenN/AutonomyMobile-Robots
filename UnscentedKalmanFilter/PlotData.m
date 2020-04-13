clc; close all;
subplot(3,2,1)
plot(mean_capture(1,:),mean_capture(2,:),'r.')
hold on;
plot(sensor_data(1,:),sensor_data(2,:))
legend('{\mu_x}','z_x');
title('{\mu_x} and z_x');
% %%%%%%%%%%%%%%%%%%%%%%%%
% figure;
subplot(3,2,2)
plot(mean_capture(1,:),mean_capture(3,:),'r.')
hold on;
plot(sensor_data(1,:),sensor_data(3,:))
legend('{\mu_y}','z_y');
title('{\mu_y} and z_y');
% %%%%%%%%%%%%%%%%%%%%%%%%%%
figure;
subplot(3,2,3)
plot(mean_capture(1,:),mean_capture(4,:),'r.')
hold on;
plot(sensor_data(1,:),sensor_data(4,:)) 
% xlim([30 60]);
legend('{\mu_\theta}','z_{\theta}');
title('{\mu_\theta} and z_{\theta}');
% %%%%%%%%%%%%%%%%%%%%%%%%%%
%%
figure; 
% subplot(3,2,4)
plot(sensor_data(2,:),sensor_data(3,:),'g.')
hold on;
plot(mean_capture(2,:),mean_capture(3,:),'r.')
legend('{\mu_x} and {\mu_y}','z_x and z_y');
title('{\mu_x} and {\mu_y} vs z_x and z_y');
% xlim([-22 -19]);
% ylim([6 9]);
% %%%%%%%%%%%%%%%%%%%%%%%%%%
% figure;
%%
% subplot(3,2,5)
plot(sigma_capture(1,:),sigma_capture(2,:),'r*')
% hold on
% plot(command_data(1,:),command_data(2,:),'r.')
% hold on
% plot(command_data(1,:),command_data(3,:),'g.')
xlim([268 269]);
ylim([-0.02 0.01]);
legend('det({\Sigma})');
title('det({\Sigma}) vs t');

max(mean_capture(4,:));
min(mean_capture(4,:));
