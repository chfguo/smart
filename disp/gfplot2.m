function varargout = gfplot2(varargin)

gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @gfplot2_OpeningFcn, ...
    'gui_OutputFcn',  @gfplot2_OutputFcn, ...
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


% --- Executes just before gfplot2 is made visible.
function gfplot2_OpeningFcn(hObject, eventdata, handles, varargin)
if nargin == 3
    disp('gfplot2(data)');
    handles.data = peaks(200);
else
    handles.data = gather(varargin{1});
end
handles.igain = 1;
handles.iszero = 0;
handles.figureCount = 1;
[handles.nz, handles.nx ] = size(handles.data);
SetData=setptr('crosshair');
set(gcf,SetData{:});
handles.tval=1;
handles.isMotion = 0;
handles.output = hObject;
gfplot2_draw(handles);
gfplot2_show1trace(handles,0);
guidata(hObject, handles);


% --- Outputs from this function are returned to the command line.
function varargout = gfplot2_OutputFcn(hObject, eventdata, handles)
varargout{1} = handles.output;

% --------------------------------------------------------------------
function Jet_ClickedCallback(hObject, eventdata, handles)
colormap(jet);
% --------------------------------------------------------------------
function Gray_ClickedCallback(hObject, eventdata, handles)
colormap(gray);
% --------------------------------------------------------------------
function Fresh_ClickedCallback(hObject, eventdata, handles)
colormap(gfcolormap2('e'));
% --------------------------------------------------------------------
function Blood_ClickedCallback(hObject, eventdata, handles)
colormap(gfcolormap2('g'));

% --------------------------------------------------------------------
function SaveMat_ClickedCallback(hObject, eventdata, handles)
ylimt=floor(get(handles.axes1,'ylim'));
xlimt=floor(get(handles.axes1,'xlim'));
ylimt(1) = ylimt(1)+1;
xlimt(1) = xlimt(1)+1;
if xlimt(1) > xlimt(2)
    xlimt(1) = xlimt(2);
end
if ylimt(1) > ylimt(2)
    ylimt(1) = ylimt(2);
end
%need modification
assignin('base',num2str(['tval_',num2str(handles.tval)]),...
    handles.data(ylimt(1):ylimt(2),xlimt(1):xlimt(2)));
handles.tval=handles.tval+1;
guidata(hObject,handles);



% --- Executes on scroll wheel click while the figure is in focus.
function figure1_WindowScrollWheelFcn(hObject, eventdata, handles)
set(handles.figure1,'currentaxes',handles.axes1);
if eventdata.VerticalScrollCount>0
    handles.igain=handles.igain-0.1;
elseif eventdata.VerticalScrollCount<0
    handles.igain=handles.igain+0.1;
end
guidata(hObject,handles);
gfplot2_redraw(handles);


% --------------------------------------------------------------------
function ResetGian_ClickedCallback(hObject, eventdata, handles)
handles.igain = 1;
gfplot2_redraw(handles);
guidata(hObject,handles);


% --------------------------------------------------------------------
function IsZero_OnCallback(hObject, eventdata, handles)
handles.iszero = 1;
guidata(hObject,handles);
gfplot2_redraw(handles);


% --------------------------------------------------------------------
function IsZero_OffCallback(hObject, eventdata, handles)
handles.iszero = 0;
guidata(hObject,handles);
gfplot2_redraw(handles);


% --- Executes on mouse press over figure background, over a disabled or
% --- inactive control, or over an axes background.
function figure1_WindowButtonDownFcn(hObject, eventdata, handles)
gfplot2_show1trace(handles);



% --- Executes on mouse motion over figure - except title and menu.
function figure1_WindowButtonMotionFcn(hObject, eventdata, handles)
if handles.isMotion == 0
    return;
end
gfplot2_show1trace(handles);



% --------------------------------------------------------------------
function isMotion_OffCallback(hObject, eventdata, handles)
handles.isMotion = 0;
guidata(hObject,handles);

% --------------------------------------------------------------------
function isMotion_OnCallback(hObject, eventdata, handles)
handles.isMotion = 1;
guidata(hObject,handles);

% --------------------------------------------------------------------
function ZoomH_OffCallback(hObject, eventdata, handles)
handles.hzoom = zoom;
setAxesZoomMotion(handles.hzoom,handles.axes1,'both');

% --------------------------------------------------------------------
function ZoomH_OnCallback(hObject, eventdata, handles)
handles.hzoom = zoom;
setAxesZoomMotion(handles.hzoom,handles.axes1,'horizontal');

% --------------------------------------------------------------------
function ZoomV_OnCallback(hObject, eventdata, handles)
handles.hzoom = zoom;
setAxesZoomMotion(handles.hzoom,handles.axes1,'vertical');

% --------------------------------------------------------------------
function ZoomV_OffCallback(hObject, eventdata, handles)
handles.hzoom = zoom;
setAxesZoomMotion(handles.hzoom,handles.axes1,'both');

