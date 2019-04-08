function dat1 = gfextmodel3d(dat,ztop,zbot,yfor,yback,xleft,xright )
%GFEXTMODEL_3D return a 3D extended model, the 3D version of GFEXTMODEL
% 
%   call:
%
%   evp = glextmodel3d(vp,ztop,zbot,yfor,ybac,xlef,xrig)
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
[nz,ny,nx]=size(dat);
dat1=zeros(nz+ztop+zbot,ny+yfor+yback,nx+xleft+xright);

for i=ztop+1:ztop+nz
    dat2=dat(i-ztop,:,:);
    dat2=reshape(dat2,[ny,nx]);
    dat3=gf_extmodel(dat2,yfor,yback,xleft,xright);
    dat1(i,:,:)=dat3;
end

for i=1:ztop

    dat1(i,:,:)=dat1(ztop+1,:,:);
end
for i=ztop+nz+1:nz+ztop+zbot

    dat1(i,:,:)=dat1(ztop+nz,:,:);
end
end