% --- help for list_cmaps ---
% 
% names of available custom colormaps.
% 
% Inputs
% ------
% 'colormap_folder' = 'C:\Users\salexand\Documents\MATLAB\custom_functions\custom_colormaps\' : char vector, optional
%     Folder in which custom color maps are stored.
% 
% Outputs
% -------
% list_cmaps_1 : cell array
%     Cell array containing names of custom color maps.
% 

function list_cmaps_1 = list_cmaps(varargin)
    
    pnames = {'colormap_folder'};
    dflts  = {'C:\Users\salexand\Documents\MATLAB\custom_functions\custom_colormaps\'};
    
    [colormap_folder] = internal.stats.parseArgs(pnames, dflts, varargin{:});
    
    colormap_folder = backslash(colormap_folder);
    
    names = [colormap_folder, '*.m'];
    list_cmaps_1 = dir(names);
    list_cmaps_1 = transpose({list_cmaps_1.name});
    list_cmaps_1 = cellfun(@(x) x(1 : end - 2), list_cmaps_1, 'UniformOutput', false);
    
end
