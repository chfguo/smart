function plotc(varargin)

n=numel(varargin);
if n==1 && iscomplex(varargin{1})
    plot(real(varargin{1}),'r','LineWidth',2)
    hold on
    plot(imag(varargin{1}),'b','LineWidth',2)
    hold off
    legend('Real','Imaginary');
    set(gcf,'Color',[1,1,1]);
    grid on
elseif n==1 && isreal(varargin{1})
    plot(varargin{1},'r','LineWidth',2)
    set(gcf,'Color',[1,1,1]);
    grid on
end
if n==2 && iscomplex(varargin{2})
    plot(varargin{1},real(varargin{2}),'r','LineWidth',2)
    hold on
    plot(varargin{1},imag(varargin{2}),'b','LineWidth',2)
    hold off
    legend('Real','Imaginary');
    set(gcf,'Color',[1,1,1]);
    grid on
elseif n==2 && isreal(varargin{2})
    plot(varargin{1},varargin{2},'r','LineWidth',2)
    set(gcf,'Color',[1,1,1]);
    grid on
end




end

