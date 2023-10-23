% --- help for gauss ---
% 
% A 2D Gaussian height profile.
% 
% Inputs
% ------
% X : double matrix
%     x-values over which the Gaussian profile will be defined.
% 
% Y : double matrix
%     y-values over which Gaussian profile will be defined.
% 
% x_0 : double
%     x-coordinate of center of Gaussian profile, i.e., mean of the
%     Gaussian profile in x.
% 
% y_0 : double
%     y-coordinate of center of Gaussian profile, i.e., mean of the
%     Gaussian profile in y.
% 
% r : double
%     Standard deviation of the Gaussian profile.
% 
% z : double
%     Height of the Gaussian profile integrated over x and y.
% 
% Outputs
% -------
% gauss_1 : double matrix
%     Matrix containing z-values of the Gaussian profile.

function gauss_1 = gauss(X, Y, x_0, y_0, r, z)
    gauss_1 = z * (1 / (sqrt(2 * pi) * r)) * exp(-((X - x_0).^2 + (Y - y_0).^2) ./ (2 * r^2));
end
