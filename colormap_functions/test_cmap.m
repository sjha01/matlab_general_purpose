% --- help for test_cmap ---
% 
% tests a color map by producing a figure that uses that color map.
% 
% Inputs
% ------
% cmap_name : char vector
%     Name of colormap to used.
% 
% Outputs
% -------
% none
% 
% Examples
% --------
% test_cmap('jet');

function test_cmap(cmap_name) 
    
    x = linspace(0, 255, 255);
    y = linspace(0, 255, 255);
    [X Y] = meshgrid(x, y);
    figure, imagesc(x, y, X);
    colormap(cmap_name);
    colorbar();
    
end
