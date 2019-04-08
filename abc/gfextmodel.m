function evp = gfextmodel(vp,topN,bottomN,leftN,rightN )
%GFEXTMODEL extends the model
%
%   call:
%
%   evp = gfextmodel(vp,topN,bottomN,leftN,rightN )
%
%
%   Example:
%   vp=gones(200,200);
%   evp=gfextmodel(vp,20,20,20,20);
%   The size of evp is 240*240
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
[Nz,Nx]=size(vp);
evp=zeros(Nz+topN+bottomN,Nx+leftN+rightN);
evp(topN+1:topN+Nz,leftN+1:leftN+Nx)=vp;
%left
for i=1:leftN
    evp(topN+1:topN+Nz,i)=vp(:,1);
end
%right
for i=leftN+Nx+1:leftN+Nx+rightN
    evp(topN+1:topN+Nz,i)=vp(:,Nx);
end
%top
for i=1:topN
    evp(i,:)=evp(topN+1,:);
end

%bottom
for i=topN+1+Nz:bottomN+Nz+topN
    evp(i,:)=evp(Nz+topN,:);
end

end

