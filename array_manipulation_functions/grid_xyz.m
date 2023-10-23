% --- help for grid_xyz ---
% 
% Given xyz data which need not be on a regular grid, gives a gridded
% version of the data.
% 
% Inputs
% ------
% x_data : double vector
%     The x positions.
% 
% y_data : double vector
%     The y positions.
% 
% z_data : double vector
%     The z positions.
% 
% grid_min : double vector
%     The minimum x- and y-value for the grid to be made. Can have 1 or 2
%     elements - if two, the values will be for x and y, respectively.
% 
% grid_step : double vector
%     The step size for the grid to be made. Can have 1 or 2
%     elements - if two, the values will be for x and y, respectively. 
% 
% grid_max : double vector
%     The maximum x- and y-value for the grid to be made. Can have 1 or 2
%     elements - if two, the values will be for x and y, respectively.
% 
% 'grid_interp' = 'linear' : char vector, optional
%     Interpolation method to find gridded z data. Available values are the
%     same as for function griddata.
% 
% Outputs
% -------
% X_data : double matrix
%     The gridded X positions.
% 
% Y_data : double matrix
%     The gridded Y positions.
% 
% Z_data : double matrix
%     The gridded Z positions.
% 
% See also
% --------
% griddata
% 

function [X_data Y_data Z_data] = grid_xyz(x_data, y_data, z_data, grid_min, grid_step, grid_max, varargin)
    
    pnames = {'grid_interp'};
    dflts = {'linear'};
    
    [grid_interp] = internal.stats.parseArgs(pnames, dflts, varargin{:});
    
    if length(grid_min) == 1
        grid_min_x = grid_min;
        grid_min_y = grid_min;
    elseif length(grid_min) == 2
        grid_min_x = grid_min(1);
        grid_min_y = grid_min(2);
    else
        error('grid_min should have size [1 n] or [n 1], with n == 1 or 2.');
    end
    if length(grid_step) == 1
        grid_step_x = grid_step;
        grid_step_y = grid_step;
    elseif length(grid_step) == 2
        grid_step_x = grid_step(1);
        grid_step_y = grid_step(2);
    else
        error('grid_step should have size [1 n] or [n 1], with n == 1 or 2.');
    end
    if length(grid_max) == 1
        grid_max_x = grid_max;
        grid_max_y = grid_max;
    elseif length(grid_max) == 2
        grid_max_x = grid_max(1);
        grid_max_y = grid_max(2);
    else
        error('grid_max should have size [1 n] or [n 1], with n == 1 or 2.');
    end
    
    x_data_gridded = grid_min_x: grid_step_x: grid_max_x;
    y_data_gridded =  grid_min_y: grid_step_y: grid_max_y;
    
    filter = logical((x_data >= grid_min_x) .* (x_data <= grid_max_x) .* (y_data >= grid_min_y) .* (y_data <= grid_max_y));
    
    [X_data Y_data] = meshgrid(x_data_gridded, y_data_gridded);
    Z_data = griddata(x_data(filter), y_data(filter), z_data(filter), X_data, Y_data, grid_interp);
    
end
