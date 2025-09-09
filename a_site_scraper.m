%% This file pulls the data from the web.

function a_site_scraper()

    % Setup:
    clear
    clc

    p = length(char(datetime("today")));
    kotoshi = extractAfter(char(datetime("today")), p-4);

    daterange = str2num(kotoshi) - 1992;

    % Get the data:
    for u = 0:daterange        % This represents the years of Powerball data, should return errors. If not, increase year count.
        
        try
    
            % Pull each year's data from powerball website
            site = "https://www.powerball.net/archive/" + int2str(u + 1992);   % The first year of powerball was 1992
            pause(0.5);
            try
                stroo = webread(site);
            catch exception
                warndlg("They are trying to fight back. To win, change your IP via a VPN and try to rerun this step. Alternatively, you can try waiting for, like, 10 minutes and see if you can reaccess in your browser.", "Data Access Error");
            end
            
            % Save that year's data as an HTML file.
            now = length(pwd);
            aru = false;

            if(now == regexp(pwd, 'Projects') + length('Projects') - 1)
                cd 'PB Parser';
            end
        
            folders = dir;
            last = length(dir);
            
            for q = 1:last
                finder = folders(q).name;
                if finder == "data"
                    aru = true;
                end
            end
    
            if aru == false
                mkdir data;         
            end
    
            nama = "Powerball_Year_" + int2str(u) + ".html";
            fid = fopen("data\" + nama, "w+");
            fprintf(fid, stroo);
            fclose(fid);
    
        catch exception
            
            warndlg("There has been some kind of error with the data, Onii-chan. Please look into it.", "Error");
    
        end
    
        
    end

    return;
end