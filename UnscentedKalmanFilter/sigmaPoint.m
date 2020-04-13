function [ X,w_m,w_c ] = sigmaPoint(mean,sigma)
% Initiate sigma weights
alpha = 0.4;
k = 3;
beta = 2;
n = 3; % gaussian dimension [x y theta].T 
lambda = alpha^2*(n + k) - n;

% Number of sigma points
w_m = zeros(1,2*n+1);
w_c = zeros(1,2*n+1);
X = zeros(n,2*n+1);

% Calculate sigma points 
X(:,1) = mean;
% % 

a = validateCovMatrix(sigma);
squareMatrix = chol(a);
 
% squareMatrix = round(sqrtm(sigma));

for u = 2:(2*n+1)
    if u <= n+1 
        X(:,u) = mean + sqrt(n+lambda)*squareMatrix(:,u-1);
    elseif u > n+1
        X(:,u) = mean - sqrt(n+lambda)*squareMatrix(:,u-n-1);
    end 
end

% Calculate sigma weights for mean
w_m(1) = lambda/(n+lambda);
for i = 2:(2*n+1)
    w_m(i) = 1/(2*(n+lambda));
end

% Calculate sigma weights for covariances
w_c(1) = lambda/(n+lambda) + (1 - alpha^2 + beta);
for j = 2:(2*n+1)
    w_c(j) = 1/(2*(n+lambda));
end

end

