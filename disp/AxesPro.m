function varargout = AxesPro(varargin)
% AXESPRO MATLAB code for AxesPro.fig
%      AXESPRO, by itself, creates a new AXESPRO or raises the existing
%      singleton*.
%
%      H = AXESPRO returns the handle to a new AXESPRO or the handle to
%      the existing singleton*.
%
%      AXESPRO('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in AXESPRO.M with the given input arguments.
%
%      AXESPRO('Property','Value',...) creates a new AXESPRO or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before AxesPro_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to AxesPro_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help AxesPro

% Last Modified by GUIDE v2.5 09-Nov-2016 08:46:04

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @AxesPro_OpeningFcn, ...
                   'gui_OutputFcn',  @AxesPro_OutputFcn, ...
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


% --- Executes just before AxesPro is made visible.
function AxesPro_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to AxesPro (see VARARGIN)

% Choose default command line output for AxesPro

handles.output = hObject;
handles.axesPro = varargin{1};
% handles.axesPro = [];
% axesPro.FontNamePopupmenu=2;
% axesPro.WeightPopupmenu=3;
% axesPro.AnglePopupmenu=2;
% axesPro.xLabelEdit='Distance(Km)';
% axesPro.yLabelEdit='Depth(Km)';
% axesPro.xySizePopupmenu=12;
% 
% axesPro.xStartEdit='0.0';
% axesPro.yStartEdit='0.0';
% axesPro.xStepEdit='0.01';
% axesPro.yStepEdit='0.01';
% axesPro.mainSizePopupmenu=10;
% 
% axesPro.barLabelEdit='Amplitude';
% axesPro.barSizePopupmenu=8;
% 
% axesPro.titleSizePopupmenu=12;
% axesPro.titleEdit=[];

% handles.axesPro=axesPro;
set(handles.FontNamePopupmenu,'Value',handles.axesPro.FontNamePopupmenu);
% 1: Times
% 2: Arial
% 3: Helvetica
set(handles.WeightPopupmenu,'Value',handles.axesPro.WeightPopupmenu);
% 1: Normal
% 2: Demi
% 3: Bold
set(handles.AnglePopupmenu,'Value',handles.axesPro.AnglePopupmenu);
% 1: Normal
% 2: Oblique
handles.axesPro.isAlways=0;
set(handles.fillupPopupmenu,'Value',handles.axesPro.fillupPopupmenu);
set(handles.xLabelEdit,'String',handles.axesPro.xLabelEdit);
set(handles.yLabelEdit,'String',handles.axesPro.yLabelEdit);
set(handles.xySizePopupmenu,'Value',handles.axesPro.xySizePopupmenu-5+1);

set(handles.xStartEdit,'String',num2str(handles.axesPro.xStartEdit));
set(handles.yStartEdit,'String',num2str(handles.axesPro.yStartEdit));
set(handles.xStepEdit,'String',num2str(handles.axesPro.xStepEdit));
set(handles.yStepEdit,'String',num2str(handles.axesPro.yStepEdit));
set(handles.LineWidthEdit,'String',num2str(handles.axesPro.LineWidthEdit));
set(handles.mainSizePopupmenu,'Value',handles.axesPro.mainSizePopupmenu-5+1);

set(handles.barLabelEdit,'String',handles.axesPro.barLabelEdit);
set(handles.barSizePopupmenu,'Value',handles.axesPro.barSizePopupmenu-5+1);

set(handles.titleEdit,'String',handles.axesPro.titleEdit);
set(handles.titleSizePopupmenu,'Value',handles.axesPro.titleSizePopupmenu-5+1);

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes AxesPro wait for user response (see UIRESUME)
uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = AxesPro_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
if ~isempty(handles)
    varargout{1} = handles.output;
    varargout{2} = handles.axesPro;
    varargout{3} = 1;
else
    varargout{1} = NaN;
    varargout{2} = NaN;
    varargout{3} = NaN;
end

function yLabelEdit_Callback(hObject, eventdata, handles)
% hObject    handle to yLabelEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of yLabelEdit as text
%        str2double(get(hObject,'String')) returns contents of yLabelEdit as a double


% --- Executes during object creation, after setting all properties.
function yLabelEdit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to yLabelEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function xLabelEdit_Callback(hObject, eventdata, handles)
% hObject    handle to xLabelEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of xLabelEdit as text
%        str2double(get(hObject,'String')) returns contents of xLabelEdit as a double


% --- Executes during object creation, after setting all properties.
function xLabelEdit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to xLabelEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function FontSizeEdit_Callback(hObject, eventdata, handles)
% hObject    handle to FontSizeEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of FontSizeEdit as text
%        str2double(get(hObject,'String')) returns contents of FontSizeEdit as a double


% --- Executes during object creation, after setting all properties.
function FontSizeEdit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to FontSizeEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in xySizePopupmenu.
function xySizePopupmenu_Callback(hObject, eventdata, handles)
% hObject    handle to xySizePopupmenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns xySizePopupmenu contents as cell array
%        contents{get(hObject,'Value')} returns selected item from xySizePopupmenu


% --- Executes during object creation, after setting all properties.
function xySizePopupmenu_CreateFcn(hObject, eventdata, handles)
% hObject    handle to xySizePopupmenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in FontNamePopupmenu.
function FontNamePopupmenu_Callback(hObject, eventdata, handles)
% hObject    handle to FontNamePopupmenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns FontNamePopupmenu contents as cell array
%        contents{get(hObject,'Value')} returns selected item from FontNamePopupmenu


% --- Executes during object creation, after setting all properties.
function FontNamePopupmenu_CreateFcn(hObject, eventdata, handles)
% hObject    handle to FontNamePopupmenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function barLabelEdit_Callback(hObject, eventdata, handles)
% hObject    handle to barLabelEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of barLabelEdit as text
%        str2double(get(hObject,'String')) returns contents of barLabelEdit as a double


% --- Executes during object creation, after setting all properties.
function barLabelEdit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to barLabelEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in barSizePopupmenu.
function barSizePopupmenu_Callback(hObject, eventdata, handles)
% hObject    handle to barSizePopupmenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns barSizePopupmenu contents as cell array
%        contents{get(hObject,'Value')} returns selected item from barSizePopupmenu


% --- Executes during object creation, after setting all properties.
function barSizePopupmenu_CreateFcn(hObject, eventdata, handles)
% hObject    handle to barSizePopupmenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in barNamePopupmenu.
function barNamePopupmenu_Callback(hObject, eventdata, handles)
% hObject    handle to barNamePopupmenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns barNamePopupmenu contents as cell array
%        contents{get(hObject,'Value')} returns selected item from barNamePopupmenu


% --- Executes during object creation, after setting all properties.
function barNamePopupmenu_CreateFcn(hObject, eventdata, handles)
% hObject    handle to barNamePopupmenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function yStartEdit_Callback(hObject, eventdata, handles)
% hObject    handle to yStartEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of yStartEdit as text
%        str2double(get(hObject,'String')) returns contents of yStartEdit as a double


% --- Executes during object creation, after setting all properties.
function yStartEdit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to yStartEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function xStartEdit_Callback(hObject, eventdata, handles)
% hObject    handle to xStartEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of xStartEdit as text
%        str2double(get(hObject,'String')) returns contents of xStartEdit as a double


% --- Executes during object creation, after setting all properties.
function xStartEdit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to xStartEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function yStepEdit_Callback(hObject, eventdata, handles)
% hObject    handle to yStepEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of yStepEdit as text
%        str2double(get(hObject,'String')) returns contents of yStepEdit as a double


% --- Executes during object creation, after setting all properties.
function yStepEdit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to yStepEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function xStepEdit_Callback(hObject, eventdata, handles)
% hObject    handle to xStepEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of xStepEdit as text
%        str2double(get(hObject,'String')) returns contents of xStepEdit as a double


% --- Executes during object creation, after setting all properties.
function xStepEdit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to xStepEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit14_Callback(hObject, eventdata, handles)
% hObject    handle to edit14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit14 as text
%        str2double(get(hObject,'String')) returns contents of edit14 as a double


% --- Executes during object creation, after setting all properties.
function edit14_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit15_Callback(hObject, eventdata, handles)
% hObject    handle to edit15 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit15 as text
%        str2double(get(hObject,'String')) returns contents of edit15 as a double


% --- Executes during object creation, after setting all properties.
function edit15_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit15 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu7.
function popupmenu7_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu7 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu7


% --- Executes during object creation, after setting all properties.
function popupmenu7_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu8.
function popupmenu8_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu8 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu8


% --- Executes during object creation, after setting all properties.
function popupmenu8_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in titleNamePopupmenu.
function titleNamePopupmenu_Callback(hObject, eventdata, handles)
% hObject    handle to titleNamePopupmenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns titleNamePopupmenu contents as cell array
%        contents{get(hObject,'Value')} returns selected item from titleNamePopupmenu


% --- Executes during object creation, after setting all properties.
function titleNamePopupmenu_CreateFcn(hObject, eventdata, handles)
% hObject    handle to titleNamePopupmenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in titleSizePopupmenu.
function titleSizePopupmenu_Callback(hObject, eventdata, handles)
% hObject    handle to titleSizePopupmenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns titleSizePopupmenu contents as cell array
%        contents{get(hObject,'Value')} returns selected item from titleSizePopupmenu


% --- Executes during object creation, after setting all properties.
function titleSizePopupmenu_CreateFcn(hObject, eventdata, handles)
% hObject    handle to titleSizePopupmenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function titleEdit_Callback(hObject, eventdata, handles)
% hObject    handle to titleEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of titleEdit as text
%        str2double(get(hObject,'String')) returns contents of titleEdit as a double


% --- Executes during object creation, after setting all properties.
function titleEdit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to titleEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
 


% --- Executes on selection change in mainSizePopupmenu.
function mainSizePopupmenu_Callback(hObject, eventdata, handles)
% hObject    handle to mainSizePopupmenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns mainSizePopupmenu contents as cell array
%        contents{get(hObject,'Value')} returns selected item from mainSizePopupmenu


% --- Executes during object creation, after setting all properties.
function mainSizePopupmenu_CreateFcn(hObject, eventdata, handles)
% hObject    handle to mainSizePopupmenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in WeightPopupmenu.
function WeightPopupmenu_Callback(hObject, eventdata, handles)
% hObject    handle to WeightPopupmenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns WeightPopupmenu contents as cell array
%        contents{get(hObject,'Value')} returns selected item from WeightPopupmenu


% --- Executes during object creation, after setting all properties.
function WeightPopupmenu_CreateFcn(hObject, eventdata, handles)
% hObject    handle to WeightPopupmenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in AnglePopupmenu.
function AnglePopupmenu_Callback(hObject, eventdata, handles)
% hObject    handle to AnglePopupmenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns AnglePopupmenu contents as cell array
%        contents{get(hObject,'Value')} returns selected item from AnglePopupmenu


% --- Executes during object creation, after setting all properties.
function AnglePopupmenu_CreateFcn(hObject, eventdata, handles)
% hObject    handle to AnglePopupmenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in OKBuT.
function OKBuT_Callback(hObject, eventdata, handles)
% hObject    handle to OKBuT (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.axesPro.FontNamePopupmenu=get(handles.FontNamePopupmenu,'Value');
% 1: Times % 2: Arial % 3: Helvetica
handles.axesPro.WeightPopupmenu=get(handles.WeightPopupmenu,'Value');
% 1: Normal % 2: Demi % 3: Bold
handles.axesPro.AnglePopupmenu=get(handles.AnglePopupmenu,'Value');
% 1: Normal % 2: Oblique
handles.axesPro.fillupPopupmenu=get(handles.fillupPopupmenu,'Value');
handles.axesPro.xLabelEdit=get(handles.xLabelEdit,'String');
handles.axesPro.yLabelEdit=get(handles.yLabelEdit,'String');
handles.axesPro.xySizePopupmenu=get(handles.xySizePopupmenu,'Value')+5-1;

handles.axesPro.xStartEdit=str2double(get(handles.xStartEdit,'String'));
handles.axesPro.yStartEdit=str2double(get(handles.yStartEdit,'String'));
handles.axesPro.xStepEdit=str2double(get(handles.xStepEdit,'String'));
handles.axesPro.yStepEdit=str2double(get(handles.yStepEdit,'String'));
handles.axesPro.LineWidthEdit=str2double(get(handles.LineWidthEdit,'String'));
handles.axesPro.mainSizePopupmenu=get(handles.mainSizePopupmenu,'Value')+5-1;

handles.axesPro.barLabelEdit=get(handles.barLabelEdit,'String');
handles.axesPro.barSizePopupmenu=get(handles.barSizePopupmenu,'Value')+5-1;

handles.axesPro.titleEdit=get(handles.titleEdit,'String');
handles.axesPro.titleSizePopupmenu=get(handles.titleSizePopupmenu,'Value')+5-1;

guidata(hObject,handles);
uiresume(handles.figure1);

% --- Executes on button press in CancelBuT.
function CancelBuT_Callback(hObject, eventdata, handles)
% hObject    handle to CancelBuT (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close(gcf);



function LineWidthEdit_Callback(hObject, eventdata, handles)
% hObject    handle to LineWidthEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of LineWidthEdit as text
%        str2double(get(hObject,'String')) returns contents of LineWidthEdit as a double


% --- Executes during object creation, after setting all properties.
function LineWidthEdit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to LineWidthEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in fillupPopupmenu.
function fillupPopupmenu_Callback(hObject, eventdata, handles)
% hObject    handle to fillupPopupmenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns fillupPopupmenu contents as cell array
%        contents{get(hObject,'Value')} returns selected item from fillupPopupmenu


% --- Executes during object creation, after setting all properties.
function fillupPopupmenu_CreateFcn(hObject, eventdata, handles)
% hObject    handle to fillupPopupmenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in AlwaysBuT.
function AlwaysBuT_Callback(hObject, eventdata, handles)
% hObject    handle to AlwaysBuT (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.axesPro.isAlways=1;
guidata(hObject,handles);
OKBuT_Callback(hObject, eventdata, handles)
