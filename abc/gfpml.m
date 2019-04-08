function [dz,dx]= gfpml(Nz,Nx,Nlayer,par)
% GFPML creates a 2D PML absorbing boundary condition.
%
%   call:
%
%   [dz dx]= gfpml(Nz,Nx,Nlayer,Par) retruns attenuation factor. 
%   
%   Note: this function can be replaced by gfcosatt
%
%   See also gfabc gfabc2 gfcosatt gfcosatt3d
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
if nargin<4
    R=0.1;
else
    R=par;
end
if nargin<3
    Nlayer=40;
end

x1=1:1:Nlayer;
x2=Nlayer:-1:1;
d0=3000*R;
d1=d0*(x1/Nlayer).^2;
d2=d0*(x2/Nlayer).^2;
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

