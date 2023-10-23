% --- help for fft2good ---
% 
% fast Fourier transform on 2D data
% 
% Inputs
% ------
% x : double matrix
%     Signal x positions.
% y : double matrix
%     Signal y positions.
% 
% z : double matrix
%     Signal z positions, i.e., data.
% 
% 'norm' = false : logical, optional
%     Indicates whether output signal values, should be normalized.
% 
% Outputs
% -------
% X : double matrix
%     Signal x-frequencies.
% Y : double matrix
%     Signal y-frequencies.
% 
% Z : double matrix
%     Value at each x- and y-frequency, calculated using FFT.
% 

function [X, Y, Z] = fft2good(x, y, z, varargin)
    
    pnames = {'norm'};
    dflts  = {false};
    
    [norm_1] = internal.stats.parseArgs(pnames, dflts, varargin{:});
    
    Z = fftshift(fft2(z));
    
    X_s = abs(1.0 / (x(1, 2) - x(1, 1)));
    X_vec = (- X_s / 2: X_s / length(x(1, :)) : X_s / 2); % frequencies
    Y_s = abs(1.0 / (y(2, 1) - y(1, 1)));
    Y_vec = (- Y_s / 2: Y_s / length(y(:, 1)) : Y_s / 2); % frequencies
    if length(X_vec) > length(Z(1, :))
        X_vec = X_vec(1 : length(X_vec) - 1);
    end
    if length(Y_vec) > length(Z(:, 1))
        Y_vec = Y_vec(1 : length(Y_vec) - 1);
    end
    
    [X, Y] = meshgrid(X_vec, Y_vec);
    
    if norm_1
        Z = Z / (length(X_vec) * length(Y_vec)); % this is a guess on the extension from fftgood, haven't checked if it actually works.
    end
    
end
