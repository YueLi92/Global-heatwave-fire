%% 1. Figure 1 - bar plots
clear,clc;
load D:\Study\fires\Extreme_fires_relationship\2022.05.31.heatwave_newdef\2021.10.16.heatwv_nheatwv_comp3\amplification_factor_htwv.mat
yvalues = {'NWN','NEN','WNA','CNA','ENA','NCA','SCA','CAR','NWS','NSA','NES','SAM','SWS','SES','SSA',... %1-15, need to skip 8 - CAR
    'NEU','WCE','EEU','MED','SAH','WAF','NCAF','NEAF','SEAF','WSAF','ESAF','MDG',... % 16-27, need to skip 27 - MDG
    'RAR','WSB','ESB','RFE','WCA','ECA','TIB','EAS','ARP','SAS','SEAN','NAU','CAU','EAU','SAU','NZ','SCAF','SEAS'}; % 28-45
xvalues = {{'Fire number'}, {'Burned area'},{'Mean size'}};
nbb = {'a','b','c'};
id1 = [1 2 17 18 28 29 30 31];
id2 = [3 4 5 6 19 32 33 34 35 36 38];
id3 = [7 9 10 11 12 21 22 23 24 37 39 44,45];
id4 = [14 25 26 40 41 42];

% msg1 = 'Boreal ecosystems include:'
% yvalues{id1}
for ri = 1 : 45
    for i = 2 : 3
        if(  sum(dataall(2,:,i,ri)) / sum(sum(dataall(2,:,2:3,ri))) < 0.05 || sum(dataall(3,:,i,ri)) / sum(sum(dataall(3,:,2:3,ri))) < 0.05 )
            dataamp(ri,:,i) = nan;
            dataall(4:6,:,i,ri) = nan;
        end
    end
end

% figure,
ddmpmean = nan(4,3);
ddmpmean2 = nan(4,3);
ddmpstd = nan(4,3);
ddmp2mean = nan(4,3);
ddmp2mean2 = nan(4,3);
ddmp2std = nan(4,3);
ddmp3mean = nan(4,3);
ddmp3std = nan(4,3);
ddmp3mean2 = nan(4,3);
for i = 1 : 3
    
    for k = 1 : 4
        if(k==1)
            idd = id1;
        elseif(k==2)
            idd = id2;
        elseif(k==3)
            idd = id3;
        else
            idd = id4;
        end
        ddmp = reshape(dataall(i+3,2,1,idd) ./dataall(i+3,1,1,idd),length(idd),1);        
        ddmpmean(k,i) = nanmean(ddmp);
        ddmpstd(k,i) = nanstd(ddmp);
        ddmpmean2(k,i) = nanmean(dataall(i+3,2,1,idd)) ./ nanmean(dataall(i+3,1,1,idd));
        
        ddmp2 = reshape(dataall(i+3,2,2,idd) ./ dataall(i+3,1,2,idd),length(idd),1);
        ddmp2mean(k,i) = nanmean(ddmp2);
        ddmp2std(k,i) = nanstd(ddmp2);
        ddmp2mean2(k,i) = nanmean(dataall(i+3,2,2,idd)) ./ nanmean(dataall(i+3,1,2,idd));
        
        ddmp3 = reshape(dataall(i+3,2,3,idd) ./ dataall(i+3,1,3,idd),length(idd),1);
        ddmp3mean(k,i) = nanmean(ddmp3);
        ddmp3std(k,i) = nanstd(ddmp3);
        ddmp3mean2(k,i) = nanmean(dataall(i+3,2,3,idd)) ./ nanmean(dataall(i+3,1,3,idd));
    end
    
end

% ddmpmean = ddmpmean2;
% ddmp2mean = ddmp2mean2;
% ddmp3mean = ddmp3mean2;

