function H = gfupline(Nz,N,Wn)
%GFUPLINE 
%   H = gfupline(Nz,N,Wn)
if nargin < 3
    Wn=0.2;
end
if nargin < 2 
N=2;
end

[B,A]=butter(N,Wn,'high');
H=freqz(B,A,Nz);
H=abs(H);
H=H.*H;
end

