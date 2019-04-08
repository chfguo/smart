function data1=ExtractTravelTime(data)

dmean=mean(data);
[nz,nx]=size(data);
for in=1:nx
    data(:,in)=data(:,in)+dmean(in)+eps;
end
len=30;
tt=data-data;
for iz=len+1:nz-len
    sumline1=sum(data(iz-len+1:iz,:));
    sumline2=sum(data(iz+1:iz+len,:));
    tt(iz,sumline2./sumline1>1.5)=1;
end
d=ones(20,20);
d(:,11:20)=0;
t1=conv2(tt,d,'same');
t1(t1<50)=0;
data1=t1;
