function icolormap = gfcolormap(iconfig)
%GFCOLORMAP return a colormap for gfplot2d
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

iprecision=iconfig.iprecision;
icolormap=zeros(iprecision,3);  % define the iprecision-by-3 colormap matrix
isfind=strfind(iconfig.icolor,'-');
if numel(iconfig.icolor)==2
    for i=1:2
        if iconfig.icolor(i)~='-'
            flag=iconfig.icolor(i);
        end
    end
else
    flag=iconfig.icolor(1);
end

switch flag
    case 'e'     % e for blue-white-red
        color_r = linspace(0,1,iprecision/2);
        color_g = linspace(0,1,iprecision/2);
        color_b = linspace(1,1,iprecision/2);
        icolormap(1:iprecision/2,1) = color_r;
        icolormap(1:iprecision/2,2) = color_g;
        icolormap(1:iprecision/2,3) = color_b;
        
        color_r = linspace(1,1,iprecision/2);
        color_g = linspace(1,0,iprecision/2);
        color_b = linspace(1,0,iprecision/2);
        icolormap(iprecision/2+1:iprecision,1) = color_r;
        icolormap(iprecision/2+1:iprecision,2) = color_g;
        icolormap(iprecision/2+1:iprecision,3) = color_b;
        
    case 'g' % g for black-white-red
        color_r = linspace(0,1,iprecision/2);
        color_g = linspace(0,1,iprecision/2);
        color_b = linspace(0,1,iprecision/2);
        icolormap(1:iprecision/2,1) = color_r;
        icolormap(1:iprecision/2,2) = color_g;
        icolormap(1:iprecision/2,3) = color_b;
        
        color_r = linspace(1,1,iprecision/2);
        color_g = linspace(1,0,iprecision/2);
        color_b = linspace(1,0,iprecision/2);
        icolormap(iprecision/2+1:iprecision,1) = color_r;
        icolormap(iprecision/2+1:iprecision,2) = color_g;
        icolormap(iprecision/2+1:iprecision,3) = color_b;
    case 'i'  % i for black-white
        color_r = linspace(0,1,iprecision);
        color_g = linspace(0,1,iprecision);
        color_b = linspace(0,1,iprecision);
        icolormap(1:iprecision,1) = color_r;
        icolormap(1:iprecision,2) = color_g;
        icolormap(1:iprecision,3) = color_b;
    case 'p'  % p for parula
        icolormap=gparula(iprecision);
    otherwise  % j for Jet
        icolormap=jet(iprecision);
end
if ~isempty(isfind)
    colormap=icolormap;
    icolormap(:,1) = colormap(end:-1:1,1);
    icolormap(:,2) = colormap(end:-1:1,2);
    icolormap(:,3) = colormap(end:-1:1,3);
end
end

