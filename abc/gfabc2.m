function outp=gfabc2( inp,hei,par,no )
% GFABC2 retrurns a factor for implementing Cerjan nonreflecting boundary
%   condition (1985) with a cosine-based factor.(Guo,2015)
%
%
%   call:
%
%   factor=gfabc2(indat); indata can be any matrix, only the size of 
%   indata is used.
%
%   factor=gfabc2(indat,NLayer); Nlayeris the boundary thickness.
%   default value is 20
%
%   factor=gfabc2(indat,NLayer,par); the range of par is [0.5,1].defaut
%   value is 0.8
%
%   factor=gfabc2(indata,NLayer,par,no); default value of no is 150,no is
%   maximum value of factor matrix.
%   
%   This function's usage differs from gfabc. 
%   
%   Example:
%
%   factor = gfabc2(data1);
%   data2 = data1.*factor;
%   
%   In this way, the computation speed is faster.
%
%   See also gfabc gfcosatt gfcosatt3d gfpml 
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
    no=150;
end
if nargin<3
    par=0.8;
end

if nargin<2
    hei=40;
end
m=1:hei;
vp=3000;

n=no*(0.5-0.5*cos(m*pi/hei*par));
w=25*2*pi;
r=sqrt(n.*n./vp./vp./(sqrt(1+n.*n/w/w)+1));
c0=exp(-r.*m);
c1=c0(end:-1:1);
[zN,xN]=size(inp);
inpp=ones(zN,xN);
%top
inpp(1:hei,:)=diag(c1)*inpp(1:hei,:);
%bottum
inpp(zN-hei+1:zN,:)=diag(c0)*inpp(zN-hei+1:zN,:);
%left
inpp(:,1:hei)=inpp(:,1:hei)*diag(c1);
%right
inpp(:,xN-hei+1:xN)=inpp(:,xN-hei+1:xN)*diag(c0);

outp=inpp;
end


