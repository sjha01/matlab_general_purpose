% --- help for amp_phase_plot ---
% 
%     Color plot of xyz data, with z complex. I.e., color plot of
%     xy(vec_x,vec_y) data, where vec_x and vec_y are the components of a
%     2D vector. The Brightness of the plot corresponds to the amplitude of
%     z (i.e., magnitude of vec), and the color of the plot corresponds to
%     the phase of z (i.e., angle of vec).
% 
% Inputs
% ------
% x : double vector
%     x-coordinate positions.
% 
% y : double vector
%     y-coordinate positions.
% 
% vec_x : double vector
%     x-components of 2D real vector, or real components of complex scalar.
% 
% vec_y : double vector
%     y-components of 2D real vector, or imaginary components of complex
%     scalar.
% 
% point_size = 1 : double, optional
%     Size of plot points. Same as s input in function scatter3.
% 
% cmap_name = 'sjha_smooth_hsv' : char vector, optional
%     Name of colormap to be used for plotting.
% 
% r_max = 'none' : double (or char vector by default), optional
%     Vector magnitude corresponding to maximum brightness value. Vector
%     magnitudes higher than r_max will be reassigned r_max as their
%     magnitude.
% 
% scale_floor = 0.0 : double, optional
%     Minimum brightness of plot, on a scale from 0.0 to 1.0. This input
%     affects the contrast of the plot.
% 
% brightness_power = 0.5 : double, optional
%     Power to which magnitude of plot is brought. I.e., magnitudes r are
%     mapped to r^brightness_power. This input affects the contrast of the
%     plot.
% 
% Outputs
% -------
% None
% 
% Examples
% --------
% % amp-phase plot of ml struct.
% figure;
% amp_phase_plot(ml.wd.xw, ml.wd.yw, ml.layer.wr.dx, ml.layer.wr.dy);
% title('Example amp-phase plot of ml struct');
% xlabel('x (m)');
% ylabel('y (m)');
% daspect([1 1 1]);
% xlim([-.150 .150]);
% ylim([-.150 .150]);
% view(0, 90);
% 

% Improvements
% ------------
% 1. Automatic colorwheel in place of where colorbar would be, as an
% option.
% 


function amp_phase_plot(x, y, vec_x, vec_y, varargin)
    
    pnames = {'point_size', 'cmap_name', 'r_max', 'scale_floor', 'brightness_power'};
    dflts = {1, 'sjha_smooth_hsv', 'none', 0.0, 0.5};
    [point_size, cmap_name, r_max, scale_floor, brightness_power] = internal.stats.parseArgs(pnames, dflts, varargin{:});
    
    phi = atan2(vec_y, vec_x);
    r = sqrt(vec_x.^2 + vec_y.^2);
    if r_max == 'none'
        r_max = max(r);
    end
    
    r_norm = r;
    % make values above r_max = r_max
    filterer = r_norm > r_max;
    r_norm(filterer) = r_max;
    % r_norm = r_norm / max(r_norm);
    r_norm = r_norm / r_max;
    % Adjust contrast by taking it to a power.
    r_norm = r_norm.^brightness_power;
    % squish brightness values to be from scale_floor to 1
    r_norm = r_norm * (1 - scale_floor);
    r_norm = r_norm + scale_floor;
    
    z_plot = ones(size(vec_x)); % z_plot is not z the complex number, it's just an array of ones for plotting.
    c_advanced = cmap_rgb(phi, cmap_name); % array of rgb elements for each data point
    c_advanced = c_advanced .* r_norm;
    
    figure;
    scatter3(x, y, z_plot, point_size, c_advanced, '.');
    colormap(cmap_name);
    
end