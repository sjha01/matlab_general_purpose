% --- help for lorentz_fit ---
% 
% Fits Lorentz distribution, f(x; x0, gamma) = amp * (1 / (pi * gamma)) * (gamma.^2 / ((x - x0).^2 + gamma.^2)), to 1D data.
% 
% Inputs
% ------
% x : double vector
%     Data to be Lorentz-fitted.
% 
% bins = 10000 : double, optional
%     Number of bins to data will be binned into when fitting.
% 
% normalization = 'none' : char vector, optional
%     Normalization to use, if any. Options are 'none', 'sum', and 'area'.
% 
% amp_0 = 1.0 : double, optional
%     Starting amplitude used for fitting.
% 
% x0_0 = 0.0 : double, optional
%     Starting location parameter used for fitting.
% 
% gamma_0 = 1.0 : double, optional
%     Starting scale parameter used for fitting.
% 
% Outputs
% -------
% amp : double
%     amplitude parameter in fitted Lorentz distribution.
% 
% x0 : double
%     location parameter in fitted Lorentz distribution.
% 
% gamma : double
%     scale parameter in fitted Lorentz distribution.
% 
% Examples
% --------
% Example here.
% 
% See also
% --------
% lorentzfit (file exchange function)
% 

% Improvements
% ------------
% 

function [amp x0 gamma] = lorentz_fit(x, varargin)
    
    pnames = {'bins', 'normalization', 'amp_0', 'x0_0', 'gamma_0'};
    dflts  = {10000, 'none', 1.0, 0.0, 1.0};
    
    [bins, normalization, amp_0, x0_0, gamma_0] = internal.stats.parseArgs(pnames, dflts, varargin{:});
    
    [counts, centers] = hist(x, bins);
    
    [fit_1 params_1] = lorentzfit(centers, counts, [amp_0 x0_0 gamma_0], [], '3');
    if strcmp(normalization, 'none')
        amp = params_1(1);
    elseif strcmp(normalization, 'sum')
        amp = params_1(1) / sum(counts);
    elseif strcmp(normalization, 'area')
        amp = params_1(1) / trapz(centers, counts);
    else
        error('Optional input ''normalization'' must be one of ''none'', ''sum'', or ''area''.');
    end
    x0 = params_1(2);
    gamma = sqrt(params_1(3));
    
end
