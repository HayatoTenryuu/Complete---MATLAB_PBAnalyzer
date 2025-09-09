%% This file pulls the exported data and does some analysis.

function c_data_analyzer()

    %--------
    % Setup:
    %--------
    clear
    clc
    
    data1 = [];
    data2 = [];
    data3 = [];
    data4 = [];
    data5 = [];
    data6 = [];

    goodlen = 0;
    
    %--------------------
    % Import Total data:
    %--------------------
    fid = fopen("excel\Powerball total data.xlsx", "r");                                  % Open as read-only so you don't make the data files empty
    contents = readtable("excel\Powerball total data.xlsx", Range = "D5:J1500", ...
        ReadVariableNames=true, VariableNamingRule="preserve");                           % Import the file's text
    fclose(fid);                                                                          % Let go of the file once the data is imported
    
    %-------------------------
    % Perform the First Test:
    %-------------------------
    
    [w, r, fig] = unoTest(contents);
    
    %-------------------------
    % Perform the Second Test:
    %-------------------------

    duoTest(contents);

    %-------------------------
    %   Output data to file:
    %-------------------------
    
    locale = dir;
    last = length(locale);
    aru = false;
    
    for q = 1:last
        finder = locale(q).name;
        if finder == "figure"
            aru = true;
        end
    end
    
    if aru == false
        mkdir figure;   
    end
    
    % Save Text as likely/middle/unlikely sets
    filename = "figure\Powerball stats.xlsx";
    if isfile(filename)
        delete(filename);
    end

    writematrix("White Ball:", filename, Sheet = 1, Range = "C3");
    writematrix("Often:", filename, Sheet = 1, Range = "D4");
    writematrix("Mid:", filename, Sheet = 1, Range = "E4");
    writematrix("Rare:", filename, Sheet = 1, Range = "F4");
    writematrix(w(1:23)', filename, Sheet = 1, Range = "D5");
    writematrix(w(24:46)', filename, Sheet = 1, Range = "F5");
    writematrix(w(47:69)', filename, Sheet = 1, Range = "H5");

    writematrix("Red Ball:", filename, Sheet = 1, Range = "C29");
    writematrix("Often:", filename, Sheet = 1, Range = "D30");
    writematrix("Mid:", filename, Sheet = 1, Range = "E30");
    writematrix("Rare:", filename, Sheet = 1, Range = "F30");    
    writematrix(r(1:8)', filename, Sheet = 1, Range = "D31");
    writematrix(r(9:17)', filename, Sheet = 1, Range = "F31");
    writematrix(r(18:26)', filename, Sheet = 1, Range = "H31");

    for a = 1:length(table2array(contents(:, "Date:")))
        if cell2mat(table2array(contents(a, "Date:"))) == ""
            goodlen = a-1;
            break;
        end
    end

    % Identify the schema of the last set of numbers by placing a 1 next to them
    for u = 1:69
        if ((u < 24) && (w(u) == str2double(cell2mat(table2array(contents(goodlen, 2)))))) || ((u < 24) && (w(u) == str2double(cell2mat(table2array(contents(goodlen, 3)))))) || ...
                ((u < 24) && (w(u) == str2double(cell2mat(table2array(contents(goodlen, 4)))))) || ((u < 24) && (w(u) == str2double(cell2mat(table2array(contents(goodlen, 5)))))) || ...
                ((u < 24) && (w(u) == str2double(cell2mat(table2array(contents(goodlen, 6))))))
            writematrix(1, filename, Sheet = 1, Range = "E" + num2str(4+u));
        elseif ((u >= 24) && (u < 47) && (w(u) == str2double(cell2mat(table2array(contents(goodlen, 2)))))) || ((u >= 24) && (u < 47) && (w(u) == str2double(cell2mat(table2array(contents(goodlen, 3)))))) || ...
                ((u >= 24) && (u < 47) && (w(u) == str2double(cell2mat(table2array(contents(goodlen, 4))))))  || ((u >= 24) && (u < 47) && (w(u) == str2double(cell2mat(table2array(contents(goodlen, 5))))))  || ...
                ((u >= 24) && (u < 47) && (w(u) == str2double(cell2mat(table2array(contents(goodlen, 6)))))) 
            writematrix(1, filename, Sheet = 1, Range = "G" + num2str(4+u-23));
        elseif ((u >= 47) && (u < 70) && (w(u) == str2double(cell2mat(table2array(contents(goodlen, 2))))))  || ((u >= 47) && (u < 70) && (w(u) == str2double(cell2mat(table2array(contents(goodlen, 3)))))) || ...
                ((u >= 47) && (u < 70) && (w(u) == str2double(cell2mat(table2array(contents(goodlen, 4)))))) || ((u >= 47) && (u < 70) && (w(u) == str2double(cell2mat(table2array(contents(goodlen, 5)))))) || ...
                ((u >= 47) && (u < 70) && (w(u) == str2double(cell2mat(table2array(contents(goodlen, 6)))))) 
            writematrix(1, filename, Sheet = 1, Range = "I" + num2str(4+u-46));
        end
    end

    for u = 1:26
        if ((u < 9) && (r(u) == str2double(cell2mat(table2array(contents(goodlen, 7)))))) 
            writematrix(1, filename, Sheet = 1, Range = "E" + num2str(29+u));
        elseif ((u >= 9) && (u < 18) && (r(u) == str2double(cell2mat(table2array(contents(goodlen, 7)))))) 
            writematrix(1, filename, Sheet = 1, Range = "G" + num2str(29+u-8));
        elseif ((u >= 18) && (u < 27) && (r(u) == str2double(cell2mat(table2array(contents(goodlen, 7)))))) 
            writematrix(1, filename, Sheet = 1, Range = "I" + num2str(29+u-17));
        end
    end
    
    % Save Image
    filename = "figure\Powerball figure data.png";
    if isfile(filename)
        delete(filename);
    end
    saveas(fig, filename);
    fig.Visible = "off";

    return;
end
