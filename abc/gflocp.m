function [locpz,locpx] = gflocp(Nz,Nx,sz,sx,varargin)
%GFLOCP retruns a P-wave partial velocity source,
%   
%   call:
%
%   [locpz,locpx] = gflocp(Nz,Nx,sx,sz,ggopt,gama) 
%       ggopt corresponds to the grid gemometry, its default value is 'cg'
%       gama is the spatial damping coeffcient, its default value is 0.18
%       
%   Example:
%   if 
%       Vx=Vx+cp.*(sbLx(Txx,dx)+sfLz(Txz,dz))+locpx*wlet(k);
%       Vz=Vz+cp.*(sbLz(Tzz,dz)+sfLx(Txz,dx))+locpz*wlet(k);
%   then
%       ggopt='sb';
%   elseif 
%       Vx=Vx+cp.*(sfLx(Txx,dx)+sbLz(Txz,dz))+locpx*wlet(k);
%       Vz=Vz+cp.*(sfLz(Tzz,dz)+sbLx(Txz,dx))+locpz*wlet(k);
%   then
%       ggopt='sf';
%   elseif 
%       Vx=Vx+cp.*(Lx(Txx,dx)+Lz(Txz,dz))+locpx*wlet(k);
%       Vz=Vz+cp.*(Lz(Tzz,dz)+Lx(Txz,dx))+locpz*wlet(k);
%   then
%       ggopt='cg';
%   end
%
%
%   Version: V1.0
%   Author : C.F.Guo
%   Time   : 2015/9/18
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
gama=0.18;
opt='cg';

if ~isempty(varargin)
if iscell(varargin{1})
    var=varargin{1};
else
    var=varargin;
end
numv1=numel(var);
numv2=numv1;

for iv=1:numv1
    if ischar(var{iv})
        opt=var{iv};
        var{iv}=[];
        numv2=numv1-1;
        break;
    end
end

if numv2==1
    gama=var{1};
end
end

loc=gfloc(Nz,Nx,sz,sx,gama);
if strcmp(opt,'sf')
    locpx=sfLx(loc,1);
    locpz=sfLz(loc,1);
elseif strcmp(opt,'sb')
    locpx=sbLx(loc,1);
    locpz=sbLz(loc,1);   
else
    locpx=Lx(loc,1);
    locpz=Lz(loc,1);
end

end

