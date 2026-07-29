%% Extd Data Fig. 7 scatterplot for mechanisms

clear,clc;
load D:\Study\fires\Extreme_fires_relationship\MODISv61_newanalysis\2026.04.17.linearMixedEffect_model\tabledatafrexcel.mat
load D:\Study\fires\Extreme_fires_relationship\2022.02.14.climregion_adjust\world_extreme_region5.mat climregion5
latmap = nan(720,1440);
for i = 1 : 720
    for j = 1 : 1440
    latmap(i,j) = i;
    end
end
latavg = nan(1,45);
for ri = 1 : 45
    latavg(ri) = mean(latmap(climregion5==ri));
end

yvalues = {'NWN','NEN','WNA','CNA','ENA','NCA','SCA','CAR','NWS','NSA','NES','SAM','SWS','SES','SSA',... %1-15, need to skip 8 - CAR
    'NEU','WCE','EEU','MED','SAH','WAF','NCAF','NEAF','SEAF','WSAF','ESAF','MDG',... % 16-27, need to skip 27 - MDG
    'RAR','WSB','ESB','RFE','WCA','ECA','TIB','EAS','ARP','SAS','SEAN','NAU','CAU','EAU','SAU','NZ','SCAF','SEAS'}; % 28-45
latt = [83,82.9000000000000,71,70.9000000000000,70.8000000000000,70.3000000000000,68,67.5000000000000,30,25.9000000000000,25.8400000000000,25.8500000000000,20,19.9000000000000,19.8000000000000,82.8000000000000,82.6000000000000,82.5000000000000,70.7000000000000,70.2000000000000,25.8000000000000,25.7000000000000,25.6000000000000,25.5000000000000,18,17.5000000000000,17,82.7000000000000,82.4000000000000,82.3000000000000,82.2000000000000,70.7000000000000,70.6000000000000,70.4000000000000,70.5000000000000,70.1000000000000,70,25.4000000000000,15,14,13,12,11, 25.65, 25];
[yyv inddd] = sort(latt,'descend');
yyvalues = {};
lattvs = [];
cnt = 1;
for ri = 1 : 45
    if(inddd(ri) ~= 8 && inddd(ri) ~=13 && inddd(ri) ~= 15 && inddd(ri) ~= 16 && inddd(ri) ~= 20 && inddd(ri) ~= 27 && inddd(ri) ~= 33 && inddd(ri) ~= 36 && inddd(ri) ~= 43)
        yyvalues = {yyvalues{:}, yvalues{inddd(ri)} };        
        lattvs(cnt) = latavg(inddd(ri));
        cnt = cnt + 1;
    end
end

% figure,
% 
% xdata = bains;
% ydata = 90-lattvs/4;
% zdata = p1./p0;
% 
% s1 = scatter(xdata,ydata,80,zdata,'filled');
% s1.MarkerEdgeColor = 'none';
% hold on,
% s2 = scatter(xdata(zdata>1),ydata(zdata>1),80,zdata(zdata>1),'filled');
% s2.MarkerEdgeColor = 'k';
% 
% colormap(flipud(hot))
% caxis([0 5])
% c1 = colorbar;
% c1.Location = 'Northoutside';
% set(c1,'YTick',[1 2 3 4 5]);
% % grid on
% box on
% % set(gca,'GridLineStyle','-.')
% set(gca,'XTick',[0 :1: 6])
% set(gca,'YTick',[-60 : 15: 90],'YTickLabel',{'60^oS','','30^oS','','0^o','','30^oN','','60^oN','','90^oN'})
% 
% 
% set(gca,'YLim',[-60 90],'XLim',[0 6],'YColor','k')
% xlabel('Heatwave-Fire')
% ylabel('Heatwave-PM_{2.5}')
% get(gca,'position');
% % set(gca,'position',[0.1500    0.600    0.2134    0.2253]);
% set(gca,'FontSize',10)



figure,

