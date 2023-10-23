% --- help for dependencies_saoy ---
% 
% Recursively list dependencies of a .m script or function file. Includes
% only scripts that are not produced by MathWorks.
% 
% Inputs
% ------
% filename : char vec
%     File name of the script. (Note: Using the full file path is ideal to
%     avoid ambiguities.
% 
% Outputs
% -------
% fList_1 : cell arr
%     List of MATLAB scripts and files on which filename depends.
% 
% pList_1 : struct
%     List of MATLAB products on which filename depends.
% 
% Examples
% --------
% folder = 'path_to_script_or_function\';
% file = 'script_or_function_name.m';
% [f p] = dependencies_saoy([folder file]);
% 

function [fList_1, pList_1] = dependencies_saoy(filename)
    [fList_1, pList_1] = matlab.codetools.requiredFilesAndProducts(filename);
    fList_1 = transpose(fList_1);
end
