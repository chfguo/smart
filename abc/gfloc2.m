function spa=gfloc2(vp,sz,sx,gama)
%GFLOC2 retruns a Gaussian function surround the source
%
%   call:
%
%   loc = gfloc2(vp,sz,sx,gama). vp can be any matrix.Only the size of vp is
%   used.
%
%   See also gfloc gfloc3d
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

if nargin<4
    gama=0.18;
end
[Nz Nx]=size(vp);
spa=zeros(Nz,Nx);
for i=1:Nz
    for j=1:Nx
        spa(i,j)=exp(-1*gama*((i-sz)^2+(j-sx)^2));
    end
end
end