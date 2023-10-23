% --- help for backslash ---
% 
% Make sure a char vector ends with a backslash. Intended for folder names.
% 
% Inputs
% ------
% folder_name : char vector
%     Name of folder.
% 
% Outputs
% -------
% backslash_1 : char vector
%     Name of folder, with an additional backslash at the end if there was
%     none before.
% 

function backslash_1 = backslash(folder_name)
    
    if ~ isequal(folder_name(end), '\')
        backslash_1 = [folder_name '\'];
    else
        backslash_1 = folder_name;
    end
    
end
