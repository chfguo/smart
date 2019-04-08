function geba(dat,igain,iszero)
%GEPA equilibrates (balances) amplitude for display
%   
%   call:
%
%   geba (dat);
%   geba (dat,igain); 
%   geba (dat,igain,iszero); 
%   
%   igain is the gain coefficient
%   if iszero='y',set the zero as the middle color
%    
%   Version: V1.0
%   Author : C.F.Guo
%   Time   : 2015/7/11 
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
if nargin<3
    iszero='n';
end
if nargin<2
    igain=1;
end
figure;
dat=gather(dat);
mindat=min(min(dat));
maxdat=max(max(dat));
imagesc(dat);
title(inputname(1));
if strcmp(iszero,'n')
    caxis([igain*mindat,igain*maxdat]);
else
    caxis([-igain*maxdat,igain*maxdat]);
end
colormap(jet);
end

