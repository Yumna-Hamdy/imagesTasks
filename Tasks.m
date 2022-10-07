classdef TASL_4_exported < matlab.apps.AppBase

    % Properties that correspond to app components
    properties (Access = public)
        UIFigure                     matlab.ui.Figure
        TabGroup                     matlab.ui.container.TabGroup
        Task1Tab                     matlab.ui.container.Tab
        EnterImageLabel              matlab.ui.control.Label
        Panel                        matlab.ui.container.Panel
        UIAxes                       matlab.ui.control.UIAxes
        GrayscaleButton              matlab.ui.control.Button
        partexamininedTextArea       matlab.ui.control.TextArea
        partexamininedTextAreaLabel  matlab.ui.control.Label
        modalityTextArea             matlab.ui.control.TextArea
        modalityTextAreaLabel        matlab.ui.control.Label
        ageTextArea                  matlab.ui.control.TextArea
        ageTextAreaLabel             matlab.ui.control.Label
        NameTextArea                 matlab.ui.control.TextArea
        NameTextAreaLabel            matlab.ui.control.Label
        ColorTypeTextArea            matlab.ui.control.TextArea
        ColorTypeTextAreaLabel       matlab.ui.control.Label
        BitDepthTextArea             matlab.ui.control.TextArea
        BitDepthTextAreaLabel        matlab.ui.control.Label
        BitsTextArea                 matlab.ui.control.TextArea
        BitsTextAreaLabel            matlab.ui.control.Label
        WidthTextArea                matlab.ui.control.TextArea
        WidthTextAreaLabel           matlab.ui.control.Label
        HeightTextArea               matlab.ui.control.TextArea
        HeightTextAreaLabel          matlab.ui.control.Label
        BrowseButton                 matlab.ui.control.Button
        Task15Tab                    matlab.ui.container.Tab
        CreateButton                 matlab.ui.control.Button
        ColorButton_2                matlab.ui.control.Button
        UIAxes2                      matlab.ui.control.UIAxes
        Task2Tab                     matlab.ui.container.Tab
        TextArea                     matlab.ui.control.TextArea
        NearestNeibourInterpolationPanel  matlab.ui.container.Panel
        UIAxes5                      matlab.ui.control.UIAxes
        BilinearInterpolationPanel   matlab.ui.container.Panel
        UIAxes4                      matlab.ui.control.UIAxes
        ViewButton                   matlab.ui.control.Button
        Task3Tab                     matlab.ui.container.Tab
        Panel_4                      matlab.ui.container.Panel
        UIAxes9                      matlab.ui.control.UIAxes
        Panel_3                      matlab.ui.container.Panel
        UIAxes8                      matlab.ui.control.UIAxes
        Panel_2                      matlab.ui.container.Panel
        UIAxes7                      matlab.ui.control.UIAxes
        Panel_5                      matlab.ui.container.Panel
        UIAxes6                      matlab.ui.control.UIAxes
        ViewButton_2                 matlab.ui.control.Button
        Task4Tab                     matlab.ui.container.Tab
        Panel_7                      matlab.ui.container.Panel
        UIAxes11                     matlab.ui.control.UIAxes
        TextArea_2                   matlab.ui.control.TextArea
        Panel_6                      matlab.ui.container.Panel
        UIAxes10                     matlab.ui.control.UIAxes
        StratButton                  matlab.ui.control.Button
    end

    
    properties (Access = public)
        Property % Description
        images;
        grayimage;
        values;
        colortypes;
    end
    
    methods (Access = private)
        
    end
    

    % Callbacks that handle component events
    methods (Access = private)

        % Code that executes after component creation
        function startupFcn(app)
            app.EnterImageLabel.Visible='on';
        end

        % Callback function: BrowseButton, Task15Tab
        function BrowseButtonPushed(app, event)
            global image;
            global arr;
            global bit_size;
            global bit_depth;
            global colour;
            global height;
            global width;
            global filesize;
            global depth;
            global color;   global name;
            
            try
                 
                %reading the image
                [filename ,pathname] = uigetfile({'*.*';'*.JPEG*';'*.bmp*';'*.dcm*'},"search img");
                
                fullpathname= [pathname, filename];
                disp(fullpathname);
                [filepath,name,ext] = fileparts(fullpathname);
                
                app.EnterImageLabel.Visible='off';
                app.HeightTextArea.Visible='on';
                 app.HeightTextAreaLabel.Visible='on';
                 app.BitDepthTextArea.Visible='on';
                 app.BitDepthTextAreaLabel.Visible='on';
                 app.WidthTextArea.Visible='on';
                 app.WidthTextAreaLabel.Visible='on';
                 app.BitsTextArea.Visible='on';
                 app.BitsTextAreaLabel.Visible='on';
                 app.ColorTypeTextArea.Visible='on';
                 app.ColorTypeTextAreaLabel.Visible='on';
                 app.Panel.Visible='on';
                %checking if the image is DICOM
                if ext(2)=='d'
                    
                    dic= [name ext];
                    
                    %reading the DICOM image
                    dicinfo = dicominfo(fullpathname);
                    %getting the height
                    app.NameTextArea.Visible='on';
                    app.NameTextAreaLabel.Visible='on';
                    app.modalityTextArea.Visible='on';
                    app.modalityTextAreaLabel.Visible='on';
                    app.ageTextArea.Visible='on';
                    app.ageTextAreaLabel.Visible='on';
                    app.partexamininedTextArea.Visible='on';
                    app.partexamininedTextAreaLabel.Visible='on';
                     height=dicinfo.Height;
                    app.HeightTextArea.Value = string(height);
                    %getting the width
                    width=dicinfo.Width;
                    app.WidthTextArea.Value = string(width);
                    %getting the size in bits
                    filesize=dicinfo.FileSize;
                    app.BitsTextArea.Value=string(filesize);
                    %getting the depth
                    depth=dicinfo.BitDepth;
                    
                    app.BitDepthTextArea.Value=string(depth);
                    %getting the colortype
                    colour=dicinfo.ColorType;
                    app.ColorTypeTextArea.Value=string(colour);
                    %handelling any missing data
                    try
                        modality=dicinfo.Modality;
                        app. modalityTextArea.Value=string(modality);

                    catch
                        app.modalityTextArea.Value='';
                        

                    end

                    try
                        name=dicinfo.PatientName.FamilyName;
                        app. NameTextArea.Value=string(name);

                    catch
                        app.NameTextArea.Value='';
                        

                    end
                   try
                        modality=dicinfo.StudyDescription;
                        app. partexamininedTextArea.Value=string(modality);

                    catch
                        app.partexamininedTextArea.Value='';

                   end

                    
                    try

                        age=dicinfo.PatientAge;
                        app.ageTextArea.Value=string(age);

                    catch
                        app.ageTextArea.Value='';
                    end

                    if isequal(name,0)
                        app.NameTextArea.Value='';
                    end
                    
                    image = dicomread(dicinfo);
                    Col = size(image,2);
                    Row = size(image,1);

                    %show the DICOM image
                    app.UIAxes.Position=[1,10,Row,Col];
                    imshow(image,[],'parent', app.UIAxes);
                    app.grayimage    =  image;
                    
                %if the photo was not DICOM
                else
                    image= imread(fullpathname);
                    Col = size(image,2);
                    Row = size(image,1);
                    %disp(RGB(image));
                   
                    [rows, columns, numberOfColorChannels] = size(image);
                    arr=[rows, columns, numberOfColorChannels];
                    % bit_size = dir(image);
                    info= imfinfo(fullpathname);
              %getting the height and width of the photo
                    bit_size=info.FileSize;
                    %getting the bit depth
                    bit_depth=info.BitDepth;
                    %viewing the photo
                    app.UIAxes.Position=[1,10,Row,Col];
                    imshow(image,'parent', app.UIAxes);
                    %viewing the other data
                    app.BitsTextArea.Value=string(bit_size);
                    app.WidthTextArea.Value = string(arr(1));
                    app.HeightTextArea.Value = string(arr(2));
                    app.BitDepthTextArea.Value=string(bit_depth);
                    %hendelling missing data
                    app.ageTextArea.Value='';
                    app.partexamininedTextArea.Value='';
                    app.NameTextArea.Value='';
                    app.modalityTextArea.Value='';
                    %getting the colour type
                    colour=info.ColorType;
                    if colour=='truecolor'
                        app.ColorTypeTextArea.Value='RGB';
                    elseif colour=='grayscale'
                        app.ColorTypeTextArea.Value='grayscale';
                    else 
                        app.ColorTypeTextArea.Value='binary';
                    end
                  val=2;
                end
                %handelling passing no photo or a corrupted photo
                catch
                    warndlg('please choose a valid photo');
                  
                    
                
            end
              
                
            app.images    =  image;
            app.colortypes=colour;
                
                
            
        end

        % Size changed function: Task1Tab
        function Task1TabSizeChanged(app, event)
            
            
        end

        % Button pushed function: CreateButton
        function CreateButtonPushed(app, event)
           %creating a white photo
            whiteImage = 255 * ones(10, 10, 3, 'uint8');
