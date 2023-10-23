% --- help for concatenate_structs_saoy ---
% 
% Concatenate multiple structs.
% 
% Inputs
% ------
% cell_with_structs : cell arr
%     Cell array containing structs which will be concatenated.
% 
% Outputs
% -------
% concatenate_structs_1 : struct
%     Concatenated struct, containing fields of every element of the
%     original structs in cell_with_structs.
% 
% Examples
% --------
% struct_1.a = 1;
% struct_2.b = 2;
% struct_2.c = 3;
% struct_3.d = 4;
% struct_all = concatenate_structs(struct_1, struct_2, struct_3);
% % output has fields a, b, c, and d.
% 

% Improvements
% ------------
% Checking for repeated fields between structs, and ways to handle this.

function concatenate_structs_1 = concatenate_structs_saoy(cell_with_structs)
    
    % error checking
    
    if ~strcmp(class(cell_with_structs), 'cell')
        error('Input ''cell_with_structs'' must be 1D cell array of structs.');
    end
    
    if ~((length(size(cell_with_structs)) == 2) & ismember(1, size(cell_with_structs)))
        error('Input ''cell_with_structs'' must be 1D cell array of structs.');
    end
    
    for i = 1:length(cell_with_structs)
        if ~strcmp(class(cell_with_structs{i}), 'struct')
            error('Input ''cell_with_structs'' must be 1D cell array of structs.');
        end
    end
    
    % main code
    
    concatenate_structs_1 = cell_with_structs{1};
    
    if length(cell_with_structs) > 1
        for i = 1:length(cell_with_structs)
            temp_struct = cell_with_structs{i};
            temp_struct_fieldnames = fieldnames(temp_struct);
            for j = 1:length(temp_struct_fieldnames)
                concatenate_structs_1.(temp_struct_fieldnames{j}) = temp_struct.(temp_struct_fieldnames{j});
            end
        end
    end

end