subplot(3,3,7),
% obs A_H of Fn versus the predicted A_H
% datamat: 1 Fn_AH, 2 BA_AH, 3 delta_VPD, 4 delta_Lightning, 5 background treecover
xdata = datamat(:,3:5);
ydata = datamat(:,1);
zdata = 90-lattvs/4;
zzdata = ones(36,1);
reg = regstats(ydata,xdata);
yy = reg.beta(4)*xdata(:,3)+reg.beta(3)*xdata(:,2) + reg.beta(2)*xdata(:,1)+reg.beta(1);
reg.tstat.pval;
reg.rsquare;

line([0 7],[1 1],'Color',[150 150 150]./255,'LineStyle','--')
line([1 1],[0 7],'Color',[150 150 150]./255,'LineStyle','--')
hold on,
% s1 = scatter(yy,ydata,40*zzdata,zdata,'filled');
s1 = scatter(ydata,yy,40*zzdata,zdata,'filled'); % predicted as the Y
s1.MarkerEdgeColor = 'none';
s1.LineWidth = 2;
clcr = flipud(hot);
clcr = clcr(1:60,:);
clcr(1:12,:) = repmat([148 230 187]./255,12,1);
clcr(13:24,:) = repmat([200 237 173]./255,12,1);
clcr(25:36,:) = repmat([255 181 152]./255,12,1);
clcr(37:48,:) = repmat([255 140 135]./255,12,1);
clcr(49:60,:) = repmat([255 99 108]./255,12,1);
colormap(clcr);
caxis([-60 90])
c1 = colorbar;
c1.Location = 'Eastoutside';
set(c1,'YTick',[-60:15:90],'YTickLabel',{'60^oS','','30^oS','','0^o','','30^oN','','60^oN','','90^oN'});
% grid on
% colorbar off
box on
% set(gca,'GridLineStyle','-.')
set(gca,'XTick',[0 :1: 7])
set(gca,'YTick',[0 : 1: 7])
hold on,
plt = plot([0:0.1:7]',[0:0.1:7]','k-');
text(0.5,6.5,['R^2 (VPD,Lightning,Treecover) = ',num2str(round(reg.rsquare*100)/100)],'FontSize',13,'Color','r')

set(gca,'YLim',[0 7],'XLim',[0 7],'YColor','k','LineWidth',1.2)
xlabel('A_H of fire number')
ylabel('Predicted A_H of fire number')
get(gca,'position');
% set(gca,'position',[0.100    0.68    0.21    0.25]);
set(gca,'position',[0.200    0.07    0.21    0.25]);
set(gca,'FontSize',13)


subplot(3,3,8),
% obs A_H of BA versus the predicted A_H
% datamat: 1 Fn_AH, 2 BA_AH, 3 delta_VPD, 4 delta_Lightning, 5 background treecover
xdata = datamat(:,3:5);
ydata = datamat(:,2);
zdata = 90-lattvs/4;
zzdata = ones(36,1);
reg = regstats(ydata,xdata);
yy = reg.beta(4)*xdata(:,3)+reg.beta(3)*xdata(:,2) + reg.beta(2)*xdata(:,1)+reg.beta(1);
reg.tstat.pval;
reg.rsquare;

