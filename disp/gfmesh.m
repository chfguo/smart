function  gfmesh(dat,iconfig)
%GFMESH  3-D mesh surface
%   call :
%   gfplot2d(dat,iconfig)
%   iconfig is a structure that cntains all the parameters see
%   gfplot2dconfig for detailed information.
%  
%   Example:
%   dat=gfin('vp,segy');
%   icfg=gfgfplot2dconfig();
%   icfg.icolor='g-';
%   icfg.fileformat={'jpg','eps'};
%   icfg.filename='example'
%   ......
%   gfmesh(dat,icfg);
%
%
%   Version: V1.0
%   Author : C.F.Guo
%   Time   : 2015/11/19
%
% ------------------------------NOTE---------------------------------------
%
% This is a subroutine of Seismic Modeling and Research Toolkit (SMART),
% It is illegal for you to use this software tool (Seismic Modeling and 
% Research Toolkit,SMART) for a purpose other than non-profit education 
% or research UNLESS you are authorized by the Seismic Modeling Project.If 
% you find any problems, please connect the Author(s): chf_guo@163.com
% 
% by C.F. Guo, 2015
% 
% Copyright(C) 2015 Elastic Wave Expolration Project (EWEP)
% China University of Petroleum(East China)
% 
% ------------------------------END----------------------------------------


igain=iconfig.igain;
if iconfig.fontsize==0
    fsmainaxis=iconfig.fsmainaxis;
    fsmainlabel=iconfig.fsmainlabel;
    fsmaintitle=iconfig.fsmaintitle;
    fsbarlabel=iconfig.fsbarlabel;
    fsbaraxis=iconfig.fsbaraxis;
    fsbarunit=iconfig.fsbarunit;
else
    fsmainaxis=iconfig.fontsize;
    fsmainlabel=iconfig.fontsize+2;
    fsmaintitle=iconfig.fontsize+2;
    fsbarlabel=iconfig.fontsize+2;
    fsbaraxis=iconfig.fontsize;
    fsbarunit=iconfig.fontsize;
end

[Nz,Nx]=size(dat);
idx=iconfig.idx;
idz=iconfig.idz;
iox=iconfig.iox;
ioz=iconfig.ioz;
ixlabel=iconfig.ixlabel;
izlabel=iconfig.izlabel;
ixaxis=(0:Nx-1)*idx+iox;
izaxis=(0:Nz-1)*idz+ioz;
[Z,X]=meshgrid(ixaxis,izaxis);
figure;
maxdat=max(max(dat));
mindat=min(min(dat));
mesh(Z,X,double(dat));
set(gca,'TickDirMode','manual','TickDir','out');
set(gca,'XAxisLocation','top');
set(gca,'Fontsize',fsmainaxis,'Fontname',iconfig.fontname);
xlabel(ixlabel,'Fontsize',fsmainlabel,'Fontname',iconfig.fontname);
ylabel(izlabel,'Fontsize',fsmainlabel,'Fontname',iconfig.fontname);
zlabel(iconfig.itlabel,'Fontsize',fsmainlabel,'Fontname',iconfig.fontname);
if strcmp(iconfig.isfillup,'y')
     set(gca,'xticklabel',sprintf('%03.2f|',get(gca,'xtick')),'XTick',get(gca,'xtick'))
     set(gca,'yticklabel',sprintf('%03.2f|',get(gca,'ytick')),'YTick',get(gca,'ytick'))
