function sta = gfcheckstr(cdat)
%GFCHECKSTR str is character array or not
if nargin==1
    pos=1;
end
 sta=1;
 
if ~isa(cdat,'char')
    
    sta=0;
    nnerr.throw([' ' num2str(pos) ' argument should be char class']);
end

end

