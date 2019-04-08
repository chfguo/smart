function [val,isok] = gfinput(titlestr,promptstr,defaultanswer)
%GFINPUT input dialog 
%   [val,isok] = gfinput(titlestr,promptstr,defaultanswer)
%   For example:
%   [val,isok] = gfinput('input dialog',{'line1','line2'},{'1','2'})
%
isok=0;
val=0;
np=numel(promptstr);
nd=numel(defaultanswer);
if np~=nd
    error('inputdlg参数个数不一致！');
    return;
end
numlines=1;
val1=cell(np);
options.Resize='on';
options.WindowStyle='normal';
options.Interpreter='tex';
answer=inputdlg(promptstr,titlestr,numlines,defaultanswer,options);
isok=1;
if isempty(answer)
    isok=0;
    return;
end

for in=1:np
    if isempty(answer{in})
        warndlg(['第',num2str(in),'个参数为空']);
    end
    val1{in}=str2num(answer{in});
end
for in=1:np
    if prod(size(val1{in}))>1
        val=val1;
        return;
    end
end
val=zeros(1,np);
if nargout>1
for in=1:np
    val(in)=val1{in};
end
end
end

