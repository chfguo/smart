function gffreq(indat,dt)
%GFFREQ dispaly the frequency spectrum along z-axis for 2d data
%
%   Call:
%
%   gffreq(dat,dt);
%
%   Version: V1.0
%   Author : C.F.Guo
%   Time   : 2015/9/11 
%
% ------------------------------NOTE---------------------------------------
%
% This a subroutine of Seismic Modeling and Research Toolkit (SMART),
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
if size(indat,1)==1
    dat=indat';
else
dat=indat;
end
[Nz,Nx]=size(dat);
fdat=abs(fft(dat));
fdat=sum(fdat,2)/Nx;
fdat=fdat.*fdat;
datmax=max(fdat);
if mod(Nz,2)~=0
    Nz=Nz+1;
end
Kmax=1/dt/2;
dkz=Kmax/(Nz/2-1);
kz=[0,1:Nz/2]*dkz;
fdat=10*log(fdat/datmax);
figure
plot(kz,fdat([1:Nz/2+1]'))
set(gca,'xlim',[kz(1),kz(end)]);
xlabel('Wavenumber');
ylabel('Relative Amplitude (dB)');
title('Frequecy Analysis');
end

