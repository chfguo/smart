function data = gfrollback(dat,DIM)
%GFROLLBACK reverses dat along the dimension DIM (1->z,2->x)
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
% ------------------------------END---------------------------------------- 
if nargin<2
    DIM=1;
end
data=dat;
[nz,nx]=size(dat);
if DIM==1
    for i=1:nz
        data(i,:)=dat(nz+1-i,:);
    end
end

if DIM==2
    for i=1:nx
        data(:,i)=dat(:,nx+1-i);
    end
end

end

