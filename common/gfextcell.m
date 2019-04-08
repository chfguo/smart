function  vargsOut = gfextcell( vargsIn)
%GFEXTCELL Summary of this function goes here
%   Detailed explanation goes here

gfcheckcell(vargsIn,1);
vargsin=gfcopycell(vargsIn);
NumOfCell=numel(vargsIn);
vargsOut={};
NumOfOutCell=0;
for in=1:NumOfCell
    NumOfOutCell=NumOfOutCell+1;
    if iscell(vargsin{in})
        vargsOutSub=gfextcell(vargsin{in});
        vargsOut=gfcellcat(vargsOut,vargsOutSub);
        NumOfOutCell=numel(vargsOut);
    else
        vargsOut{NumOfOutCell}=vargsin{in};
    end
end
end

