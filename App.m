%% Application entry point if using code.

classdef App < matlab.apps.AppBase

    % Properties that correspond to app components
    properties (Access = public)
        UIFigure                    matlab.ui.Figure
        Image_3                     matlab.ui.control.Image
        Image_2                     matlab.ui.control.Image
        Image                       matlab.ui.control.Image
        Label                       matlab.ui.control.Label
        Label_4                     matlab.ui.control.Label
        Label_3                     matlab.ui.control.Label
        Label_6                     matlab.ui.control.Label
        AnalyzeDataButton           matlab.ui.control.Button
        OrganizeDataButton          matlab.ui.control.Button
        ImportHistoricalDataButton  matlab.ui.control.Button
        uBestEverPowerballNumberGeneratoruLabel  matlab.ui.control.Label
    end

    properties (Access = public)
        a = [];
        b = [];
        c = figure("Visible","off");
    end
    
    % Callbacks that handle component events
    methods (Access = private)

        % Code that executes after component creation
        function startupFcn(app)
            app.Image.Visible = "off";
            app.Image_2.Visible = "off";
            app.Image_3.Visible = "off";
        end

        % Button pushed function: ImportHistoricalDataButton
        function ImportHistoricalDataButtonPushed(app, event)

            % Loading image on:
            app.Image.Visible = "on";
            drawnow;

            % Download powerball data:
            a_site_scraper;

            % Done label on:
            app.Image.Visible = "off";
            app.Label_6.Text = "Done!";
            drawnow;
        end

        % Button pushed function: OrganizeDataButton
        function OrganizeDataButtonPushed(app, event)

            % Loading image on:
            app.Image_2.Visible = "on";
            drawnow;

            % Organize data:
            b_data_organizer;

            % Done label on:
            app.Image_2.Visible = "off";
            app.Label_3.Text = "Done!";
            drawnow;
        end

        % Button pushed function: AnalyzeDataButton
        function AnalyzeDataButtonPushed(app, event)

            % Loading image on:
            app.Image_3.Visible = "on";
            drawnow;

            % Analyze data:
            c_data_analyzer();

            % Done label on:
            app.Image_3.Visible = "off";
            app.Label_4.Text = "Done!";
            drawnow;

            % Open the output
            winopen(".\figure")
        end
    end

    % Component initialization
    methods (Access = private)

        % Create UIFigure and components
        function createComponents(app)

            % Get the file path for locating images
            pathToMLAPP = fileparts(mfilename('fullpath'));

            % Create UIFigure and hide until all components are created
            app.UIFigure = uifigure('Visible', 'off');
            app.UIFigure.Position = [100 100 760 520];
            app.UIFigure.Name = 'MATLAB App';

            % Create uBestEverPowerballNumberGeneratoruLabel
            app.uBestEverPowerballNumberGeneratoruLabel = uilabel(app.UIFigure);
            app.uBestEverPowerballNumberGeneratoruLabel.HorizontalAlignment = 'center';
            app.uBestEverPowerballNumberGeneratoruLabel.FontSize = 28;
            app.uBestEverPowerballNumberGeneratoruLabel.Interpreter = 'html';
            app.uBestEverPowerballNumberGeneratoruLabel.Position = [36 397 690 69];
            app.uBestEverPowerballNumberGeneratoruLabel.Text = '<u> Best Ever Powerball Analyzer* </u>';

            % Create ImportHistoricalDataButton
            app.ImportHistoricalDataButton = uibutton(app.UIFigure, 'push');
            app.ImportHistoricalDataButton.ButtonPushedFcn = createCallbackFcn(app, @ImportHistoricalDataButtonPushed, true);
            app.ImportHistoricalDataButton.FontSize = 16;
            app.ImportHistoricalDataButton.Position = [200 280 188 47];
            app.ImportHistoricalDataButton.Text = 'Import Historical Data';

            % Create OrganizeDataButton
            app.OrganizeDataButton = uibutton(app.UIFigure, 'push');
            app.OrganizeDataButton.ButtonPushedFcn = createCallbackFcn(app, @OrganizeDataButtonPushed, true);
            app.OrganizeDataButton.FontSize = 16;
            app.OrganizeDataButton.Position = [200 200 188 47];
            app.OrganizeDataButton.Text = 'Organize Data';

            % Create AnalyzeDataButton
            app.AnalyzeDataButton = uibutton(app.UIFigure, 'push');
            app.AnalyzeDataButton.ButtonPushedFcn = createCallbackFcn(app, @AnalyzeDataButtonPushed, true);
            app.AnalyzeDataButton.FontSize = 16;
            app.AnalyzeDataButton.Position = [200 120 188 47];
            app.AnalyzeDataButton.Text = 'Analyze Data';

            % Create Label_6
            app.Label_6 = uilabel(app.UIFigure);
            app.Label_6.Tag = 'Label_6';
            app.Label_6.HorizontalAlignment = 'center';
            app.Label_6.FontSize = 16;
            app.Label_6.Position = [475 286 67 34];
            app.Label_6.Text = ' ';

            % Create Label_3
            app.Label_3 = uilabel(app.UIFigure);
            app.Label_3.HorizontalAlignment = 'center';
            app.Label_3.FontSize = 16;
            app.Label_3.Position = [475 206 67 34];
            app.Label_3.Text = ' ';

            % Create Label_4
            app.Label_4 = uilabel(app.UIFigure);
            app.Label_4.HorizontalAlignment = 'center';
            app.Label_4.FontSize = 16;
            app.Label_4.Position = [475 126 67 34];
            app.Label_4.Text = ' ';

            % Create Label
            app.Label = uilabel(app.UIFigure);
            app.Label.HorizontalAlignment = 'center';
            app.Label.Position = [147 17 467 22];
            app.Label.Text = "* = better than what you'll find online or on TV";

            % Create Image
            app.Image = uiimage(app.UIFigure);
            app.Image.Position = [460 285 100 40];
            app.Image.ImageSource = fullfile(pathToMLAPP, 'resources', 'hzk6C.gif');

            % Create Image_2
            app.Image_2 = uiimage(app.UIFigure);
            app.Image_2.Position = [460 205 100 40];
            app.Image_2.ImageSource = fullfile(pathToMLAPP, 'resources', 'hzk6C.gif');

            % Create Image_3
            app.Image_3 = uiimage(app.UIFigure);
            app.Image_3.Position = [460 125 100 40];
            app.Image_3.ImageSource = fullfile(pathToMLAPP, 'resources', 'hzk6C.gif');

            % Show the figure after all components are created
            app.UIFigure.Visible = 'on';
        end
    end

    % App creation and deletion
    methods (Access = public)

        % Construct app
        function app = App

            % Create UIFigure and components
            createComponents(app)

            % Register the app with App Designer
            registerApp(app, app.UIFigure)

            % Execute the startup function
            runStartupFcn(app, @startupFcn)

            if nargout == 0
                clear app
            end
        end

        % Code that executes before app deletion
        function delete(app)

            % Delete UIFigure when app is deleted
            delete(app.UIFigure)
        end
    end
end