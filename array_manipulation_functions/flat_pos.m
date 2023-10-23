% --- help for flat_pos ---
% 
% Given array shape and index of interest, returns the index of interest in
% a flattened version of the array.
% 
% Inputs
% ------
% array_shape : double arr
%     Shape of array for which indices will be mapped to flatten version of
%     the array.
% 
% array_pos : double arr
%     The indices in an array of shape array_shape for which corresponding
%     index in flattened version of the array is to be found.
% 
% Outputs
% -------
% flat_pos_1 : double
%     Index of interest in a flattened version of the array.
% 

function flat_pos_1 = flat_pos(array_shape, array_pos)
    
    shaped_array = reshape(1:prod(array_shape), array_shape);
    array_pos = num2cell(array_pos);
    flat_pos_1 = shaped_array(array_pos{:});
    
end
