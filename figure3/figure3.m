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
    
%     figure1_b
    set(gca,'XLim',[0 10],'XTick',[0:2:10],'YTick',[],'YLim',[0.5 4.5])

%     %figure1_a
%     set(gca,'XLim',[0 4],'XTick',[0:2:10],'YTick',[],'YLim',[0.5 4.5])
    set(gca,'TickDir','out','LineWidth',1.2)
%     if(i ==3)
%         legend(b1,{'Non-forest','Forest','All'},'Location','bestoutside')
%     end
end
