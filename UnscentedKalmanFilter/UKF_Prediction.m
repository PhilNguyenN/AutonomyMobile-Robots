function [ mean_bar, sigma_bar ] = UKF_Prediction(mean_t_1_w_time,sigma_t_1,u,deltaT)

% Unscented Kalman Filter Prediction
time_captured = mean_t_1_w_time(1,1);
mean_t_1 = mean_t_1_w_time(2:end,1);
% Initial values
a1=1e-9;
a2=1e-9;
a3=1e-9;
a4=1e-9;

% Control input
v = u(2,1);   %velocity
w = v*u(3,1); %angular velocity
theta_t_1 = mean_t_1(3,1); % theta

% Add time step 
next_time_step = time_captured + deltaT;
X_bar = zeros(3,7);
sigma_bar = zeros(3,3);


% X_t_1
if v ~= 0 
    
    [X_t_1,w_m,w_c] = sigmaPoint(mean_t_1,sigma_t_1);
    for i = 1:length(X_t_1)
          X_bar(:,i) = X_t_1(:,i) + [((-v*sin(theta_t_1)/w)+(v*sin(theta_t_1+w*deltaT)/w));
                                     (( v*cos(theta_t_1)/w)-(v*cos(theta_t_1+w*deltaT)/w));
                                     w*deltaT];

       if (X_bar(3,i) > 7.855)
          X_bar(3,i) = X_bar(3,i) - 2*3.14;
       elseif (X_bar(3,i) <1.5708)
          X_bar(3,i) = X_bar(3,i) + 2*3.14;
       end
    end
    
    U = [(a3*v^2+a4*w^2)   0;
         0  (a2*v^2+a1*w^2)];
      
    mean_bar = (w_m*X_bar')';
     
    V = [(-sin(theta_t_1)/w + sin(theta_t_1 + w*deltaT)/w) ( v*sin(theta_t_1)/w^2 - v*sin(theta_t_1+w*deltaT)/w^2 + v*deltaT*cos(theta_t_1 + w*deltaT)/w);
         ( cos(theta_t_1)/w - cos(theta_t_1 + w*deltaT)/w) (-v*cos(theta_t_1)/w^2 + v*cos(theta_t_1+w*deltaT)/w^2 + v*deltaT*sin(theta_t_1 + w*deltaT)/w);
           0 deltaT];
               
    R = V*U*V'; 
      
    for j = 1:length(X_bar)
        sigma_bar = sigma_bar + w_c(j)*(X_bar(j) - mean_bar)*(X_bar(j) - mean_bar)';
    end
     
    sigma_bar = sigma_bar + R;
     
    %Add time stamp
    mean_bar = cat(1,next_time_step,mean_bar);
else
    mean_bar = mean_t_1_w_time;
    sigma_bar = sigma_t_1; 
end

end

