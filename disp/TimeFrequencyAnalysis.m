function varargout = TimeFrequencyAnalysis(varargin)
% TIMEFREQUENCYANALYSIS MATLAB code for TimeFrequencyAnalysis.fig
%      TIMEFREQUENCYANALYSIS, by itself, creates a new TIMEFREQUENCYANALYSIS or raises the existing
%      singleton*.
%
%      H = TIMEFREQUENCYANALYSIS returns the handle to a new TIMEFREQUENCYANALYSIS or the handle to
%      the existing singleton*.
%
%      TIMEFREQUENCYANALYSIS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in TIMEFREQUENCYANALYSIS.M with the given input arguments.
%
%      TIMEFREQUENCYANALYSIS('Property','Value',...) creates a new TIMEFREQUENCYANALYSIS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before TimeFrequencyAnalysis_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to TimeFrequencyAnalysis_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help TimeFrequencyAnalysis

% Last Modified by GUIDE v2.5 31-Oct-2016 20:17:24

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @TimeFrequencyAnalysis_OpeningFcn, ...
    'gui_OutputFcn',  @TimeFrequencyAnalysis_OutputFcn, ...
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


% --- Executes just before TimeFrequencyAnalysis is made visible.
function TimeFrequencyAnalysis_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to TimeFrequencyAnalysis (see VARARGIN)

% Choose default command line output for TimeFrequencyAnalysis
handles.output = hObject;
% handles.data=gfreadfile('file001只通道一干活-混合.lte');

handles.isFirst=1;
handles.isTaxis=0;
handles.isCross=0;
handles.isColorbar=0;
handles.isok=1;
handles.isTF=1;
handles.cdata=varargin{1};
figopt=varargin{2};
handles.isReverse=figopt.isReverse;
handles.icolormap=figopt.icolormap;
handles.igain=figopt.igain;
handles.isZero=figopt.isZero;

handles.ntr=size(handles.cdata,2);
handles.ns=size(handles.cdata,1);
%SetData=setptr('fullcrosshair ');
SetData=setptr('fullcrosshair');
set(gcf,SetData{:});

guidata(hObject,handles);
set(gcf,'CurrentAxes',handles.mainAxes);
imagesc(handles.cdata);
if handles.isReverse
    icolorflag=[handles.icolormap,'-'];
else
    icolorflag=handles.icolormap;
end

maxdat=max(max((handles.cdata)));
mindat=min(min((handles.cdata)));
ff=1./exp(handles.igain-1);
caxis([ff*mindat,ff*maxdat]);
if handles.isZero
    maxdat=max(max(abs(handles.cdata)));
    caxis([-ff*maxdat,ff*maxdat]);
end
icolormap=gfcolormap2(icolorflag);
colormap(icolormap);
xlabel('Trace Point');
set(gca,'XAxisLocation','top');

handles.ylimt=get(gca,'ylim');
handles.xlimt=get(gca,'xlim');
handles.pos=get(gcf,'Position');

if nargin==6
    handles.line=varargin{3};
    ix=(1:handles.ntr);
    hold on
    switch handles.icolormap
        case 'p'
            plot(ix,handles.line,'k','LineWidth',2);
        case 'j'
            plot(ix,handles.line,'k','LineWidth',2);
        case 'i'
            plot(ix,handles.line,'r','LineWidth',2);
        case 'g'
            plot(ix,handles.line,'b','LineWidth',2);
        case 'e'
            plot(ix,handles.line,'k','LineWidth',2);
    end
    hold off
end

guidata(hObject,handles);



% Update handles structure
% set(gcf,'CurrentAxes',handles.mainAxes);
% imagesc(handles.cdata);
% UIWAIT makes TimeFrequencyAnalysis wait for user response (see UIRESUME)
uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = TimeFrequencyAnalysis_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
function figure1_WindowButtonDownFcn(hObject, eventdata, handles)

ylimt=handles.ylimt;
xlimt=handles.xlimt;
gpos=get(handles.mainAxes,'Position');
cpos=get(gcf,'CurrentPoint');

if cpos(1)>gpos(1) && cpos(1)<gpos(1)+gpos(3) && ...
        cpos(2)>gpos(2) && cpos(2) <gpos(2)+gpos(4)
    loch=floor((cpos(1)-gpos(1))/gpos(3)*(xlimt(2)-xlimt(1))+xlimt(1)+0.5);
    locv=floor((gpos(2)+gpos(4)-cpos(2))/gpos(4)*(ylimt(2)-ylimt(1))+ylimt(1)+0.5);
    
    set(gcf,'CurrentAxes',handles.traceAxesh);
    trace=handles.cdata(locv,:);
    
    plot(trace,'b');
    maxdat=max(abs(trace));
    ylim([-maxdat,maxdat]);
    xlim(xlimt);
%     title(num2str(loch));
    set(gca,'XTick',[]);
    set(gca,'YTick',0);
    set(gca,'YTicklabel',num2str(locv));
    
    
    set(gcf,'CurrentAxes',handles.traceAxes);
    trace=handles.cdata(:,loch);
    
    plot(trace,'b');
    xlim(ylimt);
    maxdat=max(abs(trace));
    ylim([-maxdat,maxdat]);
    view(90,90);
    title(num2str(loch));
    set(gca,'XTick',[]);
    set(gca,'YTick',[]);
    
    if handles.isTF==1
        trace=hilbert(trace);
        [tfr,t,f]=tfrpwv2(trace);
        tfr=tfr(1:floor(size(tfr,1)/2),:);
        tfr=tfr';
        
        
        set(gcf,'CurrentAxes',handles.tfrAxes);
        nx=size(tfr,2);
        imagesc(tfr);
        
        maxdat=max(max((tfr)));
        mindat=min(min((tfr)));
        ff=1./exp(handles.igain);
        caxis([ff*mindat,ff*maxdat]);       
        set(gca,'YTick',[]);
        set(gca,'XTick',[1,floor(nx/2),nx]);
        set(gca,'XTicklabel',[0,0.25,0.5]);
        xlabel('Normalized Frequency');
        set(gca,'XAxisLocation','top');
        
        
        set(gcf,'CurrentAxes',handles.tfrtraceAxesh);
        trace=tfr(locv,:);
        
        plot(trace,'b');
        maxdat=max(abs(trace));
        ylim([-maxdat,maxdat]);
        xlim([1,length(trace)]);
        set(gca,'XTick',[]);
        set(gca,'YTick',[]);
    end
end

% --------------------------------------------------------------------
function uipushtool4_ClickedCallback(hObject, eventdata, handles)
% hObject    handle to uipushtool4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
pos=get(gcf,'Position');
if  handles.isTF==0
    handles.isTF=1;
    set(handles.tfrAxes,'Visible','on');
    set(handles.tfrtraceAxesh,'Visible','on');
    guidata(hObject,handles);
    set(gcf,'Position',handles.pos);
else
    handles.isTF=0;
    set(handles.tfrAxes,'Visible','off');
    set(handles.tfrtraceAxesh,'Visible','off');
    guidata(hObject,handles);
    set(gcf,'Position',[pos(1),pos(2),106,pos(4)]);
end