figure,
for i = 1 : 3
    if(i ==2)
        ci =3;
    elseif(i==3)
        ci = 2;
    else
        ci =1;
    end
    subplot(1,3,i),
    line([1 1],[0 5],'LineStyle',':','Color','k','LineWidth',1.2)
    hold on,
    if(ci ==1)
        b1 = barh([4 3 2 1],[ddmp3mean(:,ci) ddmp2mean(:,ci) ddmpmean(:,ci)]);
        hold on,
        xx = [3.8 4 4.2; 2.8 3 3.2; 1.8 2 2.2; 0.8 1 1.2];
        e1 = errorbar([ddmp3mean(:,ci) ddmp2mean(:,ci) ddmpmean(:,ci)],xx,zeros(4,3),[ddmp3std(:,ci) ddmp2std(:,ci) ddmpstd(:,ci)],'horizontal',...
            'LineStyle','none','Color','k');
    elseif(ci ==2)
        b1 = barh([4 3 2 1],[ddmp3mean(:,ci) ddmp2mean(:,ci) ddmpmean(:,ci)]);
        hold on,
        xx = [3.8 4 4.2; 2.8 3 3.2; 1.8 2 2.2; 0.8 1 1.2];
        e1 = errorbar([ddmp3mean(:,ci) ddmp2mean(:,ci) ddmpmean(:,ci)],xx,zeros(4,3),[ddmp3std(:,ci) ddmp2std(:,ci) ddmpstd(:,ci)],'horizontal',...
            'LineStyle','none','Color','k');
    else
        b1 = barh([4 3 2 1],[ddmp3mean(:,ci) ddmp2mean(:,ci) ddmpmean(:,ci)]);
        hold on,
        xx = [3.8 4 4.2; 2.8 3 3.2; 1.8 2 2.2; 0.8 1 1.2];
        e1 = errorbar([ddmp3mean(:,ci) ddmp2mean(:,ci) ddmpmean(:,ci)],xx,zeros(4,3),[ddmp3std(:,ci) ddmp2std(:,ci) ddmpstd(:,ci)],'horizontal',...
            'LineStyle','none','Color','k');
    end
    b1(1).FaceColor = [0 240 0]/255;
%     b1(1).EdgeColor = 'none';
    b1(2).FaceColor = [0 171 40]/255;
%     b1(2).EdgeColor = 'none';
    b1(3).FaceColor = [0 0 0]/255;
%     b1(3).EdgeColor = 'none';
    
    box on
    set(gca,'FontSize',13)    
    
%     figure1_b
    set(gca,'XLim',[0 10],'XTick',[0:2:10],'YTick',[],'YLim',[0.5 4.5])

%     %figure1_a
%     set(gca,'XLim',[0 6.5],'XTick',[0:2:10],'YTick',[],'YLim',[0.5 4.5])
    set(gca,'TickDir','out','LineWidth',1.2)
%     if(i ==3)
%         legend(b1,{'Non-forest','Forest','All'},'Location','bestoutside')
%     end
end

% Output to excel of data of figure 2


%% 1. Figure 1 - bar plots - bigfire
% % Code to reproduce the Amplification factor as in figure 3/figure 2
% % in figure22_statistics\figure1.m:
% % open ddmp01

% % in new_fig3_latIntegral_relative_risk.m:
% % aaa = reshape(nansum(nansum(fnmata(4:end,:,:),2),1)./nansum(nansum(hdmata(4:end,:,:),2),1),1,rlen);
% % aa2 = aaa./firenh(1,:);
% % open aa2

clear,clc;
load D:\Study\fires\Extreme_fires_relationship\MODISv61_newanalysis\2021.10.16.heatwv_nheatwv_comp3\big_fire\amplification_factor_htwv.mat
yvalues = {'NWN','NEN','WNA','CNA','ENA','NCA','SCA','CAR','NWS','NSA','NES','SAM','SWS','SES','SSA',... %1-15, need to skip 8 - CAR
    'NEU','WCE','EEU','MED','SAH','WAF','NCAF','NEAF','SEAF','WSAF','ESAF','MDG',... % 16-27, need to skip 27 - MDG
    'RAR','WSB','ESB','RFE','WCA','ECA','TIB','EAS','ARP','SAS','SEAN','NAU','CAU','EAU','SAU','NZ','SCAF','SEAS'}; % 28-45