%vieweing the white photo
              imshow(whiteImage,'parent', app.UIAxes2);
        end

        % Button down function: Task1Tab
        function Task1TabButtonDown(app, event)
            
        end

        % Button down function: Task15Tab
        function Task15TabButtonDown(app, event)
            app.BrowseButton.Enable="off";
        end

        % Button pushed function: ColorButton_2
        function color(app, event)
             whiteImage = 255 * ones(50, 50, 3, 'uint8');
             whiteImage(2,end-4:end, :)=[0 0 255; 0 0 255; 0 0 255; 0 0 255;0 0 255];
             whiteImage(end-4:end,2, :)=[255 0 0; 255 0 0; 255 0 0; 255 0 0;255 0 0];
             imshow(whiteImage,'parent', app.UIAxes2);
        end

        % Button pushed function: GrayscaleButton
        function change(app, event)

     
      if  app.colortypes=='grayscale'
        warndlg('already grayscaled');
    
      
    
       else
            try
                    R=app.images(:,:,1);
                    G=app.images(:,:,2);
                    B=app.images(:,:,3);
                    %computing the grayscale of agiven image
                    newimage=(0.3 * R) + (0.59 * G) + (0.11 * B);
                    imshow(newimage,[],'parent', app.UIAxes);
                    app.grayimage=newimage;
