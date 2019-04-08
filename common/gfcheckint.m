function sta= gfcheckint( cdat,pos )
%GFCHECKINT check dat is INTEGER class or not
if nargin==1
    pos=1;
end
 sta=1;

if ~isa(cdat,'integer')
    sta=0;
    nnerr.throw([' ' num2str(pos) ' argument should be integer class']);
end
end

