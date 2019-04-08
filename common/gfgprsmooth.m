function pdat = gfgprsmooth(cdat,varargin)
%GFGPRSMOOTH smmoth the data along X and Z axis.
%   gprsmooth smooth the data along X axis using the past data point 
%                and the data along Z axis using the past and future data.
%   Usage:
%   pdat=gfgprsmooth(cdat)           % smStep: 4, dirflag='z';
%   pdat=gfgprsmooth(cdat,smStep)    % dirflag='z';
%   pdat=gfgprsmooth(cdat,dirflag)   % smStep: 4;
%   pdat=gfgprsmooth(cdat,smStep,dirflag)
%   pdat=gfgprsmooth(cdat,dirflag,smStep)
%   
%   Author: C.F. Guo
%   Date:   26-Oct-2016

npar=numel(varargin);
if npar==0
    smStep=4;
    dirflag='z';
elseif npar==1
    if ischar(varargin{1});
        smStep=4;
        dirflag=varargin{1};
    else
        smStep=varargin{1};
        dirflag='z';
    end
elseif npar==2
    if ishcar(varargin{1})
        dirflag=varargin{1};
        smStep=varargin{2};
    else
        dirflag=varargin{2};
        smStep=varargin{1};
    end
end

pdat=cdat;
[nz,nx]=size(cdat);
if nz*nx==nz || nz*nz==nx
    if strcmp(dirflag,'z')
        smStep=floor(smStep/2);
        for in=smStep+1:nz*nx-smStep
            pdat(in)=mean(cdat(in-smStep:in+smStep));
        end
    else
        for in=smStep:nz*nx
            pdat(in)=mean(cdat(in-smStep+1:in));
        end
    end
    
else
    if strcmp(dirflag,'z')
            smStep=floor(smStep/2);
        for in=smStep+1:nz-smStep
            pdat(in,:)=mean(cdat(in-smStep:in+smStep,:));
        end
    else
        for in=smStep:nx
            pdat(:,in)=mean(cdat(:,in-smStep+1:in),2);
        end
    end
end

end

