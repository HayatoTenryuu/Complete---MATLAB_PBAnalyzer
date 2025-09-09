%% This file organizes the data and exports excel files.

function b_data_organizer()

    % Setup
    clear
    clc

    if(length(pwd) == regexp(pwd, 'Projects') + length('Projects') - 1)
        cd 'PB Parser';
    end
    
    cd data;
    datnum = length(dir) - 3;
    cd ..;
    data2 = [];
    
    for u = 0:datnum
        
        % Initialize arrays
        dateArray = {};
        b1Array = {};
        b2Array = {};
        b3Array = {};
        b4Array = {};
        b5Array = {};
        rbArray = {};
    
        try 
    
            fid = fopen("data\Powerball_Year_" + int2str(u) + ".html", "r");        % Open as read-only so you don't make the data files empty
            contents = fileread("data\Powerball_Year_" + int2str(u) + ".html");     % Import the file's text
            
            search_line_a = '<a class="archive-box" href="/numbers/';               % Date keyword search
            search_line_b = '<div class="ball">';                                   % White Ball keyword search
            search_line_c = '<div class="powerball">';                              % Red Ball keyword search
    
            date_points = strfind(contents, search_line_a);                         % Find the location/index of each date
            wb_points = strfind(contents, search_line_b);                           % Find the location/index of each white ball number
            rb_points = strfind(contents, search_line_c);                           % Find the location/index of each red ball number
    
            index = 1;                                                              % Some things need to increment differently
    
            % Find values of each variable and assign it to arrays:
            for v = 1:length(date_points)
           
                % Capture the 10-digit date (YYYY-MM-DD format):
                dateArray = [dateArray, contents((date_points(v) + length(search_line_a)):(date_points(v) + length(search_line_a) + 9))];
                
                % Capture the white ball numbers (assume 2 digits long):
                b1Array = [b1Array, contents((wb_points(index) + length(search_line_b)):(wb_points(index) + length(search_line_b) + 1))];
                b2Array = [b2Array, contents((wb_points(index+1) + length(search_line_b)):(wb_points(index+1) + length(search_line_b) + 1))];
                b3Array = [b3Array, contents((wb_points(index+2) + length(search_line_b)):(wb_points(index+2) + length(search_line_b) + 1))];
                b4Array = [b4Array, contents((wb_points(index+3) + length(search_line_b)):(wb_points(index+3) + length(search_line_b) + 1))];
                b5Array = [b5Array, contents((wb_points(index+4) + length(search_line_b)):(wb_points(index+4) + length(search_line_b) + 1))];
                
                % Capture the red ball numbers (assume 2 digits long):
                rbArray = [rbArray, contents((rb_points(v) + length(search_line_c)):(rb_points(v) + length(search_line_c) + 1))];
    
                % Test if the ball numbers are one or two digits long. If only one digit, kill the second character in the array:
                B1 = char(b1Array(v));                  % convert the cell to a char array
                if double(B1(2)) == 60                  % double('<') returns 60
                    b1Array(v) = cellstr(B1(1));        % convert back to a cell and reassign
                end
    
                B2 = char(b2Array(v));
                if double(B2(2)) == 60
                    b2Array(v) = cellstr(B2(1));
                end
    
                B3 = char(b3Array(v));
                if double(B3(2)) == 60
                    b3Array(v) = cellstr(B3(1));
                end
    
                B4 = char(b4Array(v));
                if double(B4(2)) == 60
                    b4Array(v) = cellstr(B4(1));
                end
    
                B5 = char(b5Array(v));
                if double(B5(2)) == 60
                    b5Array(v) = cellstr(B5(1));
                end
    
                RB = char(rbArray(v));
                if double(RB(2)) == 60
                    rbArray(v) = cellstr(RB(1));
                end
    
    
                index = index + 5;
    
            end
            
            fclose(fid);
            v = 0;
            
        catch err
    
            fprintf("We have an error..." + newline);
    
        end
    
        % Make table for each file's data (yearly):
        dateTable = string(dateArray);
        b1Table = string(b1Array);
        b2Table = string(b2Array);
        b3Table = string(b3Array);
        b4Table = string(b4Array);
        b5Table = string(b5Array);
        rbTable = string(rbArray);
        
        % Make table with rows for each value type:
        data = table(flip(dateTable'), flip(b1Table'), flip(b2Table'), flip(b3Table'), flip(b4Table'), flip(b5Table'), flip(rbTable'), ...
            'VariableNames', ["Date:", "First ball:", "Second ball:", "Third ball:", "Fourth ball:", "Fifth ball:", "Powerball:"]);
    
        
        % Table for all files (overall)
        newrow = [flip(dateTable'), flip(b1Table'), flip(b2Table'), flip(b3Table'), flip(b4Table'), flip(b5Table'), flip(rbTable')];
        block = extractBetween(newrow(1, 1), 1, 4);
        if str2num(block) > 2015
            data2 = [data2; newrow];
        end
    
        % Output yearly data table to Excel File:
        locale = dir;
        last = length(locale);
        aru = false;
        
        for q = 1:last
            finder = locale(q).name;
            if finder == "excel"
                aru = true;
            end
        end
    
        if aru == false
            mkdir excel;   
        elseif (aru == true) && (u == 0)
            rmdir("excel\", "s");
            mkdir excel;
        end
    
        filename = "excel\Powerball " + int2str(u + 1992) + " data.xlsx";
        if isfile(filename)
            delete(filename);
        end
        writetable(data,filename,'Sheet',1,'Range','D4');
    
    end
    
    % Output total data to Excel File
    headers = ["Date:", "First ball:", "Second ball:", "Third ball:", "Fourth ball:", "Fifth ball:", "Powerball:"];
    data2 = [headers; data2];
    data2 = table(data2, 'VariableNames', " ");
    
    filename = "excel\Powerball total data.xlsx";
    if isfile(filename)
        delete(filename);
    end
    writetable(data2, filename,'Sheet',1,'Range','D4');

    return;
end
