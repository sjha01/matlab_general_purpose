% --- help for where ---
% 
% indices of primitive element (numeric, char, or string) in array, string,
% or non-nested cell array.
% 
% Inputs
% ------
% array : numeric (i.e., double, logical, etc.) arr, char arr, string, or
%         cell arr
%     The array to be searched.
% 
% element : numeric (i.e., double, logical, etc.) arr, char arr, string, or
%           cell arr
%     The element for which indices of locations in array will be output.
% 
% Outputs
% -------
% where1 : double arr
%     mxn matrix, wherein each row contains the indices of an occurence of
%     element inside array.
% 
% Examples
% --------
% my_cell_1 = {'7' '8' '9' '10' '11' '12' '10' '8'};
% locs = where(my_cell_1, '10'); // locs_10 = [1 4 ; 1 7]
% 
% my_arr_1 = [7 8 9 10 ; 11 12 10 8};
% locs = where(my_arr_1, 8); // locs = [1 2 ; 2 4]
% 
% my_char_1 = 'this is a char vector';
% locs = where(my_char_1, 'a'); // locs = [1 10 ; 1 13]
% 

% modifications to make
% ---------------------
% 1. add error at beginning if elements of array are not primitives.
% 
% notes
% -----
% 1. changes made 20190402, if it screws up previous code that uses where, get
% version before this to fix.
% 
% 2. UNTESTED with strings.
% 

function where1 = where(array, element)
    
    array_flat = flat(array);
    
    if ~ any(strcmp(class(array), {'cell' 'char' 'string'})) % numeric array
        
        where1 = cell(size(size(array)));
        [where1{:}] = ind2sub(size(array), find(array == element));
        where1 = [where1{:}];
    
    elseif strcmp(class(array), 'cell')
        
        if ~ any(strcmp(class(array_flat{1}), {'char' 'string'})) % cell array with numeric values
        
            where1 = cell(size(size(array)));
            [where1{:}] = ind2sub(size(array), find(cell2mat(array) == element));
            where1 = [where1{:}];
        
        else % cell array with char-like values
            
            where1 = cell(size(size(array)));
            [where1{:}] = ind2sub(size(array), find(strcmp(array, element)));
            where1 = [where1{:}];
        
        end
    
    elseif strcmp(class(array), 'string') % string array
                    
        where1 = cell(size(size(array)));
        [where1{:}] = ind2sub(size(array), find(strcmp(array, element)));
        where1 = [where1{:}];
    
    elseif strcmp(class(array), 'char') % char array
        array_size = size(array);
        array = flat(array);
        cell_array = cell(size(array));
        for i = 1:length(array)
            cell_array{i} = array(i);
        end
        array = reshape(cell_array, array_size);
        where1 = cell(size(size(array)));
        [where1{:}] = ind2sub(size(array), find(strcmp(array, element)));
        where1 = [where1{:}];
    
    else
        
        error('array type should be array, cell array, or string, and should contain only primitive data types.');
        
    end
    
    % correct for issue: 1D arrays and cell arrays where element shows up more
    % than once has weirdly shaped output.
    where1_size = size(where1);
    array_size = size(array);
    if array_size(1) == 1 & mod(where1_size(2), 2) == 0 &  where1_size(2) > 1
        where1 = transpose(where1(where1_size(2) / 2 + 1 : end));
        where1 = horzcat(ones(size(where1)), where1);
    end
    
end