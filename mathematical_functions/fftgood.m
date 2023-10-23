% --- help for fftgood ---
% 
% fast Fourier transform
% 
% Inputs
% ------
% t : vector
%     Signal times.
% x : vector
%     Signal value at each time.
% 'norm' = false : logical, optional
%     Indicates whether output signal values, X, should be normalized.
% 
% Outputs
% -------
% T : vector
%     Signal frequencies.
% X : vector
%     Signal value at each frequency, calculated using FFT.
% 

function [T, X] = fftgood(t, x, varargin)
    
    pnames = {'norm'};
    dflts  = {false};
    
    [norm_1] = internal.stats.parseArgs(pnames, dflts, varargin{:});
    
    T_s = abs(1.0 / (t(2) - t(1)));
    T = (- T_s / 2: T_s / length(x) : T_s / 2); % frequencies
    X = fftshift(fft(x));
    
    if length(T) > length(X)
        T = T(1 : length(T) - 1);
    end
    
    if norm_1
        X = X / length(T);
    end
    
end
