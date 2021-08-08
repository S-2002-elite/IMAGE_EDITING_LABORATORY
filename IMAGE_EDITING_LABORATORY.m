classdef IMAGE_EDITING_LABORATORY < matlab.apps.AppBase

    % Properties that correspond to app components
    properties (Access = public)
        UIFigure         matlab.ui.Figure
        uibuttongroup1   matlab.ui.container.ButtonGroup
        pushbutton1      matlab.ui.control.Button
        pushbutton2      matlab.ui.control.Button
        pushbutton3      matlab.ui.control.Button
        pushbutton4      matlab.ui.control.Button
        axes1            matlab.ui.control.UIAxes
        axes2            matlab.ui.control.UIAxes
        uibuttongroup4   matlab.ui.container.ButtonGroup
        pushbutton5      matlab.ui.control.Button
        pushbutton6      matlab.ui.control.Button
        pushbutton7      matlab.ui.control.Button
        pushbutton8      matlab.ui.control.Button
        text11           matlab.ui.control.Label
        uibuttongroup3   matlab.ui.container.ButtonGroup
        text2            matlab.ui.control.Label
        text3            matlab.ui.control.Label
        text4            matlab.ui.control.Label
        SliderLabel      matlab.ui.control.Label
        Slider           matlab.ui.control.Slider
        Slider_2Label    matlab.ui.control.Label
        Slider_2         matlab.ui.control.Slider
        Slider_3Label    matlab.ui.control.Label
        Slider_3         matlab.ui.control.Slider
        uibuttongroup6   matlab.ui.container.ButtonGroup
        pushbutton12     matlab.ui.control.Button
        pushbutton13     matlab.ui.control.Button
        pushbutton14     matlab.ui.control.Button
        uibuttongroup7   matlab.ui.container.ButtonGroup
        pushbutton17     matlab.ui.control.Button
        pushbutton18     matlab.ui.control.Button
        pushbutton19     matlab.ui.control.Button
        uibuttongroup8   matlab.ui.container.ButtonGroup
        pushbutton20     matlab.ui.control.Button
        pushbutton21     matlab.ui.control.Button
        pushbutton22     matlab.ui.control.Button
        pushbutton23     matlab.ui.control.Button
        uibuttongroup16  matlab.ui.container.ButtonGroup
        pushbutton33     matlab.ui.control.Button
        pushbutton30     matlab.ui.control.Button
        pushbutton26     matlab.ui.control.Button
        pushbutton31     matlab.ui.control.Button
        pushbutton27     matlab.ui.control.Button
        pushbutton29     matlab.ui.control.Button
        pushbutton28     matlab.ui.control.Button
        pushbutton15     matlab.ui.control.Button
        pushbutton16     matlab.ui.control.Button
        pushbutton24     matlab.ui.control.Button
        pushbutton33_2   matlab.ui.control.Button
        pushbutton10     matlab.ui.control.Button
        pushbutton9      matlab.ui.control.Button
        pushbutton32     matlab.ui.control.Button
        text7_2          matlab.ui.control.Label
        text5_2          matlab.ui.control.Label
        text6_2          matlab.ui.control.Label
        text5_3          matlab.ui.control.Label
        text11_2         matlab.ui.control.Label
    end

    % Callbacks that handle component events
    methods (Access = private)

        % Button pushed function: pushbutton1
        function uploadimage(app, event)
            [FileName, PathName] = uigetfile({'*.*'},'Select a image file');
            imshow(fullfile(PathName, FileName), 'Parent', app.axes1);
        end

        % Button pushed function: pushbutton2
        function rgb2gray(app, event)
            a = getimage(app.axes1);
            [rows, columns, numberOfColorChannels] = size(a);
            if numberOfColorChannels > 1
                a_gray = rgb2gray(a);
            else
                a_gray = a;
            end
            imshow(a_gray, 'Parent', app.axes2);
        end

        % Button pushed function: pushbutton3
        function rgb2hsv(app, event)
            a=getimage(app.axes1);
            [rows,columns,numberOfColorChannels] = size(a);
            if numberOfColorChannels ==3
                a_hsv = rgb2hsv(a);
            else
                error = errordlg('It is a gray scale image','image Error');
                imshow(error,'Parent',app.axes2);
            end
            imshow(a_hsv,'Parent',app.axes2);
        end

        % Button pushed function: pushbutton4
        function binaryimage(app, event)
            a=getimage(app.axes1);
            [rows,columns,numberOfColorChannels] = size(a);
            if numberOfColorChannels > 1
                a_gray = rgb2gray(a);
            else
                a_gray = a;
            end
             a_gray=im2double(a_gray);
             otsu_level=graythresh(a_gray);
             a_otsu_thresh=im2bw(a_gray,otsu_level);
             imshow(a_otsu_thresh, 'Parent', app.axes2);
        end

        % Button pushed function: pushbutton5
        function sharpness(app, event)
            a=getimage(app.axes1);
            a_sharpen = imsharpen(a,'Amount',3);
            imshow(a_sharpen,'Parent',app.axes2);
        end

        % Button pushed function: pushbutton6
        function whitebalance(app, event)
             a=getimage(app.axes1);
             [rows,columns,numberOfColorChannels] = size(a);
            if numberOfColorChannels == 3
                a_gray = rgb2gray(a);
            else
                error = errordlg('It is a gray scale image','image Error');
                imshow(error,'Parent',app.axes2);
            end
            redChannel = a(:,:,1);
            greenChannel = a(:,:,2);
            blueChannel = a(:,:,3);
            meanR = mean2(redChannel);
            meanG = mean2(greenChannel);
            meanB = mean2(blueChannel);
            meanGray = mean2(a_gray);
            redChannel = uint8(double(redChannel)*meanGray/meanR);
            greenChannel = uint8(double(greenChannel)*meanGray/meanG);
            blueChannel = uint8(double(blueChannel)*meanGray/meanB);
            rgbImage_1 = cat(3, redChannel, greenChannel, blueChannel);
            imshow(rgbImage_1,'Parent',app.axes2);
        end

        % Button pushed function: pushbutton7
        function grayadjust(app, event)
            a=getimage(app.axes1);
            [rows,columns,numbersOfColorChannels] = size(a);
            if numbersOfColorChannels > 1
                a_gray = rgb2gray(a);
            else
                a_gray = a;
            end
            gray_adj = imadjust(a_gray);
            imshow(gray_adj,'Parent',app.axes2);
        end

        % Button pushed function: pushbutton8
        function coloradjust(app, event)
            a=getimage(app.axes1);
            [rows,columns,numberOfColorChannels] = size(a);
            if numberOfColorChannels == 3
                redChannel = a(:,:,1);
                greenChannel = a(:,:,2);
                blueChannel = a(:,:,3);
                adj_R = imadjust(redChannel);
                adj_G = imadjust(greenChannel);
                adj_B = imadjust(blueChannel);
                color_adj = cat(3, adj_R,adj_G,adj_B);
                imshow(color_adj,'Parent',app.axes2);
            else
                error = errordlg('It is a gray scale image','image Error');
                imshow(error,'Parent',app.axes2);
            end
        end

        % Button pushed function: pushbutton9
        function histogram(app, event)
            a=getimage(app.axes1);
            imhist(a);
            axis auto;
            axes(app.axes2);
            [counts,binLocations] = imhist(a);
            stem(app.axes2,binLocations,counts);
        end

        % Button pushed function: pushbutton10
        function histogramequalization(app, event)
            a=getimage(app.axes1);
            [rows,columns,numberOfColorChannels] = size(a);
            if numberOfColorChannels == 3
                a_hsv = rgb2hsv(a);
                vChannel = a_hsv(:,:,3);
                vChannel_he = histeq(vChannel);
                a_hsv(:,:,3) = vChannel_he;
                a_he_rgb = hsv2rgb(a_hsv);
                imshow(a_he_rgb,'Parent',app.axes2);
            else numberOfColorChannels == 0
                a_he_gray = histeq(a);
                imshow(a_he_gray,'Parent',app.axes2);
            end
        end

        % Button pushed function: pushbutton12
        function prewittedge(app, event)
            a=getimage(app.axes1);
            [rows,columns,numbersOfColorChannels] = size(a);
            if numbersOfColorChannels > 1
                a_gray = rgb2gray(a);
            else
                a_gray = a;
            end
            a_prewitt = edge(a_gray,'prewitt');
            imshow(a_prewitt,'Parent',app.axes2);
        end

        % Button pushed function: pushbutton13
        function sobeledge(app, event)
            a=getimage(app.axes1);
            [rows,columns,numbersOfColorChannels] = size(a);
            if numbersOfColorChannels > 1
                a_gray = rgb2gray(a);
            else
                a_gray = a;
            end
            a_sobel = edge(a_gray,'sobel');
            imshow(a_sobel,'Parent',app.axes2);
        end

        % Button pushed function: pushbutton14
        function cannyedge(app, event)
            a=getimage(app.axes1);
            [rows,columns,numbersOfColorChannels] = size(a);
            if numbersOfColorChannels > 1
                a_gray = rgb2gray(a);
            else
                a_gray = a;
            end
            a_canny = edge(a_gray,'canny');
            imshow(a_canny,'Parent',app.axes2);
        end

        % Button pushed function: pushbutton17
        function gaussiannoise(app, event)
            a=getimage(app.axes1);
            a_gaussian = imnoise(a,"gaussian");
            imshow(a_gaussian,'Parent',app.axes2);
        end

        % Button pushed function: pushbutton18
        function specklenoise(app, event)
            a=getimage(app.axes1);
            a_speckle = imnoise(a,"speckle");
            imshow(a_speckle,'Parent',app.axes2);
        end

        % Button pushed function: pushbutton19
        function saltandpeppernoise(app, event)
            a=getimage(app.axes1);
            a_salt_pepper = imnoise(a,"salt & pepper");
            imshow(a_salt_pepper,'Parent',app.axes2);
        end

        % Button pushed function: pushbutton20
        function averagefilter(app, event)
            a=getimage(app.axes1);
            a_average = fspecial('average',3);
            average_filt = imfilter(a,a_average);
            imshow(average_filt,'Parent',app.axes2);
        end

        % Button pushed function: pushbutton21
        function gaussianfilter(app, event)
            a=getimage(app.axes1);
            a_gaussian = fspecial('gaussian',3);
            gaussian_filt = imfilter(a,a_gaussian);
            imshow(gaussian_filt,'Parent',app.axes2);
        end

        % Button pushed function: pushbutton22
        function medianfilter(app, event)
            a=getimage(app.axes1);
            [rows,columns,numberOfColorChannels] = size(a);
            if numberOfColorChannels == 3
                redChannel = a(:,:,1);
                greenChannel = a(:,:,2);
                blueChannel = a(:,:,3);
                med_filtR = medfilt2(redChannel);
                med_filtG = medfilt2(greenChannel);
                med_filtB = medfilt2(blueChannel);
                median_filtrgb = cat(3, med_filtR, med_filtG, med_filtB);
                imshow(median_filtrgb,'Parent',app.axes2);
            else numberOfColorChannels == 0
                median_filtgray = medfilt2(a);
                imshow(median_filtgray,'Parent',app.axes2);
            end
        end

        % Button pushed function: pushbutton23
        function guidedfilter(app, event)
            a=getimage(app.axes1);
            a_guidedfilter = imguidedfilter(a);
            imshow(a_guidedfilter,'Parent',app.axes2);
        end

        % Button pushed function: pushbutton15
        function rotateclockwise(app, event)
           a=getimage(app.axes1);
           rot_clckwise = imrotate(a,-90);
           imshow(rot_clckwise,'Parent',app.axes2);
        end

        % Button pushed function: pushbutton16
        function rotateanticlockwise(app, event)
           a=getimage(app.axes1);
           rot_anticlckwise = imrotate(a,90);
           imshow(rot_anticlckwise,'Parent',app.axes2);
        end

        % Button pushed function: pushbutton24
        function complementimage(app, event)
            a=getimage(app.axes1);
            a_complement = imcomplement(a);
            imshow(a_complement,'Parent',app.axes2);
        end

        % Button pushed function: pushbutton26
        function sepia(app, event)
            a=getimage(app.axes1);
            [rows, columns, noOfColorChannels] = size(a)
            if noOfColorChannels == 3
                b=im2double(a);
                redChannel = b(:,:,1);
                greenChannel = b(:,:,2);
                blueChannel = b(:,:,3);
                red_R = (redChannel.*0.393 + greenChannel.*0.769 + blueChannel .*0.189);
                green_G = (redChannel.*0.349 + greenChannel.*0.686 + blueChannel .*0.168);
                blue_B = (redChannel.*0.272 + greenChannel.*0.534 + blueChannel .*0.131);
                sepia_effect = cat(3, red_R, green_G, blue_B);
                imshow(sepia_effect,'Parent',app.axes2);
           else
                error = errordlg('It is a gray scale image','image Error');
                imshow(error,'Parent',app.axes2);
            end
        end

        % Button pushed function: pushbutton27
        function redfilter(app, event)
            a=getimage(app.axes1);
            a(:,:,2) = 0;
            a(:,:,3) = 0;
            imshow(a,'Parent',app.axes2);
        end

        % Button pushed function: pushbutton28
        function bluefilter(app, event)
            a=getimage(app.axes1);
            a(:,:,1) = 0;
            a(:,:,2) = 0;
            imshow(a,'Parent',app.axes2);
        end

        % Button pushed function: pushbutton29
        function greenfilter(app, event)
            a=getimage(app.axes1);
            a(:,:,1) = 0;
            a(:,:,3) = 0;
            imshow(a,'Parent',app.axes2);
        end

        % Button pushed function: pushbutton30
        function vividfilter(app, event)
            a=getimage(app.axes1);
            a_hsv = rgb2hsv(a);
            hChannel = a_hsv(:,:,1);
            sChannel = a_hsv(:,:,2);
            vChannel = a_hsv(:,:,3);
            sChannel = sChannel * 2;
            a_hsv = cat(3, hChannel, sChannel, vChannel);
            rgb_vivid = hsv2rgb(a_hsv);
            imshow(rgb_vivid,'Parent',app.axes2);
        end

        % Button pushed function: pushbutton31
        function mosaic(app, event)
            a=getimage(app.axes1);
            imshow(a,'Parent',app.axes2);
            a_gray = rgb2gray(a);
            hold on;
            h = imshow(a_gray,'Parent',app.axes2);
            hold off;
            [M,N] = size(a_gray);
            block_size = 50;
            P = ceil(M/block_size);
            Q = ceil(N/block_size);
            alpha = checkerboard(block_size,P,Q) > 0;
            alpha_1 = alpha(1:M, 1:N);
            set(h, 'AlphaData',alpha_1);
        end

        % Value changed function: Slider
        function contrastadjustment(app, event)
            a=getimage(app.axes1);
            contrastFactor = app.Slider.Value;
            newimage = uint8(double(a)*contrastFactor);
            imshow(newimage,[0, 255],'Parent',app.axes2);
        end

        % Value changed function: Slider_2
        function brightnessadjustment(app, event)
            a=getimage(app.axes1);
            brightnessfactor = app.Slider_2.Value;
            newimage = uint8(double(a)+brightnessfactor);
            imshow(newimage,[0, 255],'Parent',app.axes2);
        end

        % Value changed function: Slider_3
        function saturationadjustment(app, event)
            a=getimage(app.axes1);
            [rows, Columns, noOfColorChannels] = size(a);
            if noOfColorChannels == 3
                a_hsv = rgb2hsv(a);
                saturationfactor = app.Slider_3.Value;
                a_hsv(:,:,2) = a_hsv(:,:,2)*1.2+saturationfactor;
                a_rgb = hsv2rgb(a_hsv);
                imshow(a_rgb,[0, 255],'Parent',app.axes2);
            else 
                 error = errordlg('It is a gray scale image','image Error');
                imshow(error,'Parent',app.axes2);
            end
        end

        % Button pushed function: pushbutton33
        function resetbutton(app, event)
            app.UIFigure.Visible = 'off';
            IMAGE_PROCESSING();
            close(app.UIFigure);
        end

        % Button pushed function: pushbutton32
        function motionblureffect(app, event)
            a=getimage(app.axes1);
            a_motion = fspecial('motion',80,180);
            MotionBlur = imfilter(a,a_motion,'replicate');
            imshow(MotionBlur,'Parent',app.axes2);
        end

        % Button pushed function: pushbutton33_2
        function saveoutput(app, event)
           axes(app.axes2);
           [FileName, PathName] = uiputfile({'*.*'},'Save output as');
           Name = fullfile(PathName, FileName);
           exportgraphics(app.axes2,Name);
        end
    end

    % Component initialization
    methods (Access = private)

        % Create UIFigure and components
        function createComponents(app)

            % Create UIFigure and hide until all components are created
            app.UIFigure = uifigure('Visible', 'off');
            app.UIFigure.Position = [1 2 1454 780];
            app.UIFigure.Name = 'MATLAB App';

            % Create uibuttongroup1
            app.uibuttongroup1 = uibuttongroup(app.UIFigure);
            app.uibuttongroup1.BackgroundColor = [0.9804 0.9804 0.7098];
            app.uibuttongroup1.Tag = 'uibuttongroup1';
            app.uibuttongroup1.FontSize = 11;
            app.uibuttongroup1.Position = [3 410 269 344];

            % Create pushbutton1
            app.pushbutton1 = uibutton(app.uibuttongroup1, 'push');
            app.pushbutton1.ButtonPushedFcn = createCallbackFcn(app, @uploadimage, true);
            app.pushbutton1.Tag = 'uploadimage';
            app.pushbutton1.BackgroundColor = [0 0.447058823529412 0.741176470588235];
            app.pushbutton1.FontName = 'Arial';
            app.pushbutton1.FontSize = 16;
            app.pushbutton1.FontWeight = 'bold';
            app.pushbutton1.FontColor = [1 1 1];
            app.pushbutton1.Position = [51 264 172 50];
            app.pushbutton1.Text = 'UPLOAD IMAGE';

            % Create pushbutton2
            app.pushbutton2 = uibutton(app.uibuttongroup1, 'push');
            app.pushbutton2.ButtonPushedFcn = createCallbackFcn(app, @rgb2gray, true);
            app.pushbutton2.Tag = 'pushbutton2';
            app.pushbutton2.BackgroundColor = [0.9608 0.6392 0.3804];
            app.pushbutton2.FontName = 'Arial';
            app.pushbutton2.FontSize = 16;
            app.pushbutton2.FontWeight = 'bold';
            app.pushbutton2.FontColor = [1 1 1];
            app.pushbutton2.Position = [51 191 172 50];
            app.pushbutton2.Text = 'RGB TO GRAY';

            % Create pushbutton3
            app.pushbutton3 = uibutton(app.uibuttongroup1, 'push');
            app.pushbutton3.ButtonPushedFcn = createCallbackFcn(app, @rgb2hsv, true);
            app.pushbutton3.Tag = 'pushbutton3';
            app.pushbutton3.BackgroundColor = [0 0.549 0.549];
            app.pushbutton3.FontName = 'Arial';
            app.pushbutton3.FontSize = 16;
            app.pushbutton3.FontWeight = 'bold';
            app.pushbutton3.FontColor = [1 1 1];
            app.pushbutton3.Position = [51 112 172 50];
            app.pushbutton3.Text = 'RGB TO HSV';

            % Create pushbutton4
            app.pushbutton4 = uibutton(app.uibuttongroup1, 'push');
            app.pushbutton4.ButtonPushedFcn = createCallbackFcn(app, @binaryimage, true);
            app.pushbutton4.Tag = 'pushbutton4';
            app.pushbutton4.BackgroundColor = [0 0 0];
            app.pushbutton4.FontName = 'Arial';
            app.pushbutton4.FontSize = 16;
            app.pushbutton4.FontWeight = 'bold';
            app.pushbutton4.FontColor = [1 1 1];
            app.pushbutton4.Position = [51 33 172 50];
            app.pushbutton4.Text = 'BINARY IMAGE';

            % Create axes1
            app.axes1 = uiaxes(app.UIFigure);
            app.axes1.FontSize = 13;
            app.axes1.GridColor = [0 0 0];
            app.axes1.XTick = [];
            app.axes1.YTick = [];
            app.axes1.NextPlot = 'replace';
            app.axes1.Tag = 'axes1';
            app.axes1.Position = [265 412 467 344];

            % Create axes2
            app.axes2 = uiaxes(app.UIFigure);
            app.axes2.FontSize = 13;
            app.axes2.GridColor = [0 0 0];
            app.axes2.MinorGridColor = [0.1 0.1 0.1];
            app.axes2.XTick = [];
            app.axes2.YTick = [];
            app.axes2.ZTick = [];
            app.axes2.NextPlot = 'replace';
            app.axes2.Tag = 'axes2';
            app.axes2.Position = [728 412 465 344];

            % Create uibuttongroup4
            app.uibuttongroup4 = uibuttongroup(app.UIFigure);
            app.uibuttongroup4.BackgroundColor = [0.9804 0.9804 0.7098];
            app.uibuttongroup4.Tag = 'uibuttongroup4';
            app.uibuttongroup4.Scrollable = 'on';
            app.uibuttongroup4.FontSize = 11;
            app.uibuttongroup4.Position = [1192 412 262 344];

            % Create pushbutton5
            app.pushbutton5 = uibutton(app.uibuttongroup4, 'push');
            app.pushbutton5.ButtonPushedFcn = createCallbackFcn(app, @sharpness, true);
            app.pushbutton5.Tag = 'pushbutton5';
            app.pushbutton5.BackgroundColor = [0 0.447058823529412 0.741176470588235];
            app.pushbutton5.FontName = 'Arial';
            app.pushbutton5.FontSize = 16;
            app.pushbutton5.FontWeight = 'bold';
            app.pushbutton5.FontColor = [1 1 1];
            app.pushbutton5.Position = [45 262 172 50];
            app.pushbutton5.Text = {'SHARPNESS'; ''};

            % Create pushbutton6
            app.pushbutton6 = uibutton(app.uibuttongroup4, 'push');
            app.pushbutton6.ButtonPushedFcn = createCallbackFcn(app, @whitebalance, true);
            app.pushbutton6.Tag = 'pushbutton6';
            app.pushbutton6.BackgroundColor = [0.9608 0.6392 0.3804];
            app.pushbutton6.FontName = 'Arial';
            app.pushbutton6.FontSize = 16;
            app.pushbutton6.FontWeight = 'bold';
            app.pushbutton6.FontColor = [1 1 1];
            app.pushbutton6.Position = [45 189 172 50];
            app.pushbutton6.Text = 'WHITE BALANCE';

            % Create pushbutton7
            app.pushbutton7 = uibutton(app.uibuttongroup4, 'push');
            app.pushbutton7.ButtonPushedFcn = createCallbackFcn(app, @grayadjust, true);
            app.pushbutton7.Tag = 'pushbutton7';
            app.pushbutton7.BackgroundColor = [0 0.549 0.549];
            app.pushbutton7.FontName = 'Arial';
            app.pushbutton7.FontSize = 16;
            app.pushbutton7.FontWeight = 'bold';
            app.pushbutton7.FontColor = [1 1 1];
            app.pushbutton7.Position = [45 110 172 50];
            app.pushbutton7.Text = 'GRAY ADJUST';

            % Create pushbutton8
            app.pushbutton8 = uibutton(app.uibuttongroup4, 'push');
            app.pushbutton8.ButtonPushedFcn = createCallbackFcn(app, @coloradjust, true);
            app.pushbutton8.Tag = 'pushbutton8';
            app.pushbutton8.BackgroundColor = [0 0 0];
            app.pushbutton8.FontName = 'Arial';
            app.pushbutton8.FontSize = 16;
            app.pushbutton8.FontWeight = 'bold';
            app.pushbutton8.FontColor = [1 1 1];
            app.pushbutton8.Position = [45 31 172 50];
            app.pushbutton8.Text = 'COLOR ADJUST';

            % Create text11
            app.text11 = uilabel(app.UIFigure);
            app.text11.Tag = 'text11';
            app.text11.BackgroundColor = [0.7412 0.7216 0.4196];
            app.text11.HorizontalAlignment = 'center';
            app.text11.VerticalAlignment = 'top';
            app.text11.FontName = 'Arial';
            app.text11.FontSize = 24;
            app.text11.FontWeight = 'bold';
            app.text11.Position = [4 378 842 35];
            app.text11.Text = {'CONTROL PANEL- 1'; ''};

            % Create uibuttongroup3
            app.uibuttongroup3 = uibuttongroup(app.UIFigure);
            app.uibuttongroup3.Title = 'ADJUSTMENT';
            app.uibuttongroup3.BackgroundColor = [0.9804 0.9804 0.7098];
            app.uibuttongroup3.Tag = 'uibuttongroup3';
            app.uibuttongroup3.Scrollable = 'on';
            app.uibuttongroup3.FontSize = 11;
            app.uibuttongroup3.Position = [0 0 222 379];

            % Create text2
            app.text2 = uilabel(app.uibuttongroup3);
            app.text2.Tag = 'text2';
            app.text2.BackgroundColor = [0 0 0];
            app.text2.HorizontalAlignment = 'center';
            app.text2.VerticalAlignment = 'top';
            app.text2.FontName = 'Arial';
            app.text2.FontSize = 14;
            app.text2.FontWeight = 'bold';
            app.text2.FontColor = [1 1 1];
            app.text2.Position = [15 330 188 16];
            app.text2.Text = 'CONTRAST ADJUSTMENT';

            % Create text3
            app.text3 = uilabel(app.uibuttongroup3);
            app.text3.Tag = 'text3';
            app.text3.BackgroundColor = [0 0 0];
            app.text3.HorizontalAlignment = 'center';
            app.text3.VerticalAlignment = 'top';
            app.text3.FontName = 'Arial';
            app.text3.FontSize = 14;
            app.text3.FontWeight = 'bold';
            app.text3.FontColor = [1 1 1];
            app.text3.Position = [15 236 199 17];
            app.text3.Text = 'BRIGHTNESS ADJUSTMENT';

            % Create text4
            app.text4 = uilabel(app.uibuttongroup3);
            app.text4.Tag = 'text4';
            app.text4.BackgroundColor = [0 0 0];
            app.text4.HorizontalAlignment = 'center';
            app.text4.VerticalAlignment = 'top';
            app.text4.FontName = 'Arial';
            app.text4.FontSize = 14;
            app.text4.FontWeight = 'bold';
            app.text4.FontColor = [1 1 1];
            app.text4.Position = [17 112 197 19];
            app.text4.Text = 'SATURATION ADJUSTMENT';

            % Create SliderLabel
            app.SliderLabel = uilabel(app.uibuttongroup3);
            app.SliderLabel.HorizontalAlignment = 'right';
            app.SliderLabel.Position = [17 288 36 22];
            app.SliderLabel.Text = 'Slider';

            % Create Slider
            app.Slider = uislider(app.uibuttongroup3);
            app.Slider.Limits = [0 10];
            app.Slider.ValueChangedFcn = createCallbackFcn(app, @contrastadjustment, true);
            app.Slider.Position = [74 297 122 3];

            % Create Slider_2Label
            app.Slider_2Label = uilabel(app.uibuttongroup3);
            app.Slider_2Label.HorizontalAlignment = 'right';
            app.Slider_2Label.Position = [17 180 36 22];
            app.Slider_2Label.Text = {'Slider'; ''};

            % Create Slider_2
            app.Slider_2 = uislider(app.uibuttongroup3);
            app.Slider_2.ValueChangedFcn = createCallbackFcn(app, @brightnessadjustment, true);
            app.Slider_2.Position = [74 189 118 3];

            % Create Slider_3Label
            app.Slider_3Label = uilabel(app.uibuttongroup3);
            app.Slider_3Label.HorizontalAlignment = 'right';
            app.Slider_3Label.Position = [19 66 36 22];
            app.Slider_3Label.Text = 'Slider';

            % Create Slider_3
            app.Slider_3 = uislider(app.uibuttongroup3);
            app.Slider_3.Limits = [0 5];
            app.Slider_3.ValueChangedFcn = createCallbackFcn(app, @saturationadjustment, true);
            app.Slider_3.Position = [75 75 111 3];

            % Create uibuttongroup6
            app.uibuttongroup6 = uibuttongroup(app.UIFigure);
            app.uibuttongroup6.Title = 'EDGE DETECTION';
            app.uibuttongroup6.BackgroundColor = [0.9804 0.9804 0.7098];
            app.uibuttongroup6.Tag = 'uibuttongroup6';
            app.uibuttongroup6.FontSize = 11;
            app.uibuttongroup6.Position = [221 1 209 378];

            % Create pushbutton12
            app.pushbutton12 = uibutton(app.uibuttongroup6, 'push');
            app.pushbutton12.ButtonPushedFcn = createCallbackFcn(app, @prewittedge, true);
            app.pushbutton12.Tag = 'pushbutton12';
            app.pushbutton12.BackgroundColor = [0 0 0];
            app.pushbutton12.FontName = 'Arial';
            app.pushbutton12.FontSize = 16;
            app.pushbutton12.FontWeight = 'bold';
            app.pushbutton12.FontColor = [1 1 1];
            app.pushbutton12.Position = [19 294 172 50];
            app.pushbutton12.Text = 'PREWITT EDGE';

            % Create pushbutton13
            app.pushbutton13 = uibutton(app.uibuttongroup6, 'push');
            app.pushbutton13.ButtonPushedFcn = createCallbackFcn(app, @sobeledge, true);
            app.pushbutton13.Tag = 'pushbutton13';
            app.pushbutton13.BackgroundColor = [0 0 0];
            app.pushbutton13.FontName = 'Arial';
            app.pushbutton13.FontSize = 16;
            app.pushbutton13.FontWeight = 'bold';
            app.pushbutton13.FontColor = [1 1 1];
            app.pushbutton13.Position = [19 187 172 50];
            app.pushbutton13.Text = 'SOBEL EDGE';

            % Create pushbutton14
            app.pushbutton14 = uibutton(app.uibuttongroup6, 'push');
            app.pushbutton14.ButtonPushedFcn = createCallbackFcn(app, @cannyedge, true);
            app.pushbutton14.Tag = 'pushbutton14';
            app.pushbutton14.BackgroundColor = [0 0 0];
            app.pushbutton14.FontName = 'Arial';
            app.pushbutton14.FontSize = 16;
            app.pushbutton14.FontWeight = 'bold';
            app.pushbutton14.FontColor = [1 1 1];
            app.pushbutton14.Position = [19 79 172 50];
            app.pushbutton14.Text = 'CANNY EDGE';

            % Create uibuttongroup7
            app.uibuttongroup7 = uibuttongroup(app.UIFigure);
            app.uibuttongroup7.Title = 'NOISE ADDITION';
            app.uibuttongroup7.BackgroundColor = [0.9804 0.9804 0.7098];
            app.uibuttongroup7.Tag = 'uibuttongroup7';
            app.uibuttongroup7.FontSize = 11;
            app.uibuttongroup7.Position = [429 1 209 379];

            % Create pushbutton17
            app.pushbutton17 = uibutton(app.uibuttongroup7, 'push');
            app.pushbutton17.ButtonPushedFcn = createCallbackFcn(app, @gaussiannoise, true);
            app.pushbutton17.Tag = 'pushbutton17';
            app.pushbutton17.BackgroundColor = [0 0 0];
            app.pushbutton17.FontName = 'Arial';
            app.pushbutton17.FontSize = 16;
            app.pushbutton17.FontWeight = 'bold';
            app.pushbutton17.FontColor = [1 1 1];
            app.pushbutton17.Position = [19 295 172 50];
            app.pushbutton17.Text = 'GAUSSIAN NOISE';

            % Create pushbutton18
            app.pushbutton18 = uibutton(app.uibuttongroup7, 'push');
            app.pushbutton18.ButtonPushedFcn = createCallbackFcn(app, @specklenoise, true);
            app.pushbutton18.Tag = 'pushbutton18';
            app.pushbutton18.BackgroundColor = [0 0 0];
            app.pushbutton18.FontName = 'Arial';
            app.pushbutton18.FontSize = 16;
            app.pushbutton18.FontWeight = 'bold';
            app.pushbutton18.FontColor = [1 1 1];
            app.pushbutton18.Position = [19 190 172 50];
            app.pushbutton18.Text = 'SPECKLE NOISE';

            % Create pushbutton19
            app.pushbutton19 = uibutton(app.uibuttongroup7, 'push');
            app.pushbutton19.ButtonPushedFcn = createCallbackFcn(app, @saltandpeppernoise, true);
            app.pushbutton19.Tag = 'pushbutton19';
            app.pushbutton19.BackgroundColor = [0 0 0];
            app.pushbutton19.FontName = 'Arial';
            app.pushbutton19.FontSize = 14;
            app.pushbutton19.FontWeight = 'bold';
            app.pushbutton19.FontColor = [1 1 1];
            app.pushbutton19.Position = [19 80 174 49];
            app.pushbutton19.Text = 'SALT & PEPPER NOISE';

            % Create uibuttongroup8
            app.uibuttongroup8 = uibuttongroup(app.UIFigure);
            app.uibuttongroup8.Title = 'NOISE REDUCTION';
            app.uibuttongroup8.BackgroundColor = [0.9804 0.9804 0.7098];
            app.uibuttongroup8.Tag = 'uibuttongroup8';
            app.uibuttongroup8.FontSize = 11;
            app.uibuttongroup8.Position = [637 1 209 379];

            % Create pushbutton20
            app.pushbutton20 = uibutton(app.uibuttongroup8, 'push');
            app.pushbutton20.ButtonPushedFcn = createCallbackFcn(app, @averagefilter, true);
            app.pushbutton20.Tag = 'pushbutton20';
            app.pushbutton20.BackgroundColor = [0 0 0];
            app.pushbutton20.FontName = 'Arial';
            app.pushbutton20.FontSize = 16;
            app.pushbutton20.FontWeight = 'bold';
            app.pushbutton20.FontColor = [1 1 1];
            app.pushbutton20.Position = [19 295 172 50];
            app.pushbutton20.Text = 'AVERAGE FILTER';

            % Create pushbutton21
            app.pushbutton21 = uibutton(app.uibuttongroup8, 'push');
            app.pushbutton21.ButtonPushedFcn = createCallbackFcn(app, @gaussianfilter, true);
            app.pushbutton21.Tag = 'pushbutton21';
            app.pushbutton21.BackgroundColor = [0 0 0];
            app.pushbutton21.FontName = 'Arial';
            app.pushbutton21.FontSize = 16;
            app.pushbutton21.FontWeight = 'bold';
            app.pushbutton21.FontColor = [1 1 1];
            app.pushbutton21.Position = [17 218 172 50];
            app.pushbutton21.Text = 'GAUSSIAN FILTER';

            % Create pushbutton22
            app.pushbutton22 = uibutton(app.uibuttongroup8, 'push');
            app.pushbutton22.ButtonPushedFcn = createCallbackFcn(app, @medianfilter, true);
            app.pushbutton22.Tag = 'pushbutton22';
            app.pushbutton22.BackgroundColor = [0 0 0];
            app.pushbutton22.FontName = 'Arial';
            app.pushbutton22.FontSize = 16;
            app.pushbutton22.FontWeight = 'bold';
            app.pushbutton22.FontColor = [1 1 1];
            app.pushbutton22.Position = [19 141 172 50];
            app.pushbutton22.Text = 'MEDIAN FILTER';

            % Create pushbutton23
            app.pushbutton23 = uibutton(app.uibuttongroup8, 'push');
            app.pushbutton23.ButtonPushedFcn = createCallbackFcn(app, @guidedfilter, true);
            app.pushbutton23.Tag = 'pushbutton23';
            app.pushbutton23.BackgroundColor = [0 0 0];
            app.pushbutton23.FontName = 'Arial';
            app.pushbutton23.FontSize = 16;
            app.pushbutton23.FontWeight = 'bold';
            app.pushbutton23.FontColor = [1 1 1];
            app.pushbutton23.Position = [19 62 172 50];
            app.pushbutton23.Text = 'GUIDED FILTER';

            % Create uibuttongroup16
            app.uibuttongroup16 = uibuttongroup(app.UIFigure);
            app.uibuttongroup16.Title = 'ADVANCED';
            app.uibuttongroup16.BackgroundColor = [0.9804 0.9804 0.7098];
            app.uibuttongroup16.Tag = 'uibuttongroup16';
            app.uibuttongroup16.FontSize = 11;
            app.uibuttongroup16.Position = [845 0 609 379];

            % Create pushbutton33
            app.pushbutton33 = uibutton(app.uibuttongroup16, 'push');
            app.pushbutton33.ButtonPushedFcn = createCallbackFcn(app, @resetbutton, true);
            app.pushbutton33.Tag = 'pushbutton33';
            app.pushbutton33.BackgroundColor = [1 0 0];
            app.pushbutton33.FontName = 'Arial';
            app.pushbutton33.FontSize = 20;
            app.pushbutton33.FontWeight = 'bold';
            app.pushbutton33.FontColor = [1 1 1];
            app.pushbutton33.Position = [324 7 273 43];
            app.pushbutton33.Text = 'RESET';

            % Create pushbutton30
            app.pushbutton30 = uibutton(app.uibuttongroup16, 'push');
            app.pushbutton30.ButtonPushedFcn = createCallbackFcn(app, @vividfilter, true);
            app.pushbutton30.Tag = 'pushbutton30';
            app.pushbutton30.BackgroundColor = [0 0 0];
            app.pushbutton30.FontName = 'Arial';
            app.pushbutton30.FontSize = 16;
            app.pushbutton30.FontWeight = 'bold';
            app.pushbutton30.FontColor = [1 1 1];
            app.pushbutton30.Position = [18 299 172 50];
            app.pushbutton30.Text = 'VIVID';

            % Create pushbutton26
            app.pushbutton26 = uibutton(app.uibuttongroup16, 'push');
            app.pushbutton26.ButtonPushedFcn = createCallbackFcn(app, @sepia, true);
            app.pushbutton26.Tag = 'pushbutton26';
            app.pushbutton26.BackgroundColor = [0 0 0];
            app.pushbutton26.FontName = 'Arial';
            app.pushbutton26.FontSize = 16;
            app.pushbutton26.FontWeight = 'bold';
            app.pushbutton26.FontColor = [1 1 1];
            app.pushbutton26.Position = [216 299 172 50];
            app.pushbutton26.Text = 'SEPIA';

            % Create pushbutton31
            app.pushbutton31 = uibutton(app.uibuttongroup16, 'push');
            app.pushbutton31.ButtonPushedFcn = createCallbackFcn(app, @mosaic, true);
            app.pushbutton31.Tag = 'pushbutton31';
            app.pushbutton31.BackgroundColor = [0 0 0];
            app.pushbutton31.FontName = 'Arial';
            app.pushbutton31.FontSize = 16;
            app.pushbutton31.FontWeight = 'bold';
            app.pushbutton31.FontColor = [1 1 1];
            app.pushbutton31.Position = [412 299 172 50];
            app.pushbutton31.Text = {'MOSAIC'; ''};

            % Create pushbutton27
            app.pushbutton27 = uibutton(app.uibuttongroup16, 'push');
            app.pushbutton27.ButtonPushedFcn = createCallbackFcn(app, @redfilter, true);
            app.pushbutton27.Tag = 'pushbutton27';
            app.pushbutton27.BackgroundColor = [0 0 0];
            app.pushbutton27.FontName = 'Arial';
            app.pushbutton27.FontSize = 16;
            app.pushbutton27.FontWeight = 'bold';
            app.pushbutton27.FontColor = [1 1 1];
            app.pushbutton27.Position = [18 230 172 50];
            app.pushbutton27.Text = 'RED';

            % Create pushbutton29
            app.pushbutton29 = uibutton(app.uibuttongroup16, 'push');
            app.pushbutton29.ButtonPushedFcn = createCallbackFcn(app, @greenfilter, true);
            app.pushbutton29.Tag = 'pushbutton29';
            app.pushbutton29.BackgroundColor = [0 0 0];
            app.pushbutton29.FontName = 'Arial';
            app.pushbutton29.FontSize = 16;
            app.pushbutton29.FontWeight = 'bold';
            app.pushbutton29.FontColor = [1 1 1];
            app.pushbutton29.Position = [216 231 172 50];
            app.pushbutton29.Text = 'GREEN';

            % Create pushbutton28
            app.pushbutton28 = uibutton(app.uibuttongroup16, 'push');
            app.pushbutton28.ButtonPushedFcn = createCallbackFcn(app, @bluefilter, true);
            app.pushbutton28.Tag = 'pushbutton28';
            app.pushbutton28.BackgroundColor = [0 0 0];
            app.pushbutton28.FontName = 'Arial';
            app.pushbutton28.FontSize = 16;
            app.pushbutton28.FontWeight = 'bold';
            app.pushbutton28.FontColor = [1 1 1];
            app.pushbutton28.Position = [412 231 172 50];
            app.pushbutton28.Text = 'BLUE';

            % Create pushbutton15
            app.pushbutton15 = uibutton(app.uibuttongroup16, 'push');
            app.pushbutton15.ButtonPushedFcn = createCallbackFcn(app, @rotateclockwise, true);
            app.pushbutton15.Tag = 'pushbutton15';
            app.pushbutton15.BackgroundColor = [0 0 0];
            app.pushbutton15.FontName = 'Arial';
            app.pushbutton15.FontSize = 15;
            app.pushbutton15.FontWeight = 'bold';
            app.pushbutton15.FontColor = [1 1 1];
            app.pushbutton15.Position = [18 163 172 47];
            app.pushbutton15.Text = 'ROTATE CLOCKWISE';

            % Create pushbutton16
            app.pushbutton16 = uibutton(app.uibuttongroup16, 'push');
            app.pushbutton16.ButtonPushedFcn = createCallbackFcn(app, @rotateanticlockwise, true);
            app.pushbutton16.Tag = 'pushbutton16';
            app.pushbutton16.BackgroundColor = [0 0 0];
            app.pushbutton16.FontName = 'Arial';
            app.pushbutton16.FontWeight = 'bold';
            app.pushbutton16.FontColor = [1 1 1];
            app.pushbutton16.Position = [216 163 172 47];
            app.pushbutton16.Text = 'ROTATE ANTI- CLOCKWISE';

            % Create pushbutton24
            app.pushbutton24 = uibutton(app.uibuttongroup16, 'push');
            app.pushbutton24.ButtonPushedFcn = createCallbackFcn(app, @complementimage, true);
            app.pushbutton24.Tag = 'pushbutton24';
            app.pushbutton24.BackgroundColor = [0 0 0];
            app.pushbutton24.FontName = 'Arial';
            app.pushbutton24.FontSize = 15;
            app.pushbutton24.FontWeight = 'bold';
            app.pushbutton24.FontColor = [1 1 1];
            app.pushbutton24.Position = [412 163 175 47];
            app.pushbutton24.Text = 'COMPLEMENT IMAGE';

            % Create pushbutton33_2
            app.pushbutton33_2 = uibutton(app.uibuttongroup16, 'push');
            app.pushbutton33_2.ButtonPushedFcn = createCallbackFcn(app, @saveoutput, true);
            app.pushbutton33_2.Tag = 'pushbutton33';
            app.pushbutton33_2.BackgroundColor = [0.3922 0.8314 0.0745];
            app.pushbutton33_2.FontName = 'Arial';
            app.pushbutton33_2.FontSize = 20;
            app.pushbutton33_2.FontWeight = 'bold';
            app.pushbutton33_2.FontColor = [1 1 1];
            app.pushbutton33_2.Position = [18 7 273 43];
            app.pushbutton33_2.Text = {'SAVE'; ''};

            % Create pushbutton10
            app.pushbutton10 = uibutton(app.uibuttongroup16, 'push');
            app.pushbutton10.ButtonPushedFcn = createCallbackFcn(app, @histogramequalization, true);
            app.pushbutton10.Tag = 'pushbutton10';
            app.pushbutton10.BackgroundColor = [0 0 0];
            app.pushbutton10.FontName = 'Arial';
            app.pushbutton10.FontWeight = 'bold';
            app.pushbutton10.FontColor = [1 1 1];
            app.pushbutton10.Position = [216 95 172 46];
            app.pushbutton10.Text = 'HISTOGRAM EQUALIZATION';

            % Create pushbutton9
            app.pushbutton9 = uibutton(app.uibuttongroup16, 'push');
            app.pushbutton9.ButtonPushedFcn = createCallbackFcn(app, @histogram, true);
            app.pushbutton9.Tag = 'pushbutton9';
            app.pushbutton9.BackgroundColor = [0 0 0];
            app.pushbutton9.FontName = 'Arial';
            app.pushbutton9.FontSize = 16;
            app.pushbutton9.FontWeight = 'bold';
            app.pushbutton9.FontColor = [1 1 1];
            app.pushbutton9.Position = [18 95 172 46];
            app.pushbutton9.Text = 'HISTOGRAM';

            % Create pushbutton32
            app.pushbutton32 = uibutton(app.uibuttongroup16, 'push');
            app.pushbutton32.ButtonPushedFcn = createCallbackFcn(app, @motionblureffect, true);
            app.pushbutton32.Tag = 'pushbutton32';
            app.pushbutton32.BackgroundColor = [0 0 0];
            app.pushbutton32.FontName = 'Arial';
            app.pushbutton32.FontSize = 16;
            app.pushbutton32.FontWeight = 'bold';
            app.pushbutton32.FontColor = [1 1 1];
            app.pushbutton32.Position = [412 97 172 46];
            app.pushbutton32.Text = 'MOTION';

            % Create text7_2
            app.text7_2 = uilabel(app.UIFigure);
            app.text7_2.Tag = 'text7';
            app.text7_2.BackgroundColor = [0.7412 0.7216 0.4196];
            app.text7_2.HorizontalAlignment = 'center';
            app.text7_2.VerticalAlignment = 'top';
            app.text7_2.FontName = 'Arial';
            app.text7_2.FontSize = 20;
            app.text7_2.FontWeight = 'bold';
            app.text7_2.Position = [1 755 271 26];
            app.text7_2.Text = {'PANEL 1'; ''};

            % Create text5_2
            app.text5_2 = uilabel(app.UIFigure);
            app.text5_2.Tag = 'text5';
            app.text5_2.BackgroundColor = [0.7412 0.7216 0.4196];
            app.text5_2.HorizontalAlignment = 'center';
            app.text5_2.VerticalAlignment = 'top';
            app.text5_2.FontName = 'Arial';
            app.text5_2.FontSize = 20;
            app.text5_2.FontWeight = 'bold';
            app.text5_2.Position = [271 755 473 26];
            app.text5_2.Text = 'INPUT IMAGE';

            % Create text6_2
            app.text6_2 = uilabel(app.UIFigure);
            app.text6_2.Tag = 'text6';
            app.text6_2.BackgroundColor = [0.7412 0.7216 0.4196];
            app.text6_2.HorizontalAlignment = 'center';
            app.text6_2.VerticalAlignment = 'top';
            app.text6_2.FontName = 'Arial';
            app.text6_2.FontSize = 20;
            app.text6_2.FontWeight = 'bold';
            app.text6_2.Position = [654 755 539 26];
            app.text6_2.Text = 'OUTPUT IMAGE';

            % Create text5_3
            app.text5_3 = uilabel(app.UIFigure);
            app.text5_3.Tag = 'text5';
            app.text5_3.BackgroundColor = [0.7412 0.7216 0.4196];
            app.text5_3.HorizontalAlignment = 'center';
            app.text5_3.VerticalAlignment = 'top';
            app.text5_3.FontName = 'Arial';
            app.text5_3.FontSize = 20;
            app.text5_3.FontWeight = 'bold';
            app.text5_3.Position = [1192 756 262 25];
            app.text5_3.Text = {'PANEL 2'; ''};

            % Create text11_2
            app.text11_2 = uilabel(app.UIFigure);
            app.text11_2.Tag = 'text11';
            app.text11_2.BackgroundColor = [0.7412 0.7216 0.4196];
            app.text11_2.HorizontalAlignment = 'center';
            app.text11_2.VerticalAlignment = 'top';
            app.text11_2.FontName = 'Arial';
            app.text11_2.FontSize = 24;
            app.text11_2.FontWeight = 'bold';
            app.text11_2.Position = [844.5 378 611 35];
            app.text11_2.Text = 'CONTROL PANEL- 2';

            % Show the figure after all components are created
            app.UIFigure.Visible = 'on';
        end
    end

    % App creation and deletion
    methods (Access = public)

        % Construct app
        function app = IMAGE_EDITING_LABORATORY

            % Create UIFigure and components
            createComponents(app)

            % Register the app with App Designer
            registerApp(app, app.UIFigure)

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