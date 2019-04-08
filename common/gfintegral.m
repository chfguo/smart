function dat2= gfintegral(dat1,dh,dim,inflag)
%GFINTEGRAL Summary of this function goes here
%   Detailed explanation goes here

if nargin<4
    inflag='f';
end

if nargin<3
    dim='z';
end

if nargin<2
    dh=1;
end

dat2=dat1;
[nz,nx]=size(dat2);
if strcmp(dim,'z')
    for in=2:nz
        dat2(in,:)=dat2(in-1,:)+(dat1(in,:)+dat1(in-1,:))*dh/2;
    end
else
    for in=2:nx
        dat2(:,in)=dat2(:,in-1)+(dat1(:,in)+dat1(:,in-1))*dh/2;
    end
end

if nargin==4
    if strcmp(dim,'z')
        for in=nz-1:-1:1
            dat2(in,:)=dat2(in+1,:)+(dat1(in,:)+dat1(in+1,:))*dh/2;
        end
    else
        for in=nx-1:-1:1
            dat2(:,in)=dat2(:,in+1)+(dat1(:,in)+dat1(:,in+1))*dh/2;
        end
    end
end

end

