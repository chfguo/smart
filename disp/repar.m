% reset parameters list for gfplot
icolor='j';
iszero=0;
iscolorbar=0;
isreverse=0;
igain=1;
axesPro.FontNamePopupmenu=1;
axesPro.WeightPopupmenu=3;
axesPro.AnglePopupmenu=2;
axesPro.xLabelEdit='Distance(Km)';
axesPro.yLabelEdit='Depth(Km)';
axesPro.xySizePopupmenu=18;
axesPro.fillupPopupmenu=2;
axesPro.xStartEdit=0.0;
axesPro.yStartEdit=0.0;
axesPro.xStepEdit=0.01;
axesPro.yStepEdit=0.01;
axesPro.LineWidthEdit=1.5;
axesPro.mainSizePopupmenu=18;

axesPro.barLabelEdit='Amplitude';
axesPro.barSizePopupmenu=12;

axesPro.titleSizePopupmenu=12;
axesPro.titleEdit=[];

fcnName=[];
isautosize=0;

save(which('par.mat','file'),'fcnName','isautosize','igain',...
    'isreverse','iscolorbar','iszero','icolor','axesPro');