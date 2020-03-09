clear; clc;
% Add data to system
run('Data.m'); 

% Initial value
mean_t_1  = sensor_data(:,1);
sigma_t_1 = [ 0.0025 0 0; 0 0.0025 0; 0 0 0.025];


c_sensor = 2;
c_command= 1;
t=0;
last_t = 0;
if command_data(1,size(command_data,2)) < sensor_data(1,size(sensor_data,2))
    t_max = command_data(1,size(command_data,2));
else
    t_max = sensor_data(1,size(sensor_data,2));
end
mean = [];
mean_capture = [];

sigma_capture = [];

while t<t_max
   t_command = command_data(1,c_command);
   t_sensor  = sensor_data(1,c_sensor);
   
   if t>t_command
       t = t_command;
       delta_t = t_command - last_t;
       [mean_bar, sigma_bar] = EKF_Prediction(mean_t_1, sigma_t_1, command_data (:, c_command), delta_t);
       
       mean_t_1 = mean_bar;
       sigma_t_1 = sigma_bar;
     %  mean_capture = cat(2,mean_capture,mean_bar);

       c_command = c_command + 1;
       last_t = t;
   elseif t>t_sensor
       t = t_sensor;
       delta_t = t_sensor - last_t;
       [mean_bar, sigma_bar] = EKF_Prediction(mean_t_1, sigma_t_1, command_data (:, c_command), delta_t);
       [mean, sigma] = EKF_Correction(mean_bar,sigma_bar,sensor_data(:,c_sensor),t_sensor);
      
      
       sigma_and_time = cat(1,t,det(sigma));
       sigma_capture = cat(2,sigma_capture,sigma_and_time);

       mean_t_1 = mean;
       sigma_t_1 = sigma;
        
      
       c_sensor = c_sensor + 1;
       last_t = t;
   else
       delta_t = t-last_t;
       [mean_bar, sigma_bar] = EKF_Prediction(mean_t_1, sigma_t_1, command_data (:, c_command), delta_t);
       mean_t_1 = mean_bar;
       sigma_t_1 = sigma_bar;
     %  mean_capture = cat(2,mean_capture,mean_bar);
       
       last_t = t;
   end
        mean_capture = cat(2,mean_capture,mean);


   t = t + 0.01;
   
end


