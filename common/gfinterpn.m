function outdat = gfinterpn(indat,DIM)
%GFINTERPn interpolates data using nearest neighbor data
%   
%   Call:
%
%   outdat=gfintermed(indat,DIM)
%   if DIM='zi',interpolation along z-axis
%   if DIM='zb',backward interpolation along z-axis
%   if DIM='zf',forward interpolation along z-axis
%   if DIM='xi',interpolation along x-axis
%   if DIM='xb',backward interpolation along x-axis
%   if DIM='xf',forward interpolation along x-axis
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
[nz,nx]=size(indat);
if strcmp(DIM,'zi') || strcmp(DIM,'zb') || strcmp(DIM,'zf')
    outdat=fzeros(2*nz,nx);
else
   outdat=fzeros(nz,2*nx); 
end
    
if strcmp(DIM,'zi')
    for i=1:nz
        outdat(2*i,:)=indat(i,:);
        outdat(2*i-1,:)=indat(i,:);
    end
end

if strcmp(DIM,'xi')
    for j=1:nx
        outdat(:,2*j)=indat(:,j);
        outdat(:,2*j-1)=indat(:,j);
    end
end


if strcmp(DIM,'zb')
    for i=1:nz
        outdat(2*i,:)=indat(i,:);
    end
    
    for i=2:nz
        outdat(2*i-1,:)=0.5*(outdat(2*i-2,:)+outdat(2*i,:));
    end
    outdat(1,:)=indat(1,:)/2;
end

if strcmp(DIM,'xb')
    for i=1:nz
        outdat(:,2*i)=indat(:,i);
    end
    
    for i=2:nz
        outdat(:,2*i-1)=0.5*(outdat(:,2*i-2)+outdat(:,2*i));
    end
    outdat(:,1)=indat(:,1)/2;
end
if strcmp(DIM,'zf')
    for i=1:nz
        outdat(2*i-1,:)=indat(i,:);
    end
    
    for i=1:nz-1
        outdat(2*i,:)=0.5*(outdat(2*i-1,:)+outdat(2*i+1,:));
    end
    outdat(2*nz,:)=indat(nz,:)/2;
end

if strcmp(DIM,'xf')
    for i=1:nz
        outdat(:,2*i-1)=indat(:,i);
    end
    
    for i=2:nz
        outdat(:,2*i)=0.5*(outdat(:,2*i-1)+outdat(:,2*i+1));
    end
    outdat(:,2*nz)=indat(:,nz)/2;
end

end
