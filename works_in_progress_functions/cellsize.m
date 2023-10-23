function cellsize1 = cellsize(cell_arr)
    
    temp_cell = cell_arr;
    temp_depth = 1;    
    while strcmp(class(temp_cell{1}), 'cell')
        temp_depth = temp_depth + 1;
        temp_cell = temp_cell{1};
    end
    
    depth = temp_depth;
    cellsize1 = zeros(1, depth);
    
    temp_cell = cell_arr;
    temp_depth = 1;
    while temp_depth < depth
        cellsize1(temp_depth) = prod(size(temp_cell));
        temp_depth = temp_depth + 1;
        temp_cell = temp_cell{1};
    end
    cellsize1(temp_depth) = prod(size(temp_cell));
    
    
end