xvalues = {{'Fire number'}, {'Burned area'},{'Mean size'}};
nbb = {'a','b','c'};
id1 = [1 2 17 18 28 29 30 31];
id2 = [3 4 5 6 19 32 33 34 35 36 38];
id3 = [7 9 10 11 12 21 22 23 24 37 39 44,45];
id4 = [14 25 26 40 41 42];

% % % msg1 = 'Boreal ecosystems include:'
% % % yvalues{id1}
% % for ri = 1 : 45
% %     for i = 2 : 3
% %         if(  sum(dataall(2,:,i,ri)) / sum(sum(dataall(2,:,2:3,ri))) < 0.05 || sum(dataall(3,:,i,ri)) / sum(sum(dataall(3,:,2:3,ri))) < 0.05 )
% %             dataamp(ri,:,i) = nan;
% %             dataall(4:6,:,i,ri) = nan;
% %         end
% %     end
% % end

% figure,
ddmpmean = nan(4,3);
ddmpmean2 = nan(4,3);
ddmpstd = nan(4,3);
ddmp2mean = nan(4,3);
ddmp2mean2 = nan(4,3);
ddmp2std = nan(4,3);
ddmp3mean = nan(4,3);
ddmp3std = nan(4,3);
ddmp3mean2 = nan(4,3);
for i = 1 : 3
    
    for k = 1 : 4
        if(k==1)
            idd = id1;
        elseif(k==2)
            idd = id2;
        elseif(k==3)
            idd = id3;
        else
            idd = id4;
        end
        ddmp = reshape(dataall(i+3,2,1,idd) ./dataall(i+3,1,1,idd),length(idd),1);        
        if(i==1&& k==1)
            ddmp01 = ddmp;
        end
        ddmpmean(k,i) = nanmean(ddmp);
        ddmpstd(k,i) = nanstd(ddmp);
        ddmpmean2(k,i) = nanmean(dataall(i+3,2,1,idd)) ./ nanmean(dataall(i+3,1,1,idd));
        
        ddmp2 = reshape(dataall(i+3,2,2,idd) ./ dataall(i+3,1,2,idd),length(idd),1);
        ddmp2mean(k,i) = nanmean(ddmp2);
        ddmp2std(k,i) = nanstd(ddmp2);
        ddmp2mean2(k,i) = nanmean(dataall(i+3,2,2,idd)) ./ nanmean(dataall(i+3,1,2,idd));
        
        ddmp3 = reshape(dataall(i+3,2,3,idd) ./ dataall(i+3,1,3,idd),length(idd),1);
        ddmp3mean(k,i) = nanmean(ddmp3);
        ddmp3std(k,i) = nanstd(ddmp3);
        ddmp3mean2(k,i) = nanmean(dataall(i+3,2,3,idd)) ./ nanmean(dataall(i+3,1,3,idd));
    end
    
end

% ddmpmean = ddmpmean2;
% ddmp2mean = ddmp2mean2;
% ddmp3mean = ddmp3mean2;

