% --- help for unnest ---
% 
% converts cell array of constant depth n to n-dimensional cell array of
% depth 1.
% 
% Inputs
% ------
% cell_arr : cell arr
%     The input cell array, which should be 1-dimensional and be of
%     constant depth n.
% 
% Outputs
% -------
% unnest_1 : cell arr
%     The output cell array, which will be n-dimensional and have depth 1.
% 
% Examples
% --------
% cell_nested = {{{1 '2' 3} {'4' 5 '6'}} {{7 '8' 9} {'10' 11 '12'}}}; % nested, with depth 3
% cell_unnested = unnest(cell_nested); % unnested, 2x2x3 cell (ndim = 3)
% cell_nested_last = cell_nested{2}{2};          % {'10' 11 '12'}
% cell_nested_last = {cell_nested{2}{2}{:}};     % {'10' 11 '12'}
% cell_unnested_last = {cell_unnested{2, 2, :}}; % {'10' 11 '12'}
% 

function unnest_1 = unnest(cell_arr)
    
    if ~ strcmp(class(cell_arr), 'cell')
        error('cell_arr must be a cell array.');
    end
    
    if ~ (ismember(1, size(cell_arr)) && length(size(cell_arr)) == 2)
        error('cell_arr must be of size [1 n] or [n 1].');
    end
    
    temp_cell = cell_arr{1};
    depth = 1;
    while strcmp(class(temp_cell), 'cell')
        temp_cell = temp_cell{1};
        depth = depth + 1;
    end
    
    temp_cell = cell_arr;
    cell_size = ones(1, depth);
    for i = 1:depth
        cell_size(i) = length(temp_cell);
        temp_cell = temp_cell{1};
    end
    
    % disp(depth);
    % disp(cell_size);
    temp_cell = reshape(cell_arr, [1 numel(cell_arr)]);
    while any(cell2mat(cellfun(@(x) strcmp(class(x), 'cell'), temp_cell, 'UniformOutput', false)))
        temp_cell = horzcat(temp_cell{:});
        temp_cell = reshape(temp_cell, [1 numel(temp_cell)]);
    end
    
    unnest_1 = reshape(temp_cell, fliplr(cell_size));
    unnest_1 = permute(unnest_1, numel(size(unnest_1)):-1:1);
    
end
