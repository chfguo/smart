function varargout = firFilter(varargin)
% FIRFILTER MATLAB code for firFilter.fig
%      FIRFILTER, by itself, creates a new FIRFILTER or raises the existing
%      singleton*.
%
%      H = FIRFILTER returns the handle to a new FIRFILTER or the handle to
%      the existing singleton*.
%
%      FIRFILTER('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in FIRFILTER.M with the given input arguments.
%
%      FIRFILTER('Property','Value',...) creates a new FIRFILTER or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before firFilter_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to firFilter_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help firFilter

% Last Modified by GUIDE v2.5 13-Sep-2016 15:16:47

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @firFilter_OpeningFcn, ...
    'gui_OutputFcn',  @firFilter_OutputFcn, ...
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


% --- Executes just before firFilter is made visible.
function firFilter_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to firFilter (see VARARGIN)

% Choose default command line output for firFilter
% [data,hdr]=gfreadgpr('2G测大桥.LTE');
% filterType='low';
% 
data=varargin{1};
hdr=varargin{2};
filterType=varargin{3};
handles.ntr=hdr.ntr;
handles.ns=hdr.ns;
handles.dt=1;

handles.output = hObject;
handles.data=data;
handles.firType=filterType;
handles.firName=1;
handles.firOrder=2;
handles.firWp=0.5;
handles.firWs=0.1;
handles.firRp=0.5;
handles.firRs=20;
handles.Wn=0.5;
handles.SI=floor(hdr.ntr/2);

set(handles.ntrText,'String',num2str(hdr.ntr));
set(handles.SIEdit,'String',num2str(floor(hdr.ntr/2)));
switch handles.firType
    case 'low'
        set(handles.WpEdit,'enable','off');
        set(handles.RpEdit,'enable','off');
        set(handles.RsEdit,'enable','off');
    case 'high'
        set(handles.WsEdit,'enable','off');
        set(handles.RpEdit,'enable','off');
        set(handles.RsEdit,'enable','off');
    case 'bandstop'
        set(handles.RpEdit,'enable','off');
        set(handles.RsEdit,'enable','off');
    case 'bandpass'
        set(handles.RpEdit,'enable','off');
        set(handles.RsEdit,'enable','off');
    otherwise
        warndlg('Unrecogized filting type');
end
% Update handles structure
guidata(hObject, handles);
firdisp(hObject, handles);

% UIWAIT makes firFilter wait for user response (see UIRESUME)
% uiwait(handles.figure1);
uiwait(handles.figure1);

% --- Outputs from this function are returned to the command line.
function varargout = firFilter_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
if ~isempty(handles)
    varargout{1} = handles.output;
    varargout{2} = handles.fircf;
    varargout{3} = 1; 
else
    varargout{1} = NaN;
    varargout{2} = NaN;
    varargout{3} = NaN;
end


% --- Executes on selection change in filterType.
function filterType_Callback(hObject, eventdata, handles)
% hObject    handle to filterType (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns filterType contents as cell array
%        contents{get(hObject,'Value')} returns selected item from filterType
set(handles.WsEdit,'enable','off');
set(handles.WpEdit,'enable','off');
set(handles.RpEdit,'enable','off');
set(handles.RsEdit,'enable','off');
filterType=get(hObject,'value');
switch filterType
    case 1
        handles.firName=1;
        switch handles.firType
            case 'low'
                set(handles.WsEdit,'enable','on');
            case 'high'
                set(handles.WpEdit,'enable','on');
            otherwise
                set(handles.WsEdit,'enable','on');
                set(handles.WpEdit,'enable','on');
                set(handles.RpEdit,'enable','on');
        end
    case 2
        handles.firName=2;
        switch handles.firType
            case 'low'
                set(handles.WsEdit,'enable','on');
                set(handles.RpEdit,'enable','on');
            case 'high'
                set(handles.WpEdit,'enable','on');
                set(handles.RpEdit,'enable','on');
            otherwise
                set(handles.WsEdit,'enable','on');
                set(handles.WpEdit,'enable','on');
                set(handles.RpEdit,'enable','on');
        end
    case 3
        handles.firName=3;
        switch handles.firType
            case 'low'
                set(handles.WsEdit,'enable','on');
                set(handles.RpEdit,'enable','on');
            case 'high'
                set(handles.WpEdit,'enable','on');
                set(handles.RpEdit,'enable','on');
            otherwise
                set(handles.WsEdit,'enable','on');
                set(handles.WpEdit,'enable','on');
                set(handles.RpEdit,'enable','on');
        end
    case 4
        handles.firName=4;
        switch handles.firType
          case 'low'
                set(handles.WsEdit,'enable','on');
                set(handles.RpEdit,'enable','on');
                set(handles.RsEdit,'enable','on');
            case 'high'
                set(handles.WpEdit,'enable','on');
                set(handles.RpEdit,'enable','on');
                set(handles.RsEdit,'enable','on');
            otherwise
                set(handles.WsEdit,'enable','on');
                set(handles.WpEdit,'enable','on');
                set(handles.RpEdit,'enable','on');
                set(handles.RsEdit,'enable','on');
        end
    otherwise
        warndlg('Unrecogized filter type');
end

% handles.firOrder=str2double(get(handles.OrderEdit,'String'));
% handles.firWp=str2double(get(handles.WpEdit,'String'));
% handles.firWs=str2double(get(handles.WsEdit,'String'));
% handles.firRp=str2double(get(handles.RpEdit,'String'));
% handles.firRs=str2double(get(handles.RsEdit,'String'));
% handles.Wn=str2double(get(handles.WnEdit,'String'));
% handles.SI=str2double(get(handles.SIEdit,'String'));

guidata(hObject,handles);
firdisp(hObject,handles);



% --- Executes during object creation, after setting all properties.
function filterType_CreateFcn(hObject, eventdata, handles)
% hObject    handle to filterType (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function OrderEdit_Callback(hObject, eventdata, handles)
% hObject    handle to OrderEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of OrderEdit as text
%        str2double(get(hObject,'String')) returns contents of OrderEdit as a double
firdisp(hObject,handles);

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



function WsEdit_Callback(hObject, eventdata, handles)
% hObject    handle to WsEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of WsEdit as text
%        str2double(get(hObject,'String')) returns contents of WsEdit as a double
firdisp(hObject,handles);

% --- Executes during object creation, after setting all properties.
function WsEdit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to WsEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function WpEdit_Callback(hObject, eventdata, handles)
% hObject    handle to WpEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of WpEdit as text
%        str2double(get(hObject,'String')) returns contents of WpEdit as a double
firdisp(hObject,handles);

% --- Executes during object creation, after setting all properties.
function WpEdit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to WpEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function RsEdit_Callback(hObject, eventdata, handles)
% hObject    handle to RsEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of RsEdit as text
%        str2double(get(hObject,'String')) returns contents of RsEdit as a double
firdisp(hObject,handles);

% --- Executes during object creation, after setting all properties.
function RsEdit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to RsEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function RpEdit_Callback(hObject, eventdata, handles)
% hObject    handle to RpEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of RpEdit as text
%        str2double(get(hObject,'String')) returns contents of RpEdit as a double
firdisp(hObject,handles);

% --- Executes during object creation, after setting all properties.
function RpEdit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to RpEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function SIEdit_Callback(hObject, eventdata, handles)
% hObject    handle to SIEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of SIEdit as text
%        str2double(get(hObject,'String')) returns contents of SIEdit as a double
firdisp(hObject,handles);

% --- Executes during object creation, after setting all properties.
function SIEdit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to SIEdit (see GCBO)
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
firdisp(hObject,handles);

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


% --- Executes on button press in plusBut.
function plusBut_Callback(hObject, eventdata, handles)
% hObject    handle to plusBut (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
step=str2double(get(handles.StepEdit,'String'));
curVal=str2double(get(handles.SIEdit,'String'));
nextVal=curVal+step;
if nextVal>handles.ntr
    warndlg('抽样道数不能大于总道数');
    set(handles.SIEdit,'String',num2str(handles.ntr));
    return;
end
set(handles.SIEdit,'String',num2str(nextVal));
guidata(hObject,handles);
firdisp(hObject,handles);
% --- Executes on button press in MinusBuT.
function MinusBut_Callback(hObject, eventdata, handles)
% hObject    handle to MinusBuT (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
step=str2double(get(handles.StepEdit,'String'));
curVal=str2double(get(handles.SIEdit,'String'));
nextVal=curVal-step;
if nextVal<0
    warndlg('Can not less than 0');
    set(handles.SIEdit,'String',num2str(1));
    return;
end
set(handles.SIEdit,'String',num2str(nextVal));
guidata(hObject,handles);
firdisp(hObject,handles);

function StepEdit_Callback(hObject, eventdata, handles)
% hObject    handle to StepEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of StepEdit as text
%        str2double(get(hObject,'String')) returns contents of StepEdit as a double


% --- Executes during object creation, after setting all properties.
function StepEdit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to StepEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in okBut.
function OkBut_Callback(hObject, eventdata, handles)
% hObject    handle to okBut (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.fircf.firName=get(handles.filterType,'value');
handles.fircf.firOrder=str2double(get(handles.OrderEdit,'String'));
handles.fircf.firWp=str2double(get(handles.WpEdit,'String'));
handles.fircf.firWs=str2double(get(handles.WsEdit,'String'));
handles.fircf.firRp=str2double(get(handles.RpEdit,'String'));
handles.fircf.firRs=str2double(get(handles.RsEdit,'String'));
guidata(hObject,handles);
uiresume(handles.figure1);


% --- Executes on button press in cancelBut.
function cancelBut_Callback(hObject, eventdata, handles)
% hObject    handle to cancelBut (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close(gcf);
