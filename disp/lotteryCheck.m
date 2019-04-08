function info = lotteryCheck(info)

area1=info.currentLottery(1:5);
area2=info.currentLottery(6:7);
myLottery=info.myLottery;

match=zeros(1,2);
for in=1:5
    if sum(area1==myLottery(in))==1
        match(1)=match(1)+1;
    end
end
for in=6:7
    if sum(area2==myLottery(in))==1
        match(2)=match(2)+1;
    end
end

if match(1)==5 && match(2)==2
    info.rank=1;
elseif match(1)==5 && match(2)==1
   info.rank=2;
elseif (match(1)==5 && match(2)==0) || (match(1)==4 && match(2)==2)
  info.rank=3;
elseif (match(1)==3 && match(2)==2) || (match(1)==4 && match(2)==1)
  info.rank=4;
elseif (match(1)==3 && match(2)==1) || (match(1)==4 && match(2)==0) || ...
        (match(1)==2 && match(2)==2)
   info.rank=5;
elseif (match(1)==3 && match(2)==0) || (match(1)==1 && match(2)==2) || ...
        (match(1)==2 && match(2)==1) || (match(1)==0 && match(2)==2)
    info.rank=6;
else
    info.rank=0;
end

end

