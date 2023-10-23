% --- help for fft2good ---
% 
% fast Fourier transform on 2D data
% 
% Inputs
% ------
% X : double matrix
%     Signal x frequencies.
% Y : double matrix
%     Signal y frequencies.
% 
% Z : double matrix
%     Signal z frequencies, i.e., data.
% 
% 'norm' = false : logical, optional
%     Indicates whether output signal values, should be normalized.
% 
% Outputs
% -------
% x : double matrix
%     Signal x-positions.
% y : double matrix
%     Signal y-positions.
% 
% z : double matrix
%     Value at each x- and y-position, calculated using FFT.
% 

function [x, y, z] = ifft2good(X, Y, Z, varargin)
    
    pnames = {'norm'};
    dflts  = {false};
    
    [norm_1] = internal.stats.parseArgs(pnames, dflts, varargin{:});
    
    z = ifft2(fftshift(Z));
    
    x_s = abs(1.0 / (X(1, 2) - X(1, 1)));
    x_vec = (- x_s / 2: x_s / length(X(1, :)) : x_s / 2); % frequencies
    y_s = abs(1.0 / (Y(2, 1) - Y(1, 1)));
    y_vec = (- y_s / 2: y_s / length(Y(:, 1)) : y_s / 2); % frequencies
    if length(x_vec) > length(z(1, :))
        x_vec = x_vec(1 : length(x_vec) - 1);
    end
    if length(y_vec) > length(z(:, 1))
        y_vec = y_vec(1 : length(y_vec) - 1);
    end
    
    [x, y] = meshgrid(x_vec, y_vec);
    
    if norm_1
        z = z / (length(x_vec) * length(y_vec)); % this is a guess on the extension from fftgood, haven't checked if it actually works.
    end
    
end