line([0 7],[1 1],'Color',[150 150 150]./255,'LineStyle','--')
line([1 1],[0 7],'Color',[150 150 150]./255,'LineStyle','--')
hold on,
% s1 = scatter(yy,ydata,40*zzdata,zdata,'filled');
s1 = scatter(ydata,yy,40*zzdata,zdata,'filled'); % predicted as the Y
s1.MarkerEdgeColor = 'none';
s1.LineWidth = 2;
clcr = flipud(hot);
clcr = clcr(1:60,:);
clcr(1:12,:) = repmat([148 230 187]./255,12,1);
clcr(13:24,:) = repmat([200 237 173]./255,12,1);
clcr(25:36,:) = repmat([255 181 152]./255,12,1);
clcr(37:48,:) = repmat([255 140 135]./255,12,1);
clcr(49:60,:) = repmat([255 99 108]./255,12,1);
colormap(clcr);
caxis([-60 90])
c1 = colorbar;
c1.Location = 'Eastoutside';
set(c1,'YTick',[-60:15:90],'YTickLabel',{'60^oS','','30^oS','','0^o','','30^oN','','60^oN','','90^oN'});
% grid on
% colorbar off
box on
% set(gca,'GridLineStyle','-.')
set(gca,'XTick',[0 :1: 7])
set(gca,'YTick',[0 : 1: 7])
hold on,
plt = plot([0:0.1:7]',[0:0.1:7]','k-');
text(0.5,6.5,['R^2 (VPD,Lightning,Treecover) = ',num2str(round(reg.rsquare*100)/100)],'FontSize',13,'Color','r')

set(gca,'YLim',[0 7],'XLim',[0 7],'YColor','k','LineWidth',1.2)
xlabel('A_H of burned area')
ylabel('Predicted A_H of burned area')
get(gca,'position');
% set(gca,'position',[0.100    0.35    0.21    0.25]);
set(gca,'position',[0.630    0.07    0.21    0.25]);
set(gca,'FontSize',13)



subplot(3,3,1),
% VPD predictability for Fn
% datamat: 1 Fn_AH, 2 BA_AH, 3 delta_VPD, 4 delta_Lightning, 5 background treecover
xdata = datamat(:,3);
ydata = datamat(:,1);
zdata = 90-lattvs/4;
zzdata = ones(36,1);
reg = regstats(ydata,xdata);
xx = 0.5:1:150;
yy = reg.beta(2)*xx+reg.beta(1);
reg.tstat.pval;
reg.rsquare;

line([0 150],[1 1],'Color',[150 150 150]./255,'LineStyle','--')
line([0 0],[0 7],'Color',[150 150 150]./255,'LineStyle','--')
hold on,
s1 = scatter(xdata,ydata,40*zzdata,zdata,'filled');
s1.MarkerEdgeColor = 'none';
s1.LineWidth = 2;
clcr = flipud(hot);
clcr = clcr(1:60,:);
clcr(1:12,:) = repmat([148 230 187]./255,12,1);
clcr(13:24,:) = repmat([200 237 173]./255,12,1);
clcr(25:36,:) = repmat([255 181 152]./255,12,1);
clcr(37:48,:) = repmat([255 140 135]./255,12,1);
clcr(49:60,:) = repmat([255 99 108]./255,12,1);
colormap(clcr);
caxis([-60 90])
c1 = colorbar;
c1.Location = 'Eastoutside';
set(c1,'YTick',[-60:15:90],'YTickLabel',{'60^oS','','30^oS','','0^o','','30^oN','','60^oN','','90^oN'});
% grid on
colorbar off
box on
% set(gca,'GridLineStyle','-.')
set(gca,'XTick',[0 :30: 180])
set(gca,'YTick',[0 : 1: 7])

hold on,
plt = plot(xx,yy,'k-');
text(8,6.5,['R^2 (VPD) = ',num2str(round(reg.rsquare*100)/100)],'FontSize',13)
set(gca,'YLim',[0 7],'XLim',[0 150],'YColor','k','LineWidth',1.2)
xlabel('VPD change during heatwaves (%)')
ylabel('A_H of fire number')
get(gca,'position');
% set(gca,'position',[0.380    0.68    0.21    0.25]);
set(gca,'position',[0.100    0.73    0.21    0.25]);
set(gca,'FontSize',13)


% ----- BA_Ah 
subplot(3,3,4),
% datamat: 1 Fn_AH, 2 BA_AH, 3 delta_VPD, 4 delta_Lightning, 5 background treecover
xdata = datamat(:,3);
ydata = datamat(:,2);
zdata = 90-lattvs/4;
zzdata = ones(36,1);
reg = regstats(ydata,xdata);
xx = 0.5:1:150;
yy = reg.beta(2)*xx+reg.beta(1);
reg.tstat.pval;
reg.rsquare;

