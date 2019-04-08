function gfplot2_show1trace(handles,opt)

if nargin == 1
gpos=get(handles.axes1,'Position');
cpos=get(gcf,'CurrentPoint');

if cpos(1)>gpos(1) && cpos(1)<gpos(1)+gpos(3) && ...
        cpos(2)>gpos(2) && cpos(2) <gpos(2)+gpos(4)
    
    xlimt=floor(get(handles.axes1,'xlim'));
    ylimt=floor(get(handles.axes1,'ylim'));
    loch=floor((cpos(1)-gpos(1))/gpos(3)*(xlimt(2)-xlimt(1))+xlimt(1)+0.5);
    locv=floor((gpos(2)+gpos(4)-cpos(2))/gpos(4)*(ylimt(2)-ylimt(1))+ylimt(1)+0.5);
    set(handles.figure1,'currentaxes',handles.axes2);
    trace=handles.data(:,loch);
    plot(trace,'b');
    
    maxdat = max(abs(trace));
    if maxdat == 0
        maxdat = 1;
    end
    hold on
    plot(locv*ones(1,2),[-maxdat,maxdat],'r');
    hold off
    ylim([-maxdat,maxdat]);
    xlim(get(handles.axes1,'ylim'));
    set(handles.axes2,'YAxisLocation','right');
    set(handles.axes2,'XTick',[]);
    ylabel(num2str(loch),'Fontsize',14);
    view(90,90)
    set(handles.figure1,'currentaxes',handles.axes1);
end
elseif opt == 0
    set(handles.figure1,'currentaxes',handles.axes2);
trace = handles.data(:,1);
plot(trace,'b');
maxdat = max(abs(trace));
if maxdat == 0
    maxdat = 1;
end
ylim([-maxdat,maxdat]);
xlim(get(handles.axes1,'ylim'));
set(handles.axes2,'YAxisLocation','right');
set(handles.axes2,'XTick',[]);
ylabel(num2str(1),'Fontsize',14);
view(90,90)
set(handles.figure1,'currentaxes',handles.axes1)
end
end