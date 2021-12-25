

function varargout = main(varargin)
% MAIN MATLAB code for main.fig
%      MAIN, by itself, creates a new MAIN or raises the existing
%      singleton*.
%
%      H = MAIN returns the handle to a new MAIN or the handle to
%      the existing singleton*.
%
%      MAIN('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MAIN.M with the given input arguments.
%
%      MAIN('Property','Value',...) creates a new MAIN or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before main_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to main_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help main

% Last Modified by GUIDE v2.5 12-Dec-2021 11:10:32

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @main_OpeningFcn, ...
                   'gui_OutputFcn',  @main_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT



% --- Executes just before main is made visible.
function main_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to main (see VARARGIN)

% Choose default command line output for main
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes main wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = main_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in ImportCSV.
function ImportCSV_Callback(hObject, eventdata, handles)
% hObject    handle to ImportCSV (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[File, Path] = uigetfile('*.csv');
handles.dataSet = [Path File];
set(handles.csvStatic,'String',handles.dataSet)
guidata(hObject,handles)


% --- Executes on button press in ImportGambar.
function ImportGambar_Callback(hObject, eventdata, handles)
% hObject    handle to ImportGambar (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[filename pathname] = uigetfile(...
    {'.bmp;*.png;*.jpeg;*.jpg', 'File citra(.bmp,*.png,*.jpeg,*.jpg)';
    '.bmp', 'File Bitmap(.bmp)';...
    '.png', 'File Png(.png)';...
    '.jpg', 'File Jpeg(.jpg)';
    '.', 'Semua File (.)'},...
    'Buka Citra asli');
 %set image into axes
 handles.myImage = strcat(pathname, filename);
 axes(handles.imageAxes);
 imshow(handles.myImage);
 %set histogram
 imageImport = imread(handles.myImage);
 axes(handles.axes3);
 imhist(imageImport);
 set(handles.pathFile,'String',handles.myImage);
 %image RGB process
 img=handles.myImage;
    sz=imread(img); %read the image
    pict=double(sz);% convert it to double for calculations
    dim=size(pict); %determine the dimension of the pict
    count=0;meanR=0;meanG=0;meanB=0;%preallocations
    for i=1:dim(1)
        for j=1:dim(2)
            meanR=meanR+pict(i,j,1);
            meanG=meanG+pict(i,j,2);
            meanB=meanB+pict(i,j,3);
            count=count+1;
        end
        meanR1=meanR/count;
        meanG1=meanG/count;
        meanB1=meanB/count;
    end
    
    global avgrgbImage;
    avgrgbImage=[meanR1,meanG1,meanB1]; %prints the rgb average value
    
    %set RGB text gui
    set(handles.red,'String',meanR1)
    set(handles.green,'String',meanG1)
    set(handles.blue,'String',meanB1)
    disp(avgrgbImage);



% --- Executes on button press in Klasifikasi.
function Klasifikasi_Callback(hObject, eventdata, handles)
% hObject    handle to Klasifikasi (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global avgrgbImage;
sample = avgrgbImage;

opts = detectImportOptions(handles.dataSet);
opts.SelectedVariableNames = (2:4);
training = readmatrix(handles.dataSet, opts);

opts = detectImportOptions(handles.dataSet);
opts.SelectedVariableNames = (1);
group = readmatrix(handles.dataSet, opts);

class = fitcknn(training, group,'NumNeighbors', 5);
klasifikasi = predict(class, sample);
if(klasifikasi==1)
   hasil="Apple";
end
if(klasifikasi==2)
   hasil="Banana";
end
if(klasifikasi==3)
   hasil="Orange";
end
set(handles.text3,'String',hasil);

disp('Hasil klasifikasi :  ')
disp(klasifikasi)


% --- Executes on button press in Mentah.
function Mentah_Callback(hObject, eventdata, handles)
% hObject    handle to Mentah (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%  sourceFolder = uigetdir();
%  global sourceFolderMentah;
%  sourceFolderMentah = sourceFolder;
    %create matrix sample data 1
    folder = uigetdir();
    I=dir(fullfile(folder,'*.png'));
    for a=1:numel(I)
      filename=fullfile(folder,I(a).name);
      name{a} = filename;
      disp(filename);
    end
    for aa=1:numel(I)
        img=name{aa};
        sz=imread(img); %read the image
        pict=double(sz);% convert it to double for calculations
        dim=size(pict); %determine the dimension of the pict
        count=0;meanR=0;meanG=0;meanB=0;%preallocations
        for i=1:dim(1)
            for j=1:dim(2)
                meanR=meanR+pict(i,j,1);
                meanG=meanG+pict(i,j,2);
                meanB=meanB+pict(i,j,3);
                count=count+1;
            end
            meanR1=meanR/count;
            meanG1=meanG/count;
            meanB1=meanB/count;
        end
        avgrgb{aa}=[meanR1,meanG1,meanB1]; %prints the rgb average value
          disp(avgrgb{aa});

          % create matrix sample
          if (aa  == 1)
            sample1 = [1];
          else 
            sample1 = [sample1;1];
          end

          % create matrix rgb data1
          if (aa == 1)
                matrix = avgrgb{aa};
          else
                matrix = [ matrix ; avgrgb{aa}];
          end
    end
    global finalSample;
    finalSample = sample1 ;
    global finalMatrix;
    finalMatrix = matrix ;
    set(handles.staticMentah,'String','Teruploud');
  


% --- Executes on button press in Matang.
function Matang_Callback(hObject, eventdata, handles)
% hObject    handle to Matang (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%  sourceFolder = uigetdir();
%  global sourceFolderMatang;
%  sourceFolderMatang = sourceFolder;
    %create matrix sample data 2
    folder = uigetdir();
    J=dir(fullfile(folder,'*.png'));
    for b=1:numel(J)
      filename2=fullfile(folder,J(b).name);
      name2{b} = filename2;
      disp(filename2);
    end
    for bb=1:numel(J)
        img2=name2{bb};
        sz2=imread(img2); %read the image
        pict2=double(sz2);% convert it to double for calculations
        dim2=size(pict2); %determine the dimension of the pict
        count2=0;meanR2=0;meanG2=0;meanB2=0;%preallocations
        for m=1:dim2(1)
            for n=1:dim2(2)
                meanR2=meanR2+pict2(m,n,1);
                meanG2=meanG2+pict2(m,n,2);
                meanB2=meanB2+pict2(m,n,3);
                count2=count2+1;
            end
            meanR12=meanR2/count2;
            meanG12=meanG2/count2;
            meanB12=meanB2/count2;
        end
        avgrgb2{bb}=[meanR12,meanG12,meanB12]; %prints the rgb average value
          disp(avgrgb2{bb});

          % create matrix sample2
          if (bb  == 1)
            sample2 = [2];
          else 
            sample2 = [sample2;2];
          end

          % create matrix data2
          if (bb == 1)
                matrix2 = avgrgb2{bb};
          else
                matrix2 = [ matrix2 ; avgrgb2{bb}];
          end
    end
    global finalSample2;
    finalSample2 = sample2 ;
    global finalMatrix2;
    finalMatrix2 = matrix2 ;
    set(handles.staticMatang,'String', 'Teruploud');
  


% --- Executes on button press in SangatMatang.
function SangatMatang_Callback(hObject, eventdata, handles)
% hObject    handle to SangatMatang (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%  sourceFolder = uigetdir();
%  global sourceFolderSgtMatang;
%  sourceFolderSgtMatang = sourceFolder;
    %create matrix sample data 2
    folder3 = uigetdir();
    J=dir(fullfile(folder3,'*.png'));
    for b=1:numel(J)
      filename3=fullfile(folder3,J(b).name);
      name3{b} = filename3;
      disp(filename3);
    end
    for bb=1:numel(J)
        img3=name3{bb};
        sz3=imread(img3); %read the image
        pict3=double(sz3);% convert it to double for calculations
        dim3=size(pict3); %determine the dimension of the pict
        count3=0;meanR3=0;meanG3=0;meanB3=0;%preallocations
        for m=1:dim3(1)
            for n=1:dim3(2)
                meanR3=meanR3+pict3(m,n,1);
                meanG3=meanG3+pict3(m,n,2);
                meanB3=meanB3+pict3(m,n,3);
                count3=count3+1;
            end
            meanR13=meanR3/count3;
            meanG13=meanG3/count3;
            meanB13=meanB3/count3;
        end
        avgrgb2{bb}=[meanR13,meanG13,meanB13]; %prints the rgb average value
          disp(avgrgb2{bb});

          % create matrix sample2
          if (bb  == 1)
            sample3 = [3];
          else 
            sample3 = [sample3;3];
          end

          % create matrix data2
          if (bb == 1)
                matrix3 = avgrgb2{bb};
          else
                matrix3 = [ matrix3 ; avgrgb2{bb}];
          end
    end
    
    global finalSample3;
    finalSample3 = sample3 ;
    global finalMatrix3;
    finalMatrix3 = matrix3 ;
    set(handles.staticSgtMatang,'String','Teruploud');
    disp(finalSample3);
  


% --- Executes on button press in Processing.
function Processing_Callback(hObject, eventdata, handles)
% hObject    handle to Processing (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    global finalSample;
    global finalMatrix;
    global finalSample2;
    global finalMatrix2;
    global finalSample3;
    global finalMatrix3;
    final = [finalSample finalMatrix;finalSample2 finalMatrix2;finalSample3 finalMatrix3];
writematrix(final,'a.csv','Delimiter','tab');
set(handles.proses,'String','Data Training Berhasil Dibuat');







