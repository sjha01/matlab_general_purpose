% --- help for xml_tag_read_2_saoy ---
% 
% Finds each occurence of a specified tag in an xml, and puts resulting
% data inside the tag from each instance in a cell array.
% 
% Inputs
% ------
% file_name : string
%     The file containing the tag and relevant data.
% 
% tag_name : string
%     The tag for which data is to be extracted.
% 
% Outputs
% -------
% xml_tag_read_1 : cell arr
%     Cell array of strings, where each string contains the information
%     within each occurrence of the specified tag.
% 
% Examples
% --------
% wafer_ids = xml_tag_read_2_saoy('my_ADELler.xml', 'WaferId');
% 
% Notes
% -----
% Intended for use with xml's (or other text files) which have starting and
% ending tags with the same name. Not designed to handle nested tags of the
% same name, e.g., <tag1><tag1></tag1></tag1>.
% 
% See also
% --------
% xml2struct
% 

% Improvements
% ------------
% 1. Handle nested tags of the same name.
% 2. Ensure that the number of end tags is equal to the number of start
%    tags.
function xml_tag_read_1 = xml_tag_read_2_saoy(file_name, tag_name)
    
    % define start and end tags based on tag_name
    start_tag = ['<' tag_name '>'];
    end_tag = ['</' tag_name '>'];
    
    % read in ADEL
    fid = fopen(file_name);
    file_text = textscan(fid, '%s');
    fclose(fid);
    
    % convert to character vector
    file_text = file_text{1};
    file_text = join(file_text);
    file_text = file_text{1};
    
    % find all locations of start and end tags
    start_tag_inds = strfind(file_text, start_tag) + length(start_tag);
    end_tag_inds = strfind(file_text, end_tag) - 1;
    
    % read content between each start and end tag into element of cell array.
    xml_tag_read_1 = cell([length(start_tag_inds) + 1, 1]);
    xml_tag_read_1{1} = tag_name;
    for i = 1:(length(start_tag_inds))
        xml_tag_read_1{i + 1} = file_text(start_tag_inds(i):end_tag_inds(i));
    end
end
