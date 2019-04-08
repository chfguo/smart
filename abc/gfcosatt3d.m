function [dz,dy,dx] = gfcosatt3d( Nz,Ny,Nx,Nlayer,parameter,no )
% GFCOSATT3D creates a 3D D'Alembert  absorbing boundary condition.
%
%   call:
%
%   [dz,dy,dx] = gfcosatt3d( Nz,Ny,Nx,Nlayer,Par,N0) retrun 3D attenuation 
%   factor. Par control the control the within range of Par is [0.5,1],the 
%   default value is 0.8, 
%   N0 is the maximum value of attenuation factor. A large N0 may bring 
%   strong reflections at the interface between modeling region and 
%   attenuation region; if N0 is too samll, the reflections from artificial 
%   boundary can't be suppress effectively.[dz,dx] can also be used as PML 
%   attenuation factor.
%
%                       X-direction
%                        /
%                     /
%                  /
%               / 
%            /
%         /
%         ----------------------  Y-direction
%         |
%         |
%         |
%         |
%         |
%         |
%         |
%         |
%       Z-direction
% Note: in the M8r, I use the same coordinate system,  where n1=Z n2=Y n3=X
% 
%   See also gfabc gfabc2 gfcosatt gfpml 
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

dx=zeros(Nz,Ny,Nx);
dy=zeros(Nz,Ny,Nx);
dz=zeros(Nz,Ny,Nx);
if nargin<6
    d0=100;
else
    d0=no;
end
 if nargin<5
    R=0.8;
else
    R=parameter;
end
if nargin<4
    Nlayer=40;
end

x1=1:1:Nlayer;
x2=Nlayer:-1:1;

d1=d0*(0.5-0.5*cos(pi*R*x1/Nlayer));
d2=d0*(0.5-0.5*cos(pi*R*x2/Nlayer));
% d1=d0*(0.5+0.5*cos(1*x2*pi/Nlayer));
% d2=d0*(0.5+0.5*cos(1*x1*pi/Nlayer));

%Z-direction: top
for i=1:Nlayer
    dz(i,:,:)=d2(i);
end
%Z-direction: bottom

for i=Nz-Nlayer+1:Nz
    dz(i,:,:)=d1(i-Nz+Nlayer);
end

%Y-direction: left
for i=1:Nlayer
    dy(:,i,:)=d2(i);
end
%Y-direction: right

for i=Ny-Nlayer+1:Ny
    dy(:,i,:)=d1(i-Ny+Nlayer);
end

%X-direction: for
for i=1:Nlayer
    dx(:,:,i)=d2(i);
end
%X-direction: back

for i=Nx-Nlayer+1:Nx
    dx(:,:,i)=d1(i-Nx+Nlayer);
end

end

