function sta = gfcellisempty(cdat)
%GFCELLISEMPTY True for empty array
sta=1;
gfcheckcell(cdat,1);
nv=numel(cdat);
for in=1:nv
    ele=cdat{in};
    if isa(ele,'cell')
        sta=gfcellisempty(ele);
    else
        if isempty(ele)
            sta=1;
        else
            sta=0;
        end
    end
    if sta==0
        return;
    end
end

end

