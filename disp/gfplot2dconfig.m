function  iconfig = gfplot2dconfig()
%GFPLOT2DCONFIG return a plot parameter list for gfplot2d
%   call:
%   icfg=gfplot2dconfig();
%   
%   Parameters: [Note: Case sensitive]
%   fileformat={'jpg'}: The export file format: pdf, eps, jpg, png, tif
%                       A empty cell {} means no output
%   filename='example' : The output file's name   
%   iox=0             : X-axis initial value
%   ioz=0             : Z-axis initial value
%   idx=0.01          : X-axis step, the x range is [iox:iox+idx*Nx]
%   idz=0.001         : Z-axis step, the z range is [ioz:ioz+idz*Nz] 
%   ixlabel='Distance(Km)'      : X label
%   izlabel='Time/S'            : Z label
%   istitle='n'       : Want title ('y') or not ('n')
%   ititlepos='bottom': Title position ('top','bottom'). If colorbar is at
%                       bottom, the title have to be at top
%
%   ititle='Velocity' : Title 
%   fontname='Times New Roman'  : Fontname for all text
%   fontsize=12       : Fontsize for all axis ticklabel, however the size of 
%                       xlabel, zlable, title, barlabel is defaultly fontsize+2
%                       If fonsize=0, you can configure them separately
%   fsmainaxis=12     : Fontsize for main figure axis
%   fsmainlabel=14    : Fontsize for main figure label
%   fsmaintitle=14    : Fontsize for main figure title
%   fsbarlabel=14     : Fontsize for colorbar label, requried isbarlabel'y'
%   fsbaraxis=12      : Fontsize for colorbar axis
%   fsbarunit=12      : Fontsize for colorbar units, requried isunit='y'                     
%   isnormal='d'      : The size of figure,
%                       'd' for a size of 500-by-650 pixels
%                       'y' for a size of Nz-by-Nx pixels
%                       'n' for a size of Nz*izscale-by-Nx*izscale pixels
%                       The largest size is defualtly as size of the screen 
%  ixscale=1           : Scale factor for figure size
%  izscale=1           : Scale factor for figure size
%  icolor='i-'         : Colormap 
%                      : 'g' for black-white-red 'g-' for red-white-black
%                      : 'i' for black-white     'i-' for white-black
%                      : 'e' for blue-white-red  'e-' for red-white-blue
%                      : 'j' for jet             'j-' for reversed jet
%                      : 'p' for parula          'p-' for reversed parula
%  iszero='y'          : set Zero value as the middle color
%  igain=0.05          : values outside the range the [igain*cmin,igain*cmax] 
%                        are clamped to the first or last colormap color
%  iscolorbar='y'      : Want colorbar ('y') or not ('n')
%  ibarpos='right'      : The psotion of colorbar ('bottom','top','right')
%  isunit='n'          : Want colobar units ('y') or not('n')
%  iunit='km/s'        : Unit for colobar 
%  isbarlabel='n'      : Want colorbar label ('y') or not('n')
%  ibarlabel='Velcoity': Colorbar label
%  iprecision=128      : The resolution of the image. This number is
%                        biger,the image is more exquisite
%  isfillup='n'        : If 'y', the ticklables has two decimals. For
%                        exampel 0 becaomes 0.00
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
iconfig.fileformat={}; %'eps','jpg','png','tif'
iconfig.filename='snapshot';
iconfig.iox=0;
iconfig.ioz=0;
iconfig.idx=0.01;
iconfig.idz=0.001;
iconfig.ixlabel='Distance(Km)';
iconfig.izlabel='Time/S';
iconfig.itlabel='Amp.';
iconfig.fontname='Times New Roman';
iconfig.fontsize=12; 
iconfig.igain=0.5;
iconfig.isnormal='d';% 'y','n'
iconfig.ixscale=1;
iconfig.izscale=1;
iconfig.icolor='i-'; % g for black-white-red
                    % i for black-white
                    % e for blue-white-red
                    % j for Jet

iconfig.iszero='y'; %
iconfig.iscolorbar='n'; %'n'
iconfig.ibarpos='right'; % bottom 
                         % left
                         % top
iconfig.isunit='n'; %'y'
iconfig.iunit='km/s';   % 0 is means don't want unit
iconfig.isbarlabel='y';
iconfig.ibarlabel='Velcoity'; 
iconfig.istitle='n';
iconfig.ititlepos='bottom';
iconfig.ititle='Velocity';

iconfig.iprecision=128;
iconfig.isfillup='n';

iconfig.fsmainaxis=12;
iconfig.fsmainlabel=14;
iconfig.fsmaintitle=14;
iconfig.fsbarlabel=14;
iconfig.fsbaraxis=12;
iconfig.fsbarunit=12;

end

