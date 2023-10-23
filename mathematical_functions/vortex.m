% --- help for vortex ---
% 
% vortex profile
% 
% Inputs
% ------
% x_pos : double vec
%     x-values over which values of vortex will be evaluated.
% 
% y_pos : double vec
%     y-values over which values of vortex will be evaluated.
% 
% x_pos_0 : double
%     x-coordinate of center of vortex.
% 
% y_pos_0 : double
%     y-coordinate of center of vortex.
% 
% r_0 : double
%     Decay rate of vortex magnitude. Vortex decays as function of distance
%     r from center of vortex as (r / r_0)^2.
% 
% m = 1 : double, optional
%     Topological charge, i.e., how many times vortex phase goes between 0
%     and 2 pi as angle from center of vortex goes from 0 to 2 pi.
% 
% phase_0 = 0 : double, optional
%     Phase of vortex at phi = 0. I.e., where angle from center of vortex
%     to point with respect to angle from center of vortex to point with
%     same y-value as center of vortex is 0.
% 
% output_type = 'matrix' : char vec, optional
%     Type of double arrs that outputs will be. 
% 
% Outputs
% -------
% vortex_1 : double matrix or double vec, corresponding to output_type
%     Complex-valued scalar vortex. The full phasor representation of the
%     vortex.
% 
% dx_1 : double matrix or double vec, corresponding to output_type
%     Real-valued scalars, representing real portion of vortex_1. The first
%     component (i.e., x-component) of 2-component vector representation of
%     the vortex.
% 
% dy_1 : double matrix or double vec, corresponding to output_type
%     Real-valued scalars, representing imaginary portion of vortex_1.
%     The second component (i.e., y-component) of 2-component vector
%     representation of the vortex.
% 


function [vortex_1, dx_1, dy_1] = vortex(x_pos, y_pos, x_pos_0, y_pos_0, r_0, varargin);
    
    pnames = {'m', 'phase_0', 'output_type'};
    dflts  = {1, 0, 'matrix'};
    
    [m, phase_0, output_type] = internal.stats.parseArgs(pnames, dflts, varargin{:});
    
    if strcmp(output_type, 'matrix')
        [X Y] = meshgrid(x_pos, y_pos);
        
        X = X - x_pos_0;
        Y = Y - y_pos_0;
        R = sqrt(X.^2 + Y.^2);
        phi = atan2(Y, X);
        
        % model as Laguerre-Gauss profile.
        vortex_1 = ((2 / (pi * factorial(abs(m)))) / r_0)...
            * ((sqrt(2) * R / r_0).^abs(m))...
            .* exp(-R.^2 / (r_0^2))...
            .* exp(1j * (m * phi + phase_0));
        
        dx_1 = real(vortex_1);
        dy_1 = imag(vortex_1);
    
    elseif strcmp(output_type, 'vec')
        x = x_pos - x_pos_0;
        y = y_pos - y_pos_0;
        r = sqrt(x.^2 + y.^2);
        phi = atan2(y, x);
        
        % model as Laguerre-Gauss profile.
        vortex_1 = ((2 / (pi * factorial(abs(m)))) / r_0)...
            * ((sqrt(2) * r / r_0).^abs(m))...
            .* exp(-r.^2 / (r_0^2))...
            .* exp(1j * (m * phi + phase_0));
        
        dx_1 = real(vortex_1);
        dy_1 = imag(vortex_1);
    
    else
        error('output_type must be either ''matrix'' or ''vec''.');
    end
    
end
