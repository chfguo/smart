function data = gfextract(dat,step,direc)
%GFEXTRACT extract subdata 
%   
if nargin<3
    direc=1;
end
if nargin<2
    step=2;
end
[nz,nx]=size(dat);

if direc==2
    index=[1:step:nx];
    data=dat(:,index);
    
else
    index=[1:step:nz];
    data=dat(index,:);
end

end

