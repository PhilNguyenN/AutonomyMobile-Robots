function [ mean, sigma ] = UKF_Correction(mean_bar_w_time,sigma_bar,z,T)
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
Q = [ 0.0025 0 0; 
      0 0.0025 0; 
      0 0 0.025];
S_t = zeros(3,3);
sigma_t_x_z = zeros(3,3);

time_captured = T;
mean_bar = mean_bar_w_time(2:end,1);

[X_bar_t,w_m,w_c] = sigmaPoint(mean_bar,sigma_bar);


Z_bar_t = X_bar_t;

z_hat_t = (w_m*Z_bar_t')';


for i = 1:length(Z_bar_t)
    S_t = S_t + w_c(i)*(Z_bar_t(i) - z_hat_t)*(Z_bar_t(i) - z_hat_t)';
end
    
for j = 1:length(X_bar_t)
    sigma_t_x_z = sigma_t_x_z + w_c(i)*(X_bar_t(j) - mean_bar)*(Z_bar_t(j) - z_hat_t)';
end

K_t = sigma_t_x_z/(S_t + Q);

% Calculate Mean
mean = mean_bar + K_t*(z(2:end) - z_hat_t);

    if mean(3,1) > 7.854
        mean(3,1) = mean(3,1) - 6.2832;
    elseif mean(3,1) < 1.5708
        mean(3,1) = mean(3,1) + 6.2832;
    end
    
mean = cat(1,time_captured,mean);

% Calculate Sigma
temp =  K_t*S_t*K_t';
sigma = sigma_bar - temp;
% sigma = (eye(3) - K_t*sigma_t_x_z)*sigma_bar;

end

