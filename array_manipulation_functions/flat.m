% --- help for flat --- 
% 
% flatten an array from size [m n] to size [1 m*n]
% 

function flat1 = flat(array)
    
    flat1 = reshape(array, [1 prod(size(array))]);
    
end