% --------------------------------------------------------------------
function SaveFigure_ClickedCallback(hObject, eventdata, handles)
[filename, pathname] = uiputfile('*.fig', 'Pick an Figure file');
if isequal(filename,0) || isequal(pathname,0)
else
    savefig(fullfile(pathname, filename));
end

% --------------------------------------------------------------------
function SavePicture_ClickedCallback(hObject, eventdata, handles)
[filename, pathname] = uiputfile('*.jpg', 'Pick an JPEG file');
if isequal(filename,0) || isequal(pathname,0)
else
    saveas(gcf,fullfile(pathname, filename),'jpg');
end

% --------------------------------------------------------------------
function Smooth_ClickedCallback(hObject, eventdata, handles)
set(handles.figure1,'currentaxes',handles.axes1);
handles.data = gfsmooth(handles.data);
guidata(hObject,handles);
gfplot2_redraw(handles);

% --------------------------------------------------------------------
function Medfilt_ClickedCallback(hObject, eventdata, handles)
set(handles.figure1,'currentaxes',handles.axes1);
handles.data = medfilt2(handles.data);
guidata(hObject,handles);
gfplot2_redraw(handles);


% --------------------------------------------------------------------
function reDraw_ClickedCallback(hObject, eventdata, handles)
gfplot2_redraw(handles);


% --------------------------------------------------------------------
function process_Callback(hObject, eventdata, handles)
% hObject    handle to process (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function rbk_Callback(hObject, eventdata, handles)

meanTrace1 = handles.data(:,1);
[~,ntr] = size(handles.data);
RBKMoveCoef = 0.9;
for im = 1:ntr
    meanTrace1 = meanTrace1*RBKMoveCoef + handles.data(:,im)*(1-RBKMoveCoef);
    handles.data(:,im) = handles.data(:,im) - meanTrace1;
end
guidata(hObject,handles);
gfplot2_redraw(handles);


% --------------------------------------------------------------------
function topDec_Callback(hObject, eventdata, handles)
[ns,ntr] = size(handles.data);
ff = gfupline(ns,2,0.15);

for im = 1:ntr

    handles.data(:,im) = handles.data(:,im) .* ff;
end
guidata(hObject,handles);
gfplot2_redraw(handles);


% --------------------------------------------------------------------
function agc_Callback(hObject, eventdata, handles)
segNum = 8;
%  y1=data;
[ns,~] = size(handles.data);
Num=floor(ns/segNum);                                          
MaxGainCoeff = 60;

% 2017-08-29   增益参考？
datain1=handles.data(:,6)-mean(handles.data(:,1:6),2);
%DSP所发增益权值
BM1=[4200,4000,3800,3000,2800,2400,2800,3600,4200,5000];
Amp1 = zeros(1,segNum+1);                                              %%%%%此值在计算每个通道时需要置零
for i=5:Num    %5:Num， 不考虑前4个数据？
    Amp1(1)=Amp1(1)+abs(datain1(i));
end
Amp1(1)=Amp1(1)/(Num-4);

for i=2:8
    Amp1(i)=0;
    for ii=floor((i-1.5)*Num):i*Num
        Amp1(i)=Amp1(i)+abs(datain1(ii));
    end
    Amp1(i)=Amp1(i)/floor((1.5*Num));
end

for ii=7*Num:ns                      %%%%%%注意这个m值，直接写成512
    Amp1(9)=Amp1(9)+abs(datain1(ii));
end
Amp1(9)=Amp1(9)/Num;

Gain1 = zeros(1,segNum+1);
for i=1:9
    if(Amp1(i)>BM1(i))
        BM1(i) = Amp1(i);
    end
    just_data1=20*log10(BM1(i)/(Amp1(i)+0.000001));
    if (just_data1 > MaxGainCoeff)
        just_data1 = MaxGainCoeff;            %%%放大倍数不限制   60
    end
    %     if (just_data1(i)>80)
    %          just_data1(i)=80;            %%%放大倍数不限制   60
    %      end
    Gain1(i)=10^((just_data1)*0.05);
end
Multi_Gain1 = zeros(ns,1);
for i=1:8
    single_gain11=Gain1(i);
    single_gain12=Gain1(i+1);
    for k=1:Num
        coeff=(single_gain12-single_gain11)*(k-1)/Num+single_gain11;
        if(coeff<4096)%8192)%4096)
            Multi_Gain1((i-1)*Num+k)=coeff;
        else
            Multi_Gain1((i-1)*Num+k)=4095;
            %                Multi_Gain1((i-1)*Num+k)=8191;
        end
    end
end

for i=1:ns
    handles.data(i,:)=handles.data(i,:)*Multi_Gain1(i);  
end
guidata(hObject,handles);
gfplot2_redraw(handles);
