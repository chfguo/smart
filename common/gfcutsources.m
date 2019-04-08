function data = gfcutsources( L,N,times )
if nargin<3
    times=1;
end
if nargin<2
    N=50;
end
[Nz,Nx]=size(L);

afun=zeros(N,Nx);

for i=1:Nx
    afun(:,i)=linspace(0,1,N);
end
data=L;
for k=1:times
data(1:N,:)=data(1:N,:).*afun;
end

end

