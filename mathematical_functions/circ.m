% --- help for circ ---
% 
% A circle matrix.
% 
% Inputs
% ------
% X : double matrix
%     x-values over which circle will be defined.
% 
% Y : double matrix
%     y-values over which circle will be defined.
% 
% x_0 : double
%     x-coordinate of center of circle.
% 
% y_0 : double
%     y-coordinate of center of circle.
% 
% r : double
%     Radius of circle.
% 
% z : double
%     Height of circle.
% 
% Outputs
% -------
% circ_1 : double matrix
%     Matrix containing z-values of the circle.

function circ_1 = circ(X, Y, x_0, y_0, r, z)
    circ_1 = z * (sqrt((X - x_0).^2 + (Y - y_0).^2) <= r);
end
