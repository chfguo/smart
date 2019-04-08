function  gfplot3d(dat,iconfig)
%GFPLOT3D display 3d seismic data as image
%   call :
%   gfplot3d(dat,iconfig)
%   iconfig is a structure that cntains all the parameters see
%   gfplot2dconfig for detailed information.
%
%   Example:
%   dat=gfin('vp,segy');
%   icfg=gfgfplot3dconfig();
%   icfg.icolor='g-';
%   icfg.fileformat={'jpg','eps'};
%   icfg.filename='example'
%   ......
%   gfplot3d(dat,icfg);
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
icolormap=gfcolormap(iconfig);

igain=iconfig.igain;
if iconfig.fontsize==0
    fsmainaxis=iconfig.fsmainaxis;
    fsmainlabel=iconfig.fsmainlabel;
    fsbarlabel=iconfig.fsbarlabel;
    fsbaraxis=iconfig.fsbaraxis;
    fsbarunit=iconfig.fsbarunit;
else
    fsmainaxis=iconfig.fontsize;
    fsmainlabel=iconfig.fontsize+2;
    fsbarlabel=iconfig.fontsize-1;
    fsbaraxis=iconfig.fontsize;
    fsbarunit=iconfig.fontsize;
end

if iconfig.mlcolor==-1
    mlcolor=icolormap(ceil(iconfig.iprecision/2),:);
else
    mlcolor=iconfig.mlcolor;
end

[Nz,Nx,Ny]=size(dat);
idx=iconfig.idx;
idy=iconfig.idy;
idz=iconfig.idz;
isx=iconfig.isx;
isy=iconfig.isy;
isz=iconfig.isz;
if isx==0
    isx=Nx;
end
if isy==0;
    isy=1;
end
if isz==0
    isz=1;
end
if isx>Nx
    nnerr.throw('isx must be samller than Nx');
end
if isy>Ny
    nnerr.throw('isy must be samller than Ny');
end
if isz>Nz
    nnerr.throw('isz must be samller than Nz');
end
fontdat=reshape(dat(:,:,isy),Nz,Nx);
plandat=reshape(dat(isz,:,:),Nx,Ny)';
leftdat=reshape(dat(:,isx,:),Nz,Ny);

iox=iconfig.iox;
ioy=iconfig.ioy;
ioz=iconfig.ioz;
ixlabel=iconfig.ixlabel;
iylabel=iconfig.iylabel;
izlabel=iconfig.izlabel;
ixaxis=(0:Nx)*idx+iox;
iyaxis=(1:Ny+1)*idy+ioy;
izaxis=(0:Nz)*idz+ioz;

maxdat=max(max(max(dat)));
mindat=max(min(min(dat)));
figure();
fig1=subplot(2,2,1);
imagesc(ixaxis,iyaxis,plandat);
axis xy
set(gca,'TickDirMode','manual','TickDir','out');
set(gca,'XTick',[]);
set(gca,'Fontsize',fsmainaxis,'Fontname',iconfig.fontname);
ylabel(iylabel,'Fontsize',fsmainlabel,'Fontname',iconfig.fontname);
box off
pos1=get(fig1,'position');
set(gca,'Position',[pos1(1) pos1(2) iconfig.ixscale*pos1(3) iconfig.iyscale*pos1(4)]);
pos1=get(fig1,'position');
if strcmp(iconfig.isfillup,'y')
    set(gca,'yticklabel',sprintf('%03.2f|',get(gca,'ytick')),'YTick',get(gca,'ytick'))
end
colormap(icolormap);
if strcmp(iconfig.iszero,'n')
    caxis([igain*mindat,igain*maxdat]);
else
    caxis([-igain*maxdat,igain*maxdat]);
end

line([ixaxis(1)-idx,ixaxis(end)+idx],[iyaxis(end),iyaxis(end)],'color',[0 0 0]);
line([ixaxis(end),ixaxis(end)],[iyaxis(1)-idy,iyaxis(end)+idy],'color',[0 0 0]);
if strcmp(iconfig.isml,'y')
    %marked line
    line([ixaxis(1)-idx,ixaxis(end)+idx],[iyaxis(isy),iyaxis(isy)],'color',mlcolor);
    line([ixaxis(isx),ixaxis(isx)],[iyaxis(1)-idy,iyaxis(end)+idy],'color',mlcolor);
end
fig2=subplot(2,2,3);
imagesc(ixaxis,izaxis,fontdat);
set(gca,'TickDirMode','manual','TickDir','out');
set(gca,'Fontsize',fsmainaxis,'Fontname',iconfig.fontname);
ylabel(izlabel,'Fontsize',fsmainlabel,'Fontname',iconfig.fontname);
xlabel(ixlabel,'Fontsize',fsmainlabel,'Fontname',iconfig.fontname);
box off
pos2=get(fig2,'position');
set(gca,'Position',[pos2(1) pos2(2) pos1(3) iconfig.izscale*pos2(4)]);
pos2=get(fig2,'position');
if strcmp(iconfig.isfillup,'y')
    set(gca,'xticklabel',sprintf('%03.2f|',get(gca,'xtick')),'XTick',get(gca,'xtick'))
    set(gca,'yticklabel',sprintf('%03.2f|',get(gca,'ytick')),'YTick',get(gca,'ytick'))
