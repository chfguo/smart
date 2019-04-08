function  spa= gfloc( Nz,Nx,sz,sx,gama )
%GFLOC retruns a Gaussian function surrounding the source,it will significantly
%   alleviate the numerical dispersion caused by source dingularty.it is a
%   Gaussian smoothing function, essentialy 
%   
%   call:
%
%   loc = gfloc(Nz,Nx,sz,sx,gama) gama is a attenuation factor, 
%   
%   Example:
%   P=Dp.*(Dm.*P+dt*vp.^2.*(sfLx(gpuVx,dx)+sfLz(gpuVz,dz)))+loc*wlet(k);
%
%   See also gfloc2 gfloc3d
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

if nargin<5
    gama=0.18;
end
spa=zeros(Nz,Nx);
for i=1:Nz
    for j=1:Nx
        spa(i,j)=exp(-gama*((i-sz)^2+(j-sx)^2));
    end
end
end



