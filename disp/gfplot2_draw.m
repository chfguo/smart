function gfplot2_draw(handles)
set(handles.figure1,'currentaxes',handles.axes1);
imagesc(handles.data);
colormap(jet);
handles.isMotion = 0;
set(handles.axes1,'XAxisLocation','top');
xlabel('Traces','Fontsize',14);
ylabel('Sample points','Fontsize',14);

end

