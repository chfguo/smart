function [pdat,GainCurve] = gftgc(cdat,N,Wn,RN)
%GFTGC Time varying Gain Control
%   gftgc apply time varying gain control using the Highpass butterworth
%       filter to generate the gain curve
%   Usage
%   [pdat,GainCurve]=gftcg(cdat)   % N=2, Wn=0.2 (0-0.5); RN=1 repeat times
%   [pdat,GainCurve]=gftcg(cdat,N) % Wn=0.2
%   [pdat,GainCurve]=gftcg(cdat,N,Wn)
%   [pdat,GainCurve]=gftcg(cdat,N,Wn,RN)

%   Author: C.F. Guo
%   Date:   26-Oct-2016
if nargin<4
    RN=1;
end

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
for im=1:RN
    for in=1:nx
        pdat(:,in)=cdat(:,in).*H;
    end
end
GainCurve=H;

end