line([0 150],[1 1],'Color',[150 150 150]./255,'LineStyle','--')
line([0 0],[0 7],'Color',[150 150 150]./255,'LineStyle','--')
hold on,
s1 = scatter(xdata,ydata,40*zzdata,zdata,'filled');
s1.MarkerEdgeColor = 'none';
s1.LineWidth = 2;
clcr = flipud(hot);
clcr = clcr(1:60,:);
clcr(1:12,:) = repmat([148 230 187]./255,12,1);
clcr(13:24,:) = repmat([200 237 173]./255,12,1);
clcr(25:36,:) = repmat([255 181 152]./255,12,1);
clcr(37:48,:) = repmat([255 140 135]./255,12,1);
clcr(49:60,:) = repmat([255 99 108]./255,12,1);
colormap(clcr);
caxis([-60 90])
c1 = colorbar;
c1.Location = 'Northoutside';
set(c1,'YTick',[-60:15:90],'YTickLabel',{'60^oS','','30^oS','','0^o','','30^oN','','60^oN','','90^oN'});
% grid on
colorbar off
box on
% set(gca,'GridLineStyle','-.')
set(gca,'XTick',[0 :30: 180])
set(gca,'YTick',[0 : 1: 7])

hold on,
plt = plot(xx,yy,'k-');
text(8,6.5,['R^2 (VPD) = ',num2str(round(reg.rsquare*100)/100)],'FontSize',13)
set(gca,'YLim',[0 7],'XLim',[0 150],'YColor','k','LineWidth',1.2)
xlabel('VPD change during heatwaves (%)')
ylabel('A_H of burned area')
get(gca,'position');
% set(gca,'position',[0.380    0.35    0.21    0.25]);
set(gca,'position',[0.100    0.4    0.21    0.25]);
set(gca,'FontSize',13)



% ----- Fn_Ah, delt_Lightning
subplot(3,3,2),
% datamat: 1 Fn_AH, 2 BA_AH, 3 delta_VPD, 4 delta_Lightning, 5 background treecover
xdata = datamat(:,4);
ydata = datamat(:,1);
zdata = 90-lattvs/4;
zzdata = ones(36,1);
reg = regstats(ydata,xdata);
xx = -100:1:230;
yy = reg.beta(2)*xx+reg.beta(1);
reg.tstat.pval;
reg.rsquare;

line([-100 230],[1 1],'Color',[150 150 150]./255,'LineStyle','--')
line([0 0],[0 7],'Color',[150 150 150]./255,'LineStyle','--')
hold on,
s1 = scatter(xdata,ydata,40*zzdata,zdata,'filled');
s1.MarkerEdgeColor = 'none';
s1.LineWidth = 2;
clcr = flipud(hot);
clcr = clcr(1:60,:);
clcr(1:12,:) = repmat([148 230 187]./255,12,1);
clcr(13:24,:) = repmat([200 237 173]./255,12,1);
clcr(25:36,:) = repmat([255 181 152]./255,12,1);
clcr(37:48,:) = repmat([255 140 135]./255,12,1);
clcr(49:60,:) = repmat([255 99 108]./255,12,1);
colormap(clcr);
caxis([-60 90])
c1 = colorbar;
c1.Location = 'Eastoutside';
set(c1,'YTick',[-60:15:90],'YTickLabel',{'60^oS','','30^oS','','0^o','','30^oN','','60^oN','','90^oN'});
colorbar off
% grid on
box on
% set(gca,'GridLineStyle','-.')
set(gca,'XTick',[-100 :50: 230])
set(gca,'YTick',[0 : 1: 7])

hold on,
plt = plot(xx,yy,'k-');
text(-80,6.5,['R^2 (Lightning) = ',num2str(round(reg.rsquare*100)/100)],'FontSize',13)

