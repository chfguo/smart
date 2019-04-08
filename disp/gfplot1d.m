function gfplot1d(data,x,xlabelstr,ylabelstr)

if nargin==1
    plot(data,'LineWidth',2);
    xlabel('Sample point','Fontsize',18,'Fontname','Times New Roman');
    ylabel('Amplitude','Fontsize',18,'Fontname','Times New Roman');
    set(gca,'Fontsize',14);
end

if nargin==2
    plot(data,x,'LineWidth',2);
    xlabel('Sample point','Fontsize',18,'Fontname','Times New Roman');
    ylabel('Amplitude','Fontsize',18,'Fontname','Times New Roman');
    set(gca,'Fontsize',14);
end

if nargin==3
    plot(data,'LineWidth',2);
    xlabel(xlabelstr,'Fontsize',18,'Fontname','Times New Roman');
    ylabel(ylabelstr,'Fontsize',18,'Fontname','Times New Roman');
    set(gca,'Fontsize',14);
end

if nargin==4
    plot(data,x,'LineWidth',2);
    xlabel(xlabelstr,'Fontsize',18,'Fontname','Times New Roman');
    ylabel(ylabelstr,'Fontsize',18,'Fontname','Times New Roman');
    set(gca,'Fontsize',14);
end

end

