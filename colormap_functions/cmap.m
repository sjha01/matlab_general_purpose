% --- help for cmap ---
% 
% custom colormap
% 
% Inputs
% ------
% cmap_name : char vector
%     Name of colormap to be created.
% 
% cmap_data : char vector or double matrix
%     If char vector, name of text file containing colormap values.
%     If double matrix, matrix with grayscale or rgb values for colormap.
% 
% 'output_folder' =
% 'C:\Users\salexand\Documents\MATLAB\custom_functions\custom_colormaps\' : char vector, optional
%     Name of folder in which colormap will be output.
%
% 'method' = 'nearest' : char vector, optional
%     Interpolation method to be used to force custom colormap to have 256
%     (by default) color values. Available values are the same as for
%     function interp1.
% 
% 'map_length' = 256 : double, optional
%     Number of distinct rgb values that custom colormap will have. If
%     cmap_data does not have this number of values, it will be
%     interpolated so that it does.
% 
% Outputs
% -------
% none
% 
% Files generated
% ---------------
% [backslash(output_folder) lower(cmap_name) '_mat.mat']
%     mat file containing 256 (by default) x 3 rgb values for color map.
% 
% [backslash(output_folder) lower(cmap_name) '.m']
%     matlab function that evaluates cmap_name.
% 
% Examples
% --------
% my_gray = linspace(0, 1, 256);
% cmap(my_gray);
% 
% x = linspace(0, 255, 255);
% y = linspace(0, 255, 255);
% [X Y] = meshgrid(x, y);
% 
% figure, imagesc(x, y, X);
% colormap('my_gray');
% colorbar();
% 

% Improvements
% ------------
% 1. Catch error if cmap_name is not a char vector.
% 

function cmap(cmap_name, cmap_data, varargin)
    
    pnames = {'output_folder', 'method', 'map_length'};
    dflts  = {'C:\Users\salexand\Documents\MATLAB\custom_functions\colormap_functions\custom_colormaps\', 'nearest', 256};
    
    [output_folder, method, map_length] = internal.stats.parseArgs(pnames, dflts, varargin{:});
    
    output_folder = backslash(output_folder);
    
    if ~ strcmp(cmap_name, lower(cmap_name))
        disp(['cmap_name changed from ' cmap_name 'to ' lower(cmap_name) '.']);
    end
    cmap_name = lower(cmap_name);
    
    if ~ (any(ismember(output_folder(1 : end - 1), regexp(path, pathsep, 'Split'))) || strcmp(output_folder(1 : end - 1), pwd))
        error('output folder must be in present working directory or MATLAB path. To add it to MATLAB path, use addpath function.');
    end
    
    % folder = mfilename('fullpath'); folder = folder(1 : (length(folder) - length(mfilename())));
    
    % cmap_0 = strcat(folder,  'custom_colormaps\', cmap_name, '.txt');
    % fid = fopen(cmap_0);
    if strcmp(class(cmap_data), 'char')
        fid = fopen(cmap_data);
        cmap_1 = textscan(fid, '%f');
        cmap_1 = cmap_1{1};
        fclose(fid);
    elseif strcmp(class(cmap_data), 'double')
        cmap_1 = cmap_data;
    else
        error('cmap_data must be double arr, or name of text file containing doubles.')
    end
    
    if min(flat(cmap_1)) < 0 || max(flat(cmap_1)) > 1
        error('cmap_data must not contain values below 0 or above 1.');
    end
    
    cmap_size = size(cmap_1);
    
    if ~ ismember(cmap_size(2), [1 3])
        error('cmap_data must be array or name of text file with either 1 column or 3 columns.');
    end
    
    if isequal(cmap_size(2), 1)
        cmap_1 = [cmap_1 cmap_1 cmap_1];
    end
    
    if ~ (cmap_size(1) == map_length)
        cmap_1 = interp1(1:length(cmap_1), cmap_1, linspace(1, length(cmap_1), map_length), method);
    end
    
    eval([cmap_name '_mat = cmap_1;']);
    save([output_folder cmap_name '_mat.mat'], [cmap_name '_mat']);
    
    fid = fopen([output_folder cmap_name '.m'], 'w'); % lower since matlab looks for lowercase only functions in Windows
    function_str = {
        ['function my_map = ' cmap_name '()']... % lower matlab looks for lowercase only functions in Windows
        ['    load(''' cmap_name '_mat'');']...
        ['    my_map = ' cmap_name '_mat;']...
        ['end']...
        };
    for i = 1:length(function_str)
        fprintf(fid, '%s\n', strcat(function_str{i}));
    end
    fclose(fid);
    
end