catch
    warndlg('please choose a valid photo');
            end
        end
                   
        end

        % Size changed function: Task2Tab
        function tab3(app, event)


        end

        % Button down function: Task2Tab
        function newtab(app, event)
            
        end

        % Button pushed function: ViewButton
        function view(app, event)
try
 valo = app.values;
val= str2double(valo);

            

 %display(val);   
 disp(size(app.images,2));
%Nearest neighbour interpolation
Col = size(app.images,2)*val;
Row = size(app.images,2)*val;
B = imresize(app.grayimage,[size(app.images,2) size(app.images,2)]);
gray=imresize(app.grayimage,[size(app.images,2) size(app.images,2)]);
disp(size(app.images,2));
%FIND THE RATIO OF THE NEW SIZE BY OLD SIZE
rtR = Col/size(B,1);
rtC = Col/size(B,2);


%OBTAIN THE INTERPOLATED POSITIONS
IR = max(round([1:(size(B,1)*rtR)]./(rtR)),1);
IC = max(round([1:(size(B,2)*rtC)]./(rtC)),1);
if IR==0
    IR=1;
end
if IC==0
    IC=1;
end
    


%ROW_WISE INTERPOLATION
new = B(:,IR);


%COLUMN-WISE INTERPOLATION
new = new(IC,:);
%display(size(new));
 app.UIAxes5.Position=[0,27,Row,Col];
% 
 imshow(new,[],'parent', app.UIAxes5);





%Bilinear interpolation

[row col d] = size(app.images);  %3 dimentional array
 %val=8;                 %zooming factor
zr=val*row;
 zc=val*col;
 for i=1:zr

     x=i/val;

     x1=floor(x);
     x2=ceil(x);
     if x1==0
         x1=1;
     end
    xint=rem(x,1);
    for j=1:zc

         y=j/val;

        y1=floor(y);
         y2=ceil(y);
         if y1==0
             y1=1;
         end
       yint=rem(y,1);
%getting the bottom left point
       BL=gray(x1,y1,:);
       %getting the top left point
        TL=gray(x1,y2,:);
        %getting the bottom right point
         BR=gray(x2,y1,:);
         %getting the top right point
        TR=gray(x2,y2,:);

        R1=BR*yint+BL*(1-yint);
         R2=TR*yint+TL*(1-yint);

         im_zoom(i,j,:)=R1*xint+R2*(1-xint);
        end
 end
 %display(size(im_zoom));
  app.UIAxes4.Position=[0,19,Row,Col];