figure,
for i = 1 : 3
    if(i ==2)
        ci =3;
    elseif(i==3)
        ci = 2;
    else
        ci =1;
    end
    subplot(1,3,i),
    line([1 1],[0 5],'LineStyle',':','Color','k','LineWidth',1.2)
    hold on,
    if(ci ==1)
        b1 = barh([4 3 2 1],[ddmp3mean(:,ci) ddmp2mean(:,ci) ddmpmean(:,ci)]);
        hold on,
        xx = [3.8 4 4.2; 2.8 3 3.2; 1.8 2 2.2; 0.8 1 1.2];
        e1 = errorbar([ddmp3mean(:,ci) ddmp2mean(:,ci) ddmpmean(:,ci)],xx,zeros(4,3),[ddmp3std(:,ci) ddmp2std(:,ci) ddmpstd(:,ci)],'horizontal',...
            'LineStyle','none','Color','k');
    elseif(ci ==2)
        b1 = barh([4 3 2 1],[ddmp3mean(:,ci) ddmp2mean(:,ci) ddmpmean(:,ci)]);
        hold on,
        xx = [3.8 4 4.2; 2.8 3 3.2; 1.8 2 2.2; 0.8 1 1.2];
        e1 = errorbar([ddmp3mean(:,ci) ddmp2mean(:,ci) ddmpmean(:,ci)],xx,zeros(4,3),[ddmp3std(:,ci) ddmp2std(:,ci) ddmpstd(:,ci)],'horizontal',...
            'LineStyle','none','Color','k');
    else
        b1 = barh([4 3 2 1],[ddmp3mean(:,ci) ddmp2mean(:,ci) ddmpmean(:,ci)]);
        hold on,
        xx = [3.8 4 4.2; 2.8 3 3.2; 1.8 2 2.2; 0.8 1 1.2];
        e1 = errorbar([ddmp3mean(:,ci) ddmp2mean(:,ci) ddmpmean(:,ci)],xx,zeros(4,3),[ddmp3std(:,ci) ddmp2std(:,ci) ddmpstd(:,ci)],'horizontal',...
            'LineStyle','none','Color','k');
    end
    b1(1).FaceColor = [0 240 0]/255;
%     b1(1).EdgeColor = 'none';
    b1(2).FaceColor = [0 171 40]/255;
%     b1(2).EdgeColor = 'none';
    b1(3).FaceColor = [0 0 0]/255;
%     b1(3).EdgeColor = 'none';
    
    box on
    set(gca,'FontSize',13)    
    
% %     figure1_b
%     set(gca,'XLim',[0 10],'XTick',[0:2:10],'YTick',[],'YLim',[0.5 4.5])

    %figure1_a
    set(gca,'XLim',[0 4],'XTick',[0:2:10],'YTick',[],'YLim',[0.5 4.5])
    set(gca,'TickDir','out','LineWidth',1.2)
%     if(i ==3)
%         legend(b1,{'Non-forest','Forest','All'},'Location','bestoutside')
%     end
end

%% 4. amplification factor for different regions
load D:\Study\fires\Extreme_fires_relationship\2021.12.09.newregion_recomp\2021.10.16.heatwv_nheatwv_comp2\amplification_factor_htwv.mat
yvalues = {'NWN','NEN','WNA','CNA','ENA','NCA','SCA','CAR','NWS','NSA','NES','SAM','SWS','SES','SSA',... %1-15, need to skip 8 - CAR
    'NEU','WCE','EEU','MED','SAH','WAF','CAF','NEAF','SEAF','WSAF','ESAF','MDG',... % 16-27, need to skip 27 - MDG
    'RAR','WSB','ESB','RFE','WCA','ECA','TIB','EAS','ARP','SAS','SEA','NAU','CAU','EAU','SAU','NZ'}; % 28-43
latt = [83,82.9000000000000,71,70.9000000000000,70.8000000000000,70.3000000000000,68,67.5000000000000,30,25.9000000000000,25.8400000000000,25.8500000000000,20,19.9000000000000,19.8000000000000,82.8000000000000,82.6000000000000,82.5000000000000,70.7000000000000,70.2000000000000,25.8000000000000,25.7000000000000,25.6000000000000,25.5000000000000,18,17.5000000000000,17,82.7000000000000,82.4000000000000,82.3000000000000,82.2000000000000,70.7000000000000,70.6000000000000,70.4000000000000,70.5000000000000,70.1000000000000,70,25.4000000000000,15,14,13,12,11];
[yyv inddd] = sort(latt,'descend');
xvalues = {{'Fire number'}, {'Burned area'},{'Mean size'}};
nbb = {'a','b','c'};
id1 = [1 2 17 18 28 29 30 31];
id2 = [3 4 5 6 19 20 32 33 34 35 36];
id3 = [7 9 10 11 12 21 22 23 24 37 38 39];
id4 = [14 25 26 40 41 42];

