function  gfshow3d( data ,glaxis ,sleep)
% GFSHOW3D shows the 3d data volume 
%
%   call:
%
%   gfgfshow3d( data )
%   gfgfshow3d( data ,glaxis )
%   gfgfshow3d( data ,glaxis ,sleep)
%
%   GFSHOW3D shows the 3d data volume as a movie along a special axis, 
%   default: y-axis. If the movie paly fast, make sleep bigger,
%   default: sleep=0.01s
%
%
%   Version: V1.0
%   Author : C.F.Guo
%   Time   : 2015/9/12 
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

[nz,ny,nx]=size(data);
if nargin <3
    sleep=0.01;
end

if nargin <2
   glaxis='y'; 
end

if glaxis=='z'
for i=1:nz
    d=data(i,:,:);
    d=reshape(d,[ny,nx]);
    pause(sleep)
    imagesc(d);
    title(['Along Z-axis:   ' num2str(i)]);
    getframe;
    
end

elseif glaxis=='y'
   for i=1:ny
    d=data(:,i,:);
    d=reshape(d,[nz,nx]);
     pause(sleep)
    imagesc(d);
    title(['Along Y-axis:   ' num2str(i)]);
    getframe;
    
   end
elseif glaxis=='z-'
for i=nz:-1:1
    d=data(i,:,:);
    d=reshape(d,[ny,nx]);
    pause(sleep)
    imagesc(d);
    title(['Along Z-axis:   ' num2str(i)]);
    getframe;
    
end

elseif glaxis=='y-'
   for i=ny:-1:1
    d=data(:,i,:);
    d=reshape(d,[nz,nx]);
     pause(sleep)
    imagesc(d);
    title(['Along Y-axis:   ' num2str(i)]);
    getframe;
    
   end
elseif glaxis=='x-'
    for i=nx:-1:1
    d=data(:,:,i);
    d=reshape(d,[nz,ny]);
    pause(sleep)
    imagesc(d);
    title(['Along X-axis:   ' num2str(i)]);
    getframe;
    end
else
    for i=1:nx
    d=data(:,:,i);
    d=reshape(d,[nz,ny]);
    pause(sleep)
    imagesc(d);
    title(['Along X-axis:   ' num2str(i)]);
    getframe;
    end
end
    
end

