% --- help for var_to_string ---
% 
% name of variable as string
% 
% Inputs
% ------
% var : can be anything
%     The variable.
% 
% Outputs
% -------
% out : char vector
%     A string containing the name of var.
% 
% Examples
% --------
% my_num = 50;
% my_str = var_to_string(my_num); % my_str = 'my_num';
% 
% See also
% --------
% eval
% 

function out = var_to_string(var)
  out = inputname(1);
end
