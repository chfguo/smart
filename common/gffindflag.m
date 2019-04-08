function [isfind varsListOut]= gffindflag(varsList, flag)
%GFFINDFLAG Summary of this function goes here
%   Detailed explanation goes here

nv=numel(varsList);
isfind=0;
for i=1:nv
        if strcmp(varsList{i},flag)
            varsList{i}=[];
            isfind=1;
            break;
        end 
end
varsListOut=gfcopycell(varsList);
end

