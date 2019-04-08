function varargout = plt(varargin)
% PLT MATLAB code for plt.fig
%      PLT, by itself, creates a new PLT or raises the existing
%      singleton*.
%
%      H = PLT returns the handle to a new PLT or the handle to
%      the existing singleton*.
%
%      PLT('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in PLT.M with the given input arguments.
%
%      PLT('Property','Value',...) creates a new PLT or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before plt_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to plt_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help plt

% Last Modified by GUIDE v2.5 08-Sep-2017 11:44:42

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @plt_OpeningFcn, ...
    'gui_OutputFcn',  @plt_OutputFcn, ...
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


% --- Executes just before plt is made visible.
function plt_OpeningFcn(hObject, eventdata, handles, varargin)
clc
handles.output = hObject;
colormap(gray)
set(gca,'XAxisLocation','top');
set(gca,'TickDirMode','manual','TickDir','out');
% Update handles structure
handles.sliderVal=0;
handles.sliderValZ=0;
set(handles.slider1Z,'Value',1-handles.sliderValZ);
handles.status=0;
handles.displayigain=1;
guidata(hObject, handles);

if ischar(varargin{1})
    handles.data=readgpr(varargin{1});
else
    handles.data=varargin{1};
end

[nz,nx]=size(handles.data);

handles.nx=nx;
handles.nz=nz;
handles.Nmax=1000;

if nx<handles.Nmax
    set(handles.slider1,'Visible','off');
    handles.Nmax=handles.nx;
end

handles.range=handles.nx-handles.Nmax;

handles.start=1+floor(handles.sliderVal*handles.range);
handles.end=handles.Nmax+floor(handles.sliderVal*handles.range);


handles.NmaxZ=1000;

if nx<handles.NmaxZ
    set(handles.slider1Z,'Visible','off');
    handles.NmaxZ=handles.nz;
end

handles.rangeZ=handles.nz-handles.NmaxZ;

handles.startZ=1+floor(handles.sliderValZ*handles.rangeZ);
handles.endZ=handles.NmaxZ+floor(handles.sliderValZ*handles.rangeZ);

guidata(hObject, handles);
gfplt(handles);
box off


% --- Outputs from this function are returned to the command line.
function varargout = plt_OutputFcn(hObject, eventdata, handles)
varargout{1} = handles.output;

% --- Executes on slider movement.
function slider1_Callback(hObject, eventdata, handles)

handles.sliderVal=get(hObject,'Value');
handles.start=1+floor(handles.sliderVal*handles.range);
handles.end=handles.Nmax+floor(handles.sliderVal*handles.range);
guidata(hObject, handles);
gfplt(handles);

% --- Executes during object creation, after setting all properties.
function slider1_CreateFcn(hObject, eventdata, handles)
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

% --------------------------------------------------------------------
function uipushtool1_ClickedCallback(hObject, eventdata, handles)
% hObject    handle to uipushtool1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

ylimt=get(gca,'ylim');
xlimt=get(gca,'xlim');
handles.xlimt=[ceil(xlimt(1)),floor(xlimt(2))];
handles.ylimt=[ceil(ylimt(1)),floor(ylimt(2))];
xx=handles.xlimt(1):1:handles.xlimt(2);
zz=handles.ylimt(1):1:handles.ylimt(2);

dat=handles.data(zz,xx);
[filename,pathname] = uiputfile({'*.dat'},'Save as');

if filename~=0
    saveMat(dat,[pathname,'\',filename],2);
end
guidata(hObject, handles);
gfplt(handles);
clear dat


% --------------------------------------------------------------------
function dispGain_ClickedCallback(hObject, eventdata, handles)
% hObject    handle to dispGain (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

[handles.displayigain,flag]=gfinput('增益显示',{'增益系数'},{num2str(handles.displayigain)});

if flag
    guidata(hObject, handles);
    gfplt(handles);
end



% --------------------------------------------------------------------
function ZoomLong_ClickedCallback(hObject, eventdata, handles)
% hObject    handle to ZoomLong (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.Nmax=handles.Nmax+100;
set(handles.slider1,'Visible','on');
if handles.nx<handles.Nmax
    set(handles.slider1,'Visible','off');
    handles.Nmax=handles.nx;
end

handles.range=handles.nx-handles.Nmax;
handles.start=1+floor(handles.sliderVal*handles.range);
handles.end=handles.Nmax+floor(handles.sliderVal*handles.range);
guidata(hObject, handles);
gfplt(handles);

% --------------------------------------------------------------------
function ZoomShort_ClickedCallback(hObject, eventdata, handles)
% hObject    handle to ZoomShort (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.Nmax=handles.Nmax-100;
set(handles.slider1,'Visible','on');
if handles.Nmax<100
    handles.Nmax=100;
end

handles.range=handles.nx-handles.Nmax;
handles.start=1+floor(handles.sliderVal*handles.range);
handles.end=handles.Nmax+floor(handles.sliderVal*handles.range);
guidata(hObject, handles);
gfplt(handles);


% --------------------------------------------------------------------
function normal_ClickedCallback(hObject, eventdata, handles)
% hObject    handle to normal (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if handles.status>0
    for in=1:handles.nx
        ss=mean(handles.data(:,in));
        handles.data(:,in)=handles.data(:,in)-ss;
    end
    guidata(hObject, handles);
    gfplt(handles);
end


% --- Executes on slider movement.
function slider1Z_Callback(hObject, eventdata, handles)
handles.sliderValZ=1-get(hObject,'Value');
handles.startZ=1+floor(handles.sliderValZ*handles.rangeZ);
handles.endZ=handles.NmaxZ+floor(handles.sliderValZ*handles.rangeZ);
guidata(hObject, handles);
gfplt(handles);


% --- Executes during object creation, after setting all properties.
function slider1Z_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider1Z (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --------------------------------------------------------------------
function ZoomLongZ_ClickedCallback(hObject, eventdata, handles)
% hObject    handle to ZoomLongZ (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.NmaxZ=handles.NmaxZ+100;
set(handles.slider1Z,'Visible','on');
if handles.nz<handles.NmaxZ
    set(handles.slider1Z,'Visible','off');
    handles.NmaxZ=handles.nz;
end

handles.rangeZ=handles.nz-handles.NmaxZ;
handles.startZ=1+floor(handles.sliderValZ*handles.rangeZ);
handles.endZ=handles.NmaxZ+floor(handles.sliderValZ*handles.rangeZ);
guidata(hObject, handles);
gfplt(handles);


% --------------------------------------------------------------------
function ZoomShortZ_ClickedCallback(hObject, eventdata, handles)
% hObject    handle to ZoomShortZ (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.NmaxZ=handles.NmaxZ-100;
set(handles.slider1Z,'Visible','on');
if handles.NmaxZ<100
    handles.NmaxZ=100;
end

handles.rangeZ=handles.nz-handles.NmaxZ;
handles.startZ=1+floor(handles.sliderValZ*handles.rangeZ);
handles.endZ=handles.NmaxZ+floor(handles.sliderValZ*handles.rangeZ);
guidata(hObject, handles);
gfplt(handles);


% --- Executes on scroll wheel click while the figure is in focus.
function figure1_WindowScrollWheelFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  structure with the following fields (see FIGURE)
%	VerticalScrollCount: signed integer indicating direction and number of clicks
%	VerticalScrollAmount: number of lines scrolled for each click
% handles    structure with handles and user data (see GUIDATA)

gpos=get(handles.axes1,'Position');
cpos=get(gcf,'CurrentPoint');

if cpos(1)>gpos(1) && cpos(1)<gpos(1)+gpos(3) && ...
        cpos(2)>gpos(2) && cpos(2) <gpos(2)+gpos(4)
    
    if eventdata.VerticalScrollCount>0
        handles.displayigain=handles.displayigain-0.1;
    elseif eventdata.VerticalScrollCount<0
        handles.displayigain=handles.displayigain+0.1;
    end
    guidata(hObject,handles);
    gfplt(handles);
end

if cpos(1)>gpos(1) && cpos(1)<gpos(1)+gpos(3) && cpos(2)<gpos(2) 
    handles.sliderVal=get(handles.slider1,'Value');
    
    if eventdata.VerticalScrollCount>0
        handles.sliderVal=handles.sliderVal-0.1;
    elseif eventdata.VerticalScrollCount<0
        handles.sliderVal=handles.sliderVal+0.1;
    end
    
    
    if handles.sliderVal>1 
        handles.sliderVal=1;
    end
    if handles.sliderVal<0 
        handles.sliderVal=0;
    end
    set(handles.slider1,'Value',handles.sliderVal);
    guidata(hObject, handles); 
    slider1_Callback(handles.slider1, eventdata, handles);
end

  if cpos(1)>gpos(1)+gpos(3) && cpos(2)>gpos(2) && cpos(2) <gpos(2)+gpos(4)
  
  handles.sliderValZ=get(handles.slider1Z,'Value');
    
    if eventdata.VerticalScrollCount>0
        handles.sliderValZ=handles.sliderValZ-0.1;
    elseif eventdata.VerticalScrollCount<0
        handles.sliderValZ=handles.sliderValZ+0.1;
    end
    
    
    if handles.sliderValZ>1 
        handles.sliderValZ=1;
    end
    if handles.sliderValZ<0 
        handles.sliderValZ=0;
    end
    set(handles.slider1Z,'Value',handles.sliderValZ);
    guidata(hObject, handles); 
    slider1Z_Callback(handles.slider1Z, eventdata, handles);
  
  end


% --------------------------------------------------------------------
function Jet_ClickedCallback(hObject, eventdata, handles)
colormap(jet);

% --------------------------------------------------------------------
function Gray_ClickedCallback(hObject, eventdata, handles)
colormap(gray);


% --------------------------------------------------------------------
function Fresh_ClickedCallback(hObject, eventdata, handles)
icolormap=gfcolormap2('e');
colormap(icolormap);


% --------------------------------------------------------------------
function Blood_ClickedCallback(hObject, eventdata, handles)
icolormap=gfcolormap2('g');
colormap(icolormap);