end
set(gcf, 'PaperPositionMode', 'manual');
set(gcf, 'PaperUnits', 'points');
scsize=get(0,'screensize');
switch iconfig.isnormal % Figure size ( if the size is beyond the size of the screen
    % the default lagerset size is the screen's size )
    case 'n'
        Nxs=iconfig.ixscale*Nx;
        Nzs=iconfig.izscale*Nz;
        Px=scsize(3)/2-Nxs/2;
        Pz=scsize(4)/2-Nzs/2;
        set(gcf,'Position',[Px Pz Nxs Nzs]);
        set(gcf,'PaperPosition',[Px Pz Nxs Nzs]);
    case 'y'
        Nxs=iconfig.ixscale*Nx;
        Nzs=iconfig.izscale*Nz;
        maxs=max(Nz,Nx);
        if maxs<500
            Nxs=650;
            Nzs=Nxs/Nx*Nz;
        end
        Px=scsize(3)/2-Nxs/2;
        Pz=scsize(4)/2-Nzs/2;
       
        set(gcf,'Position',[Px Pz Nxs Nzs]);
        set(gcf,'PaperPosition',[Px Pz Nxs Nzs]);
    otherwise
        Nzs=500;
        Nxs=650;
        Px=scsize(3)/2-Nxs/2;
        Pz=scsize(4)/2-Nzs/2;
        set(gcf,'Position',[Px Pz Nxs Nzs]);
        set(gcf,'PaperPosition',[Px Pz Nxs Nzs]);
end
icolormap=gfcolormap(iconfig);
colormap(icolormap);
caxis([igain*mindat,igain*maxdat]);
if strcmp(iconfig.iscolorbar,'y')
    switch iconfig.ibarpos
        case 'left'
            icolorbar=colorbar('WestOutside','Fontsize',fsbaraxis,'Fontname',iconfig.fontname);
            icolorytick=get(icolorbar,'ytick')/igain;
            if strcmp(iconfig.isbarlabel,'y')
                set(get(icolorbar,'YLabel'),'string',iconfig.ibarlabel,'Fontsize',fsbarlabel);
            end
            if (abs(icolorytick(1))>10000 || abs(icolorytick(1))>10000<0.0001)
                oldLabels = icolorytick;
                exps=log10(abs(icolorytick(1)));
                if exps<0
                    scale=10^floor(exps);
                else
                    scale=10^ceil(exps);
                end
                newLabels = oldLabels/scale;
                set(icolorbar,'YTickLabel',newLabels);
                posAxes = get(icolorbar,'position');
                textBox = annotation('textbox','linestyle','none','string',['x 10 ^{' sprintf('%d',log10(scale)) '}'],'Fontsize',fsmainaxis,'Fontname',iconfig.fontname);
                posAn = get(textBox,'position');
                set(textBox,'position',[posAxes(1)+posAxes(3) posAxes(2)+posAxes(4)-posAn(4)/2 posAn(3) posAn(4)],'VerticalAlignment','cap');
            end
            if strcmp(iconfig.isunit,'y')
                set(get(icolorbar,'Title'),'string',iconfig.iunit,'Fontsize',fsbarunit);
            end
        case 'top'
            icolorbar=colorbar('NorthOutside','Fontsize',fsbaraxis,'Fontname',iconfig.fontname);
            icolorytick=get(icolorbar,'xtick')/igain;
            if strcmp(iconfig.isbarlabel,'y')
                set(get(icolorbar,'XLabel'),'string',iconfig.ibarlabel,'Fontsize',fsbarlabel);
            end
            if (abs(icolorytick(1))>10000 || abs(icolorytick(1))>10000<0.0001)
                oldLabels = icolorytick;
                exps=log10(abs(icolorytick(1)));
                if exps<0
                    scale=10^floor(exps);
                else
                    scale=10^ceil(exps);
                end
                newLabels = oldLabels/scale;
                set(icolorbar,'XTickLabel',newLabels);
                posAxes = get(icolorbar,'position');
                textBox = annotation('textbox','linestyle','none','string',['x 10 ^{' sprintf('%d',log10(scale)) '}'],'Fontsize',fsmainaxis,'Fontname',iconfig.fontname);
                posAn = get(textBox,'position');
                set(textBox,'position',[posAxes(1)+posAxes(3) posAxes(2)+posAxes(4)-posAn(4)/2 posAn(3) posAn(4)],'VerticalAlignment','cap');
            end
            if strcmp(iconfig.isunit,'y')
                set(get(icolorbar,'YLabel'),'string',iconfig.iunit,'Fontsize',fsbarunit);
            end
        case 'bottom'
            icolorbar=colorbar('SouthOutside','Fontsize',fsbaraxis,'Fontname',iconfig.fontname);
            icolorytick=get(icolorbar,'xtick')/igain;
            if strcmp(iconfig.isbarlabel,'y')
                set(get(icolorbar,'XLabel'),'string',iconfig.ibarlabel,'Fontsize',fsbarlabel);
            end
            if (abs(icolorytick(1))>10000 || abs(icolorytick(1))>10000<0.0001)
                oldLabels = icolorytick;
                exps=log10(abs(icolorytick(1)));
                if exps<0
                    scale=10^floor(exps);
                else
                    scale=10^ceil(exps);
                end
                newLabels = oldLabels/scale;
                set(icolorbar,'XTickLabel',newLabels);
                posAxes = get(icolorbar,'position');
                textBox = annotation('textbox','linestyle','none','string',['x 10 ^{' sprintf('%d',log10(scale)) '}'],'Fontsize',fsmainaxis,'Fontname',iconfig.fontname);
                posAn = get(textBox,'position');
                set(textBox,'position',[posAxes(1)+posAxes(3) posAxes(2)+posAxes(4)-posAn(4)/2 posAn(3) posAn(4)],'VerticalAlignment','cap');
            end
            if strcmp(iconfig.isunit,'y')
                set(get(icolorbar,'YLabel'),'string',iconfig.iunit,'Fontsize',fsbarunit);
            end
        otherwise
            icolorbar=colorbar('EastOutside','Fontsize',fsbaraxis,'Fontname',iconfig.fontname);
            icolorytick=get(icolorbar,'ytick')/igain;
            if strcmp(iconfig.isbarlabel,'y')
                set(get(icolorbar,'YLabel'),'string',iconfig.ibarlabel,'Fontsize',fsbarlabel);
            end
            if (abs(icolorytick(1))>10000 || abs(icolorytick(1))>10000<0.0001)
                oldLabels = icolorytick;
                exps=log10(abs(icolorytick(1)));
                if exps<0
                    scale=10^floor(exps);
                else
                    scale=10^ceil(exps);
                end
                newLabels = oldLabels/scale;
                set(icolorbar,'YTickLabel',newLabels);
                posAxes = get(icolorbar,'position');
                textBox = annotation('textbox','linestyle','none','string',['x 10 ^{' sprintf('%d',log10(scale)) '}'],'Fontsize',fsmainaxis,'Fontname',iconfig.fontname);
                posAn = get(textBox,'position');
                set(textBox,'position',[posAxes(1)+posAxes(3) posAxes(2)+posAxes(4)-posAn(4)/2 posAn(3) posAn(4)],'VerticalAlignment','cap');
            end
            if strcmp(iconfig.isunit,'y')
                set(get(icolorbar,'Title'),'string',iconfig.iunit,'Fontsize',fsbarunit);
            end
    end
    set(icolorbar,'TickDirMode','manual','TickDir','out');
    set(icolorbar,'box','off');
end

if strcmp(iconfig.istitle,'y')
    switch iconfig.ititlepos
        case 'bottom'
            if strcmp(iconfig.ibarpos,'bottom')
                title(iconfig.ititle,'Fontsize',fsmaintitle,'Fontname',iconfig.fontname);
            else
                posx=0.5*(ixaxis(1)+ixaxis(end));
                posz=1.05*izaxis(end);
                title(iconfig.ititle,'position',[posx,posz],'Fontsize',fsmaintitle,'Fontname',iconfig.fontname);
            end
        otherwise
            title(iconfig.ititle,'Fontsize',fsmaintitle,'Fontname',iconfig.fontname);
    end
end

shading interp;


nout=numel(iconfig.fileformat);

for in=1:nout
    subfix=iconfig.fileformat{in};
    switch subfix
        case 'pdf'
            print('-dpdf',[iconfig.filename,'.pdf']);
        case 'eps'
           print('-r300','-depsc2',[iconfig.filename,'.eps']);
        case 'png'
           print('-r300','-dpng',[iconfig.filename,'.png']);
        case 'tif'
           print('-r300','-dtiff',[iconfig.filename,'.tif']);
        otherwise 
           print('-r300','-djpeg',[iconfig.filename,'.jpg']);
    end
end
end




