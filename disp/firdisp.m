function firdisp(hObject,handles)
%FIRDISP Summary of this function goes here
%   Detailed explanation goes here
handles.firName=get(handles.filterType,'value');
handles.firOrder=str2double(get(handles.OrderEdit,'String'));
handles.firWp=str2double(get(handles.WpEdit,'String'));
handles.firWs=str2double(get(handles.WsEdit,'String'));
handles.firRp=str2double(get(handles.RpEdit,'String'));
handles.firRs=str2double(get(handles.RsEdit,'String'));
handles.Wn=str2double(get(handles.WnEdit,'String'));
handles.SI=str2double(get(handles.SIEdit,'String'));
guidata(hObject,handles);
N=handles.firOrder;
Wp=handles.firWp;
Ws=handles.firWs;
Rp=handles.firRp;
Rs=handles.firRs;
firType=handles.firType;
firName=handles.firName;

set(gcf,'CurrentAxes',handles.Raxes);
if handles.SI>handles.ntr
    warndlg('Number of sampling trace must be less than total number');
    return;
end
if handles.firWp>1 || handles.firWp<0
    warndlg(' 0 < Wp < 1 ');
    return;
end
if handles.firWs>1 || handles.firWs<0
    warndlg(' 0 < Ws < 1 ');
    return;
end

data=handles.data(:,handles.SI);
t=(0:handles.ns-1)*handles.dt;
set(gcf,'CurrentAxes',handles.Raxes);
plot(t,data);
xlim([0,t(end)+t(2)]);
title([num2str(handles.SI),' trace raw data']);
xlabel('Z-Axis');
ylabel('Amplitude');

set(gcf,'CurrentAxes',handles.Faxes)
fdata=abs(fft(data));
fmax=1/handles.dt;
ff=fmax/(handles.ns-1)*(0:handles.ns);
ffindex=floor(handles.ns/2*handles.Wn);
plot(ff(1:ffindex),fdata(1:ffindex));
xlim([0,ff(ffindex)]);
title([num2str(handles.SI),' trace frequency spectrum']);
xlabel('Normalized frequency');
ylabel('Amplitude');
flag=0;
if strcmp(firType,'low')
    flag=1;
    switch firName
        case 1
            [B,A]=butter(N,Ws,'low');
        case 2
            [B,A]=cheby1(N,Rp,Ws,'low');
        case 3
            [B,A]=cheby2(N,Rp,Ws,'low');
        case 4
            [B,A]=ellip(N,Rp,Rs,Ws,'low');
    end
elseif strcmp(firType,'high')
    flag=1;
    switch firName
        case 1
            [B,A]=butter(N,Wp,'high');
        case 2
            [B,A]=cheby1(N,Rp,Wp,'high');
        case 3
            [B,A]=cheby2(N,Rp,Wp,'high');
        case 4
            [B,A]=ellip(N,Rp,Rs,Wp,'high');
    end
elseif strcmp(firType,'bandstop')
    flag=1;
    switch firName
        case 1
            [B,A]=butter(N,[Ws,Wp],'stop');
        case 2
            [B,A]=cheby1(N,Rp,[Ws,Wp],'stop');
        case 3
            [B,A]=cheby2(N,Rp,[Ws,Wp],'stop');
        case 4
            [B,A]=ellip(N,Rp,Rs,[Ws,Wp],'stop');
    end
else
    switch firName
        case 1
            [Bh,Ah]=butter(N,Ws,'high');
            [Bl,Al]=butter(N,Wp,'low');
        case 2
            [Bh,Ah]=cheby1(N,Rp,Ws,'high');
            [Bl,Al]=cheby1(N,Rp,Wp,'low');
        case 3
            [Bh,Ah]=cheby2(N,Rp,Ws,'high');
            [Bl,Al]=cheby2(N,Rp,Wp,'low');
        case 4
            [Bh,Ah]=ellip(N,Rp,Rs,Ws,'high');
            [Bl,Al]=ellip(N,Rp,Rs,Wp,'low');
    end
end
if flag==1
    data=filter(B,A,data);
    set(gcf,'CurrentAxes',handles.Paxes);
    plot(t,data);
    xlim([0,t(end)+t(2)]);
    title([num2str(handles.SI),' trace data after filtering']);
    xlabel('Z-Axis');
    ylabel('Amplitude');
    
    set(gcf,'CurrentAxes',handles.Haxes);
    H=freqz(B,A,floor(handles.ns/2));
    plot(ff(1:ffindex),abs(H(1:ffindex)));
    xlim([0,ff(ffindex)]);
    title('filter response');
    xlabel('Normalized frequency');
    ylabel('Normalized Amp.');
    ylim([-0.1,1.2]);
    set(gca,'YTick',[0,1]);
else
    data=filter(Bh,Ah,data);
    data=filter(Bl,Al,data);
    set(gcf,'CurrentAxes',handles.Paxes);
    plot(t,data);
    xlim([0,t(end)+t(2)]);
    title([num2str(handles.SI),' trace data after filtering']);
    xlabel('Z-Axis');
    ylabel('Amplitude');
    
    set(gcf,'CurrentAxes',handles.Haxes);
    Hh=freqz(Bh,Ah,floor(handles.ns/2));
    Hl=freqz(Bl,Al,floor(handles.ns/2));
    plot(ff(1:ffindex),abs(Hh(1:ffindex)).* ...
        abs(Hl(1:ffindex)));
    xlim([0,ff(ffindex)]);
    title('filter response');
    xlabel('Normalized frequency');
    ylabel('Normalized Amp.');
    ylim([-0.1,1.2]);
    set(gca,'YTick',[0,1]);
    
end

end

