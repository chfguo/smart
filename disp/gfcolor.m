function d = gfcolor(f)
%GFCOLOR return a color
%   icolor=gfcolor(index)           .
%   gfcolor(); dsiplays the color

if nargin==0
    lin=1:0.01:2;
    plot(lin,'color',gfcolor(1),'LineWidth',2);
    hold on
    for in=2:15
        plot(lin-in+1,'color',gfcolor(in),'LineWidth',2);
    end
    legend('1','2','3','4','5','6','7','8','9','10','11','12','13','14','15');
else
    switch f
        case 1 %red
            d=[255,0,0];
        case 4 %green
            d=[0,255,0];
        case 2 %blue
            d=[0,0,255];
        case 3 %dark
            d=[0,0,0];
        case 6 %DarkCyan
            d=[0,139,139];
        case 7 %yellow
            d=[255,255,0];
        case 8 %Brown
            d=[165,42,42];
        case 5 %Magenta
            d=[255,0,255];
        case 10 %Snow
            d=[255,137,137];
        case 11 %SlateBlue2
            d=[122,103,238];
        case 9 %Cyan
            d=[0 255 255];
        case 12 %SeaGreen
            d=[84 255 159];
        case 13 %Khaki
            d=[255 120 143];
        case 14 %Deep Yellow
            d=[180 139 50];
        case 15 %DarkGoldenrod
            d=[139 101 155];
        case 0
            d=[143,255,255];
        otherwise
            d = randi(244,[1,3])+1;
    end
    d=d/255;
end
end

