function gfplot2_redraw(handles)
set(handles.figure1,'currentaxes',handles.axes1);
xlimt=get(handles.axes1,'xlim');
ylimt=get(handles.axes1,'ylim');

imagesc(handles.data);

maxdat=max(max((handles.data)));
mindat=min(min((handles.data)));
ff=1./exp(handles.igain-1);
if maxdat ~= mindat

if handles.iszero
    maxdat=max(max(abs(handles.data)));
    caxis([-ff*maxdat,ff*maxdat]);
else
    caxis([ff*mindat,ff*maxdat]);
end

end

set(handles.axes1,'xlim',xlimt);
set(handles.axes1,'ylim',ylimt);
set(handles.axes1,'XAxisLocation','top');
xlabel('Traces','Fontsize',14);
ylabel('Sample points','Fontsize',14);
end

