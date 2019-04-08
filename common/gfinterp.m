function data = gfinterp(dat,Nz,Nx,methodstr)
% gfinterp 1-D and 2-D interpolation    
% data = gfinterp(dat,Nz,Nx,methodstr)
%        [Nz,Nx] is the size of the interpolated data
%   
%   methodstrs pecifies alternate methods.The default is linear interpolation
%    
%     'nearest' - nearest neighbor interpolation
%     'linear'  - bilinear interpolation
%     'spline'  - spline interpolation
%     'cubic'   - bicubic interpolation as long as the data is
%                 uniformly spaced, otherwise the same as 'spline'


if nargin<4
    methodstr='linear';
end
[nz,nx]=size(dat);  
[x,y]=meshgrid(linspace(1,nx,nx),linspace(1,nz,nz));
[xi,yi] = meshgrid(linspace(1,nx,Nx),linspace(1,nz,Nz));
data = interp2(x,y,dat,xi,yi,methodstr);

end

