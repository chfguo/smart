function rdat = gfcopycell(sdat)
%GFCOPYCELL copy cell sdat to another cell without empty element

gfcheckcell(sdat);
if gfcellisempty(sdat)
    rdat={};
    return;
end
ik=1;
nv=numel(sdat);
for in=1:nv
    ele=sdat{in};
    if isa(ele,'cell')
        if ~gfcellisempty(ele)
            rdat{ik}=gfcopycell(ele);
            ik=ik+1;
        end
    else
        if ~isempty(ele)
            rdat{ik}=ele;
            ik=ik+1;
        end
    end
        

end

