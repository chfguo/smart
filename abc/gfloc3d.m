function spa=gfloc3d(Nz,Ny,Nx,sz,sy,sx,gama)
%GF_LOC_3D retruns a 3D Gaussian function surround the source
%
%   call:
%
%   loc = gfloc3d(Nz,Ny,Nx,sz,sy,sx,gama)
%
%   See also gfloc gfloc2
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


if nargin<7
    gama=0.18;
end

spa=zeros(Nz,Ny,Nx);
for i=1:Nz
    for k=1:Ny
       for j=1:Nx
        spa(i,k,j)=exp(-1*gama*((i-sz)^2+(j-sx)^2+(k-sy)^2));
       end
    end
end

end