set(gca,'YLim',[0 7],'XLim',[-100 230],'YColor','k','LineWidth',1.2)
xlabel('Lightning change during heatwaves (%)')
ylabel('A_H of fire number')
get(gca,'position');
% set(gca,'position',[0.660    0.68    0.210    0.25]);
set(gca,'position',[0.380    0.73    0.21    0.25]);
set(gca,'FontSize',13)


% ----- BA_Ah, delt_Lightning
subplot(3,3,5),
% datamat: 1 Fn_AH, 2 BA_AH, 3 delta_VPD, 4 delta_Lightning, 5 background treecover
xdata = datamat(:,4);
ydata = datamat(:,2);
zdata = 90-lattvs/4;
zzdata = ones(36,1);
reg = regstats(ydata,xdata);
xx = -100:1:230;
yy = reg.beta(2)*xx+reg.beta(1);
reg.tstat.pval;
reg.rsquare;

line([-100 230],[1 1],'Color',[150 150 150]./255,'LineStyle','--')
line([0 0],[0 7],'Color',[150 150 150]./255,'LineStyle','--')
hold on,
s1 = scatter(xdata,ydata,40*zzdata,zdata,'filled');
s1.MarkerEdgeColor = 'none';
s1.LineWidth = 2;
clcr = flipud(hot);
clcr = clcr(1:60,:);
clcr(1:12,:) = repmat([148 230 187]./255,12,1);
clcr(13:24,:) = repmat([200 237 173]./255,12,1);
clcr(25:36,:) = repmat([255 181 152]./255,12,1);
clcr(37:48,:) = repmat([255 140 135]./255,12,1);
clcr(49:60,:) = repmat([255 99 108]./255,12,1);
colormap(clcr);
caxis([-60 90])
c1 = colorbar;
c1.Location = 'Eastoutside';
set(c1,'YTick',[-60:15:90],'YTickLabel',{'60^oS','','30^oS','','0^o','','30^oN','','60^oN','','90^oN'});
colorbar off
% grid on
box on
% set(gca,'GridLineStyle','-.')
set(gca,'XTick',[-100 :50: 230])
set(gca,'YTick',[0 : 1: 7])
hold on,
plt = plot(xx,yy,'k-');
text(-80,6.5,['R^2 (Lightning) = ',num2str(round(reg.rsquare*100)/100)],'FontSize',13)

set(gca,'YLim',[0 7],'XLim',[-100 230],'YColor','k','LineWidth',1.2)
xlabel('Lightning change during heatwaves (%)')
ylabel('A_H of burned area')
get(gca,'position');
% set(gca,'position',[0.660    0.35    0.210    0.25]);
set(gca,'position',[0.380    0.40    0.21    0.25]);
set(gca,'FontSize',13)

% ----- Fn_Ah, bg treecover
subplot(3,3,3),
% datamat: 1 Fn_AH, 2 BA_AH, 3 delta_VPD, 4 delta_Lightning, 5 background treecover
xdata = datamat(:,5);
ydata = datamat(:,1);
zdata = 90-lattvs/4;
zzdata = ones(36,1);
reg = regstats(ydata,xdata);
xx = 0:15:60;
yy = reg.beta(2)*xx+reg.beta(1);
reg.tstat.pval;
reg.rsquare;

line([0 60],[1 1],'Color',[150 150 150]./255,'LineStyle','--')
line([0 0],[0 7],'Color',[150 150 150]./255,'LineStyle','--')
hold on,
s1 = scatter(xdata,ydata,40*zzdata,zdata,'filled');
s1.MarkerEdgeColor = 'none';
s1.LineWidth = 2;
clcr = flipud(hot);
clcr = clcr(1:60,:);
clcr(1:12,:) = repmat([148 230 187]./255,12,1);
clcr(13:24,:) = repmat([200 237 173]./255,12,1);
clcr(25:36,:) = repmat([255 181 152]./255,12,1);
clcr(37:48,:) = repmat([255 140 135]./255,12,1);
clcr(49:60,:) = repmat([255 99 108]./255,12,1);
colormap(clcr);
caxis([-60 90])
c1 = colorbar;
c1.Location = 'Eastoutside';
set(c1,'YTick',[-60:15:90],'YTickLabel',{'60^oS','','30^oS','','0^o','','30^oN','','60^oN','','90^oN'});
% colorbar off
% grid on
box on
% set(gca,'GridLineStyle','-.')
set(gca,'XTick',[0 :15: 60])
set(gca,'YTick',[0 : 1: 7])

