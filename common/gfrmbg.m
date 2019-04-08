function pdat = gfrmbg(cdat,rmStep)
%GFRMBG remove background noise
%   gfrmbg remove background noise by minus the local average value.
%   Usage:
%   pdat=gfrmbg(cdat)   % rmStep=16, local window
%   pdat=gfrmbg(cdat,rmStep)  
%
%   Author: C.F. Guo
%   Date:   26-Oct-2016

if nargin<2
    rmStep=16;
end

pdat=cdat;
pdat(:)=0;

[nz,nx]=size(cdat);
for in=rmStep+1:nx
    tmp=cdat(:,in-rmStep+1:in);
    tmp2=sum(tmp,2)/rmStep;
    pdat(:,in)=(cdat(:,in)-tmp2);
end

end

