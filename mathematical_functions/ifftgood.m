% --- help for ifftgood ---
% 
% inverse fast Fourier transform
% 
% Inputs
% ------
% T : vector
%     Signal frequencies.
% X : vector
%     Signal value at each frequency.
% 'norm' = false : logical, optional
%     Indicates whether output signal values, x, should be normalized.
% 
% Outputs
% -------
% t : vector
%     Signal times.
% x : vector
%     Signal value at each time, calculated using inverse FFT.
% 

function [t, x] = ifftgood(T, X, varargin)
    
    pnames = {'norm'};
    dflts  = {false};
    
    [norm_1] = internal.stats.parseArgs(pnames, dflts, varargin{:});
    
    t_s = abs(1.0 / (T(2) - T(1)));
    t = (- t_s / 2: t_s / length(X) : t_s / 2); % times
    x = ifft(ifftshift(X));
    
    if length(t) > length(x)
        t = t(1 : length(t) - 1);
    end
    
    if norm_1
        x = x * length(t);
    end
    
end
