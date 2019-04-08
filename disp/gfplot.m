function varargout = gfplot(varargin)
% GFPLOT 2D display function
%   gfplot('filename');  open a file and display 2D data
%   gfplot(data);        display data
%   gfplot(line);        display 1D line
%   gfplot(x,line);
%   gfplot(x,line,xlabel,ylabel)
%
%   Version: V1.0
%   Author : C.F.Guo
%   Time   : 2017/1/11
%
% ------------------------------NOTE---------------------------------------
%
% This is a subroutine of Seismic Modeling and Research Toolkit (SMART),
% It is illegal for you to use this software tool (Seismic Modeling and
% Research Toolkit,SMART) for a purpose other than non-profit education
% or research UNLESS you are authorized by the Seismic Modeling Project.If
% you find any problems, please connect the Author(s): chf_guo@163.com
%
% by C.F. Guo, 2016

gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @gfplot_OpeningFcn, ...
    'gui_OutputFcn',  @gfplot_OutputFcn, ...
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


% --- Executes just before gfplot is made visible.
function gfplot_OpeningFcn(hObject,eventdata,handles,varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure


% varargin   command line arguments to gfplot (see VARARGIN)

% Choose default command line output for gfplot
clc
handles.output = hObject;
handles.dirpar=which('par.mat');
if isempty(handles)
    disp('Can not find parameters file');
    disp('Suggest using repar.m to create the parameters file');
end
handles.ns=0;
handles.ntr=0;
handles.icolor= 'g';
handles.isfillup='y';
handles.iszero= 1;
handles.isreverse=0;
handles.iscolorbar=0;
handles.igain=0.5;
handles.isok=0;
handles.st=0;
handles.autoGianNum=16;
handles.fcn=[];
handles.tval=1;
% axesPro.FontNamePopupmenu=1;
% axesPro.WeightPopupmenu=3;
% axesPro.AnglePopupmenu=2;
% axesPro.xLabelEdit='Distance(Km)';
% axesPro.yLabelEdit='Depth(Km)';
% axesPro.xySizePopupmenu=14;
% axesPro.fillupPopupmenu=2;
% axesPro.xStartEdit=0.0;
% axesPro.yStartEdit=0.0;
% axesPro.xStepEdit=0.01;
% axesPro.yStepEdit=0.01;
% axesPro.LineWidthEdit=1.5;
% axesPro.mainSizePopupmenu=14;
%
% axesPro.barLabelEdit='Amplitude';
% axesPro.barSizePopupmenu=12;
%
% axesPro.titleSizePopupmenu=12;
% axesPro.titleEdit=[];
% handles.axesPro=axesPro;

handles.filename='Untitled';

if exist(handles.dirpar,'file')
    load(handles.dirpar);
    handles.icolor=icolor;
    handles.iszero=iszero;
    handles.iscolorbar=iscolorbar;
    handles.isreverse=isreverse;
    handles.igain=igain;
    handles.isAutoSize=isautosize;
    handles.axesPro=axesPro;
    if ~isempty(fcnName)
        handles.fcn=fcnName;
        set(handles.myFcn,'TooltipString',handles.fcn);
    end
end
switch handles.icolor
    case 'i'
        set(handles.colormap_gray,'Check','on');
    case 'g'
        set(handles.colormap_rwb,'Check','on');
    case 'e'
        set(handles.colormap_rwl,'Check','on');
    case 'j'
        set(handles.colormap_jet,'Check','on');
    case 'p'
        set(handles.colormap_paru,'Check','on');
    case 'f'
        set(handles.colormap_flag,'Check','on');
end
if isreverse==1
    set(handles.mIsReverse,'Check','on');
end
if iszero==1
    set(handles.mIsZero,'Check','on');
end

if iscolorbar==1
    set(handles.mIsColorbar,'Check','on');
end

if handles.isAutoSize==1
    set(handles.sAutoSize,'Check','on');
end

handles.line=[];
if nargin>4
    handles.line=varargin{2};
end
if nargin>3
    if ischar(varargin{1})
        handles.filename=varargin{1};
        handles.data=gfreadfile(handles.filename);
        handles.isok=1;
    else
        set(handles.mReloadFile,'Enable','off');
        handles.data=gather(varargin{1});
    end
    
    handles.ns=size(handles.data,1);
    handles.ntr=size(handles.data,2);
    handles.isok=1;
    if handles.ns==1 || handles.ntr==1
        numpar=numel(varargin);
        switch numpar
            case 1
                gfplot1d(varargin{1});
                set(handles.axes1,'Position',[0.15,0.15,0.8,0.83]);
                handles.isok=0;
            case 2
                gfplot1d(varargin{1},varargin{2});
                set(handles.axes1,'Position',[0.15,0.12,0.83,0.83]);
                handles.isok=0;
            case 3
                gfplot1d(varargin{1},varargin{2},varargin{3});
                set(handles.axes1,'Position',[0.15,0.12,0.83,0.83]);
                handles.isok=0;
            case 4
                gfplot1d(varargin{1},varargin{2},varargin{3},varargin{4});
                set(handles.axes1,'Position',[0.15,0.12,0.83,0.83]);
                handles.isok=0;
        end
        
    end
    if handles.isok
        guidata(hObject,handles);
        
        if handles.isAutoSize==0
            set(handles.axes1,'Position',[0.11,0.045,0.8,0.8]);
        else
            if handles.ntr/handles.ns>2
                set(gcf,'Position',[0.5-0.65/2,0.5-0.65/2,0.65,0.65]);
            elseif handles.ntr/handles.ns>1 && handles.ntr/handles.ns<2
                set(gcf,'Position',[0.25,0.5-0.65/2,0.5,0.65]);
                set(handles.axes1,'Position',[0.10,0.045,0.85,0.80]);
            elseif handles.ntr/handles.ns<1 && handles.ntr/handles.ns>0.5
                set(gcf,'Position',[0.3,0.5-0.65/2,0.4,0.65]);
                set(handles.axes1,'Position',[0.11,0.045,0.84,0.80]);
            else
                set(gcf,'Position',[0.35,0.5-0.65/2,0.3,0.65]);
                set(handles.axes1,'Position',[0.15,0.045,0.80,0.80]);
            end
        end
        
    end
end

if handles.isok
    [B,A]=butter(2,0.2,'high');
    H=freqz(B,A,handles.ns);
    H=abs(H);
    handles.timeVaryGainCurve=H;
    if sum(sum(isnan(handles.data)))
        close(gcf);
        gdis(handles.data);
        warndlg('Some or all elements of data are NaN');
        return;
    end
    gfplotseis(handles);
end

guidata(hObject,handles);



% UIWAIT makes gfplot wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = gfplot_OutputFcn(hObject, eventdata, handles)

% --------------------------------------------------------------------
function mFile_Callback(hObject, eventdata, handles)

% --------------------------------------------------------------------
function mOpenFile_Callback(hObject, eventdata, handles)
 [name,path] = uigetfile('*.dat;*.dzt; *.lte;*.su;*.segy;*.rad;*.rd3;*.rd7','�������ļ�');
if name==0
    return;
end
handles.filename=strcat(path,name);
handles.data=gfreadfile(handles.filename);
handles.isok=1;
[handles.ns,handles.ntr]=size(handles.data);
if handles.isAutoSize==0
    set(handles.axes1,'Position',[0.11,0.045,0.8,0.8]);
else
    if handles.ntr/handles.ns>2
        set(gcf,'Position',[0.5-0.65/2,0.5-0.65/2,0.65,0.65]);
    elseif handles.ntr/handles.ns>1 && handles.ntr/handles.ns<2
        set(gcf,'Position',[0.25,0.5-0.65/2,0.5,0.65]);
        set(handles.axes1,'Position',[0.10,0.045,0.85,0.80]);
    elseif handles.ntr/handles.ns<1 && handles.ntr/handles.ns>0.5
        set(gcf,'Position',[0.3,0.5-0.65/2,0.4,0.65]);
        set(handles.axes1,'Position',[0.11,0.045,0.84,0.80]);
    else
        set(gcf,'Position',[0.35,0.5-0.65/2,0.3,0.65]);
        set(handles.axes1,'Position',[0.15,0.045,0.80,0.80]);
    end
end

set(handles.mReloadFile,'Enable','on');
guidata(hObject,handles);
gfplotseis(handles);
set(gcf,'Name',['gfplot: ',name]);

% --------------------------------------------------------------------
function mReloadFile_Callback(hObject, eventdata, handles)

handles.data=gfreadfile(handles.filename);
handles.isok=1;
[handles.ns,handles.ntr]=size(handles.data);
guidata(hObject,handles);
gfplotseis(handles);



% --------------------------------------------------------------------
function mSavaData_Callback(hObject, eventdata, handles)
if ~handles.isok
    return;
end
[filename, pathname] = uiputfile( ...
    {'*.segy','SEGY file (*.segy)';'*.su','SU file (*.su)'}, ...
    'Pick a file',[handles.filename '.segy']);
if pathname==0
    return;
end
suffixStr=getfilesuffix([pathname,filename]);
switch suffixStr
    case 'su'
        gfwritesu(handles.data,[pathname,filename]);
    otherwise
        gfwritesegy(handles.data,[pathname,filename]);
end



% --------------------------------------------------------------------
function mSavaFigure_Callback(hObject, eventdata, handles)
if ~handles.isok
    return;
end
[filename, pathname] = uiputfile( ...
    {'*.jpg','JPEG image (*.jpg)'; ...
    '*.eps','EPS file (*.eps)'; ...
    '*.png','Portable Network Graphics file (*.png)'}, ...
    'Pick a file',[handles.filename '.jpg']);
if pathname==0
    return;
end

suffixStr=getfilesuffix([pathname,filename]);
handles.pos=get(gcf,'Position');
guidata(hObject,handles);
switch suffixStr
    case 'eps'
        fig1=gfplotseis2(handles);
        print(fig1,'-r150','-depsc2','-opengl',[pathname,filename]);
        close(fig1);
    case 'png'
        fig1=gfplotseis2(handles);
        print(fig1,'-r150','-dpng','-opengl',[pathname,filename]);
        close(fig1);
    otherwise
        fig1=gfplotseis2(handles);
        print(fig1,'-r150','-djpeg','-opengl',[pathname,filename]);
        close(fig1);
end

% --------------------------------------------------------------------
function mExit_Callback(hObject, eventdata, handles)
clear handles
close(gcf);

% --------------------------------------------------------------------
function uiExit_ClickedCallback(hObject, eventdata, handles)
clear handles
close(gcf);

% --------------------------------------------------------------------
function uiSaveFigure_ClickedCallback(hObject, eventdata, handles)
mSavaFigure_Callback(hObject, eventdata, handles);


% --------------------------------------------------------------------
function uiOpenFile_ClickedCallback(hObject, eventdata, handles)
mOpenFile_Callback(hObject, eventdata, handles);


% --------------------------------------------------------------------
function uiSaveData_ClickedCallback(hObject, eventdata, handles)
mSavaData_Callback(hObject, eventdata, handles);


% --------------------------------------------------------------------
function colormap_gray_Callback(hObject, eventdata, handles)
if ~handles.isok
    return;
end
handles.icolor='i';
set(handles.colormap_gray,'Check','on');
set(handles.colormap_rwb,'Check','off');
set(handles.colormap_rwl,'Check','off');
set(handles.colormap_jet,'Check','off');
set(handles.colormap_paru,'Check','off');
set(handles.colormap_flag,'Check','off');
guidata(hObject,handles);
gfplotseis(handles);
icolor=handles.icolor;
save par.mat '-append' icolor


% --------------------------------------------------------------------
function colormap_rwb_Callback(hObject, eventdata, handles)
if ~handles.isok
    return;
end
handles.icolor='g';
set(handles.colormap_gray,'Check','off');
set(handles.colormap_rwb,'Check','on');
set(handles.colormap_rwl,'Check','off');
set(handles.colormap_jet,'Check','off');
set(handles.colormap_paru,'Check','off');
set(handles.colormap_flag,'Check','off');
guidata(hObject,handles);
gfplotseis(handles);
icolor=handles.icolor;
save par.mat '-append' icolor

% --------------------------------------------------------------------
function colormap_rwl_Callback(hObject, eventdata, handles)
if ~handles.isok
    return;
end
handles.icolor='e';
set(handles.colormap_gray,'Check','off');
set(handles.colormap_rwb,'Check','off');
set(handles.colormap_rwl,'Check','on');
set(handles.colormap_jet,'Check','off');
set(handles.colormap_paru,'Check','off');
set(handles.colormap_flag,'Check','off');
guidata(hObject,handles);
gfplotseis(handles);
icolor=handles.icolor;
save par.mat '-append' icolor

% --------------------------------------------------------------------
function colormap_jet_Callback(hObject, eventdata, handles)
if ~handles.isok
    return;
end
handles.icolor='j';
set(handles.colormap_gray,'Check','off');
set(handles.colormap_rwb,'Check','off');
set(handles.colormap_rwl,'Check','off');
set(handles.colormap_jet,'Check','on');
set(handles.colormap_paru,'Check','off');
set(handles.colormap_flag,'Check','off');
guidata(hObject,handles);
gfplotseis(handles);
icolor=handles.icolor;
save par.mat '-append' icolor

% --------------------------------------------------------------------
function colormap_paru_Callback(hObject, eventdata, handles)
if ~handles.isok
    return;
end
handles.icolor='p';
set(handles.colormap_gray,'Check','off');
set(handles.colormap_rwb,'Check','off');
set(handles.colormap_rwl,'Check','off');
set(handles.colormap_jet,'Check','off');
set(handles.colormap_paru,'Check','on');
set(handles.colormap_flag,'Check','off');
guidata(hObject,handles);
gfplotseis(handles);
icolor=handles.icolor;
save par.mat '-append' icolor

% --------------------------------------------------------------------
function mIsReverse_Callback(hObject, eventdata, handles)
if ~handles.isok
    return;
end
if handles.isreverse==1
    handles.isreverse=0;
    set(handles.mIsReverse,'Check','off');
else
    handles.isreverse=1;
    set(handles.mIsReverse,'Check','on');
end
guidata(hObject,handles);
gfplotseis(handles);
isreverse=handles.isreverse;
save par.mat '-append' isreverse

% --------------------------------------------------------------------
function mIsZero_Callback(hObject, eventdata, handles)
if ~handles.isok
    return;
end
if handles.iszero==1
    handles.iszero=0;
    set(handles.mIsZero,'Check','off');
else
    handles.iszero=1;
    set(handles.mIsZero,'Check','on');
end
guidata(hObject,handles);
gfplotseis(handles);
iszero=handles.iszero;
save par.mat '-append' iszero

% --------------------------------------------------------------------
function mIsColorbar_Callback(hObject, eventdata, handles)
if ~handles.isok
    return;
end
if handles.iscolorbar==1
    handles.iscolorbar=0;
    set(handles.mIsColorbar,'Check','off');
else
    handles.iscolorbar=1;
    set(handles.mIsColorbar,'Check','on');
end
guidata(hObject,handles);
gfplotseis(handles);
iscolorbar=handles.iscolorbar;
save par.mat '-append' iscolorbar

% --------------------------------------------------------------------
function uiColorbar_ClickedCallback(hObject, eventdata, handles)
if ~handles.isok
    return;
end
if handles.iscolorbar==1
    handles.iscolorbar=0;
    set(handles.mIsColorbar,'Check','off');
else
    handles.iscolorbar=1;
    set(handles.mIsColorbar,'Check','on');
end
guidata(hObject,handles);
gfplotseis(handles);
iscolorbar=handles.iscolorbar;
save par.mat '-append' iscolorbar


% --------------------------------------------------------------------
function mProcess_Callback(hObject, eventdata, handles)
% -------------------------------------------------------------------
function mAxes_Callback(hObject, eventdata, handles)
% --------------------------------------------------------------------
function AxesProperties_Callback(hObject, eventdata, handles)
if ~handles.isok
    return;
end
[subfig,axesPro,flag]=AxesPro(handles.axesPro);
if isnan(flag)
    return
end
close(subfig)
handles.axesPro=axesPro;
%fillupPopupmenu=handles.axesPro.fillupPopupmenu;
guidata(hObject,handles);
gfplotseis(handles);
if handles.axesPro.isAlways
    save par.mat '-append' axesPro
end

% --------------------------------------------------------------------
function pGian_Callback(hObject, eventdata, handles)
% --------------------------------------------------------------------
function pFIR_Callback(hObject, eventdata, handles)
% --------------------------------------------------------------------
function pSmooth_Callback(hObject, eventdata, handles)
if ~handles.isok
    return;
end
handles.pdata=handles.data;
handles.data=gfsmooth(handles.data);
guidata(hObject,handles);
gfplotseis(handles);

% --------------------------------------------------------------------
function pMedian_Callback(hObject, eventdata, handles)
if ~handles.isok
    return;
end
handles.pdata=handles.data;
handles.data=medfilt2(handles.data);
guidata(hObject,handles);
gfplotseis(handles);


% --------------------------------------------------------------------
function pLaplacian_Callback(hObject, eventdata, handles)
if ~handles.isok
    return;
end
handles.pdata=handles.data;
handles.data=gflaplas(handles.data);
handles.data(1,:)=0;
handles.data(end,:)=0;
handles.data(:,1)=0;
handles.data(:,end)=0;
guidata(hObject,handles);
gfplotseis(handles);

% --------------------------------------------------------------------
function pAGC_Callback(hObject, eventdata, handles)
if ~handles.isok
    return;
end
handles.pdata=handles.data;
prompt={'AGC control points:'};
name='AGC setting';
numlines=1;
defaultanswer={num2str(handles.autoGianNum)};
options.Resize='on';
options.WindowStyle='normal';
options.Interpreter='tex';
answer=inputdlg(prompt,name,numlines,defaultanswer,options);
if isempty(answer)
    return;
end
handles.autoGianNum=str2double(answer);
autoGianNum=handles.autoGianNum;
autoSeg=autoGianNum+1;
[ns,ntr]=size(handles.data);
d=mod(ns,autoSeg);
subNs=(ns-d)/autoSeg;
gainCurve=zeros(ns,1);
for in=1:ntr
    for is=1:autoGianNum
        amp=mean(abs(handles.data((is-1)*subNs+1:(is+1)*subNs,in)))/2/subNs;
        gainCurve(is*subNs)=1/amp;
        gainCurve(is*subNs+1)=1/amp;
    end
    for is=1:autoGianNum
        gainCurve((is-1)*subNs+1:is*subNs)= ...
            linspace(gainCurve((is-1)*subNs+1),gainCurve(is*subNs),subNs);
    end
    gainCurve(is*subNs+1:end)=gainCurve(is*subNs);
    handles.data(:,in)=handles.data(:,in).*gainCurve;
end
guidata(hObject,handles);
gfplotseis(handles);

% --------------------------------------------------------------------
function pManul_Callback(hObject, eventdata, handles)
if ~handles.isok
    return;
end
[fdcf,tvg,flag]=timeVaryGain(handles.ns);
if isnan(flag)
    return;
end
close(fdcf);
N=tvg.Order;
Wn=tvg.Wn;
[B,A]=butter(N,Wn,'high');
H=freqz(B,A,handles.ns);
H=abs(H);
handles.timeVaryGainCurve=H;
handles.pdata=handles.data;
for in=1:handles.ntr
    handles.data(:,in)=handles.pdata(:,in).*H;
end
guidata(hObject,handles);
gfplotseis(handles);


% --------------------------------------------------------------------
function uiCutSource_ClickedCallback(hObject, eventdata, handles)
if ~handles.isok
    return;
end
handles.pdata=handles.data;
[B,A]=butter(2,0.2,'high');
H=freqz(B,A,handles.ns);
H=abs(H);
handles.timeVaryGainCurve=H;
for in=1:handles.ntr
    handles.data(:,in)=handles.pdata(:,in).*handles.timeVaryGainCurve;
end
guidata(hObject,handles);
gfplotseis(handles);


% --------------------------------------------------------------------
function uiSmooth_ClickedCallback(hObject, eventdata, handles)
pSmooth_Callback(hObject, eventdata, handles);


% --------------------------------------------------------------------
function uiMedian_ClickedCallback(hObject, eventdata, handles)
pMedian_Callback(hObject, eventdata, handles);


% --------------------------------------------------------------------
function uiLapLace_ClickedCallback(hObject, eventdata, handles)
pLaplacian_Callback(hObject, eventdata, handles);


% --------------------------------------------------------------------
function lowPassFiltering_Callback(hObject, eventdata, handles)
if ~handles.isok
    return;
end
handles.pdata=handles.data;
hdr.ntr=handles.ntr;
hdr.ns=handles.ns;
[subfig,fircf,flag]=firFilter(handles.data,hdr,'low');
if isnan(flag)
    return
end
close(subfig)
switch fircf.firName
    case 1
        [B,A]=butter(fircf.firOrder,fircf.firWs,'low');
    case 2
        [B,A]=cheby1(fircf.firOrder,fircf.firRp,fircf.firWs,'low');
    case 3
        [B,A]=cheby2(fircf.firOrder,fircf.firRp,fircf.firWs,'low');
    case 4
        [B,A]=ellip(fircf.firOrder,fircf.firRp,fircf.firRs,fircf.firWs,'low');
end
for in=1:handles.ntr
    dat=handles.data(:,in);
    handles.data(:,in)=filter(B,A,dat);
end
handles.pdata(1:end-size(A,2),:)=handles.data(size(A,2)+1:end,:);
handles.data=handles.pdata;

guidata(hObject,handles);
gfplotseis(handles);

% --------------------------------------------------------------------
function highPassFiltering_Callback(hObject, eventdata, handles)
if ~handles.isok
    return;
end
handles.pdata=handles.data;
hdr.ntr=handles.ntr;
hdr.ns=handles.ns;
[subfig,fircf,flag]=firFilter(handles.data,hdr,'high');
if isnan(flag)
    return
end
close(subfig)
switch fircf.firName
    case 1
        [B,A]=butter(fircf.firOrder,fircf.firWp,'high');
    case 2
        [B,A]=cheby1(fircf.firOrder,fircf.firRp,fircf.firWp,'high');
    case 3
        [B,A]=cheby2(fircf.firOrder,fircf.firRp,fircf.firWp,'high');
    case 4
        [B,A]=ellip(fircf.firOrder,fircf.firRp,fircf.firRs,fircf.firWp,'high');
end
for in=1:handles.ntr
    dat=handles.data(:,in);
    handles.data(:,in)=filter(B,A,dat);
end
handles.pdata(1:end-size(A,2),:)=handles.data(size(A,2)+1:end,:);
handles.data=handles.pdata;
guidata(hObject,handles);
gfplotseis(handles);

% --------------------------------------------------------------------
function bandPassFiltering_Callback(hObject, eventdata, handles)
if ~handles.isok
    return;
end
handles.pdata=handles.data;
hdr.ntr=handles.ntr;
hdr.ns=handles.ns;
[subfig,fircf,flag]=firFilter(handles.data,hdr,'bandpass');
if isnan(flag)
    return
end
close(subfig)
switch fircf.firName
    case 1
        [Bh,Ah]=butter(fircf.firOrder,fircf.firWs,'high');
        [Bl,Al]=butter(fircf.firOrder,fircf.firWp,'low');
    case 2
        [Bh,Ah]=cheby1(fircf.firOrder,fircf.firRp,fircf.firWs,'high');
        [Bl,Al]=cheby1(fircf.firOrder,fircf.firRp,fircf.firWp,'low');
    case 3
        [Bh,Ah]=cheby2(fircf.firOrder,fircf.firRp,fircf.firWs,'high');
        [Bl,Al]=cheby2(fircf.firOrder,fircf.firRp,fircf.firWp,'low');
    case 4
        [Bh,Ah]=ellip(fircf.firOrder,fircf.firRp,fircf.firRs,fircf.firWs,'high');
        [Bl,Al]=ellip(fircf.firOrder,fircf.firRp,fircf.firRs,fircf.firWp,'low');
end
for in=1:handles.ntr
    dat=handles.data(:,in);
    handles.data(:,in)=filter(Bl,Al,filter(Bh,Ah,dat));
end
handles.pdata(1:end-size(Al,2),:)=handles.data(size(Al,2)+1:end,:);
handles.data=handles.pdata;
guidata(hObject,handles);
gfplotseis(handles);

% --------------------------------------------------------------------
function bandStopFiltering_Callback(hObject, eventdata, handles)
if ~handles.isok
    return;
end
handles.pdata=handles.data;
hdr.ntr=handles.ntr;
hdr.ns=handles.ns;
[subfig,fircf,flag]=firFilter(handles.data,hdr,'bandstop');
if isnan(flag)
    return
end
close(subfig)
switch fircf.firName
    case 1
        [B,A]=butter(fircf.firOrder,[fircf.firWs,fircf.firWp],'stop');
    case 2
        [B,A]=cheby1(fircf.firOrder,fircf.firRp,[fircf.firWs,fircf.firWp],'stop');
    case 3
        [B,A]=cheby2(fircf.firOrder,fircf.firRp,[fircf.firWs,fircf.firWp],'stop');
    case 4
        [B,A]=ellip(fircf.firOrder,fircf.firRp,fircf.firRs,[fircf.firWs,fircf.firWp],'stop');
end
for in=1:handles.ntr
    dat=handles.data(:,in);
    handles.data(:,in)=filter(B,A,dat);
end
handles.pdata(1:end-size(A,2),:)=handles.data(size(A,2)+1:end,:);
handles.data=handles.pdata;
guidata(hObject,handles);
gfplotseis(handles);

% --- Executes on scroll wheel click while the figure is in focus.
function figure1_WindowScrollWheelFcn(hObject, eventdata, handles)
if ~handles.isok
    return;
end
if eventdata.VerticalScrollCount>0
    handles.igain=handles.igain-0.1;
elseif eventdata.VerticalScrollCount<0
    handles.igain=handles.igain+0.1;
end
guidata(hObject,handles);
maxdat=max(max((handles.data)));
mindat=min(min((handles.data)));
ff=1./exp(handles.igain-1);
if maxdat ~= mindat
    caxis([ff*mindat,ff*maxdat]);
end
if handles.iszero
    maxdat=max(max(abs(handles.data)));
    caxis([-ff*maxdat,ff*maxdat]);
end
igain=handles.igain;
save par.mat '-append' igain



% --------------------------------------------------------------------
function mGianFactor_Callback(hObject, eventdata, handles)
prompt={'Display gain factor:'};
name='Display gain factor ';
numlines=1;
defaultanswer={num2str(handles.igain)};
options.Resize='on';
options.WindowStyle='normal';
options.Interpreter='tex';
answer=inputdlg(prompt,name,numlines,defaultanswer,options);
if isempty(answer)
    return;
end

handles.igain=str2double(answer{1});
guidata(hObject,handles);

if ~handles.isok
    
    return;
    
end

maxdat=max(max((handles.data)));
mindat=min(min((handles.data)));
ff=1./exp(handles.igain-1);
caxis([ff*mindat,ff*maxdat]);
if handles.iszero
    maxdat=max(max(abs(handles.data)));
    caxis([-ff*maxdat,ff*maxdat]);
end
igain=handles.igain;
save par.mat '-append' igain

% --------------------------------------------------------------------
function uiUndo_ClickedCallback(hObject, eventdata, handles)
if ~handles.isok
    return;
end
handles.data=handles.pdata;
guidata(hObject,handles);
gfplotseis(handles);


% --------------------------------------------------------------------
function uiQuestion_ClickedCallback(hObject, eventdata, handles)
ButtonName = questdlg([' If you have any problems, please connect the author: chf_guo@163.com.',...
    '  Are you interested in lottery? Would you like playing a little game with me (^_^)? ',...
    '  If you win the first prize, make a screenshot and send to me, I will give you 10 Yuan.'...
    '  Just try your luck! No cheating!'], ...
    'Connect me ...', ...
    'Yes', 'No', 'Yes');
if strcmp(ButtonName,'Yes')
    littlegame();
end % switch

% --------------------------------------------------------------------
function mHelp_Callback(hObject, eventdata, handles)

% --------------------------------------------------------------------
function mManual_Callback(hObject, eventdata, handles)

% --------------------------------------------------------------------
function Aboutgfplot_Callback(hObject, eventdata, handles)
str1=['   <gfplot> scales data and display as image. <gfplot> also provides some simple processes, like FIR filtering, ',....
    'smooth, meddian filtering and data gain. This display function is ',...
    'based on MATLAB GUI. The core function is <imagesc>. It can be used as '....
    'an independt MATLAB GUI program or a just simple funtion. This function is added ',...
    'on 2016/10/20'];
str2='';
str3=['   This is a subroutine of Seismic Modeling and Research Toolkit (SMART),',...
    'It is illegal for you to use this software tool (Seismic Modeling and ',...
    'Research Toolkit,SMART) for a purpose other than non-profit education ',...
    'or research UNLESS you are authorized by the Author(s).If ',...
    'you find any problems, please connect the Author(s): chf_guo@163.com'];
str={str1,str2,str3};
msgbox(str,'gfplot');

% --------------------------------------------------------------------
function FileDoc_Callback(hObject, eventdata, handles)
str1='   File�˵��д򿪡��������롢�������ݺͱ���ͼ�������Ӳ˵�';
str2='   <gfplot>����ֱ�Ӷ�������ݸ�ʽ��SU��SEGY��LTE��RAD����ֻ��ʽ��';
str3='SU��SEGY��ʽ�ǵ������ϸ�ʽ��LTE��RAD��̽���״��������ʽ������';
str4='����ֻ���Ա���ΪSU��SEGY���ݸ�ʽ��';
str5='   ͼƬ����֧��EPS��JPEG��PNG����ͼ����ʽ����ʵ��ֻҪMATLAB֧��';
str6='��ͼƬ��ʽ���Ǳ���ģ�����û�б�Ҫ������ֻ���������ָ�ʽ������ΪͼƬ';
str7='������<print>����д�ģ�����<print>���������ͼƬ����Ļ����ʾ������ͼƬ';
str8='�ǲ�һ�µģ�<print>Ϊ��Ч�ʿ�����������ġ���������ͼƬ������Ҫ��';
str9='���Խ���MATLAB��figure����(Go to Figure)�������á�';
str={str1,'',str2,str3,str4,'',str5,str6,str7,str8,str9,''};
h=msgbox(str,'Summry');
set(h,'Resize','on');

% --------------------------------------------------------------------
function DispDoc_Callback(hObject, eventdata, handles)
str1='   Display�˵���ɫ��(Colormap)���Ƿ�ת(Reverse)���Ƿ���ֵ����Ϊ�м�ɫ';
str2='(ZeroCor)���Ƿ���Ҫɫ��(Colorbar)����ʾ����(DispGain)����ѡ�����';
str3='   ɫ��(Colormap)�лҶ�ͼ(Gray)��������(Jet)�������(Fresh)����׺�(Blood)';
str4='������(Parula)������ɫ����ѡ��';
str5='   �Ƿ�ת(Reverse)��ת������ʾ�ļ��ԣ���Ӱ�쵽���ݡ�';
str6='   �Ƿ���ֵ����Ϊ�м�ɫ(ZeroCor)��һ���ǳ����õ����ã���Щ���ݵı���ֵ';
str7='��Ϊ�㣬����ʾ��ʱ�����ֱ���ɫ�������ں�׺�ɫ���£�������ʾΪ��ɫ��';
str8='������ֵ��Ϊ�м�ɫ��ʱ�򣬱���ɫ��Ϊ��ɫ';
str9='   �Ƿ���Ҫɫ��(Colorbar)����ɫ���';
str10='   ��ʾ����(DispGain)ͨ���ض�������ʾ͹�����źţ����Ӳ˵�����һ�������';
str11='��ֵԽ������Խ���ԡ������������Ĺ���Ҳ����ʵ�����棬��������תΪ��';
str12='�棬����ת��Ϊ˥������ʾ���治Ӱ�����ݱ���';
str={str1,str2,'',str3,str4,'',str5,'',str6,str7,str8,'',str9,'',str10,str11,str12,''};
h=msgbox(str,'Summry');
set(h,'Resize','on');

% --------------------------------------------------------------------
function ProcessDoc_Callback(hObject, eventdata, handles)
str1='   Process�˵�����������(Gain)��FIR�˲�(FIR filter)��ƽ��(Smooth)����ֵ(Median)';
str2='��������˹(Laplacian)���˲�����ѡ�����';
str3='   ��������(Gain)��Ϊ�Զ�����(AGC)���ֶ�����(Manul)���Զ�������Ҫ��������㣬';
str4='Ĭ��Ϊ16��һ�㲻��Ҫ�޸ģ��ֶ�����ʵ��������˥��ǳ��ǿ�źŵģ�ͨ�����ò���';
str5='�����������ߡ�';
str6='   FIR�˲�(FIR filter)�е�ͨ����ͨ����ͨ�Լ�����ȼ����˲�����ʵ�ַ�ʽ�а�����';
str7='˹(butter)���б�ѩ��I��(cheby1)���б�ѩ��II��(cheby2)�Լ���Բ(ellip)�˲�����';
str8='MATLAB���⼸���˲���������ϸ���ܣ��ڴ˲���׸��';
str9='   ƽ��(Smooth)�˲���ά����ƽ���˲�����ֵ(Median)�˲���ά������ֵ�˲�������';
str10='��˹(Laplacian)�˲�ȥ����Ƶ����';
str={str1,str2,'',str3,str4,str5,'',str6,str7,str8,'',str9,str10,''};
h=msgbox(str,'Summry');
set(h,'Resize','on');

% --------------------------------------------------------------------
function AxesDoc_Callback(hObject, eventdata, handles)
str1='   AxesPro�˵���Ҫ�Ƕ����ꡢ�������������С�ȵȽ�������';
str2='   ����һ��(Fonts)����ѡ���������ͣ��Ӵ��Լ���б����ѡ��';
str3='   �ݺ�����(xzLable)���������������ơ�����Ĵ�С';
str4='   �ݺ�������(xzTickLable)���ÿ̶ȵ���ʾλ�á����ݵļ����С��';
str5='�̶��ߵĴ�ϸ�������С�ȣ����⻹�и��̶ȵĸ�ʽ��(Formatted)';
str6='��ʾ������IntegerΪ�̶�Ϊ������Deci��ʾ����С�����һλ��Ч';
str7='���֣�CentiΪ����С�������λ��';
str8='   ɫ��(barLabel)����ɫ�������ơ������С';
str9='   ����(Title)���ñ��⣬����Ϊ�����ʾ����Ҫ���⣬�����λ����';
str10='ͼƬ�±߽�߿���';
str={str1,'',str2,'',str3,'',str4,str5,str6,str7,'',str8,'',str9,str10,''};
h=msgbox(str,'Summry');
set(h,'Resize','on');

% --------------------------------------------------------------------
function AboutSMART_Callback(hObject, eventdata, handles)
str1=['  SMART (seismic modelling and research toolkit) is a simple but useful ',...
    '   MATLAB toolbox for numerical wave prpogation modelling.',...
    ' The primary aim of SMART is to provide some basic subfunctions for researchers ',...
    'to build their programes easily.'];
str2='';
str3='Copyright(C) 2016 Elastic Wave Expolration Project (EWEP)';
str4='China University of Petroleum(East China)';
str={str1,str2,str3,str4,''};
msgbox(str,'SMART');

% --------------------------------------------------------------------
function mSummry_Callback(hObject, eventdata, handles)
str1='  <gfplot> ��һ����ά������ʾ��������������һ��ʹ��,���磺gfplot(data)';
str2='ͬʱҲ����������ڴ򿪡�<gfplot> ����Ҫ�����Ƿ����ݵ���ʾ���ݣ���';
str3='�����м򵥵ģ������˲�ƽ�������ݴ�����ʹ����ʹ��MATLAB��ͬѧ����';
str4='������<gfplot>�����ͼ';
str5='';
str6='    <gfplot>��Ҫ���ļ���File������ʾ���ã�Display�����򵥴���Process��';
str7='���������ã�AxePro���ȼ����򵥵Ĳ˵���������⼸���˵����м򵥵Ľ��ܡ�';

str={str1,str2,str3,str4,str5,str6,str7,''};
h=msgbox(str,'Summry');
set(h,'Resize','on');


% --------------------------------------------------------------------
function gotofigure_Callback(hObject, eventdata, handles)
if ~handles.isok
    return;
end
handles.pos=get(gcf,'Position');
guidata(hObject,handles);
h=figure('Visible','on','Units','Normalized','Position',handles.pos);
switch handles.axesPro.FontNamePopupmenu
    case 1
        fontname='Times New Roman';
    case 2
        fontname='Arial';
    case 3
        fontname='Helvetica';
end
switch handles.axesPro.AnglePopupmenu
    case 1
        angle='Normal';
    case 2
        angle='Oblique';
end
switch handles.axesPro.WeightPopupmenu
    case 1
        weight='Normal';
    case 2
        weight='Demi';
    case 3
        weight='Bold';
end

Nx=handles.ntr;
Nz=handles.ns;
idx=handles.axesPro.xStepEdit;
idz=handles.axesPro.yStepEdit;
iox=handles.axesPro.xStartEdit;
ioz=handles.axesPro.yStartEdit;
ixlabel=handles.axesPro.xLabelEdit;
izlabel=handles.axesPro.yLabelEdit;

ixaxis=(0:Nx)*idx+iox;
izaxis=(0:Nz)*idz+ioz;

imagesc(ixaxis,izaxis,handles.data);
set(gca,'TickDirMode','manual','TickDir','out');
set(gca,'XAxisLocation','top');
set(gca,'LineWidth',handles.axesPro.LineWidthEdit);
set(gca,'Fontsize',handles.axesPro.mainSizePopupmenu,'Fontname',fontname,...
    'FontWeight',weight,'FontAngle',angle);
xlabel(ixlabel,'Fontsize',handles.axesPro.xySizePopupmenu,'Fontname',fontname,...
    'FontWeight',weight,'FontAngle',angle);
ylabel(izlabel,'Fontsize',handles.axesPro.xySizePopupmenu,'Fontname',fontname,...
    'FontWeight',weight,'FontAngle',angle);

if strcmp(handles.isfillup,'y')
    switch handles.axesPro.fillupPopupmenu
        case 1
        case 2
            d=get(gca,'XTick');
            d(floor(d)~=d)=[];
            set(gca,'XTick',d);
            d=get(gca,'YTick');
            d(floor(d)~=d)=[];
            set(gca,'YTick',d);
            
        case 3
            set(gca,'xticklabel',sprintf('%03.1f|',get(gca,'xtick')),'XTick',get(gca,'xtick'));
            set(gca,'yticklabel',sprintf('%03.1f|',get(gca,'ytick')),'YTick',get(gca,'ytick'));
        case 4
            set(gca,'xticklabel',sprintf('%03.2f|',get(gca,'xtick')),'XTick',get(gca,'xtick'));
            set(gca,'yticklabel',sprintf('%03.2f|',get(gca,'ytick')),'YTick',get(gca,'ytick'));
    end
end
box off
xlim=get(gca,'XLim');
zlim=get(gca,'YLim');
xstart=xlim(1);
xend=xlim(2);
zstart=zlim(1);
zend=zlim(2);

line([xend,xend],[zstart,zend],'color',[0 0 0],'linewidth',handles.axesPro.LineWidthEdit);
line([xstart,xend],[zend,zend],'color',[0 0 0],'linewidth',handles.axesPro.LineWidthEdit);

if handles.isreverse
    icolorflag=[handles.icolor,'-'];
else
    icolorflag=handles.icolor;
end

maxdat=max(max((handles.data)));
mindat=min(min((handles.data)));
ff=1./exp(handles.igain-1);
if maxdat ~= mindat
    caxis([ff*mindat,ff*maxdat]);
end
if handles.iszero
    maxdat=max(max(abs(handles.data)));
    caxis([-ff*maxdat,ff*maxdat]);
end
icolormap=gfcolormap2(icolorflag);
colormap(icolormap);

if handles.iscolorbar
    icolorbar=colorbar('EastOutside','Fontsize',handles.axesPro.barSizePopupmenu,'Fontname',fontname,...
        'FontWeight',weight,'FontAngle',angle);
    set(get(icolorbar,'YLabel'),'string',handles.axesPro.barLabelEdit,'Fontname',fontname,...
        'FontWeight',weight,'FontAngle',angle);
end

if ~isempty(handles.axesPro.titleEdit)
    th=title(handles.axesPro.titleEdit);
    set(th,'FontSize',handles.axesPro.titleSizePopupmenu,'Fontname',fontname,...
        'FontWeight',weight,'FontAngle',angle);
    title(th,'position',[(xstart+xend)/2,zend]);
end
set(h,'Color',[1,1,1]);

% --------------------------------------------------------------------
function pCalculus_Callback(hObject, eventdata, handles)

% --------------------------------------------------------------------
function pAlgebra_Callback(hObject, eventdata, handles)

% --------------------------------------------------------------------
function pNormalization_Callback(hObject, eventdata, handles)
if ~handles.isok
    return;
end
handles.pdata=handles.data;
for in=2:handles.ntr
    handles.data(:,in)=handles.pdata(:,in)/(max(abs(handles.pdata(:,in)))+eps);
end
guidata(hObject,handles);
gfplotseis(handles);


% --------------------------------------------------------------------
function prmBackgroud_Callback(hObject, eventdata, handles)
if ~handles.isok
    return;
end
[par,isok]=gfinput('Remove background',{'Dim(1-z,2-x)','Time Window'},{'2','20'});
if ~isok
    return;
end
handles.pdata=handles.data;
dirp=par(1);
tw=par(2);
if dirp==1
    for in=floor(tw/2)+1:handles.ns-floor(tw/2)
        tmp=sum(handles.pdata(in-floor(tw/2)+1:in+floor(tw/2),:));
        handles.data(in,:)=handles.pdata(in,:)-tmp/(2*floor(tw/2));
    end
    handles.data(1:floor(tw/2),:)=eps;
    handles.data(end-floor(tw/2)+1:end,:)=eps;
elseif dirp==2
    for in=floor(tw/2)+1:handles.ntr-floor(tw/2)
        tmp=sum(handles.pdata(:,in-floor(tw/2)+1:in+floor(tw/2)),2);
        handles.data(:,in)=handles.pdata(:,in)-tmp/(2*floor(tw/2));
    end
    handles.data(:,1:floor(tw/2))=eps;
    handles.data(:,end-floor(tw/2)+1:end)=eps;
end
guidata(hObject,handles);
gfplotseis(handles);

% --------------------------------------------------------------------
function pIntegral_Callback(hObject, eventdata, handles)
if ~handles.isok
    return;
end
handles.pdata=handles.data;
handles.data=gfintegral(handles.data);
guidata(hObject,handles);
gfplotseis(handles);


% --------------------------------------------------------------------
function pDifference_Callback(hObject, eventdata, handles)
if ~handles.isok
    return;
end
handles.pdata=handles.data;
for in=2:handles.ns
    handles.data(in,:)=handles.pdata(in,:)-handles.pdata(in-1,:);
end
guidata(hObject,handles);
gfplotseis(handles);

% --------------------------------------------------------------------
function pLocalSum_Callback(hObject, eventdata, handles)
if ~handles.isok
    return;
end

[tw,isok]=gfinput('Local Sum',{'Time Window'},{'20'});
if ~isok
    return;
end

handles.pdata=handles.data;

for in=floor(tw/2)+1:handles.ns-floor(tw/2)
    handles.data(in,:)=sum(handles.pdata(in-floor(tw/2)+1:in+floor(tw/2),:));
end

guidata(hObject,handles);
gfplotseis(handles);


% --------------------------------------------------------------------
function pAbsolute_Callback(hObject, eventdata, handles)
if ~handles.isok
    return;
end
handles.pdata=handles.data;
handles.data=abs(handles.data);
guidata(hObject,handles);
gfplotseis(handles);

% --------------------------------------------------------------------
function pFrequency_Callback(hObject, eventdata, handles)

% --------------------------------------------------------------------
function pFrequencySpectrum_Callback(hObject, eventdata, handles)
gffreq2(handles.data,1);

% --------------------------------------------------------------------
function pTimeFrequency_Callback(hObject, eventdata, handles)
if ~handles.isok
    return;
end
figopt.isReverse=handles.isreverse;
figopt.icolormap=handles.icolor;
figopt.igain=handles.igain;
figopt.isZero=handles.iszero;
if isempty(handles.line)
    TimeFrequencyAnalysis(handles.data,figopt);
else
    TimeFrequencyAnalysis(handles.data,figopt,handles.line);
end


% --------------------------------------------------------------------
function DisplaySetting_Callback(hObject, eventdata, handles)
% --------------------------------------------------------------------
function ColormapSetting_Callback(hObject, eventdata, handles)
% --------------------------------------------------------------------
function ExportScript_Callback(hObject, eventdata, handles)
if ~handles.isok
    return;
end
[name,path] = uiputfile( ...
    {'','MATLAB Script (*.m)'}, ...
    'Pick a file');
if name==0
    return;
end
filename=strcat(path,name);
fid=fopen(filename,'w');

fprintf(fid,'function %s(inputdata)\n',name(1:end-2));
fprintf(fid,'%% This is a plot function generated by gfplot, automatically\n');
fprintf(fid,'%% Usage: %s(inputdata)\n',name(1:end-2));
fprintf(fid,'%%\n');
fprintf(fid,'%% Author: Guo C.F.\n');
fprintf(fid,'%% Date: %s\n\n',date());

handles.pos=get(gcf,'Position');
fprintf(fid,'handles.data=inputdata;\n');
fprintf(fid,'handles.pos=[%f,%f,%f,%f];\n',handles.pos(1),....
    handles.pos(2),handles.pos(3),handles.pos(4));
fprintf(fid,'[handles.ns,handles.ntr]=size(handles.data);\n');
fprintf(fid,'handles.icolor=''%s'';\n',handles.icolor);
fprintf(fid,'handles.isfillup=''%s'';\n',handles.isfillup);
fprintf(fid,'handles.iszero=%d;\n',handles.iszero);
fprintf(fid,'handles.isreverse=%d;\n',handles.isreverse);
fprintf(fid,'handles.iscolorbar=%d;\n',handles.iscolorbar);
fprintf(fid,'handles.igain=%f;\n',handles.igain);
fprintf(fid,'handles.axesPro.FontNamePopupmenu=%d;\n',handles.axesPro.FontNamePopupmenu);
fprintf(fid,'handles.axesPro.WeightPopupmenu=%d;\n',handles.axesPro.WeightPopupmenu);
fprintf(fid,'handles.axesPro.AnglePopupmenu=%d;\n',handles.axesPro.AnglePopupmenu);
fprintf(fid,'handles.axesPro.xLabelEdit=''%s'';\n',handles.axesPro.xLabelEdit);
fprintf(fid,'handles.axesPro.yLabelEdit=''%s'';\n',handles.axesPro.yLabelEdit);
fprintf(fid,'handles.axesPro.xySizePopupmenu=%d;\n',handles.axesPro.xySizePopupmenu);
fprintf(fid,'handles.axesPro.fillupPopupmenu=%d;\n',handles.axesPro.fillupPopupmenu);
fprintf(fid,'handles.axesPro.xStartEdit=%f;\n',handles.axesPro.xStartEdit);
fprintf(fid,'handles.axesPro.yStartEdit=%f;\n',handles.axesPro.yStartEdit);
fprintf(fid,'handles.axesPro.xStepEdit=%f;\n',handles.axesPro.xStepEdit);
fprintf(fid,'handles.axesPro.yStepEdit=%f;\n',handles.axesPro.yStepEdit);
fprintf(fid,'handles.axesPro.LineWidthEdit=%f;\n',handles.axesPro.LineWidthEdit);
fprintf(fid,'handles.axesPro.mainSizePopupmenu=%d;\n',handles.axesPro.mainSizePopupmenu);
fprintf(fid,'handles.axesPro.barLabelEdit=''%s'';\n',handles.axesPro.barLabelEdit);
fprintf(fid,'handles.axesPro.barSizePopupmenu=%d;\n',handles.axesPro.barSizePopupmenu);
fprintf(fid,'handles.axesPro.titleSizePopupmenu=%d;\n',handles.axesPro.titleSizePopupmenu);
if isempty(handles.axesPro.titleEdit)
    fprintf(fid,'handles.axesPro.titleEdit=[];\n');
else
    fprintf(fid,'handles.axesPro.titleEdit=%s;\n',handles.axesPro.titleEdit);
end
fprintf(fid,'gfplotmp(handles);\n');
fclose(fid);

% --------------------------------------------------------------------
function GoToFigure_ClickedCallback(hObject, eventdata, handles)
if ~handles.isok
    return;
end
gotofigure_Callback(hObject, eventdata, handles)

% --------------------------------------------------------------------
function GOTOFun_ClickedCallback(hObject, eventdata, handles)
if ~handles.isok
    return;
end
ExportScript_Callback(hObject, eventdata, handles);


% --------------------------------------------------------------------
function pAmplitude_Callback(hObject, eventdata, handles)
if ~handles.isok
    return;
end

handles.pdata=handles.data;
handles.data=abs(hilbert(handles.data));
guidata(hObject,handles);
gfplotseis(handles);

function figure1_WindowButtonDownFcn(hObject, eventdata, handles)
setappdata(hObject,'isPressed',true);

function figure1_WindowButtonUpFcn(hObject, eventdata, handles)
setappdata(hObject, 'isPressed', false);
% --- Executes on mouse motion over figure - except title and menu.
function figure1_WindowButtonMotionFcn(hObject, eventdata, handles)
if handles.st
    isPressed = getappdata(hObject, 'isPressed');
    if isPressed
        gpos=get(handles.axes1,'Position');
        cpos=get(gcf,'CurrentPoint');
        
        if cpos(1)>gpos(1) && cpos(1)<gpos(1)+gpos(3) && ...
                cpos(2)>gpos(2) && cpos(2) <gpos(2)+gpos(4)
            xl=max(get(gca,'XLim'));
            zl=max(get(gca,'YLim'));
            xp=(cpos(1)-gpos(1))/gpos(3)*xl;
            zp=(gpos(2)+gpos(4)-cpos(2))/gpos(4)*zl;
            plot([xp,xp+xl/100],[zp,zp+zl/100],'LineWidth',5);
        end
    end
end


% --------------------------------------------------------------------
function uitoggletool5_OffCallback(hObject, eventdata, handles)
handles.st=0;
hold off;
guidata(hObject,handles);
gfplotseis(handles);

% --------------------------------------------------------------------
function uitoggletool5_OnCallback(hObject, eventdata, handles)
handles.st=1;
hold on
guidata(hObject,handles);


% --------------------------------------------------------------------
function pdfDoc_Callback(hObject, eventdata, handles)
open('gfplotdoc.pdf');


% --------------------------------------------------------------------
function colormap_flag_Callback(hObject, eventdata, handles)

if ~handles.isok
    return;
end
handles.icolor='f';
set(handles.colormap_gray,'Check','off');
set(handles.colormap_rwb,'Check','off');
set(handles.colormap_rwl,'Check','off');
set(handles.colormap_jet,'Check','off');
set(handles.colormap_paru,'Check','off');
set(handles.colormap_flag,'Check','on');
guidata(hObject,handles);
gfplotseis(handles);
icolor=handles.icolor;
save par.mat '-append' icolor

% --------------------------------------------------------------------
function pHilbert_Callback(hObject, eventdata, handles)

% --------------------------------------------------------------------
function pInstPhase_Callback(hObject, eventdata, handles)
if ~handles.isok
    return;
end

handles.pdata=handles.data;
handles.data=angle(hilbert(handles.data)+eps)*180;
guidata(hObject,handles);
gfplotseis(handles);


% --------------------------------------------------------------------
function sNextFcns_Callback(hObject, eventdata, handles)
[name,path] = uigetfile('*.m','MATLAB����');
if name==0
    return;
end
fid1=fopen(strcat(path,name),'r');
dpath=which('gfplot.m');
dpath(end-8+1:end)=[];
fid2=fopen(strcat(dpath,name),'w+');

while 1
    tline = fgetl(fid1);
    if ~ischar(tline), break, end
    fprintf(fid2,'%s',tline);
    fprintf(fid2,'\n');
end
fclose(fid1);
fclose(fid2);
handles.fcn=name(1:end-2);
guidata(hObject,handles);
set(handles.myFcn,'TooltipString',handles.fcn);
fcnName=handles.fcn;
save par.mat '-append' fcnName

% --------------------------------------------------------------------
function myFcn_ClickedCallback(hObject, eventdata, handles)
if ~handles.isok
    return;
end
if isempty(handles.fcn)
    warndlg('No function is assigned!');
    return;
end

handles.pdata=handles.data;
handles.data=feval(handles.fcn,handles.data);
guidata(hObject,handles);
gfplotseis(handles);

% --------------------------------------------------------------------
function sAutoSize_Callback(hObject, eventdata, handles)
if ~handles.isok
    return;
end
if handles.isAutoSize==1
    handles.isAutoSize=0;
    set(handles.sAutoSize,'Check','off');
else
    handles.isAutoSize=1;
    set(handles.sAutoSize,'Check','on');
end
guidata(hObject,handles);
isautosize=handles.isAutoSize;
save par.mat '-append' isautosize


% --------------------------------------------------------------------
function dMesh_Callback(hObject, eventdata, handles)
% hObject    handle to dMesh (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if ~handles.isok
    return;
end
handles.pos=get(gcf,'Position');
guidata(hObject,handles);
figure('Visible','on','Units','Normalized','Position',handles.pos);
switch handles.axesPro.FontNamePopupmenu
    case 1
        fontname='Times New Roman';
    case 2
        fontname='Arial';
    case 3
        fontname='Helvetica';
end
switch handles.axesPro.AnglePopupmenu
    case 1
        angle='Normal';
    case 2
        angle='Oblique';
end
switch handles.axesPro.WeightPopupmenu
    case 1
        weight='Normal';
    case 2
        weight='Demi';
    case 3
        weight='Bold';
end
ixlabel=handles.axesPro.xLabelEdit;
izlabel=handles.axesPro.yLabelEdit;
[Nz,Nx]=size(handles.data);
xx=1:Nx;
zz=1:Nz;
[XX,ZZ]=meshgrid(xx,zz);
surf(XX,ZZ,double(handles.data));
shading interp
set(gca,'TickDirMode','manual','TickDir','out');
set(gca,'XAxisLocation','top');
set(gca,'LineWidth',handles.axesPro.LineWidthEdit);
set(gca,'Fontsize',handles.axesPro.mainSizePopupmenu,'Fontname',fontname,...
    'FontWeight',weight,'FontAngle',angle);
xlabel(ixlabel,'Fontsize',handles.axesPro.xySizePopupmenu,'Fontname',fontname,...
    'FontWeight',weight,'FontAngle',angle);
ylabel(izlabel,'Fontsize',handles.axesPro.xySizePopupmenu,'Fontname',fontname,...
    'FontWeight',weight,'FontAngle',angle);
zlabel('Amplitude','Fontsize',handles.axesPro.xySizePopupmenu,'Fontname',fontname,...
    'FontWeight',weight,'FontAngle',angle);

if strcmp(handles.isfillup,'y')
    switch handles.axesPro.fillupPopupmenu
        case 1
        case 2
            d=get(gca,'XTick');
            d(floor(d)~=d)=[];
            set(gca,'XTick',d);
            d=get(gca,'YTick');
            d(floor(d)~=d)=[];
            set(gca,'YTick',d);
            
        case 3
            set(gca,'xticklabel',sprintf('%03.1f|',get(gca,'xtick')),'XTick',get(gca,'xtick'));
            set(gca,'yticklabel',sprintf('%03.1f|',get(gca,'ytick')),'YTick',get(gca,'ytick'));
        case 4
            set(gca,'xticklabel',sprintf('%03.2f|',get(gca,'xtick')),'XTick',get(gca,'xtick'));
            set(gca,'yticklabel',sprintf('%03.2f|',get(gca,'ytick')),'YTick',get(gca,'ytick'));
    end
end
box off
xlim=get(gca,'XLim');
zlim=get(gca,'YLim');
xstart=xlim(1);
xend=xlim(2);
zstart=zlim(1);
zend=zlim(2);

line([xend,xend],[zstart,zend],'color',[0 0 0],'linewidth',handles.axesPro.LineWidthEdit);
line([xstart,xend],[zend,zend],'color',[0 0 0],'linewidth',handles.axesPro.LineWidthEdit);

if handles.isreverse
    icolorflag=[handles.icolor,'-'];
else
    icolorflag=handles.icolor;
end

maxdat=max(max((handles.data)));
mindat=min(min((handles.data)));
ff=1./exp(handles.igain-1);
caxis([ff*mindat,ff*maxdat]);
if handles.iszero
    maxdat=max(max(abs(handles.data)));
    caxis([-ff*maxdat,ff*maxdat]);
end
icolormap=gfcolormap2(icolorflag);
colormap(icolormap);

if handles.iscolorbar
    icolorbar=colorbar('EastOutside','Fontsize',handles.axesPro.barSizePopupmenu,'Fontname',fontname,...
        'FontWeight',weight,'FontAngle',angle);
    set(get(icolorbar,'YLabel'),'string',handles.axesPro.barLabelEdit,'Fontname',fontname,...
        'FontWeight',weight,'FontAngle',angle);
end

if ~isempty(handles.axesPro.titleEdit)
    th=title(handles.axesPro.titleEdit);
    set(th,'FontSize',handles.axesPro.titleSizePopupmenu,'Fontname',fontname,...
        'FontWeight',weight,'FontAngle',angle);
    title(th,'position',[(xstart+xend)/2,zend]);
end

% --------------------------------------------------------------------
function sDefault_Callback(hObject, eventdata, handles)

repar;
if ~handles.isok
    return;
end

gfplot(handles.data);


% --------------------------------------------------------------------
function mSaveMat_Callback(hObject, eventdata, handles)
% hObject    handle to mSaveMat (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if ~handles.isok
    return;
end
handles.tval=1;
%need modification
assignin('base',num2str(['tval_',num2str(handles.tval)]),handles.data);
handles.tval=handles.tval+1;
guidata(hObject,handles);
