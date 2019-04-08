function currentLottery = lotteryGenerate()
currentLottery=zeros(1,7);

%第一个数
num1=randi(35,1);
currentLottery(1)=num1;

%第二个数
num2=randi(35,1);
while num2==num1
    num2=randi(35,1);
end
currentLottery(2)=num2;

%第三个数
num3=randi(35,1);
while num3==num1 || num3==num2
    num3=randi(35,1);
end
currentLottery(3)=num3;

%第四个数
num4=randi(35,1);
while num4==num1 || num4==num2 || num4==num3
    num4=randi(35,1);
end
currentLottery(4)=num4;

%第五个数
num5=randi(35,1);
while num5==num1 || num5==num2 || num5==num3 || num5==num4
    num5=randi(35,1);
end
currentLottery(5)=num5;

%第六个数
num6=randi(12,1);
currentLottery(6)=num6;


%第七个数
num7=randi(12,1);
while num7==num6 
    num7=randi(12,1);
end
currentLottery(7)=num7;
currentLottery(1:5)=sort(currentLottery(1:5));
if currentLottery(6)>currentLottery(7)
    tmp=currentLottery(6);
    currentLottery(6)=currentLottery(7);
    currentLottery(7)=tmp;
end

end

