function sta = gfcheckposi(cdat,pos)
%GFCHECKPOSI check dat is positive or not
if nargin==1
    pos=1;
end
 sta=1;
if cdat<0 || cdat==0
    sta=0;
    nnerr.throw([' ' num2str(pos) ' argument should be positive']);
end

end

