function outp = gflaplas( pic )
%GFLAPLAS implement a laplacian transform to data
%
%   call:
%
%   data = gflaplas(dat);
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
[l,c]=size(pic);

la=[0,1,0; 1,-4,1;0,1,0];
temp=conv2(pic,la);
outp=temp(1+1:l+1,1+1:c+1);

% outp=Lx2(pic,1)+Lz2(pic,1);

end