% % 
  imshow(im_zoom,[],'parent', app.UIAxes4);
catch 
   warndlg('please enter a valid input'); 
end







        end

        % Value changed function: TextArea
        function value(app, event)
            textvalue = app.TextArea.Value;
            app.values=textvalue;
        end

        % Value changed function: HeightTextArea
        function w(app, event)
            
            app.HeightTextArea.Visible='off';
            
        end

        % Button pushed function: ViewButton_2
        function displayss(app, event)
       try
           
       app.Panel_3.Visible='on';
       app.Panel_2.Visible='on';
       app.Panel_4.Visible='on';
       app.Panel_5.Visible='on';
         
      
            Col = size(app.images,2);
           Row = size(app.images,1);
           
            app.UIAxes6.Position=[0,0,Row,Col];
            app.UIAxes7.Position=[0,0,Row,Col];
            im=app.images;
            if  app.colortypes=='truecolor' 
              im = rgb2gray(im);
              display(app.colortypes);
            
            end
            %Normalized histogram
       Histo=zeros(1,256)  ;
       for i=1:Row
           for j=1:Col
               
               Temp=im(i,j);
               Histo(Temp+1)=Histo(Temp+1)+1;
               
           end
           
       end


%Generating PDF out of histogram by diving by total no. of pixels
Histo=Histo./(Col*Row);

%Generating CDF out of PDF
cdf = zeros(1,256);
cdf(1)=Histo(1);
for i=2:256
    
    cdf(i)=cdf(i-1)+Histo(i);
end
%getting the new points
SK = round(255*cdf);

ep = zeros(size(im));
for i=1:Row                                        %loop tracing the rows of image
    for j=1:Col                                   %loop tracing thes columns of image
        t=(im(i,j)+1);                               %pixel values in image
        ep(i,j)=SK(t);                             %Making the ouput image using cdf as the transformation function
    end                                             
end
%the normalized equalized histogram
Histo_2=zeros(1,256)  ;
       for i=1:Row
           for j=1:Col
               
               Temp=ep(i,j);
               Histo_2(Temp+1)=Histo_2(Temp+1)+1;
               
           end
           
       end


%Generating PDF out of histogram by diving by total no. of pixels
Histo_2=Histo_2./(Col*Row);



stem(app.UIAxes8,0:255,Histo);
stem(app.UIAxes9,0:255,Histo_2);
imshow(app.images,[],'parent', app.UIAxes6);
imshow(ep,[],'parent', app.UIAxes7);

 
       catch 
           warndlg('please enter a valid input');
           
       end     
        
        

 
  %imshow(Histo)
  
        end

        % Button pushed function: StratButton
        function task(app, event)
           
            valo = app.TextArea_2.Value;
           val= str2double(valo);
           
           
           
            try
                
                
                
            app.Panel_6.Visible='on';
       app.Panel_7.Visible='on';
           
            
            
            
            f=app.images;
            
            if  app.colortypes=='truecolor' 
              f = rgb2gray(f);
            end
            
            
            
           % f=rgb2gray(im);
            [x,y]=size(f);
           Col = size(app.images,2);
           Row = size(app.images,1);
           
          kernel=(1/val^2) *ones(val);
           %display(kernel);
           padding=(val-1);
           newsize=Col+padding;
           newarray=zeros(Row+padding,Col+padding );
          
           for i=1:size(f,1)
               for j=1:size(f,2)
                  newarray(i+(val-1)/2,j+(val-1)/2)=f(i,j); 
            
               end
               
           end  
           %PERFORM COONVOLUTION
for i = 1:size(newarray,1)-(val-1)
    for j = 1:size(newarray,2)-(val-1)
        Temp = newarray(i:i+(val-1),j:j+(val-1)).* kernel;
        Output(i,j) = sum(Temp(:));
    end
end   
casted = cast( Output , 'uint8' );
display(class(casted));
display(class(Output));
%display(Output);
          
