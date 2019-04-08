function varargout = timeVaryGain(varargin)
% TIMEVARYGAIN MATLAB code for timeVaryGain.fig
%      TIMEVARYGAIN, by itself, creates a new TIMEVARYGAIN or raises the existing
%      singleton*.
%
%      H = TIMEVARYGAIN returns the handle to a new TIMEVARYGAIN or the handle to
%      the existing singleton*.
%
%      TIMEVARYGAIN('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in TIMEVARYGAIN.M with the given input arguments.
%
%      TIMEVARYGAIN('Property','Value',...) creates a new TIMEVARYGAIN or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before timeVaryGain_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to timeVaryGain_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help timeVaryGain

% Last Modified by GUIDE v2.5 14-Sep-2016 21:11:58

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @timeVaryGain_OpeningFcn, ...
                   'gui_OutputFcn',  @timeVaryGain_OutputFcn, ...
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


% --- Executes just before timeVaryGain is made visible.
function timeVaryGain_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to timeVaryGain (see VARARGIN)

% Choose default command line output for timeVaryGain
handles.output = hObject;
handles.ns=varargin{1};
% handles.ns=500;
% Update handles structure
handles.tvg.Order=str2double(get(handles.OrderEdit,'String'));
handles.tvg.Wn=str2double(get(handles.WnEdit,'String'));
guidata(hObject,handles);
N=handles.tvg.Order;
Wn=handles.tvg.Wn;
[B,A]=butter(N,Wn,'high');
H=freqz(B,A,handles.ns);
x=1:handles.ns;
plot(x,abs(H));
ylim([-0.1,1.1]);
set(gca,'YTick',[0,1]);
xlim([0,handles.ns]);
% UIWAIT makes timeVaryGain wait for user response (see UIRESUME)
uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = timeVaryGain_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
if ~isempty(handles)
    varargout{1} = handles.output;
    varargout{2} = handles.tvg;
    varargout{3} = 1; 
else
    varargout{1} = NaN;
    varargout{2} = NaN;
    varargout{3} = NaN;
end


% --- Executes on button press in OKBuT.
function OKBuT_Callback(hObject, eventdata, handles)
% hObject    handle to OKBuT (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.tvg.Order=str2double(get(handles.OrderEdit,'String'));
handles.tvg.Wn=str2double(get(handles.WnEdit,'String'));
guidata(hObject,handles);
guidata(hObject,handles);
uiresume(handles.figure1);

% --- Executes on button press in CancelBuT.
function CancelBuT_Callback(hObject, eventdata, handles)
% hObject    handle to CancelBuT (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close(gcf)

function OrderEdit_Callback(hObject, eventdata, handles)
% hObject    handle to OrderEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of OrderEdit as text
%        str2double(get(hObject,'String')) returns contents of OrderEdit as a double
handles.tvg.Order=str2double(get(handles.OrderEdit,'String'));
handles.tvg.Wn=str2double(get(handles.WnEdit,'String'));
guidata(hObject,handles);
N=handles.tvg.Order;
Wn=handles.tvg.Wn;
[B,A]=butter(N,Wn,'high');
H=freqz(B,A,handles.ns);
x=1:handles.ns;
plot(x,abs(H));
ylim([-0.1,1.1]);
set(gca,'YTick',[0,1]);
xlim([0,handles.ns]);
guidata(hObject,handles);


% --- Executes during object creation, after setting all properties.
function OrderEdit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to OrderEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function WnEdit_Callback(hObject, eventdata, handles)
% hObject    handle to WnEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of WnEdit as text
%        str2double(get(hObject,'String')) returns contents of WnEdit as a double
handles.tvg.Order=str2double(get(handles.OrderEdit,'String'));
handles.tvg.Wn=str2double(get(handles.WnEdit,'String'));
guidata(hObject,handles);
N=handles.tvg.Order;
Wn=handles.tvg.Wn;
[B,A]=butter(N,Wn,'high');
H=freqz(B,A,handles.ns);
x=1:handles.ns;
plot(x,abs(H));
ylim([-0.1,1.1]);
set(gca,'YTick',[0,1]);
xlim([1,handles.ns]);

% --- Executes during object creation, after setting all properties.
function WnEdit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to WnEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
