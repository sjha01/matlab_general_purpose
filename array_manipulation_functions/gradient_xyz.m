% --- help for gradient_xyz ---
% 
% Given xyz 2D matrices of xyz data, returns the gradient of the z data.
% 
% Inputs
% ------
% X : double matrix
%     The x positions.
% 
% Y : double matrix
%     The y positions.
% 
% Z : double matrix
%     The z positions.
% 
% 'pad_with' = 'none' : double (or char vector by default), optional
%     Number to be used to pad gradient arrays back to size of original
%     arrays. If 'none', no padding is done.
% 
% Outputs
% -------
% dZ_over_dX : double matrix
%     The x-component of the gradient, \frac{\partial{Z}}{\partial{X}}.
% 
% dZ_over_dY : double matrix
%     The y-component of the gradient, \frac{\partial{Z}}{\partial{Y}}.
%  
% See also
% --------
% gradient, intgrad2
% 

function [dZ_over_dX dZ_over_dY] = gradient_xyz(X, Y, Z, varargin)
    
    pnames = {'pad_with'};
    dflts = {'none'};
    
    [pad_with] = internal.stats.parseArgs(pnames, dflts, varargin{:});
    
    X_partial = X(:, 3 : end) - X(:, 1 : end - 2); X_partial = X_partial(2 : end - 1, :);
    Y_partial = Y(3 : end, :) - Y(1 : end - 2, :); Y_partial = Y_partial(:, 2 : end - 1);
    Z_partial_X = Z(:, 3 : end) - Z(:, 1 : end - 2); Z_partial_X = Z_partial_X(2 : end - 1, :);
    Z_partial_Y = Z(3 : end, :) - Z(1 : end - 2, :); Z_partial_Y = Z_partial_Y(:, 2 : end - 1);
    
    dZ_over_dX = Z_partial_X ./ X_partial;
    dZ_over_dY = Z_partial_Y ./ Y_partial;
    
    % optionally pad back to original size. pad_with is the number with
    % which the arrays are padded.
    if ~(pad_with == 'none')
        dZ_over_dX = padarray(dZ_over_dX, [1 1], pad_with, 'both');
        dZ_over_dY = padarray(dZ_over_dY, [1 1], pad_with, 'both');
    end
    
end
