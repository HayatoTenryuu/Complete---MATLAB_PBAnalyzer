%% This file performs the second test.

function secondTest(contents) 

    %----------------------------------------------------------------------
    % Second test - find the winning schema for 2000 to present, then plot:
    %----------------------------------------------------------------------

    % Phase 1 - Get locations for yearly data %
    fprintf(newline + "Performing Baseline Analysis for Years leading up to 2020." + newline)
    
    x = [1:69];
    x2 = [1:26];
    y = [];
    y2 = [];
    z = [];
    z2 = [];

    totlen = 0;
    
    % Get rid of empty cells:
    for a = 1:length(table2array(contents(:, "Date:")))
        if cell2mat(table2array(contents(a, "Date:"))) == ""
            totlen = a-1;
            break;
        end
    end

    % Find start and end of each year starting at 2020:
    datee = table2array(contents(totlen, "Date:"));
    presnt = str2double(datee{1}(1:4));

    range = presnt - 2020 + 1;
    q = cell(range, 2);

    for year = 2020:presnt
        for c = 1:totlen
            express = strcat(num2str(year),'-*');
            if regexp(cell2mat(table2array(contents(c, "Date:"))), express) == 1
                if year == 2020
                    q{1, 1} = c;
                    break;
                end

                r = year-2019;
                q{r, 1} = c;
                q{r-1, 2} = c-1;
                break;
            end
        end
    end

    q{range, 2} = totlen;

    % Phase 2 - Get yearly schema data (total count of each schema per drawing)

    % All in one counts
    perma_500 = 0;
    perma_050 = 0;
    perma_005 = 0;

    % Outer set counts
    perma_104 = 0;
    perma_203 = 0;
    perma_302 = 0;
    perma_401 = 0;
    
    % Middle exchange counts
    perma_140 = 0;
    perma_041 = 0;

    perma_230 = 0;
    perma_032 = 0;

    perma_320 = 0;
    perma_023 = 0;

    perma_410 = 0;
    perma_014 = 0;
    
    % Triple convolution counts
    perma_311 = 0;
    perma_131 = 0;
    perma_113 = 0;
    
    perma_221 = 0;
    perma_212 = 0;
    perma_122 = 0;

    % Red ball schema count
    perma_r1 = 0;
    perma_r2 = 0;
    perma_r3 = 0;

    for d = 1:range
        fprintf("Performing Complicated Analysis for Year " + num2str(2019 + d) + newline)
        drawings_this_year = q{d, 2} - q{d, 1} + 1;

        % All in one counts
        count_schema_500 = 0;
        count_schema_050 = 0;
        count_schema_005 = 0;

        % Outer set counts
        count_schema_104 = 0;
        count_schema_203 = 0;
        count_schema_302 = 0;
        count_schema_401 = 0;
        
        % Middle exchange counts
        count_schema_140 = 0;
        count_schema_041 = 0;

        count_schema_230 = 0;
        count_schema_032 = 0;

        count_schema_320 = 0;
        count_schema_023 = 0;

        count_schema_410 = 0;
        count_schema_014 = 0;
        
        % Triple convolution counts
        count_schema_311 = 0;
        count_schema_131 = 0;
        count_schema_113 = 0;
        
        count_schema_221 = 0;
        count_schema_212 = 0;
        count_schema_122 = 0;

        % Red ball schema count
        count_schema_r1 = 0;
        count_schema_r2 = 0;
        count_schema_r3 = 0;
    
        for draw = 0:(drawings_this_year - 1)           % five drawings means go 0:4
            goodlen = q{d, 1} + draw - 1;               % gets the stats up to the previous drawing
    
            % Part 1 - get stats up to current drawing (for schema baseline)
            data1 = string(table2array(contents(1:goodlen, "First ball:")));
            data2 = string(table2array(contents(1:goodlen, "Second ball:")));
            data3 = string(table2array(contents(1:goodlen, "Third ball:")));
            data4 = string(table2array(contents(1:goodlen, "Fourth ball:")));
            data5 = string(table2array(contents(1:goodlen, "Fifth ball:")));
            data6 = string(table2array(contents(1:goodlen, "Powerball:")));
            
            % White balls:
            for b = 1:69                                    % white ball number
            
                count = 0;
                
                for c = 1:goodlen
                    if str2double(data1(c)) == b            % first number drawn
                        count = count + 1;
                    end
                    if str2double(data2(c)) == b            % second number drawn
                        count = count + 1;
                    end
                    if str2double(data3(c)) == b
                        count = count + 1;
                    end
                    if str2double(data4(c)) == b
                        count = count + 1;
                    end
                    if str2double(data5(c)) == b
                        count = count + 1;
                    end
                end
            
                y(b) = count;                       % Number of times b (the white ball) was drawn within this year.
                z(b) = y(b) / length(data1);        % The denominator is how many drawings there have been
            
            end
            
            % Red balls:
            for b = 1:26
            
                count = 0;
                
                for c = 1:goodlen
                    if str2double(data6(c)) == b
                        count = count + 1;
                    end
                end
            
                y2(b) = count;
                z2(b) = y2(b) / length(data6);        % The denominator is how many red balls have been pulled.
            end
    
            % What this gave us, (because it's not obvious),
                % x[] is ball numbers 1-69 (the white ball numbers)
                % y[] is how often this year each ball number (corresponding entry in x) was drawn
                % z[] is the odds of each ball number (corresponding entry in x) being drawn
    
                % x2[], y2[], z2[] are the same with the red balls
        
            % Part 2 - Organize the schemas:
            wbest2019 = [x; y];
            wbest2019 = sortrows(wbest2019', 2, "descend")';
        
            rbest2019 = [x2; y2];
            rbest2019 = sortrows(rbest2019', 2, "descend")';
    
            White = cell(ceil(length(x)/3) + 1, 3);
            Red = cell(ceil(length(x2)/3) + 1, 3);
    
            White{1, 1} = 'Most Likely:';
            White{1, 2} = 'Mid';
            White{1, 3} = 'Least Likely';
            for entry = 2:24
                White{entry, 1} = wbest2019(1, entry-1);
                White{entry, 2} = wbest2019(1, 23 + entry - 1);
                White{entry, 3} = wbest2019(1, 46 + entry - 1);
            end
        
            Red{1, 1} = 'Most Likely:';
            Red{1, 2} = 'Mid';
            Red{1, 3} = 'Least Likely';
            for entry = 2:9
                Red{entry, 1} = rbest2019(1, entry-1);
                Red{entry, 2} = rbest2019(1, 9 + entry - 1);
                Red{entry, 3} = rbest2019(1, 18 + entry - 1);
            end
    
            % What this gave us:
                % White{} is a 23x3 cell divided up by Most, Mid, and Least likely numbers
                % Red{} is also done the same way.
            
                % We can now search each row of contents() between YearStart and YearEnd
                % using q{} to see if the first 5 elements are in White{1, 2, or 3} and
                % searching for the 6th element in Red{1, 2, or 3}
        
            % Part 3 - For each drawing of this year, calculate the winning schema
    
            % Count White Schema
            pain = table2array(contents(q{d, 1} + draw, 2:6));  % variable to hold white values per drawing, per year
            painr = table2array(contents(q{d, 1} + draw, 7));

            agony1 = cell2mat(White(2:24, 1))';         % Most likely
            agony2 = cell2mat(White(2:24, 2))';         % Mid
            agony3 = cell2mat(White(2:24, 3))';         % Least likely

            ragony1 = cell2mat(Red(2:9, 1))';
            ragony2 = cell2mat(Red(2:9, 2))';
            ragony3 = cell2mat(Red(2:9, 3))';

            % All in one
            if (sum(ismember(str2double(pain), agony1)) == 5) 
                count_schema_500 = count_schema_500 + 1;
            end

            if (sum(ismember(str2double(pain), agony2)) == 5)
                count_schema_050 = count_schema_050 + 1;
            end

            if (sum(ismember(str2double(pain), agony3)) == 5)
                count_schema_005 = count_schema_005 + 1;
            end

            % Outer set
            if (sum(ismember(str2double(pain), agony1)) == 1 && ...
                sum(ismember(str2double(pain), agony3)) == 4)

                count_schema_104 = count_schema_005 + 1;
            end

            if (sum(ismember(str2double(pain), agony1)) == 2 && ...
                sum(ismember(str2double(pain), agony3)) == 3)

                count_schema_203 = count_schema_203 + 1;
            end

            if (sum(ismember(str2double(pain), agony1)) == 3 && ...
                sum(ismember(str2double(pain), agony3)) == 2)

                count_schema_302 = count_schema_302 + 1;
            end

            if (sum(ismember(str2double(pain), agony1)) == 4 && ...
                sum(ismember(str2double(pain), agony3)) == 1)

                count_schema_401 = count_schema_401 + 1;
            end

            % Middle exchange
            if (sum(ismember(str2double(pain), agony2)) == 4 && ...
                sum(ismember(str2double(pain), agony1)) == 1)

                count_schema_140 = count_schema_140 + 1;
            end

            if (sum(ismember(str2double(pain), agony2)) == 4 && ...
                sum(ismember(str2double(pain), agony3)) == 1)

                count_schema_041 = count_schema_041 + 1;
            end

            if (sum(ismember(str2double(pain), agony2)) == 3 && ...
                sum(ismember(str2double(pain), agony1)) == 2)

                count_schema_230 = count_schema_230 + 1;
            end

            if (sum(ismember(str2double(pain), agony2)) == 3 && ...
                sum(ismember(str2double(pain), agony3)) == 2)

                count_schema_032 = count_schema_032 + 1;
            end

            if (sum(ismember(str2double(pain), agony2)) == 2 && ...
                sum(ismember(str2double(pain), agony1)) == 3)

                count_schema_320 = count_schema_320 + 1;
            end

            if (sum(ismember(str2double(pain), agony2)) == 2 && ...
                sum(ismember(str2double(pain), agony3)) == 3)

                count_schema_023 = count_schema_023 + 1;
            end

            if (sum(ismember(str2double(pain), agony2)) == 1 && ...
                sum(ismember(str2double(pain), agony1)) == 4)

                count_schema_410 = count_schema_410 + 1;
            end

            if (sum(ismember(str2double(pain), agony2)) == 1 && ...
                sum(ismember(str2double(pain), agony3)) == 4)

                count_schema_014 = count_schema_014 + 1;
            end

            % Triple convolution
            if (sum(ismember(str2double(pain), agony1)) == 3 && ...
                sum(ismember(str2double(pain), agony2)) == 1 && ...
                sum(ismember(str2double(pain), agony3)) == 1)

                count_schema_311 = count_schema_311 + 1;
            end

            if (sum(ismember(str2double(pain), agony1)) == 1 && ...
                sum(ismember(str2double(pain), agony2)) == 3 && ...
                sum(ismember(str2double(pain), agony3)) == 1)

                count_schema_131 = count_schema_131 + 1;
            end

            if (sum(ismember(str2double(pain), agony1)) == 1 && ...
                sum(ismember(str2double(pain), agony2)) == 1 && ...
                sum(ismember(str2double(pain), agony3)) == 3)

                count_schema_113 = count_schema_113 + 1;
            end

            if (sum(ismember(str2double(pain), agony1)) == 2 && ...
                sum(ismember(str2double(pain), agony2)) == 2 && ...
                sum(ismember(str2double(pain), agony3)) == 1)

                count_schema_221 = count_schema_221 + 1;
            end

            if (sum(ismember(str2double(pain), agony1)) == 2 && ...
                sum(ismember(str2double(pain), agony2)) == 1 && ...
                sum(ismember(str2double(pain), agony3)) == 2)

                count_schema_212 = count_schema_212 + 1;
            end

            if (sum(ismember(str2double(pain), agony1)) == 1 && ...
                sum(ismember(str2double(pain), agony2)) == 2 && ...
                sum(ismember(str2double(pain), agony3)) == 2)

                count_schema_122 = count_schema_122 + 1;
            end

            % Count red schema
            if ismember(str2double(painr), ragony1)
                count_schema_r1 = count_schema_r1 + 1;
            end

            if ismember(str2double(painr), ragony2)
                count_schema_r2 = count_schema_r2 + 1;
            end

            if ismember(str2double(painr), ragony3)
                count_schema_r3 = count_schema_r3 + 1;
            end
        end

        % Build figure for white
        fig1 = figure;
        subplot(1, 2, 1);
        xaxW = [count_schema_500, 0, 0, 0, 0, count_schema_050, 0, 0, 0, 0, count_schema_005;
            0, 0, count_schema_401, 0, count_schema_302, 0, count_schema_203, 0, count_schema_104, 0, 0;
            0, count_schema_410, count_schema_320, count_schema_230, count_schema_140, 0, count_schema_041, count_schema_032, count_schema_023, count_schema_014, 0;
            0, 0, 0, count_schema_311, count_schema_221, count_schema_212, count_schema_122, count_schema_113, 0, 0, 0;
            0, 0, 0, 0, 0, count_schema_131, 0, 0, 0, 0, 0];
        bar3(xaxW); 
        
        % Set axes labels
        set(gca, 'yticklabel', {'All in One', ...
            'Outer Pair', ...
            'Middle Exchange', ...
            'Triple, Outer Heavy', ...
            'Triple, Inner Heavy'});
        set(gca, 'xticklabel', {'Top Heavy', ...
            'Top Weighted', ...
            'Top Leaning', ...
            'Mid but Top Weighted', ...
            'Mid Leaning Up', ...
            'Perfectly Centered', ...
            'Mid Leaning Down', ...
            'Mid but Bottom Weighted', ...
            'Bottom Leaning', ...
            'Bottom Weighted', ...
            'Bottom Heavy'});
        
        subplot(1, 2, 2);
        xaxR = [count_schema_r1; count_schema_r2; count_schema_r3];
        bar3(xaxR);
        set(gca, 'yticklabel', {'Top Range', 'Mid Range', 'Bottom Range'});

        % Save figure to file
        locale = dir;
        last = length(locale);
        aru = false;
    
        for que = 1:last
            finder = locale(que).name;
            if finder == "figure"
                aru = true;
            end
        end
        
        if aru == false
            mkdir figure;   
        end
        
        % Save Text as likely/middle/unlikely sets
        set(fig1, "Visible", "on");                 % The figure remembers its visibility later
        filename = "figure\Year " + num2str(d + 2019) + " Schema Chart";
        if isfile(filename)
            delete(filename);
        end

        savefig(fig1, filename);

        set(fig1, "Visible", "off");
        
        % Update permanent values prior to moving to the new year
        
        % All in one counts
        perma_500 = perma_500 + count_schema_500;
        perma_050 = perma_050 + count_schema_050;
        perma_005 = perma_005 + count_schema_005;
    
        % Outer set counts
        perma_104 = perma_104 + count_schema_104;
        perma_203 = perma_203 + count_schema_203;
        perma_302 = perma_302 + count_schema_302;
        perma_401 = perma_401 + count_schema_401;
        
        % Middle exchange counts
        perma_140 = perma_140 + count_schema_140;
        perma_041 = perma_041 + count_schema_041;
    
        perma_230 = perma_230 + count_schema_230;
        perma_032 = perma_032 + count_schema_032;
    
        perma_320 = perma_320 + count_schema_320;
        perma_023 = perma_023 + count_schema_023;
    
        perma_410 = perma_410 + count_schema_410;
        perma_014 = perma_014 + count_schema_014;
        
        % Triple convolution counts
        perma_311 = perma_311 + count_schema_311;
        perma_131 = perma_131 + count_schema_131;
        perma_113 = perma_113 + count_schema_113;
        
        perma_221 = perma_221 + count_schema_221;
        perma_212 = perma_212 + count_schema_212;
        perma_122 = perma_122 + count_schema_122;
    
        % Red ball schema count
        perma_r1 = perma_r1 + count_schema_r1;
        perma_r2 = perma_r2 + count_schema_r2;
        perma_r3 = perma_r3 + count_schema_r3;
    end 

    % Phase 3 - Bar plot the schemas across all years (single plot per schema)
    fprintf("Performing some final analysis." + newline)

    % Build figure for white
    fig2 = figure;
    subplot(1, 2, 1);
    xaxW = [perma_500, 0, 0, 0, 0, perma_050, 0, 0, 0, 0, perma_005;
        0, 0, perma_401, 0, perma_302, 0, perma_203, 0, perma_104, 0, 0;
        0, perma_410, perma_320, perma_230, perma_140, 0, perma_041, perma_032, perma_023, perma_014, 0;
        0, 0, 0, perma_311, perma_221, perma_212, perma_122, perma_113, 0, 0, 0;
        0, 0, 0, 0, 0, perma_131, 0, 0, 0, 0, 0];
    bar3(xaxW); 
    
    % Set axes labels
    set(gca, 'yticklabel', {'All in One', ...
        'Outer Pair', ...
        'Middle Exchange', ...
        'Triple, Outer Heavy', ...
        'Triple, Inner Heavy'});
    set(gca, 'xticklabel', {'Top Heavy', ...
        'Top Weighted', ...
        'Top Leaning', ...
        'Mid but Top Weighted', ...
        'Mid Leaning Up', ...
        'Perfectly Centered', ...
        'Mid Leaning Down', ...
        'Mid but Bottom Weighted', ...
        'Bottom Leaning', ...
        'Bottom Weighted', ...
        'Bottom Heavy'});
    
    subplot(1, 2, 2);
    xaxR = [count_schema_r1; count_schema_r2; count_schema_r3];
    bar3(xaxR);
    set(gca, 'yticklabel', {'Top Range', 'Mid Range', 'Bottom Range'});

    % Save figure to file
    locale = dir;
    last = length(locale);
    aru = false;

    for que = 1:last
        finder = locale(que).name;
        if finder == "figure"
            aru = true;
        end
    end
    
    if aru == false
        mkdir figure;   
    end
    
    % Save Text as likely/middle/unlikely sets
    set(fig2, "Visible", "on");
    filename = "figure\Schema Performace Since 2020";
    if isfile(filename)
        delete(filename);
    end

    savefig(fig2, filename);
    
    set(fig2, "Visible", "on");    
end