% 2nd filter, forest fire number < 1% of the total fire number will
% neglected
for ri = 1 : 43
    for i = 2 : 3
        if(  sum(dataall(2,:,i,ri)) / sum(sum(dataall(2,:,2:3,ri))) < 0.05 || sum(dataall(3,:,i,ri)) / sum(sum(dataall(3,:,2:3,ri))) < 0.05 )
            dataamp(ri,:,i) = nan;
        end
    end
end

figure,

for i = 1 : 3
    if(i ==2)
        ci =3;
    elseif(i==3)
        ci = 2;
    else
        ci =1;
    end
    subplot(1,3,ci);
    
   for k = 1 : 4
        if(k==1)
            idd = id1;
        elseif(k==2)
            idd = id2;
        elseif(k==3)
            idd = id3;
        else
            idd = id4;
        end
        ddmp = nanmean(dataall(i+3,2,1,idd)) / nanmean(dataall(i+3,1,1,idd));
%         l1 = line([0 dataamp(ri,i,1)],[26-ri+1+0.2 26-ri+1+0.2],'Color',[254 124 0]/255,'LineWidth',1.8);
        l1 = line([0 ddmp],[4-k+1+0.2 4-k+1+0.2],'Color',[254 124 0]/255,'LineWidth',1.8);
        hold on,
        ddmp2 = nanmean(dataall(i+3,2,2,idd)) / nanmean(dataall(i+3,1,2,idd));
%         l2 = line([0 dataamp(ri,i,2)],[26-ri+1 26-ri+1],'Color',[0 180 171]/255,'LineWidth',1.8);
        l2 = line([0 ddmp2],[4-k+1 4-k+1],'Color',[0 180 171]/255,'LineWidth',1.8);
        hold on,
        ddmp3 = nanmean(dataall(i+3,2,3,idd)) / nanmean(dataall(i+3,1,3,idd));
%         l3 = line([0 dataamp(ri,i,3)],[26-ri+1-0.2 26-ri+1-0.2],'Color',[255 216 50]/255,'LineWidth',1.8);
        l3 = line([0 ddmp3],[4-k+1-0.2 4-k+1-0.2],'Color',[255 216 50]/255,'LineWidth',1.8);

    end
    line([1 1],[0 5],'Color','k','LineStyle',':')
    if(i ==1)
%         set(gca,'YTick',[1 : 26],'YTickLabel',fliplr(yvalues));
        set(gca,'YTick',[1 : 4],'YTickLabel',{'Austral','Tropic','Temperate','Boreal'});
    else
        set(gca,'YTick',[1 : 4],'YTickLabel',{});
    end
    if(i ==1)
        set(gca,'YLim',[0 5],'XLim',[0 4], 'XTick',[1 : 1:4]);
    elseif(i ==2)
        set(gca,'YLim',[0 5],'XLim',[0 4], 'XTick',[1 : 1:4]);
    else
        set(gca,'YLim',[0 5],'XLim',[0 4], 'XTick',[1 : 1:4]);
    end
    if(i<3)
        text(-1, 27.5,nbb{i},'FontWeight','bold','FontSize',13)
    else
        text(-0.5, 27.5,nbb{i},'FontWeight','bold','FontSize',13)
    end
    xlabel(xvalues{i});
    box on
    grid on
%     if(i==3)
%         legend([l1 l2 l3],{'All','Forest','Non-forest'})
%     end
    set(gca,'FontSize',10)
end

set(gcf,'position',[   428   404   551   274])
