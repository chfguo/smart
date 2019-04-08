function pdat = agc(cdat,np)
%GFAGC Automatic Gain Control
%   Usage:
%   pdat=agc(cdat)   ; np: 16, number of control point
%   pdat=agc(cdat,np)
%
%   Author: C.F. Guo
%   Date:   26-Oct-2016

if nargin<2
    np=16;
end
pdat=cdat;

autoGainNum=np;
autoSeg=autoGainNum+1;
[ns,ntr]=size(cdat);

for in = 1:ntr
    cdat(:,in) = cdat(:,in) + mean((cdat(:,in)));
end


d=mod(ns,autoSeg);
subNs=(ns-d)/autoSeg;
gainCurve=zeros(ns,1);
for in=1:ntr
    for is=1:autoGainNum
        amp=mean(abs(cdat((is-1)*subNs+1:(is+1)*subNs,in)))/2/subNs;
        gainCurve(is*subNs)=1/amp;
        gainCurve(is*subNs+1)=1/amp;
    end
    for is=1:autoGainNum
        gainCurve((is-1)*subNs+1:is*subNs)= ...
            linspace(gainCurve((is-1)*subNs+1),gainCurve(is*subNs),subNs);
    end
    gainCurve(is*subNs+1:end)=gainCurve(is*subNs);
    pdat(:,in)=cdat(:,in).*gainCurve;
end

end

