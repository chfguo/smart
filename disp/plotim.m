function plotim(data,line)
%PLOTIMAGE
%   plotim(data,line)
if nargin == 1
    igain = 0.5;
    dpath = which('fzeros');
    load([dpath(1:end-8),'\disp\ICONS.mat'],'SMOOTHICON');
    load([dpath(1:end-8),'\disp\ICONS.mat'],'MEDFILTICON');
    h_fig = figure;
    imagesc(data);
    him = get(gca,'Children'); set(him,'CDataMapping','scaled');
    
    hImage = uimenu(h_fig,'Label','图像(&M)','Position',2);
    hm = uimenu(hImage,'Label','数据映射');
    hc = uimenu(hImage,'Label','调色板');
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
    
    set(h_fig,'WindowScrollWheelFcn',@figScroll);
    
    mindat=min(min(data));
    maxdat=max(max(data));
    caxis([igain*mindat,igain*maxdat]);
    colormap(jet);
    set(gca,'xaxislocation','top');
    ht = uitoolbar(h_fig);
    uipushtool(ht,'CDATA',SMOOTHICON,'TooltipString','平滑','ClickedCallback',@hptsmooth);
    uipushtool(ht,'CDATA',MEDFILTICON,'TooltipString','中值滤波','ClickedCallback',@hptmedfilt2);
end

    function hptmedfilt2(hObject,callbackdata)
        data = medfilt2(data);
        mindat=min(min(data));
        maxdat=max(max(data));
        imagesc(data);
        set(gca,'xaxislocation','top');
        caxis([igain*mindat,igain*maxdat]);
    end
    function hptsmooth(hObject,callbackdata)
        data = gfsmooth(data);
        mindat=min(min(data));
        maxdat=max(max(data));
        imagesc(data);
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



if nargin == 2
    
    igain = 0.5;
    dpath = which('fzeros');
    load([dpath(1:end-8),'\disp\ICONS.mat'],'SMOOTHICON');
    load([dpath(1:end-8),'\disp\ICONS.mat'],'MEDFILTICON');
    h_fig = figure;
    imagesc(data);
    
    
    hImage = uimenu(h_fig,'Label','图像(&M)','Position',2);
    hm = uimenu(hImage,'Label','数据映射');
    hc = uimenu(hImage,'Label','调色板');
    uimenu(hm,'Label','Scaled','Accelerator','r','Callback',...
        'him = get(gca,''Children''); set(him(2),''CDataMapping'',''scaled'')');
    uimenu(hm,'Label','Direct','Accelerator','d','Callback',...
        'him = get(gca,''Children''); set(him(2),''CDataMapping'',''direct'')');
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
    
    set(h_fig,'WindowScrollWheelFcn',@figScroll);
    
    mindat=min(min(data));
    maxdat=max(max(data));
    caxis([igain*mindat,igain*maxdat]);
    colormap(jet);
    set(gca,'xaxislocation','top');
    ht = uitoolbar(h_fig);
    uipushtool(ht,'CDATA',SMOOTHICON,'TooltipString','平滑','ClickedCallback',@hptsmooth);
    uipushtool(ht,'CDATA',MEDFILTICON,'TooltipString','中值滤波','ClickedCallback',@hptmedfilt2);
    
    
    
    hL = uimenu(h_fig,'Label','曲线(&L)','Position',3);
    hLColor = uimenu(hL,'Label','颜色');
    hLWidth = uimenu(hL,'Label','宽度');
    hLStyle = uimenu(hL,'Label','样式');
    uimenu(hLColor,'Label','红色','Callback',...
        'hline = get(gca,''Children''); set(hline(1),''Color'',[1 0 0])');
    uimenu(hLColor,'Label','蓝色','Callback',...
        'hline = get(gca,''Children''); set(hline(1),''Color'',[0 0 1])');
    uimenu(hLColor,'Label','绿色','Callback',...
        'hline = get(gca,''Children''); set(hline(1),''Color'',[0 1 0])');
    uimenu(hLColor,'Label','黄色','Callback',...
        'hline = get(gca,''Children''); set(hline(1),''Color'',[1 1 0])');
    uimenu(hLColor,'Label','品红','Callback',...
        'hline = get(gca,''Children''); set(hline(1),''Color'',[1 0 1])');
    uimenu(hLColor,'Label','青色','Callback',...
        'hline = get(gca,''Children''); set(hline(1),''Color'',[0 1 1])');
    uimenu(hLColor,'Label','黑色','Callback',...
        'hline = get(gca,''Children''); set(hline(1),''Color'',[0 0 0])');
    uimenu(hLColor,'Label','白色','Callback',...
        'hline = get(gca,''Children''); set(hline(1),''Color'',[1 1 1])');
    uimenu(hLWidth,'Label','0.25','Callback',...
        'hline = get(gca,''Children''); set(hline(1),''LineWidth'',0.25)');
    uimenu(hLWidth,'Label','0.5','Callback',...
        'hline = get(gca,''Children''); set(hline(1),''LineWidth'',0.5)');
    uimenu(hLWidth,'Label','1','Callback',...
        'hline = get(gca,''Children''); set(hline(1),''LineWidth'',1)');
    uimenu(hLWidth,'Label','2','Callback',...
        'hline = get(gca,''Children''); set(hline(1),''LineWidth'',2)');
    uimenu(hLWidth,'Label','4','Callback',...
        'hline = get(gca,''Children''); set(hline(1),''LineWidth'',4)');
    uimenu(hLWidth,'Label','8','Callback',...
        'hline = get(gca,''Children''); set(hline(1),''LineWidth'',8)');
    uimenu(hLWidth,'Label','16','Callback',...
        'hline = get(gca,''Children''); set(hline(1),''LineWidth'',16)');
    uimenu(hLStyle,'Label','实线','Callback',...
        'hline = get(gca,''Children''); set(hline(1),''LineStyle'',''-'')');
    uimenu(hLStyle,'Label','虚线','Callback',...
        'hline = get(gca,''Children''); set(hline(1),''LineStyle'',''--'')');
    uimenu(hLStyle,'Label','点线','Callback',...
        'hline = get(gca,''Children''); set(hline(1),''LineStyle'','':'')');
    uimenu(hLStyle,'Label','点画线','Callback',...
        'hline = get(gca,''Children''); set(hline(1),''LineStyle'',''-.'')');
    hold on
    plot(line,'r','LineWidth',2)
    hold off
    him = get(gca,'Children'); set(him(2),'CDataMapping','scaled');
end

end





