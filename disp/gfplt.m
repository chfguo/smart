function gfplt(handles)
x=handles.start:handles.end;
y=handles.startZ:handles.endZ;

imagesc(x,y,handles.data(y,x));
maxdat=max(max((handles.data(y,x))));
mindat=min(min((handles.data(y,x))));
ff=1./exp(handles.displayigain-1);
caxis([ff*mindat,ff*maxdat]);
set(gca,'XAxisLocation','top');
set(gca,'TickDirMode','manual','TickDir','out');
box off

end

