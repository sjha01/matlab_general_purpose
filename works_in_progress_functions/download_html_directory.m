function download_html_directory(input_url, output_folder, varargin)
    
    pnames = {'credentials_required', 'username', 'password'};
    dflts  = {true, 'username', 'password'};
    
    [credentials_required, username, password] = internal.stats.parseArgs(pnames, dflts, varargin{:});
    
    if ~strcmp(output_folder(end), '\')
        output_folder = [output_folder '\'];
    end
    
    if ~exist(output_folder, 'dir')
        mkdir(output_folder);
    end
    
    output_folder_details = dir(output_folder);
    output_folder_details = arrayfun(@(x) output_folder_details(x).name, 1:length(output_folder_details), 'UniformOutput', false);
    if ~sum((strcmp(output_folder_details, '.') + strcmp(output_folder_details, '..')) == 0) == 0
        error('Input parameter ''output_folder'' cannot correspond to a folder which contents prior to running function.');
    end
    
    if credentials_required
        html = urlread_auth(input_url, username, password);
    else
        html = webread(input_url); % untested
    end
    html = char(html);

    li_start = transpose(strfind(html, '<li>'));
    li_end = transpose(strfind(html, '</li>'));
    li = cell([length(li_start) 1]);
    li = transpose(arrayfun(@(x) html(li_start(x):li_end(x)), 1:length(li), 'UniformOutput', false));
    hrefs = cell(size(li));
    for i = 1:length(hrefs)
        href_start = where(li{i}, '='); href_start = href_start(1, 2) + 2;
        href_end = where(li{i}, '>'); href_end = href_end(2, 2) - 2;
        hrefs{i} = li{i}(href_start:href_end);
    end
    no_parents = (strcmp(hrefs, './') + strcmp(hrefs, '../')) == 0;
    hrefs = hrefs(no_parents);
    folders = endsWith(hrefs, '/');
    files = ~folders;
    hrefs_folders = hrefs(folders);
    hrefs_files = hrefs(files);
    for i = 1:length(hrefs_files)
        if credentials_required
            html_i = urlread_auth([input_url hrefs_files{i}], username, password);
        else
            html_i = webread(input_url); % untested
        end
        html_i = char(html_i);
        
        fid = fopen([output_folder hrefs_files{i}], 'w');
        fprintf('%s', html_i);
        fclose(fid);
        
    end
    for i = 1:length(hrefs_folders)
        download_html_directory([input_url hrefs_folders{i}], [output_folder hrefs_folders{i}], 'credentials_required', credentials_required, 'username', username, 'password', password);
    end

end

function [s,info] = urlread_auth(url, user, password)
%URLREAD_AUTH Like URLREAD, with basic authentication
%
% [s,info] = urlread_auth(url, user, password)
%
% Returns bytes. Convert to char if you're retrieving text.
%
% Examples:
% sampleUrl = 'http://browserspy.dk/password-ok.php';
% [s,info] = urlread_auth(sampleUrl, 'test', 'test');
% txt = char(s)

    % Matlab's urlread() doesn't do HTTP Request params, so work directly with Java
    jUrl = java.net.URL(url);
    conn = jUrl.openConnection();
    conn.setRequestProperty('Authorization', ['Basic ' base64encode([user ':' password])]);
    conn.connect();
    info.status = conn.getResponseCode();
    info.errMsg = char(readstream(conn.getErrorStream()));
    s = readstream(conn.getInputStream());
end

function out = base64encode(str)
% Uses Sun-specific class, but we know that is the JVM Matlab ships with
    encoder = sun.misc.BASE64Encoder();
    out = char(encoder.encode(java.lang.String(str).getBytes()));
end

function out = readstream(inStream)
%READSTREAM Read all bytes from stream to uint8
    try
        import com.mathworks.mlwidgets.io.InterruptibleStreamCopier;
        byteStream = java.io.ByteArrayOutputStream();
        isc = InterruptibleStreamCopier.getInterruptibleStreamCopier();
        isc.copyStream(inStream, byteStream);
        inStream.close();
        byteStream.close();
        out = typecast(byteStream.toByteArray', 'uint8'); %'
    catch err
        out = []; %HACK: quash
    end
end