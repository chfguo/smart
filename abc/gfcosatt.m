function [dz,dx]=gfcosatt(Nz,Nx,Nlayer,par,n0)
% GFCOSATT creates a 2D D'Alembert absorbing boundary condition.
%
%   call:
%
%   [dz,dx] = gfcosatt(Nz,Nx,Nlayer,Par,N0) retrun 2D attenuation factors. 
%   Par control the control the within range of Par is [0.5,1],the default 
%   value is 0.8, 
%   N0 is the maximum value of attenuation factor. A large N0 may bring 
%   strong reflections at the interface between modeling region and 
%   attenuation region; if N0 is too samll, the reflections from artificial 
%   boundary can't be suppress effectively.[dz,dx] can also be used as PML 
%   attenuation factor.
%   
%   Example:
%   
%   [PMLZ,PMLX]=gfcosatt(Nz,Nx,Npml,0.8,100);
%   Q=PMLX+PMLZ;
%   Dp=1./(1+Q*dt/2);
%   Dm=(1-Q*dt/2);
%
%   P=Dp.*(Dm.*P+dt*vp.^2.*(sfLx(gpuVx,dx)+sfLz(gpuVz,dz)))+loc*wlet(k);
%   
%   See also gfabc gfabc2 gfcosatt3d gfpml 
%
%   Version: V1.0
%   Author : C.F.Guo
%   Time   : 2015/9/11 
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
dx=zeros(Nz,Nx);
dz=zeros(Nz,Nx);
if nargin<5
    d0=200;
else
    d0=n0;
end
if nargin<4
    R=0.8;
else
    R=par;
end
if nargin<3
    Nlayer=40;
end

x1=1:1:Nlayer;
x2=Nlayer:-1:1;
d1=d0*(0.5-0.5*cos(pi*R*x1/Nlayer));
d2=d0*(0.5-0.5*cos(pi*R*x2/Nlayer));
for i=1:Nlayer
    dx(:,i)=d2(i);
end
for i=Nx-Nlayer+1:Nx
    dx(:,i)=d1(i-Nx+Nlayer);
end
for i=1:Nlayer
    dz(i,:)=d2(i);
end
for i=Nz-Nlayer+1:Nz
    dz(i,:)=d1(i-Nz+Nlayer);
end

end

