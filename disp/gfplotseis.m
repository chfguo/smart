function  gfplotseis(handles)
%GFPLOTSEIS Summary of this function goes here
%   Detailed explanation goes here


%* axesPro.FontNamePopupmenu=2;
%* axesPro.WeightPopupmenu=3;
%* axesPro.AnglePopupmenu=2;
%* axesPro.xLabelEdit='Distance(Km)';
%* axesPro.yLabelEdit='Depth(Km)';
%* axesPro.xySizePopupmenu=12;
%
%* axesPro.xStartEdit=0.0;
%* axesPro.yStartEdit=0.0;
%* axesPro.xStepEdit=0.01;
%* axesPro.yStepEdit=0.01;
%* axesPro.mainSizePopupmenu=10;
%
%* axesPro.barLabelEdit='Amplitude';
%* axesPro.barSizePopupmenu=8;
%
%* axesPro.titleSizePopupmenu=12;
%* axesPro.titleEdit=[];

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

line([xend-abs(xstart/2),xend-abs(xstart/2)],[zstart,zend],'color',[0 0 0],'linewidth',handles.axesPro.LineWidthEdit);
line([xstart,xend],[zend-abs(zstart/2),zend-abs(zstart/2)],'color',[0 0 0],'linewidth',handles.axesPro.LineWidthEdit);


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
     icolorbar=colorbar('Fontsize',handles.axesPro.barSizePopupmenu,'Fontname',fontname,...
         'FontWeight',weight,'FontAngle',angle);
     set(get(icolorbar,'YLabel'),'string',handles.axesPro.barLabelEdit,'Fontname',fontname,...
         'FontWeight',weight,'FontAngle',angle,'Fontsize',handles.axesPro.barSizePopupmenu);
end

if ~isempty(handles.axesPro.titleEdit)
    th=title(handles.axesPro.titleEdit);
    set(th,'FontSize',handles.axesPro.titleSizePopupmenu,'Fontname',fontname,...
        'FontWeight',weight,'FontAngle',angle);
    title(th,'position',[(xstart+xend)/2,zend]);
    
end


end
    
