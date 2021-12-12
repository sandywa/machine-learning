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

% Last Modified by GUIDE v2.5 12-Dec-2021 09:46:20

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
 handles.myImage = strcat(pathname, filename);
 axes(handles.imageAxes);
 imshow(handles.myImage);
 set(handles.pathFile,'String',handles.myImage);



% --- Executes on button press in Klasifikasi.
function Klasifikasi_Callback(hObject, eventdata, handles)
% hObject    handle to Klasifikasi (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in Mentah.
function Mentah_Callback(hObject, eventdata, handles)
% hObject    handle to Mentah (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
  sourceFolder = uigetdir();
  handles.sourceFolderMentah = sourceFolder;
  set(handles.pathFile,'String',handles.sourceFolderMentah);
 %guidata(hObject, handles);
  


% --- Executes on button press in Matang.
function Matang_Callback(hObject, eventdata, handles)
% hObject    handle to Matang (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
  sourceFolder = uigetdir();
  handles.sourceFolderMatang = sourceFolder;
  set(handles.pathFile,'String',handles.sourceFolderMatang);


% --- Executes on button press in SangatMatang.
function SangatMatang_Callback(hObject, eventdata, handles)
% hObject    handle to SangatMatang (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
  sourceFolder = uigetdir();
  handles.sourceFolderSgtMatang = sourceFolder;
  set(handles.pathFile,'String',handles.sourceFolderSgtMatang);


% --- Executes on button press in Processing.
function Processing_Callback(hObject, eventdata, handles)
% hObject    handle to Processing (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
