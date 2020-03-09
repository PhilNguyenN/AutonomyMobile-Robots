function [ mean, sigma ] = EKF_Correction(mean_bar, sigma_bar, z,T)
H = eye(3);
Q = [ 0.0025 0 0; 
      0 0.0025 0; 
      0 0 0.025];

K = (sigma_bar)/(sigma_bar + Q); 

mean = mean_bar(2:end) + K*(z(2:end) - mean_bar(2:end));
mean = [T; mean];
    
    if mean(4,1) > 7.854
        mean(4,1) = mean(4,1) - 6.2832;
    elseif mean(4,1) < 1.5708
        mean(4,1) = mean(4,1) + 6.2832;
    end

sigma = (eye(3) - K*H)*sigma_bar;

end

