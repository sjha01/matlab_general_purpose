% --- help for save_each ---
% 
% saves each variable in workspace, with each file name corresponding to each
% variable name.
% 
% Inputs
% ------
% folder_name : char vector
%     name of base folder to save matlab variables in.
% 
% Outputs
% -------
% None
% 
% Examples
% --------
% a = 1; b =2;
% save_each(''); % In present working directory, saves a.mat, containing
%                % variable a with value 1, and b.mat, containing variable b
%                % with value 2.
% 

function save_each(folder_name)
  
  if ~exist(folder_name, 'dir')
    mkdir(folder_name);
  end
  
  var_names = evalin('base', 'who');
  
  for i = 1:length(var_names)
    var_name = evalin('base', var_names{i});
    save(strcat(folder_name, '\', var_names{i}, '.mat'), var_to_string(var_name));
  end
  
end
