function outp=gfabc(inp,hei)
% GFABC implements Cerjan nonreflecting boundary condition (1985) with a 
%   cosine-based factor.(Libin,2009)
%
%   call:
%
%   outdat=gfabc(indat);
%   outdat=gfabc(indat,NLayer); Nlayer is the boundary thickness
%
%   Version: V1.0
%   Author : C.F.Guo
%   Time   : 2015/9/11 
%
%   See also gfabc2 gfcosatt gfcosatt3d gfpml 
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

if nargin<2
hei=40;       % boundary height
end 
[zN,xN]=size(inp);
r=0.08;      % a coefficient control curvature 
h=1:1:hei;
c0=0.5+0.5*cos(r.*h.*pi./hei);
h1=hei:-1:1;
c1=0.5+0.5*cos(r.*h1.*pi./hei);
    %top
    inp(1:hei,:)=diag(c1)*inp(1:hei,:);
    %bottum
    inp(zN-hei+1:zN,:)=diag(c0)*inp(zN-hei+1:zN,:);
    %left
    inp(:,1:hei)=inp(:,1:hei)*diag(c1);
    %right
    inp(:,xN-hei+1:xN)=inp(:,xN-hei+1:xN)*diag(c0);

    outp=inp;
end