subtracted=f -casted;
  lastoutput= subtracted*val+ casted; 
            %for i=1:size(lastoutput,1)
              % for j=1:size(lastoutput,2)
                   
                   %if lastoutput(i,j)<0
                       
                      % lastoutput(i,j)=0;
                   %elseif lastoutput(i,j)>255
                       %lastoutput(i,j)=255;
                   %end
               %end
            
            %end
           
            app.UIAxes10.Position=[0,23,Row,Col];
            app.UIAxes11.Position=[20,370,Row,Col];
            imshow(app.images,[],'parent', app.UIAxes10);
            imshow(lastoutput,[],'parent', app.UIAxes11);
            
            catch 
               warndlg('please enter a valid input'); 
            end
            
             if mod( val , 2 )==0
                warndlg('please enter an odd input');
               
               
            end
            
        end
    end

    % Component initialization
    methods (Access = private)

        % Create UIFigure and components
        function createComponents(app)

            % Create UIFigure and hide until all components are created
            app.UIFigure = uifigure('Visible', 'off');
            app.UIFigure.Position = [100 100 634 448];
            app.UIFigure.Name = 'MATLAB App';

            % Create TabGroup
            app.TabGroup = uitabgroup(app.UIFigure);
            app.TabGroup.Position = [1 -5 636 454];

            % Create Task1Tab
            app.Task1Tab = uitab(app.TabGroup);
            app.Task1Tab.SizeChangedFcn = createCallbackFcn(app, @Task1TabSizeChanged, true);
            app.Task1Tab.Title = 'Task1';
            app.Task1Tab.BackgroundColor = [0 0 0];
            app.Task1Tab.ButtonDownFcn = createCallbackFcn(app, @Task1TabButtonDown, true);

            % Create BrowseButton
            app.BrowseButton = uibutton(app.Task1Tab, 'push');
            app.BrowseButton.ButtonPushedFcn = createCallbackFcn(app, @BrowseButtonPushed, true);
            app.BrowseButton.Position = [20 335 100 22];
            app.BrowseButton.Text = 'Browse';

            % Create HeightTextAreaLabel
            app.HeightTextAreaLabel = uilabel(app.Task1Tab);
            app.HeightTextAreaLabel.HorizontalAlignment = 'right';
            app.HeightTextAreaLabel.Visible = 'off';
            app.HeightTextAreaLabel.Position = [149 392 39 22];
            app.HeightTextAreaLabel.Text = 'Height';

            % Create HeightTextArea
            app.HeightTextArea = uitextarea(app.Task1Tab);
            app.HeightTextArea.ValueChangedFcn = createCallbackFcn(app, @w, true);
            app.HeightTextArea.Visible = 'off';
            app.HeightTextArea.Position = [203 383 106 33];

            % Create WidthTextAreaLabel
            app.WidthTextAreaLabel = uilabel(app.Task1Tab);
            app.WidthTextAreaLabel.HorizontalAlignment = 'right';
            app.WidthTextAreaLabel.Visible = 'off';
            app.WidthTextAreaLabel.Position = [153 339 35 22];
            app.WidthTextAreaLabel.Text = 'Width';

            % Create WidthTextArea
            app.WidthTextArea = uitextarea(app.Task1Tab);
            app.WidthTextArea.Visible = 'off';
            app.WidthTextArea.Position = [203 330 106 33];

            % Create BitsTextAreaLabel
            app.BitsTextAreaLabel = uilabel(app.Task1Tab);
            app.BitsTextAreaLabel.HorizontalAlignment = 'right';
            app.BitsTextAreaLabel.Visible = 'off';
            app.BitsTextAreaLabel.Position = [163 283 25 22];
            app.BitsTextAreaLabel.Text = 'Bits';

            % Create BitsTextArea
            app.BitsTextArea = uitextarea(app.Task1Tab);
            app.BitsTextArea.Visible = 'off';
            app.BitsTextArea.Position = [203 274 106 33];

            % Create BitDepthTextAreaLabel
            app.BitDepthTextAreaLabel = uilabel(app.Task1Tab);
            app.BitDepthTextAreaLabel.HorizontalAlignment = 'right';
            app.BitDepthTextAreaLabel.Visible = 'off';
            app.BitDepthTextAreaLabel.Position = [133 237 55 22];
            app.BitDepthTextAreaLabel.Text = 'Bit Depth';

            % Create BitDepthTextArea
            app.BitDepthTextArea = uitextarea(app.Task1Tab);
            app.BitDepthTextArea.Visible = 'off';
            app.BitDepthTextArea.Position = [203 228 106 33];

            % Create ColorTypeTextAreaLabel
            app.ColorTypeTextAreaLabel = uilabel(app.Task1Tab);
            app.ColorTypeTextAreaLabel.HorizontalAlignment = 'right';
            app.ColorTypeTextAreaLabel.Visible = 'off';
            app.ColorTypeTextAreaLabel.Position = [125 194 63 22];
            app.ColorTypeTextAreaLabel.Text = 'Color Type';

            % Create ColorTypeTextArea
            app.ColorTypeTextArea = uitextarea(app.Task1Tab);
            app.ColorTypeTextArea.Visible = 'off';
            app.ColorTypeTextArea.Position = [203 185 106 33];

            % Create NameTextAreaLabel
            app.NameTextAreaLabel = uilabel(app.Task1Tab);
            app.NameTextAreaLabel.HorizontalAlignment = 'right';
            app.NameTextAreaLabel.Visible = 'off';
            app.NameTextAreaLabel.Position = [384 390 37 22];
            app.NameTextAreaLabel.Text = 'Name';

            % Create NameTextArea
            app.NameTextArea = uitextarea(app.Task1Tab);
            app.NameTextArea.Visible = 'off';
            app.NameTextArea.Position = [436 381 106 33];

            % Create ageTextAreaLabel
            app.ageTextAreaLabel = uilabel(app.Task1Tab);
            app.ageTextAreaLabel.HorizontalAlignment = 'right';
            app.ageTextAreaLabel.Visible = 'off';
            app.ageTextAreaLabel.Position = [396 339 25 22];
            app.ageTextAreaLabel.Text = 'age';

            % Create ageTextArea
            app.ageTextArea = uitextarea(app.Task1Tab);
            app.ageTextArea.Visible = 'off';
            app.ageTextArea.Position = [436 330 106 33];

            % Create modalityTextAreaLabel
            app.modalityTextAreaLabel = uilabel(app.Task1Tab);
            app.modalityTextAreaLabel.HorizontalAlignment = 'right';
            app.modalityTextAreaLabel.Visible = 'off';
            app.modalityTextAreaLabel.Position = [371 284 50 22];
            app.modalityTextAreaLabel.Text = 'modality';

            % Create modalityTextArea
            app.modalityTextArea = uitextarea(app.Task1Tab);
            app.modalityTextArea.Visible = 'off';
            app.modalityTextArea.Position = [436 275 106 33];

            % Create partexamininedTextAreaLabel
            app.partexamininedTextAreaLabel = uilabel(app.Task1Tab);
            app.partexamininedTextAreaLabel.HorizontalAlignment = 'right';
            app.partexamininedTextAreaLabel.Visible = 'off';
            app.partexamininedTextAreaLabel.Position = [330 238 91 22];
            app.partexamininedTextAreaLabel.Text = 'part examinined';

            % Create partexamininedTextArea
            app.partexamininedTextArea = uitextarea(app.Task1Tab);
            app.partexamininedTextArea.Visible = 'off';
            app.partexamininedTextArea.Position = [436 229 106 33];

            % Create GrayscaleButton
            app.GrayscaleButton = uibutton(app.Task1Tab, 'push');
            app.GrayscaleButton.ButtonPushedFcn = createCallbackFcn(app, @change, true);
            app.GrayscaleButton.Position = [20 304 100 22];
            app.GrayscaleButton.Text = 'Grayscale';

            % Create Panel
            app.Panel = uipanel(app.Task1Tab);
            app.Panel.Visible = 'off';
            app.Panel.Scrollable = 'on';
            app.Panel.Position = [330 45 253 175];

            % Create UIAxes
            app.UIAxes = uiaxes(app.Panel);
            xlabel(app.UIAxes, 'X')
            ylabel(app.UIAxes, 'Y')
            zlabel(app.UIAxes, 'Z')
            app.UIAxes.Position = [1 29 222 136];

            % Create EnterImageLabel
            app.EnterImageLabel = uilabel(app.Task1Tab);
            app.EnterImageLabel.HorizontalAlignment = 'center';
            app.EnterImageLabel.FontSize = 30;
            app.EnterImageLabel.FontColor = [0.902 0.902 0.902];
            app.EnterImageLabel.Position = [34 203 560 59];
            app.EnterImageLabel.Text = 'Enter  Image';

            % Create Task15Tab
            app.Task15Tab = uitab(app.TabGroup);
            app.Task15Tab.SizeChangedFcn = createCallbackFcn(app, @BrowseButtonPushed, true);
            app.Task15Tab.Title = 'Task1.5';
            app.Task15Tab.BackgroundColor = [0 0 0];
            app.Task15Tab.ForegroundColor = [1 1 1];
            app.Task15Tab.ButtonDownFcn = createCallbackFcn(app, @Task15TabButtonDown, true);

            % Create UIAxes2
            app.UIAxes2 = uiaxes(app.Task15Tab);
            title(app.UIAxes2, 'Title')
            xlabel(app.UIAxes2, 'X')
            ylabel(app.UIAxes2, 'Y')
            zlabel(app.UIAxes2, 'Z')
            app.UIAxes2.Position = [234 146 300 185];

            % Create ColorButton_2
            app.ColorButton_2 = uibutton(app.Task15Tab, 'push');
            app.ColorButton_2.ButtonPushedFcn = createCallbackFcn(app, @color, true);
            app.ColorButton_2.Position = [34 383 100 22];
            app.ColorButton_2.Text = 'Color';

            % Create CreateButton
            app.CreateButton = uibutton(app.Task15Tab, 'push');
            app.CreateButton.ButtonPushedFcn = createCallbackFcn(app, @CreateButtonPushed, true);
            app.CreateButton.Position = [34 341 100 22];
            app.CreateButton.Text = 'Create';

            % Create Task2Tab
            app.Task2Tab = uitab(app.TabGroup);
            app.Task2Tab.SizeChangedFcn = createCallbackFcn(app, @tab3, true);
            app.Task2Tab.Title = 'Task2';
            app.Task2Tab.BackgroundColor = [0 0 0];
            app.Task2Tab.ForegroundColor = [0.149 0.149 0.149];
            app.Task2Tab.ButtonDownFcn = createCallbackFcn(app, @newtab, true);

            % Create ViewButton
            app.ViewButton = uibutton(app.Task2Tab, 'push');
            app.ViewButton.ButtonPushedFcn = createCallbackFcn(app, @view, true);
            app.ViewButton.FontColor = [0 1 1];
            app.ViewButton.Position = [10 350 100 22];
            app.ViewButton.Text = 'View';

            % Create BilinearInterpolationPanel
            app.BilinearInterpolationPanel = uipanel(app.Task2Tab);
            app.BilinearInterpolationPanel.Title = 'Bilinear Interpolation';
            app.BilinearInterpolationPanel.Scrollable = 'on';
            app.BilinearInterpolationPanel.Position = [359 105 260 221];

            % Create UIAxes4
            app.UIAxes4 = uiaxes(app.BilinearInterpolationPanel);
            title(app.UIAxes4, 'Title')
            xlabel(app.UIAxes4, 'X')
            ylabel(app.UIAxes4, 'Y')
            zlabel(app.UIAxes4, 'Z')
            app.UIAxes4.Position = [1 19 259 185];

            % Create NearestNeibourInterpolationPanel
            app.NearestNeibourInterpolationPanel = uipanel(app.Task2Tab);
            app.NearestNeibourInterpolationPanel.Title = 'Nearest Neibour Interpolation';
            app.NearestNeibourInterpolationPanel.Scrollable = 'on';
            app.NearestNeibourInterpolationPanel.Position = [31 105 260 221];

            % Create UIAxes5
            app.UIAxes5 = uiaxes(app.NearestNeibourInterpolationPanel);
            title(app.UIAxes5, 'Title')
            xlabel(app.UIAxes5, 'X')
            ylabel(app.UIAxes5, 'Y')
            zlabel(app.UIAxes5, 'Z')
            app.UIAxes5.Position = [1 18 259 185];

            % Create TextArea
            app.TextArea = uitextarea(app.Task2Tab);
            app.TextArea.ValueChangedFcn = createCallbackFcn(app, @value, true);
            app.TextArea.Position = [20 378 82 46];

            % Create Task3Tab
            app.Task3Tab = uitab(app.TabGroup);
            app.Task3Tab.Title = 'Task3';
            app.Task3Tab.BackgroundColor = [0 0 0];

            % Create ViewButton_2
            app.ViewButton_2 = uibutton(app.Task3Tab, 'push');
            app.ViewButton_2.ButtonPushedFcn = createCallbackFcn(app, @displayss, true);
            app.ViewButton_2.Position = [20 388 100 22];
            app.ViewButton_2.Text = 'View';

            % Create Panel_5
            app.Panel_5 = uipanel(app.Task3Tab);
            app.Panel_5.Visible = 'off';
            app.Panel_5.Scrollable = 'on';
            app.Panel_5.Position = [10 219 216 153];

            % Create UIAxes6
            app.UIAxes6 = uiaxes(app.Panel_5);
            title(app.UIAxes6, 'image')
            xlabel(app.UIAxes6, 'X')
            ylabel(app.UIAxes6, 'Y')
            zlabel(app.UIAxes6, 'Z')
            app.UIAxes6.Position = [0 19 215 152];

            % Create Panel_2
            app.Panel_2 = uipanel(app.Task3Tab);
            app.Panel_2.Visible = 'off';
            app.Panel_2.Scrollable = 'on';
            app.Panel_2.Position = [10 55 225 152];

            % Create UIAxes7
            app.UIAxes7 = uiaxes(app.Panel_2);
            title(app.UIAxes7, 'Equalized image')
            xlabel(app.UIAxes7, 'X')
            ylabel(app.UIAxes7, 'Y')
            zlabel(app.UIAxes7, 'Z')
            app.UIAxes7.Position = [0 19 224 151];

            % Create Panel_3
            app.Panel_3 = uipanel(app.Task3Tab);
            app.Panel_3.Visible = 'off';
            app.Panel_3.Scrollable = 'on';
            app.Panel_3.Position = [339 219 255 153];

            % Create UIAxes8
            app.UIAxes8 = uiaxes(app.Panel_3);
            title(app.UIAxes8, 'Normalized histogram')
            xlabel(app.UIAxes8, 'X')
            ylabel(app.UIAxes8, 'Y')
            zlabel(app.UIAxes8, 'Z')
            app.UIAxes8.Position = [0 19 254 152];

            % Create Panel_4
            app.Panel_4 = uipanel(app.Task3Tab);
            app.Panel_4.Visible = 'off';
            app.Panel_4.Position = [347 42 247 162];

            % Create UIAxes9
            app.UIAxes9 = uiaxes(app.Panel_4);
            title(app.UIAxes9, 'Normalized histogram of equalized image')
            xlabel(app.UIAxes9, 'X')
            ylabel(app.UIAxes9, 'Y')
            zlabel(app.UIAxes9, 'Z')
            app.UIAxes9.Position = [0 19 246 161];

            % Create Task4Tab
            app.Task4Tab = uitab(app.TabGroup);
            app.Task4Tab.Title = 'Task 4';
            app.Task4Tab.BackgroundColor = [0 0 0];

            % Create StratButton
            app.StratButton = uibutton(app.Task4Tab, 'push');
            app.StratButton.ButtonPushedFcn = createCallbackFcn(app, @task, true);
            app.StratButton.Position = [17 341 100 22];
            app.StratButton.Text = 'Strat';

            % Create Panel_6
            app.Panel_6 = uipanel(app.Task4Tab);
            app.Panel_6.Visible = 'off';
            app.Panel_6.Scrollable = 'on';
            app.Panel_6.Position = [1 95 260 221];

            % Create UIAxes10
            app.UIAxes10 = uiaxes(app.Panel_6);
            xlabel(app.UIAxes10, 'X')
            ylabel(app.UIAxes10, 'Y')
            zlabel(app.UIAxes10, 'Z')
            app.UIAxes10.Position = [0 42 259 185];

            % Create TextArea_2
            app.TextArea_2 = uitextarea(app.Task4Tab);
            app.TextArea_2.Position = [20 370 93 33];

            % Create Panel_7
            app.Panel_7 = uipanel(app.Task4Tab);
            app.Panel_7.Visible = 'off';
            app.Panel_7.Scrollable = 'on';
            app.Panel_7.Position = [312 99 260 221];

            % Create UIAxes11
            app.UIAxes11 = uiaxes(app.Panel_7);
            title(app.UIAxes11, 'The enhanced image')
            xlabel(app.UIAxes11, 'X')
            ylabel(app.UIAxes11, 'Y')
            zlabel(app.UIAxes11, 'Z')
            app.UIAxes11.Position = [0 54 259 185];

            % Show the figure after all components are created
            app.UIFigure.Visible = 'on';
        end
    end

    % App creation and deletion
    methods (Access = public)

        % Construct app
        function app = TASL_4_exported

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