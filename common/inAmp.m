function pdat = inAmp(cdat)
%INAMP instantaneous amplitude of the data
%   Usage:
%   pdat=inAmp(cdat);
%
%   Author: C.F. Guo
%   Date:   26-Oct-2016

[nz,nx]=size(cdat);
pdat=cdat;
for in=1:nx
    dat=cdat(:,in);
    datX=hilbert(dat);
    pdat(:,in)=abs(datX);
end
end

