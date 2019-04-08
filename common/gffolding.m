function [f,v] = gffolding(vel,dh,hN,gflag,plotflag)
% gffolding finite difference dispersion analysis
% gffolding(vel,dh,N,gflag)
% [f,v] = gffolding(vel,dh,N,gflag,plotflag)
%   vel:   velocity
%   dh:    space interval
%   hN:    the half order of FD, if N = 1, the FD's order is 2N
%   gflag: 'sg' for staggered-grid FD
%          'cg' for centered-grid FD
%   plotflag: 1 show a plot
%             0 not to show a plot
%   f:     frequency
%   v:     numerical velocity
%   Example 1:
%       gffolding(2000,10,4,'sg')
%
%   Example 2:
%       [f1,v1] = gffolding(2000,10,4,'sg',0);
%       [f2,v2] = gffolding(2000,10,5,'sg',0);
%       plot(f1,v1);
%       hold on;
%       plot(f2,v2,'r')
%       grid on
%       ylabel('Relative velocity');
%       xlabel('Frequency/Hz');
%       axis([f1(1),f1(end),min(v1),max(v1)]);
%
% You can set the FD coefficients like following:
% gffolding(vel,dh,N,gflag)
% [f,v] = gffolding(vel,dh,N,gflag,plotflag)
%   cm:    FD coefficients
%   Example 3:
%       cm = gfstcoef(4);
%       gffolding(2000,10,cm,'sg')
%
%   Example 4:
%       cm1 = gfstcoef(4);
%       cm2 = gfstcoef(5);
%       [f1,v1] = gffolding(2000,10,cm1,'sg',0);
%       [f2,v2] = gffolding(2000,10,cm2,'sg',0);
%       plot(f1,v1);
%       hold on;
%       plot(f2,v2,'r')
%       grid on
%       ylabel('Relative velocity');
%       xlabel('Frequency/Hz');
%       axis([f1(1),f1(end),min(v1),max(v1)]);
%
%   Guo Chengfeng 2017-12-13

if nargin < 5
    plotflag = 1;
end
if nargin<4
    gflag='sg';
end
if nargin<3
    hN=5;
end
if nargin<2
    dh=10;
end
if nargin<1
    vel=1500;
end
vo=vel;
h=dh;

if numel(hN) == 1 && floor(hN) == hN
    N = hN;
else
    cm = hN;
    N = numel(cm);
end

if numel(hN) == 1 && floor(hN) == hN
    if strcmp(gflag,'sg')
        cm = gfstcoef(N);
    else
        cm = gfcoef(N);
    end
end

d2=cm;

if nargout == 0
    k=(0:0.001:1/h)*2*pi;
    d1=k;
    for j=2:size(k,2)
        for i=1:N
            if strcmp(gflag,'sg')
                d2(i)=sin(k(j)*h*(i-0.5));
            else
                d2(i)=sin(k(j)*h*(i));
            end
        end
        d1(j)=vo/pi/h*sum(cm.*d2);
    end
    f=d1;
    vf=f./k/vo*pi*2;
    
    plot(f(2:end),vf(2:end),'LineWidth',1.5)
    title(['Relation of f-v (N=' num2str(2*N) ', dx=' num2str(h) ')'],'FontName','Times New Roman','FontSize',12);
    ylabel('Relative velocity','FontName','Times New Roman','FontSize',12);
    xlabel('Frequency/Hz','FontName','Times New Roman','FontSize',12);
    
    hold on
    foldingF=1/h/2*vel; % folding frequency in theory
    foldF=f;
    for i=1:size(f,2)
        foldF(i)=foldingF;
    end
    plot(foldF(2:end),vf(2:end),'r--','LineWidth',1.5)
    
    foldingFn=f;% actual folding frequency
    for i=1:size(f,2)
        foldingFn(i)=max(f);
    end
    plot(foldingFn(2:end),vf(2:end),'g--','LineWidth',1.5)
    
    
    [val,index]=max(f);
    fmax=1:1:floor(val)+1;
    slip=fmax;
    for i=1:floor(val)+1
        slip(i)=vf(index);
    end
    plot(fmax,slip,'m--','LineWidth',1.5)
    text(val/2,0.5+vf(index)/2,'Dispersion region','FontName','Times New Roman','FontSize',12);
    text(val/2,vf(index)/2,'Aliasing region','FontName','Times New Roman','FontSize',12);
    legend(['Velocity: ' num2str(vel) 'm/s'],['Theoretical folding Frequency(',num2str(roundn(foldingF,-1)) 'Hz)'], ...
        ['Numerical folding Frequency(',num2str(roundn(max(f),-1)) 'Hz)'],'location','best');
    grid on
end
if nargout==2
    
    k=(0:0.001:1/h)*pi;
    d1=k;
    for j=2:size(k,2)
        for i=1:N
            if strcmp(gflag,'sg')
                d2(i)=sin(k(j)*h*(i-0.5));
            else
                d2(i)=sin(k(j)*h*(i));
            end
        end
        d1(j)=vo/pi/h*sum(cm.*d2);
    end
    f=d1;
    vf=f./k/vo*pi*2;
    v = vf;
    if plotflag
        plot(f,vf);
        ylabel('Relative velocity','FontName','Times New Roman','FontSize',12);
        xlabel('Frequency/Hz','FontName','Times New Roman','FontSize',12);
        axis([f(1),f(end),min(vf),max(vf)]);
        grid on
    end
    
end





