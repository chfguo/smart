function [locsz,locsx] = gflocs(Nz,Nx,sx,sz,varargin)
%GFLOCS retruns a S-wave partial velocity source,
%   
%   call:
%
%   [locsz,locsx] = gflocs(Nz,Nx,sx,sz,ggopt,gama) 
%       ggopt corresponds to the grid gemometry, its default value is 'cg'
%       gama is the spatial damping coeffcient, its default value is 0.18
%       
%   Example:
%   if 
%       Vx=Vx+cp.*(sbLx(Txx,dx)+sfLz(Txz,dz))+locsx*wlet(k);
%       Vz=Vz+cp.*(sbLz(Tzz,dz)+sfLx(Txz,dx))+locsz*wlet(k);
%   then
%       ggopt='sf';
%   elseif 
%       Vx=Vx+cp.*(sfLx(Txx,dx)+sbLz(Txz,dz))+locsx*wlet(k);
%       Vz=Vz+cp.*(sfLz(Tzz,dz)+sbLx(Txz,dx))+locsz*wlet(k);
%   then
%       ggopt='sb';
%   elseif 
%       Vx=Vx+cp.*(Lx(Txx,dx)+Lz(Txz,dz))+locsx*wlet(k);
%       Vz=Vz+cp.*(Lz(Tzz,dz)+Lx(Txz,dx))+locsz*wlet(k);
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
[locpz,locpx] = gflocp(Nz,Nx,sx,sz,varargin);
locsx=-locpz;
locsz=locpx;

end

