function [ mean_bar, sigma_bar] = EKF_Prediction(mean_t_1,sigma_t_1,u,deltaT)
% predict movement
v = u(2,1);   %velocity
w = v*u(3,1); %angular velocity
theta_t_1 = mean_t_1(4,1); % theta

    if v ~= 0 
        mean_bar = mean_t_1 + [deltaT; 
                              ((-v*sin(theta_t_1)/w)+(v*sin(theta_t_1+w*deltaT)/w));
                              (( v*cos(theta_t_1)/w)-(v*cos(theta_t_1+w*deltaT)/w));
                              w*deltaT];
        if mean_bar(4,1) > 7.855 
            mean_bar(4,1) = mean_bar(4,1) - 2*3.14;
        elseif mean_bar(4,1) <1.5708
            mean_bar(4,1) = mean_bar(4,1) + 2*3.14;
        end
        
        a1=1;
        a2=1;
        a3=0.1;
        a4=0.1;

        U = [(a3*v^2+a4*w^2) 0;
            0 (a2*v^2+a1*w^2)];

        G = [1 0 -v*cos(theta_t_1)/w + v*cos(theta_t_1+w*deltaT)/w;
             0 1 -v*sin(theta_t_1)/w + v*sin(theta_t_1+w*deltaT)/w;
             0 0 1];

        V = [(-sin(theta_t_1)/w + sin(theta_t_1 + w*deltaT)/w) ( v*sin(theta_t_1)/w^2 - v*sin(theta_t_1+w*deltaT)/w^2 + v*deltaT*cos(theta_t_1 + w*deltaT)/w);
             ( cos(theta_t_1)/w - cos(theta_t_1 + w*deltaT)/w) (-v*cos(theta_t_1)/w^2 + v*cos(theta_t_1+w*deltaT)/w^2 + v*deltaT*sin(theta_t_1 + w*deltaT)/w);
             0 deltaT];

        R = V*U*V';

        sigma_bar = G*sigma_t_1'*G' + R; 
    else
        mean_bar = mean_t_1;
        sigma_bar = sigma_t_1;
    end    
end


