function pdat = rmbg(cdat,rmStep)
%RMBG remove background noise
%   rmbg remove background noise by minus the local average value.
%   Usage:
%   pdat=rmbg(cdat)   % rmStep=8, local window
%   pdat=rmbg(cdat,rmStep)  
%
%   Author: C.F. Guo
%   Date:   26-Oct-2016

if nargin<2
    rmStep=1/8;
end
[ns,ntr]= size(cdat);
pdat=zeros(ns,ntr);

trace = cdat(:,1);
for in = 1:ntr
    trace = trace * (1-rmStep) + rmStep * cdat(:,in);
    pdat(:,in) = cdat(:,in) - trace;
end

end

