function sta = gfcheckcell(cdat,pos)
%GFCHECKCELL check dat is CELL class or not
if nargin==1
    pos=1;
end
 sta=1;
if ~isa(cdat,'cell')
    sta=0;
    nnerr.throw([' ' num2str(pos) ' argument should be cell class ']);
end
end

