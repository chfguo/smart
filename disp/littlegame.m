function littlegame()
LottoContinue=1;
while LottoContinue
    continueflag=0;
    [lotto,isok]=gfinput('Super Lotto',{'Five different red number between 1-35',...
        'Two different blue number between 1-12'},{'7 11 16 19 26','4 7'});
    if isok
        redNum=lotto{1};
        blueNum=lotto{2};
        for in=1:5
            if redNum(in)<1 || redNum(in)>35
                ButtonName = questdlg('The red number should not be bigeer than 35 or smaller than 1 !', 'Super Lotto', ...
                    'Yes', 'No', 'Yes');
                if strcmp(ButtonName,'No')
                    LottoContinue=0;
                end
                
                continueflag=1;
                break;
            end
            if floor(redNum(in))~=redNum(in)
                ButtonName = questdlg('The number should be integer!', 'Super Lotto', ...
                    'Yes', 'No', 'Yes');
                if strcmp(ButtonName,'No')
                    LottoContinue=0;
                end
                continueflag=1;
                break;
            end
            for im=1:5
                if in==im
                    continue;
                end
                if redNum(in)==redNum(im)
                    ButtonName = questdlg('The number should be different with each other', 'Super Lotto', ...
                        'Yes', 'No', 'Yes');
                    if strcmp(ButtonName,'No')
                        LottoContinue=0;
                    end
                    continueflag=1;
                    break;
                end
            end
        end
        if continueflag==1;
            continue;
        end
        for in=1:2
            if blueNum(in)<1 || blueNum(in)>12
                ButtonName = questdlg('The red number should not be bigeer than 12 and smaller than 1 !', 'Super Lotto', ...
                    'Yes', 'No', 'Yes');
                if strcmp(ButtonName,'No')
                    LottoContinue=0;
                end
                continueflag=1;
                break;
            end
            if floor(blueNum(in))~=blueNum(in)
                continueflag=1;
                ButtonName = questdlg('The number should be integer!', 'Super Lotto', ...
                    'Yes', 'No', 'Yes');
                if strcmp(ButtonName,'No')
                    LottoContinue=0;
                end
                break;
            end
        end
        if blueNum(1)==blueNum(2)
            continueflag=1;
            ButtonName = questdlg('The number should be different with each other', 'Super Lotto', ...
                'Yes', 'No', 'Yes');
            if strcmp(ButtonName,'No')
                LottoContinue=0;
            end
        end
        if continueflag==1
            continue;
        end
        MyLottery=[redNum,blueNum];
        MyLottery(1:5)=sort(MyLottery(1:5));
        if MyLottery(6)>MyLottery(7)
            tmp=MyLottery(6);
            MyLottery(6)=MyLottery(7);
            MyLottery(7)=tmp;
        end
        currentLottery=lotteryGenerate();
        info.currentLottery=currentLottery;
        info.myLottery=MyLottery;
        info=lotteryCheck(info);
        
        if info.rank==1
            ButtonName = questdlg(['Current lottery: ',num2str(currentLottery),...
                '                                Your lottery:      ',num2str(MyLottery),...
                '                             Congratulations. You won the 1st Prize, ',...         ',...
                'Continue?'],...
                'Super Lotto', ...
                'Yes', 'No', 'Yes');
        elseif info.rank==2
            ButtonName = questdlg(['Current lottery: ',num2str(currentLottery),...
                '                                Your lottery:      ',num2str(MyLottery),...
                '                             Congratulations. You won the 2nd Prize, ',...         ',...
                'Continue?'],...
                'Super Lotto', ...
                'Yes', 'No', 'Yes');
        elseif info.rank==3
            ButtonName = questdlg(['Current lottery: ',num2str(currentLottery),...
                '                                Your lottery:      ',num2str(MyLottery),...
                '                             Congratulations. You won the 3rd Prize, ',...         ',...
                'Continue?'],...
                'Super Lotto', ...
                'Yes', 'No', 'Yes');
        elseif info.rank==4
            ButtonName = questdlg(['Current lottery: ',num2str(currentLottery),...
                '                                Your lottery:      ',num2str(MyLottery),...
                '                             Congratulations. You won the 4th Prize, ',...         ',...
                'Continue?'],...
                'Super Lotto', ...
                'Yes', 'No', 'Yes');
        elseif info.rank==5
            ButtonName = questdlg(['Current lottery: ',num2str(currentLottery),...
                '                                Your lottery:      ',num2str(MyLottery),...
                '                             Congratulations. You won the 5th Prize, ',...         ',...
                'Continue?'],...
                'Super Lotto', ...
                'Yes', 'No', 'Yes');
        elseif info.rank==6
            ButtonName = questdlg(['Current lottery: ',num2str(currentLottery),...
                '                                Your lottery:      ',num2str(MyLottery),...
                '                             Congratulations. You won the 6th Prize, ',...         ',...
                'Continue?'],...
                'Super Lotto', ...
                'Yes', 'No', 'Yes');
        else
            ButtonName = questdlg(['Current lottery: ',num2str(currentLottery),...
                '                                Your lottery:      ',num2str(MyLottery),...
                '                             It''s a pity, ',...         ',...
                'Continue?'],...
                'Super Lotto', ...
                'Yes', 'No', 'Yes');
        end
        if strcmp(ButtonName,'No')
            LottoContinue=0;
        end
    else
        LottoContinue=0;
    end
    
    
end
end

