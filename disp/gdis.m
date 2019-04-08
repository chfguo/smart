function  handle=gdis( varargin )
%GDIS dispalys the 1D and 2D data conveniently
%
%   call:
%
%   handle=gdis(...) 
%      
%   GDIS uses the PLOT to displays the 1D data and IMAGESC to 2D data;     
%
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

switch (nargin),
    case 0,
        image('CDataMapping','scaled');
    case 1,
        dat=real(varargin{1});
        [nz,nx]=size(dat);
        
        if nz*nx == nz || nz*nx == nx
            if nargout == 0
                figure
                plot(dat);
                title(inputname(1));
            else
                handle=figure;
                plot(dat);
                title(inputname(1));
            end
        else
            if nargout==0
                figure
                imagesc(dat);
                title(inputname(1));
            else
                handle=figure;
                imagesc(dat);
                title(inputname(1));
            end
        end
    otherwise,
        dat=real(varargin{1});
        [nz,nx]=size(dat);
        varargin{1}=real(varargin{1});
        if nz*nx==nz || nz*nx==nx
            if nargout==0
                figure
                plot(varargin{:});
                title(inputname(1));
            else
                handle=figure;
                plot(varargin{:});
                title(inputname(1));
            end
        else
            if nargout==0
                figure
                imagesc(varargin{:});
                title(inputname(1));
            else
                handle=figure;
                imagesc(varargin{:});
                title(inputname(1));
            end
        end    
end
end

