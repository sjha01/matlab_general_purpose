% --- help for cmap_rgb ---
% 
% Get rgb values that a given colormap maps a given array onto.
% 
% Inputs
% ------
% my_arr : double vector
%     Range of values that colormap would map to rgb values.
% 
% my_cmap : char arr
%     Name of colormap for which rgb values are desired.
% 
% Outputs
% -------
% cmap_rgb_1 : double matrix
%     3-column matrix of rgb values corresponding to values in my_arr.
%     Length of cmap_rgb_1 is the same as that of my_arr.
% 

% Notes
% -----
% 
% Adapted from : https://stackoverflow.com/questions/40057611/matlab-1d-array-to-rgb-triplets-with-colormap?rq=1
% 
% 
% Improvements to make
% --------------------
% 1. Error checking at beginning, make sure input types are correct.
% 2. Option for custom min and max values to which min and max values of
% colormap will correspond.

function cmap_rgb_1 = cmap_rgb(my_arr, my_cmap)

    % pick a range of values that should map to full color scale
    c_range = [min(flat(my_arr)) max(flat(my_arr))];

    % pick a colormap
    colormap(my_cmap);

    % get colormap data
    colormap_data = colormap;

    % get the number of rows in the colormap
    colormap_data_size = size(colormap_data, 1);

    % translate x values to colormap indices
    my_arr_index = ceil((my_arr - c_range(1)) .* colormap_data_size ./ (c_range(2) - c_range(1)));

    % limit indices to array bounds
    my_arr_index = max(my_arr_index, 1);
    my_arr_index = min(my_arr_index, colormap_data_size);

    % read rgb values from colormap
    cmap_rgb_1 = colormap_data(my_arr_index, :);
    
    close; % something above opens a blank figure. Closing it.
    
end