function  iconfig = gfplot3dconfig()
%GFPLOT3DCONFIG return a plot parameter list for gfplot3d
%   call:
%   icfg=gfplot3dconfig();
%   
%   Most parameters have the same meanings as 2d case
%   Parameters: [Note: Case sensitive]
%   fileformat={'jpg'}; %'eps','jpg','png','tif','pdf'
%   outfile='Example';
%                  the order of dimension is [nz,nx,ny]
%   isx=1;         % which section in x-axis need to display
%   isy=1;         % which section in y-axis need to display
%   isz=1;         % which section in z-axis need to display
%   iox=0;
%   ioy=0;
%   ioz=0;
%   idx=0.01;
%   idy=0.01;
%   idz=0.01;
%   ixlabel='Inline/Km';
%   iylabel='Crossline/Km';
%   izlabel='Depth/Km';
%   fontname='Times New Roman';
%   fontsize=12; 
%   igain=1;
%   ixscale=1;
%   iyscale=1;
%   izscale=1;
%   iszero='n';
%   icolor='j'; % g for black-white-red
%                     i for black-white
%                     e for blue-white-red
%                     j for Jet
%   isequaly='n'; % if 'y',the length of lateral view is equal to width 
%                       of the vertical view
% 
%   iscolorbar='n'; %'n'
%   isunit='n'; %'y'
%   iunit='km/s';   % 0 is means don't want unit
%   isbarlabel='y';
%   ibarlabel='Velcoity'; 
% 
%   iprecision=128;
%   isfillup='n';
% 
%   fsmainaxis=12;
%   fsmainlabel=14;
%   fsbarlabel=14;
%   fsbaraxis=12;
%   fsbarunit=12;
%   isml='y';   % want marked line (y) or not (n)
%   mlcolor=1; % marked line color ([0~1,0~1,0~1]).if =1, the line color
%     
%  
%
%
%   Version: V1.0
%   Author : C.F.Guo
%   Time   : 2015/11/19 
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
iconfig.fileformat={'jpg'}; %'eps','jpg','png','tif','pdf'
iconfig.outfile='Example';
iconfig.isx=1;
iconfig.isy=1;
iconfig.isz=1;
iconfig.iox=0;
iconfig.ioy=0;
iconfig.ioz=0;
iconfig.idx=0.01;
iconfig.idy=0.01;
iconfig.idz=0.01;
iconfig.ixlabel='Inline/Km';
iconfig.iylabel='Crossline/Km';
iconfig.izlabel='Depth/Km';
iconfig.fontname='Times New Roman';
iconfig.fontsize=12; 
iconfig.igain=1;
iconfig.ixscale=1;
iconfig.iyscale=1;
iconfig.izscale=1;
iconfig.iszero='n';
iconfig.icolor='j'; % g for black-white-red
                    % i for black-white
                    % e for blue-white-red
                    % j for Jet
iconfig.isequaly='n'; % if 'y',the length of lateral view is equal to width 
                      % of the vertical view

iconfig.iscolorbar='n'; %'n'
iconfig.isunit='n'; %'y'
iconfig.iunit='km/s';   % 0 is means don't want unit
iconfig.isbarlabel='y';
iconfig.ibarlabel='Velcoity'; 

iconfig.iprecision=128;
iconfig.isfillup='n';

iconfig.fsmainaxis=12;
iconfig.fsmainlabel=14;
iconfig.fsbarlabel=14;
iconfig.fsbaraxis=12;
iconfig.fsbarunit=12;
iconfig.isml='y';   % want marked line (y) or not (n)
iconfig.mlcolor=1; % marked line color ([0~1,0~1,0~1]).if =1, the line color
                    % is take from the median value of colormap;
end

