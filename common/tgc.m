function [pdat,GainCurve] = tgc(cdat,N,Wn)
%TGC Time varying Gain Control 
%   tgc apply time varying gain control using the Highpass butterworth
%       filter to generate the gain curve
%   Usage
%   [pdat,GainCurve]=tcg(cdat)   % N=2, Wn=0.2 (0-0.5); 
%   [pdat,GainCurve]=tcg(cdat,N) % Wn=0.2
%   [pdat,GainCurve]=tcg(cdat,N,Wn) 

%   Author: C.F. Guo
%   Date:   26-Oct-2016
if nargin<3
    Wn=0.2;
end
if nargin<2
    N=2;
end
[nz,nx]=size(cdat);
pdat=cdat;

[B,A]=butter(N,Wn,'high');
H=freqz(B,A,nz);
H=abs(H);
for in=1:nx
    pdat(:,in)=cdat(:,in).*H;
end

GainCurve=H;

end

