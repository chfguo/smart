function datap = gfsmooth( data,N )
%GFSMOOTH smooths data
%
%   call:
%
%   data = gfsmooth(dat,num)
%
%       num is the time of loop, default: 1
%
%
%   Version: V1.0
%   Author : C.F.Guo
%   Time   : 2015/9/12 
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

if nargin < 2
    N=1;
end
L=[1 2 1;2 4 2;1 2 1];
L=L/16;
datap=gfextmodel(data,2*N,2*N,2*N,2*N);
[Nz,Nx]=size(data);
for i=1:N
datap=conv2(datap,L);
end

datap=datap(1+3*N:Nz+3*N,1+3*N:Nx+3*N);
end

