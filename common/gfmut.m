function data_mut = gfmut( data,range,scale,position,bd )
%GFMUT excise the data out of given range measured by degree
%
%   data_mut = gfmut(data, range, scale, position )
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
% ------------------------------END----------------------------------------
[nz,nx]=size(data);
factor=ones([nz,nx]);
if nargin<5
    bd=0;
end
if nargin<4
    position=floor(nx/2);
end
if nargin<3
    scale=1;
end
if nargin<2
    range=30;
end

for i=1:nx
    pos=floor(abs((i-position))*tan(range/180*pi)*scale+bd);
    if pos>nz
        pos=nz;
    end
    factor(1:pos,i)=0;
end
   
   data_mut=data.*factor;
end

