function sta = gfcheckfloat(cdat,pos)
%GFCHECKFLOAT check dat is the float class or not
if nargin==1
    pos=1;
end
 sta=1;

if ~isa(cdat,'float')
    sta=0;
    nnerr.throw(['' num2str(pos) ' argument should be float class']);
end
end