end
line([ixaxis(1)-idx,ixaxis(end)+idx],[izaxis(1),izaxis(1)],'color',[0 0 0]);
if strcmp(iconfig.isml,'y')
    %marked line
    line([ixaxis(1)-idx,ixaxis(end)+idx],[izaxis(isz),izaxis(isz)],'color',mlcolor);
    line([ixaxis(isx),ixaxis(isx)],[izaxis(1)-idz,izaxis(end)+idz],'color',mlcolor);
end
if strcmp(iconfig.iszero,'n')
    caxis([igain*mindat,igain*maxdat]);
else
    caxis([-igain*maxdat,igain*maxdat]);
end

fig3=subplot(2,2,4);
imagesc(iyaxis,izaxis,leftdat);
set(gca,'TickDirMode','manual','TickDir','out');
set(gca,'Fontsize',fsmainaxis,'Fontname',iconfig.fontname);
set(gca,'YTick',[]);
xlabel(iylabel,'Fontsize',fsmainlabel,'Fontname',iconfig.fontname);
box off
pos3=get(fig3,'position');
pos=get(gcf,'position');
dwratio=pos(4)/pos(3);
if strcmp(iconfig.isequaly,'y')
    set(gca,'Position',[pos3(1) pos3(2) dwratio*pos1(4) pos2(4)]);
else
    set(gca,'Position',[pos3(1) pos3(2) pos1(3) pos2(4)]);
end
pos3=get(fig3,'position');
if strcmp(iconfig.isfillup,'y')
    set(gca,'xticklabel',sprintf('%03.2f|',get(gca,'xtick')),'XTick',get(gca,'xtick'));
end
line([iyaxis(1)-idy,iyaxis(end)+idy],[izaxis(1),izaxis(1)],'color',[0 0 0]);
line([iyaxis(end),iyaxis(end)],[izaxis(1)-idz,izaxis(end)+idz],'color',[0 0 0]);
if strcmp(iconfig.isml,'y')
    %marked line
    line([iyaxis(1)-idx,iyaxis(end)+idx],[izaxis(isz),izaxis(isz)],'color',mlcolor);
    line([iyaxis(isy),iyaxis(isy)],[izaxis(1)-idz,izaxis(end)+idz],'color',mlcolor);
end
if strcmp(iconfig.iszero,'n')
    caxis([igain*mindat,igain*maxdat]);
else
    caxis([-igain*maxdat,igain*maxdat]);
end

set(fig1,'position',[1.4*pos1(1),1.8*pos2(2)+pos2(4),pos1(3),pos1(4)]);
set(fig2,'position',[1.4*pos2(1),1.8*pos2(2),pos2(3),pos2(4)]);
set(fig3,'position',[1.4*pos2(1)+pos2(3),1.8*pos3(2),pos3(3),pos3(4)]);
pos3=get(fig3,'position');
if strcmp(iconfig.iscolorbar,'y')
    icolorbar=colorbar('WestOutside','Fontsize',fsbaraxis,'Fontname',iconfig.fontname);
    cpos=get(icolorbar,'position');
    set(icolorbar,'position',[pos3(1)+1.05*pos3(3),cpos(2) cpos(3) cpos(4)]);
    set(icolorbar,'YAxisLocation','right');
    icolorytick=get(icolorbar,'ytick')/igain;
    if strcmp(iconfig.isbarlabel,'y')
        set(get(icolorbar,'YLabel'),'string',iconfig.ibarlabel,'Fontsize',fsbarlabel);
    end
    if (max(abs(icolorytick))>10000 || max(abs(icolorytick))<0.0001)
        oldLabels = icolorytick;
        exps=log10(abs(icolorytick(1)));
        if exps<0
            scale=10^floor(exps);
        else
            scale=10^floor(exps);
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
    if strcmp(iconfig.isfillup,'y')
        set(icolorbar,'yticklabel',sprintf('%03.2f|',get(icolorbar,'ytick')),'YTick',get(icolorbar,'ytick'));
    end
    
end

nout=numel(iconfig.fileformat);

for in=1:nout
    subfix=iconfig.fileformat{in};
    switch subfix
        case 'pdf'
            print(gcf,'-r720','-depsc2',[iconfig.filename,'.eps']);
            [result,msg]=eps2pdf([iconfig.filename,'.eps']);
            if result~=0
                disp(msg);
            end
        case 'eps'
            print('-r720','-depsc2',[iconfig.filename,'.eps']);
        case 'png'
            print('-r720','-dpng',[iconfig.filename,'.png']);
        case 'tif'
            print('-r720','-dtiff',[iconfig.filename,'.tif']);
        otherwise
            print('-r720','-djpeg',[iconfig.filename,'.jpg']);
    end
end
end




