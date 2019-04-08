function icolormap = gfcolormap2(flags)
%GFCOLORMAP return a colormap
%
%   gfcolormap2('e') : for blue-white-red
%   gfcolormap2('g') : for black-white-red
%   gfcolormap2('i') : for black-white
%   gfcolormap2('v') : for variation of jet
%   gfcolormap2('j') : for jet
%   gfcolormap2('p') : for parula
%
%   Version: V1.0
%   Author : C.F.Guo
%   Time   : 2016/9/1
%

iprecision=128;
icolormap=zeros(iprecision,3);  % define the iprecision-by-3 colormap matrix
isfind=strfind(flags,'-');
if numel(flags)==2
    for i=1:2
        if flags(i)~='-'
            flagd=flags(i);
        end
    end
else
    flagd=flags(1);
end

switch flagd
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
    case 'f' % f for flag
        icolormap=flag(iprecision);
    case 'v' % a variation of jet
        icolormap=[0         0         0;
            0         0    0.1429;
            0         0    0.2857;
            0         0    0.4286;
            0         0    0.5714;
            0         0    0.7143;
            0         0    0.8571;
            0         0    1.0000;
            0    0.0625    1.0000;
            0    0.1250    1.0000;
            0    0.1875    1.0000;
            0    0.2500    1.0000;
            0    0.3125    1.0000;
            0    0.3750    1.0000;
            0    0.4375    1.0000;
            0    0.5000    1.0000;
            0    0.5625    1.0000;
            0    0.6250    1.0000;
            0    0.6875    1.0000;
            0    0.7500    1.0000;
            0    0.8125    1.0000;
            0    0.8750    1.0000;
            0    0.9375    1.0000;
            0    1.0000    1.0000;
            0.0625    1.0000    0.9375;
            0.1250    1.0000    0.8750;
            0.1875    1.0000    0.8125;
            0.2500    1.0000    0.7500;
            0.3125    1.0000    0.6875;
            0.3750    1.0000    0.6250;
            0.4375    1.0000    0.5625;
            0.5000    1.0000    0.5000;
            0.5625    1.0000    0.4375;
            0.6250    1.0000    0.3750;
            0.6875    1.0000    0.3125;
            0.7500    1.0000    0.2500;
            0.8125    1.0000    0.1875;
            0.8750    1.0000    0.1250;
            0.9375    1.0000    0.0625;
            1.0000    1.0000         0;
            1.0000    0.9375         0;
            1.0000    0.8750         0;
            1.0000    0.8125         0;
            1.0000    0.7500         0;
            1.0000    0.6875         0;
            1.0000    0.6250         0;
            1.0000    0.5625         0;
            1.0000    0.5000         0;
            1.0000    0.4375         0;
            1.0000    0.3750         0;
            1.0000    0.3125         0;
            1.0000    0.2500         0;
            1.0000    0.1875         0;
            1.0000    0.1250         0;
            1.0000    0.0625         0;
            1.0000         0         0;
            0.8750         0         0;
            0.7500         0         0;
            0.6250         0         0;
            0.0500         0         0;
            0.3750         0         0;
            0.2500         0         0;
            0.1250         0         0;
            0              0         0];     
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