hold on,
plt = plot(xx,yy,'k-');
text(4,6.5,['R^2 (Treecover) = ',num2str(round(reg.rsquare*100)/100)],'FontSize',13)

set(gca,'YLim',[0 7],'XLim',[0 60],'YColor','k','LineWidth',1.2)
xlabel('Background tree cover (%)')
ylabel('A_H of fire number')
get(gca,'position');
% set(gca,'position',[0.1300    0.05    0.3347    0.25]);
set(gca,'position',[0.660    0.73    0.210    0.25]);
set(gca,'FontSize',13)

% ----- Fn_Ah, bg treecover
subplot(3,3,6),
% datamat: 1 Fn_AH, 2 BA_AH, 3 delta_VPD, 4 delta_Lightning, 5 background treecover
xdata = datamat(:,5);
ydata = datamat(:,2);
zdata = 90-lattvs/4;
zzdata = ones(36,1);
reg = regstats(ydata,xdata);
xx = 0:15:60;
yy = reg.beta(2)*xx+reg.beta(1);
reg.tstat.pval;
reg.rsquare;

line([0 60],[1 1],'Color',[150 150 150]./255,'LineStyle','--')
line([0 0],[0 7],'Color',[150 150 150]./255,'LineStyle','--')
hold on,
s1 = scatter(xdata,ydata,40*zzdata,zdata,'filled');
s1.MarkerEdgeColor = 'none';
s1.LineWidth = 2;
clcr = flipud(hot);
clcr = clcr(1:60,:);
clcr(1:12,:) = repmat([148 230 187]./255,12,1);
clcr(13:24,:) = repmat([200 237 173]./255,12,1);
clcr(25:36,:) = repmat([255 181 152]./255,12,1);
clcr(37:48,:) = repmat([255 140 135]./255,12,1);
clcr(49:60,:) = repmat([255 99 108]./255,12,1);
colormap(clcr);
caxis([-60 90])
c1 = colorbar;
c1.Location = 'Eastoutside';
set(c1,'YTick',[-60:15:90],'YTickLabel',{'60^oS','','30^oS','','0^o','','30^oN','','60^oN','','90^oN'});
% colorbar off
% grid on
box on
% set(gca,'GridLineStyle','-.')
set(gca,'XTick',[0 :15: 60])
set(gca,'YTick',[0 : 1: 7])

hold on,
plt = plot(xx,yy,'k-');
text(4,6.5,['R^2 (Treecover) = ',num2str(round(reg.rsquare*100)/100)],'FontSize',13)

set(gca,'YLim',[0 7],'XLim',[0 60],'YColor','k','LineWidth',1.2)
xlabel('Background tree cover (%)')
ylabel('A_H of burned area')
get(gca,'position');
% set(gca,'position',[0.5700    0.05    0.3347    0.25]);
set(gca,'position',[0.6600    0.40    0.21    0.25]);
set(gca,'FontSize',13)

% 
% reg = regstats(datamat(:,1),datamat(:,3:5));
% reg.rsquare
% 
% reg = regstats(datamat(:,1),datamat(:,3:4));
% reg.rsquare
% 
% reg = regstats(datamat(:,2),datamat(:,3:5));
% reg.rsquare
% 
% reg = regstats(datamat(:,2),datamat(:,3:4));
% reg.rsquare

set(gcf,'position',[480         141        1580        1197])
