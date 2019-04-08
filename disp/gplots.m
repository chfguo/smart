function gplots(data)
%IMAGE
%   gplotim(varargin)

handle_plot = @imagesc;
type_plot = 1;
igain = 0.5;
dpath = which('fzeros');
load([dpath(1:end-8),'\disp\ICONS.mat'],'SMOOTHICON');
load([dpath(1:end-8),'\disp\ICONS.mat'],'MEDFILTICON');
load([dpath(1:end-8),'\disp\ICONS.mat'],'RMBGICON');
h_fig = figure;
handle_plot(data);
him = get(gca,'Children'); set(him,'CDataMapping','scaled');

hImage = uimenu(h_fig,'Label','图像(&M)','Position',2);
hm = uimenu(hImage,'Label','数据映射');
hc = uimenu(hImage,'Label','调色板');
ht = uimenu(hImage,'Label','其他显示');

uimenu(hm,'Label','Scaled','Accelerator','r','Callback',...
    'him = get(gca,''Children''); set(him,''CDataMapping'',''scaled'')');
uimenu(hm,'Label','Direct','Accelerator','d','Callback',...
    'him = get(gca,''Children''); set(him,''CDataMapping'',''direct'')');


uimenu(hc,'Label','Jet','Callback',...
    'colormap(jet)');
uimenu(hc,'Label','Gray','Callback',...
    'colormap(gray)');
uimenu(hc,'Label','Flash','Callback',...
    'colormap(gfcolormap2(''g''))');
uimenu(hc,'Label','Parula','Callback',...
    'colormap(gfcolormap2(''p''))');
uimenu(hc,'Label','VJet','Callback',...
    'colormap(gfcolormap2(''v''))');
uimenu(ht,'Label','plot','Callback',...
    @figplot);
uimenu(ht,'Label','image','Callback',...
    @figimage);
uimenu(ht,'Label','surf','Callback',...
    @figsurf);
uimenu(ht,'Label','surfc','Callback',...
    @figsurfc);
uimenu(ht,'Label','contour','Callback',...
    @figcontour);
uimenu(ht,'Label','mesh','Callback',...
    @figmesh);
set(h_fig,'WindowScrollWheelFcn',@figScroll);

mindat=min(min(data));
maxdat=max(max(data));
caxis([igain*mindat,igain*maxdat]);
colormap(jet);
set(gca,'xaxislocation','top');
ht = uitoolbar(h_fig);
uipushtool(ht,'CDATA',SMOOTHICON,'TooltipString','平滑','ClickedCallback',@hptsmooth);
uipushtool(ht,'CDATA',MEDFILTICON,'TooltipString','中值滤波','ClickedCallback',@hptmedfilt2);
uipushtool(ht,'CDATA',RMBGICON,'TooltipString','背景消除','ClickedCallback',@hptrmbg);

    function hptmedfilt2(hObject,callbackdata)
        data = medfilt2(data);
        mindat=min(min(data));
        maxdat=max(max(data));
        handle_plot(data);
        if type_plot == 2
            shading interp;
        end
        set(gca,'xaxislocation','top');
        caxis([igain*mindat,igain*maxdat]);
    end

    function hptsmooth(hObject,callbackdata)
        data = gfsmooth(data);
        mindat=min(min(data));
        maxdat=max(max(data));
        handle_plot(data);
        if type_plot == 2
            shading interp;
        end
        set(gca,'xaxislocation','top');
        caxis([igain*mindat,igain*maxdat]);
    end

    function figScroll(src,callbackdata)
        if callbackdata.VerticalScrollCount > 0
            igain = igain * 1.1;
        else
            igain = igain * 0.9;
        end
        caxis([igain*mindat,igain*maxdat]);
    end

    function hptrmbg(hObject,callbackdata)
        data = rmbg(data);
        mindat=min(min(data));
        maxdat=max(max(data));
        handle_plot(data);
        if type_plot == 2
            shading interp;
        end
        set(gca,'xaxislocation','top');
        caxis([igain*mindat,igain*maxdat]);
    end

    function figsurf(hObject,callbackdata)
        mindat=min(min(data));
        maxdat=max(max(data));
        handle_plot=@surf;
        handle_plot(data);
        shading interp;
        type_plot = 2;
        caxis([igain*mindat,igain*maxdat]);
    end

    function figmesh(hObject,callbackdata)
        mindat=min(min(data));
        maxdat=max(max(data));
        handle_plot=@mesh;
        handle_plot(data);
        type_plot = 2;
        shading interp;
        caxis([igain*mindat,igain*maxdat]);
    end

    function figsurfc(hObject,callbackdata)
        mindat=min(min(data));
        maxdat=max(max(data));
        handle_plot=@surfc;
        handle_plot(data);
        type_plot = 2;
        shading interp;
        caxis([igain*mindat,igain*maxdat]);
    end

    function figcontour(hObject,callbackdata)
        mindat=min(min(data));
        maxdat=max(max(data));
        handle_plot=@contour;
        type_plot = 1;
        handle_plot(data);
        set(gca,'xaxislocation','top');
        caxis([igain*mindat,igain*maxdat]);
    end

    function figimage(hObject,callbackdata)
        mindat=min(min(data));
        maxdat=max(max(data));
        handle_plot=@imagesc;
        type_plot = 1;
        handle_plot(data);
        set(gca,'xaxislocation','top');
        caxis([igain*mindat,igain*maxdat]);
    end
    function figplot(hObject,callbackdata)
        figure
        plot(data);
    end
end