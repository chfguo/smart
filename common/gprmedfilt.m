function pdat = gprmedfilt(cdat,dirflag)
%GFGPRMEDFILT apply median filter to data along X and Z axis.
%   gprmedfilt apply medfilt1 to the data along X axis using the past data 
%              point and to data along Z axis using the past and future data.
%   Usage:
%   pdat=gprmedfilt(cdat)          % dirflag='z';
%   pdat=gprsmooth(cdat,dirflag)  
%
%   Author: C.F. Guo
%   Date:   26-Oct-2016

if nargin<2
    dirflag='z';
end

pdat=cdat;
[nz,nx]=size(cdat);
if nz*nx==nz || nz*nz==nx  % 1 Dim
    if strcmp(dirflag,'z')
        for in=2:nz*nx-1
            pdat(in)=median(cdat(in-1:in+1));
        end
    else
        for in=3:nz*nx
            pdat(in)=median(cdat(in-3+1:in));
        end
    end
    
else % 2 Dim
   if strcmp(dirflag,'z')
        for in=2:nz-1
            pdat(in,:)=median(cdat(in-1:in+1,:));
        end
    else
        for in=3:nx
            pdat(:,in)=median(cdat(:,in-3+1:in),2);
        end
    end
end

end

