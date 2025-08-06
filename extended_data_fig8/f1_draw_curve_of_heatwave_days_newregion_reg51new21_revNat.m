%% f1_draw_curve_heatwave days - part0 Only heat wave days
clear,clc;
ensnb = {'1001.001', '1021.002', '1041.003', '1061.004', '1081.005', '1101.006', '1121.007', '1141.008', '1161.009', '1181.010', '1231.001', '1231.002', '1231.003', '1231.004', '1231.005', '1231.006', '1231.007', '1231.008', '1231.009', '1231.010', '1251.001', '1251.002', '1251.003', '1251.004', '1251.005', '1251.006', '1251.007', '1251.008', '1251.009', '1251.010', '1281.001', '1281.002', '1281.003', '1281.004', '1281.005', '1281.006', '1281.007', '1281.008', '1281.009', '1281.010', '1301.001', '1301.002', '1301.003', '1301.004', '1301.005', '1301.006', '1301.007', '1301.008', '1301.009', '1301.010'};
ensnb2 = {'1011.001', '1031.002', '1051.003', '1071.004', '1091.005', '1111.006', '1131.007', '1151.008', '1171.009', '1191.010', '1231.011', '1231.012', '1231.013', '1231.014', '1231.015', '1231.016', '1231.017', '1231.018', '1231.019', '1231.020', '1251.011', '1251.012', '1251.013', '1251.014', '1251.015', '1251.016', '1251.017', '1251.018', '1251.019', '1251.020', '1281.011', '1281.012', '1281.013', '1281.014', '1281.015', '1281.016', '1281.017', '1281.018', '1281.019', '1281.020', '1301.011', '1301.012', '1301.013', '1301.014', '1301.015', '1301.016', '1301.017', '1301.018', '1301.019', '1301.020'};
scenario = {'BHISTcmip6','BSSP370cmip6'};
load D:\Study\fires\Extreme_fires_relationship\2022.05.31.heatwave_newdef\2021.10.16.heatwv_nheatwv_comp3\amplification_factor_htwv.mat
yvalues = {'NWN','NEN','WNA','CNA','ENA','NCA','SCA','CAR','NWS','NSA','NES','SAM','SWS','SES','SSA',... %1-15, need to skip 8 - CAR
    'NEU','WCE','EEU','MED','SAH','WAF','NCAF','NEAF','SEAF','WSAF','ESAF','MDG',... % 16-27, need to skip 27 - MDG
    'RAR','WSB','ESB','RFE','WCA','ECA','TIB','EAS','ARP','SAS','SEAN','NAU','CAU','EAU','SAU','NZ','SCAF','SEAS'}; % 28-45
monthrange = repmat([1 12], 45,1); % fireseason e.g., from May to Sep

doy_leap   = [1 32 61 92 122 153 183 214 245 275 306 336];
doy_noleap = [1 32 60 91 121 152 182 213 244 274 305 335];
doyref = doy_noleap;
% new region AR6 - adjust - reg5 (sahara, mada, Southeast Asia)
% just consecutive 3 month with the largest total burned area througout the
% year
fseason3 = repmat([6 8], 45,1); % fireseason for statistics e.g., from Jun to Aug
fseason3(4,:) = [2 4]; 
fseason3(5,:) = [1 3];
fseason3(6,:) = [4 6];
fseason3(7,:) = [3 5];
fseason3(8,:) = [1 12]; %% should kick this out
fseason3(9,:) = [1 3];
fseason3(10,:) = [1 3];
fseason3(11,:) = [8 10];
fseason3(12,:) = [7 9]; 
fseason3(13,:) = [1 3];
fseason3(14,:) = [7 9];
fseason3(15,:) = [12 2];
fseason3(16,:) = [3 5];
fseason3(17,:) = [7 9];
fseason3(18,:) = [6 8];
fseason3(19,:) = [7 9];
fseason3(20,:) = [10 12]; %% should kick this out
fseason3(21,:) = [11 1];
fseason3(22,:) = [11 1];
fseason3(23,:) = [11 1];
fseason3(24,:) = [6 8];
fseason3(25,:) = [7 9];
fseason3(26,:) = [7 9];
fseason3(27,:) = [1 12]; %% shoudl kick this out
fseason3(28,:) = [6 8];
fseason3(29,:) = [6 8];
fseason3(30,:) = [6 8]; %%% ESB adjust to summer
fseason3(31,:) = [6 8]; %%% RFE adjust to summer
fseason3(32,:) = [6 8];
fseason3(33,:) = [8 10];
fseason3(34,:) = [9 11];
fseason3(35,:) = [4 6];
fseason3(36,:) = [6 8];
fseason3(37,:) = [2 4];
fseason3(38,:) = [1 3]; %%% Peninsula, Thailand ect
fseason3(39,:) = [9 11];
fseason3(40,:) = [9 11];
fseason3(41,:) = [9 11];
fseason3(42,:) = [11 1];
fseason3(43,:) = [1 3];
fseason3(44,:) = [5 7];
fseason3(45,:) = [8 10]; %%% tropical Asia island

fseason2 = fseason3;

fseason = fseason2;
htdayinc = nan(45,1);

for ri = 1 : 45
    ri
    if(ri ==8 || ri ==13 ||ri ==15 ||ri ==16 || ri == 20 ||ri ==27 ||ri ==33 ||ri ==36 ||ri ==43)
        continue;
    end
    
    if(fseason(ri,2) ==1) % 11-12, 1
        flag = 1;
        bgday1 = doyref(1);
        edday1 = doyref(2)-1;
        bgday2 = doyref(11);
        edday2 = doyref(12)+30;
        dylen = 31+30+31;
    elseif(fseason(ri,2) ==2)
        flag = 1;
        bgday1 = doyref(1);
        edday1 = doyref(3)-1;
        bgday2 = doyref(12);
        edday2 = doyref(12)+30;
        dylen = 90;
    else
        if(fseason(ri,2)==12)
            flag = 2;
            bgday = doyref(fseason(ri,1));
            edday = doyref(12)+30;
            dylen = edday - bgday+1;
        else
            flag = 2;
            bgday = doyref(fseason(ri,1));
            edday = doyref(fseason(ri,2)+1)-1;
            dylen = edday - bgday+1;
        end
    end
    htt = nan(70,100);
%     httera5 = nan(19,1);
    
    for ii = 1 : 100
        if(ii <=50)
            load(['D:\Study\fires\Extreme_fires_relationship\2021.11.18.cesm2_les\draw_script\d1_htwv_ratio_new_reg51new21\htwv_ratio.',ensnb{ii},'.region_',num2str(ri),'.mat'])
        else
            load(['D:\Study\fires\Extreme_fires_relationship\2021.11.18.cesm2_les\draw_script\d1_htwv_ratio_new_reg51new21\htwv_ratio.',ensnb2{ii-50},'.region_',num2str(ri),'.mat'])
        end
        
        for i = 1 : 70
            tmp = yt(i).ytmx;
            if(flag ==1)
                htt(i,ii) = sum(tmp(bgday1:edday1)) + sum(tmp(bgday2:edday2));
            else
                htt(i,ii) = sum(tmp(bgday:edday));
            end
            
        end
    end
% %     load(['/data1/geog/yli/cesm_lens2/htwvratio/era5/htwv_ratio.region_',num2str(ri),'.mat'])
% %     for i = 1 : 19
% %         tmp = yt(i).ytmx;
% %         if(flag ==1)
% %             httera5(i) = sum(tmp(bgday1:edday1)) + sum(tmp(bgday2:edday2));
% %         else
% %             httera5(i) = sum(tmp(bgday:edday));
% %         end
% %         
% %     end
    
    httmax = max(htt,[],2);
    
%     if(ri ==1)
        figure,
        subplot(1,2,1),
%     else
%         if(ri ==2)
%             figure,
%         end
%         subplot(4,6,ri-1),
%     end
        
    for ii = 1 : 100
        p1(ii) = plot([1981:1:2050]',htt(:,ii));
        p1(ii).Color = [0.8 0.8 0.8 0.3];
        p1(ii).LineWidth = 1.2;
        hold on,
    end
    httavg = mean(htt,2);
    httstd = std(htt,0,2);
    htdayinc(ri) = mean(httavg(end-25:end-10)) - mean(httavg(2003-1980:2021-1980)); % modify here to change the period to 2025-2040
    x = [1981:1:2050]';
    
    hold on,
    p22 = plot([1981:1:2050]',httavg+httstd);
    p22.Color = 'k';
    p22.LineWidth = 1.2;
    p22.LineStyle = '--';
    hold on,
    
    x2 = [x', fliplr(x')];
    inBetween = [httavg'+httstd', fliplr(httavg')];
%     inBetween = [httmax', fliplr(ydata')];
    f1 = fill(x2, inBetween, [0.95 0.8 0.8]);
    f1.EdgeColor = 'none';
    f1.FaceAlpha = 0.5;
    hold on,
     
    ydata3 = httavg-httstd;
    ydata3(ydata3<0) = 0;
    p33 = plot([1981:1:2050]',ydata3);
    p33.Color = 'k';
    p33.LineWidth = 1.2;
    p33.LineStyle = '--';
    
    hold on,
    x2 = [x', fliplr(x')];
    inBetween = [ ydata3',fliplr(httavg')];
    f2 = fill(x2, inBetween, [0.95 0.8 0.8]);
    f2.EdgeColor = 'none';
    f2.FaceAlpha = 0.5;
    
    hold on,
    p11 = plot([1981:1:2050]',httavg);
    p11.Color = 'k';
    p11.LineWidth = 1.8;
    
%     if(ri >= 20)
        xlabel('Year')
%     end
%     if(ri ==2 || ri == 8 || ri == 14 || ri ==20)
        ylabel('Heat wave days (d)')
%     end
    set(gca,'XLim',[1980 2050],'YLim',[0 80])
    if(ri ==1)
        legend([p11 p22 p1(1)],{'Mean projection','Mean±STD','One member'},'Location','best')
    end
    %     set(gca,'YLim',[0 40])
    title(['region:',yvalues{ri}])
        set(gcf,'position',[304 528 1073 420])

%     saveas(gcf,['D:\Study\fires\Extreme_fires_relationship\2021.11.18.cesm2_les\draw_script\fire_prediction_reg51new21\nheatwvday_prediction_CESM_region_',num2str(ri),'_',yvalues{ri},'.jpg']);
    
end
save D:\Study\fires\Extreme_fires_relationship\2021.11.18.cesm2_les\draw_script\htdayincnew21.2025_2040.mat htdayinc


%% 4. draw fire predictions at 9 hotspot - Extended Data Fig. 8
clear,clc;
ensnb = {'1001.001', '1021.002', '1041.003', '1061.004', '1081.005', '1101.006', '1121.007', '1141.008', '1161.009', '1181.010', '1231.001', '1231.002', '1231.003', '1231.004', '1231.005', '1231.006', '1231.007', '1231.008', '1231.009', '1231.010', '1251.001', '1251.002', '1251.003', '1251.004', '1251.005', '1251.006', '1251.007', '1251.008', '1251.009', '1251.010', '1281.001', '1281.002', '1281.003', '1281.004', '1281.005', '1281.006', '1281.007', '1281.008', '1281.009', '1281.010', '1301.001', '1301.002', '1301.003', '1301.004', '1301.005', '1301.006', '1301.007', '1301.008', '1301.009', '1301.010'};
ensnb2 = {'1011.001', '1031.002', '1051.003', '1071.004', '1091.005', '1111.006', '1131.007', '1151.008', '1171.009', '1191.010', '1231.011', '1231.012', '1231.013', '1231.014', '1231.015', '1231.016', '1231.017', '1231.018', '1231.019', '1231.020', '1251.011', '1251.012', '1251.013', '1251.014', '1251.015', '1251.016', '1251.017', '1251.018', '1251.019', '1251.020', '1281.011', '1281.012', '1281.013', '1281.014', '1281.015', '1281.016', '1281.017', '1281.018', '1281.019', '1281.020', '1301.011', '1301.012', '1301.013', '1301.014', '1301.015', '1301.016', '1301.017', '1301.018', '1301.019', '1301.020'};
scenario = {'BHISTcmip6','BSSP370cmip6'};
load D:\Study\fires\Extreme_fires_relationship\MODISv61_newanalysis\2021.10.16.heatwv_nheatwv_comp3\big_fire\amplification_factor_htwv.mat

monthrange = repmat([1 12], 45,1); % fireseason e.g., from May to Sep

doy_leap   = [1 32 61 92 122 153 183 214 245 275 306 336];
doy_noleap = [1 32 60 91 121 152 182 213 244 274 305 335];
doyref = doy_noleap;
% new region AR6 - adjust - reg5 (sahara, mada, Southeast Asia)
% just consecutive 3 month with the largest total burned area througout the
% year
fseason3 = repmat([6 8], 45,1); % fireseason for statistics e.g., from Jun to Aug
fseason3(4,:) = [2 4]; 
fseason3(5,:) = [1 3];
fseason3(6,:) = [4 6];
fseason3(7,:) = [3 5];
fseason3(8,:) = [1 12]; %% should kick this out
fseason3(9,:) = [1 3];
fseason3(10,:) = [1 3];
fseason3(11,:) = [8 10];
fseason3(12,:) = [7 9]; 
fseason3(13,:) = [1 3];
fseason3(14,:) = [7 9];
fseason3(15,:) = [12 2];
fseason3(16,:) = [3 5];
fseason3(17,:) = [7 9];
fseason3(18,:) = [6 8];
fseason3(19,:) = [7 9];
fseason3(20,:) = [10 12]; %% should kick this out
fseason3(21,:) = [11 1];
fseason3(22,:) = [11 1];
fseason3(23,:) = [11 1];
fseason3(24,:) = [6 8];
fseason3(25,:) = [7 9];
fseason3(26,:) = [7 9];
fseason3(27,:) = [1 12]; %% shoudl kick this out
fseason3(28,:) = [6 8];
fseason3(29,:) = [6 8];
fseason3(30,:) = [6 8]; %%% ESB adjust to summer
fseason3(31,:) = [6 8]; %%% RFE adjust to summer
fseason3(32,:) = [6 8];
fseason3(33,:) = [8 10];
fseason3(34,:) = [9 11];
fseason3(35,:) = [4 6];
fseason3(36,:) = [6 8];
fseason3(37,:) = [2 4];
fseason3(38,:) = [1 3]; %%% Peninsula, Thailand ect
fseason3(39,:) = [9 11];
fseason3(40,:) = [9 11];
fseason3(41,:) = [9 11];
fseason3(42,:) = [11 1];
fseason3(43,:) = [1 3];
fseason3(44,:) = [5 7];
fseason3(45,:) = [8 10]; %%% tropical Asia island
fseason2 = fseason3;

fseason = fseason2;
datafirerisk = nan(45,2); % avg and 95th percentile
dylenall = nan(45,1);
htwdobsall = nan(45,19);
nbb = {'a','b','c','d','e','f','g','h','i'};
yvalues = {'NWN','NEN','WNA','CNA','ENA','NCA','SCA','CAR','NWS','NSA','NES','SAM','SWS','SES','SSA',... %1-15, need to skip 8 - CAR
    'NEU','WCE','EEU','MED','SAH','WAF','NCAF','NEAF','SEAF','WSAF','ESAF','MDG',... % 16-27, need to skip 27 - MDG
    'RAR','WSB','ESB','RFE','WCA','ECA','TIB','EAS','ARP','SAS','SEAN','NAU','CAU','EAU','SAU','NZ','SCAF','SEAS'}; % 28-45
figure,
idd = [1, 30, 3, 19, 9, 7, 42, 14];
yname = {'N.W.North-America','E.Siberia','W.North-America','Mediterranean','N.W.South-America','S.Central-America', ...
    'S.Australia','S.E.South-America'};
httavgall = nan(70,8);
for kk = 1 : 8
    ri = idd(kk);
    ri
    if(ri ==8 || ri ==13 ||ri ==15 ||ri ==16 || ri == 20 ||ri ==27 ||ri ==33 ||ri ==36 ||ri ==43)
        continue;
    end
    load(['D:\Study\fires\Extreme_fires_relationship\2022.05.31.heatwave_newdef\2021.10.15.heatwave_proportion\region_',num2str(ri),'_htwv_ratio.mat'],'yt');
    htwdobs = nan(19,1);

    for yr = 2003 : 2021
        xdata = [doyref(monthrange(ri,1)) : 1 : doyref(monthrange(ri,2))+30];
        if(fseason(ri,2) == 1) % for rare cases in the SH
            if(yr < 2021)
                tmp = [yt(yr-2002).ytmx(end-60 : end) yt(yr+1-2002).ytmx(1:31)];
                sublen = 92;
            else
                tmp = yt(yr-2002).ytmx(end-60 : end);
                sublen = 61;
            end
        elseif(fseason(ri,2) ==2)
            if(yr < 2021)
                tmp = [yt(yr-2002).ytmx(end-30 : end) yt(yr+1-2002).ytmx(1:59)];
                sublen = 90;
            else
                tmp = yt(yr-2002).ytmx(end-30 : end);
                sublen = 31;
            end
        else
            if(fseason(ri,2) == 12)
                xxdata = [doyref(fseason(ri,1)) : 1 : doyref(12)+30];
                % determine the fire season and subtract it from the original time
                % series of fire activities in that region
                sublen = length(xxdata);
                t = strfind(xdata,xxdata);
                tmp = yt(yr-2002).ytmx(t: t+sublen-1);
            else
                xxdata = [doyref(fseason(ri,1)) : 1 : doyref(fseason(ri,2)+1)-1];
                % determine the fire season and subtract it from the original time
                % series of fire activities in that region
                sublen = length(xxdata);
                t = strfind(xdata,xxdata);
                tmp = yt(yr-2002).ytmx(t: t+sublen-1);
            end
        end
        htwdobs(yr-2002) = sum(tmp);
    end
    htwdobsall(ri,:) = reshape(htwdobs,1,19);
    
    if(fseason(ri,2) ==1) % 11-12, 1
        flag = 1;
        bgday1 = doyref(1);
        edday1 = doyref(2)-1;
        bgday2 = doyref(11);
        edday2 = doyref(12)+30;
        dylen = 31+30+31;
    elseif(fseason(ri,2) == 2)
        flag = 1;
        bgday1 = doyref(1);
        edday1 = doyref(3)-1;
        bgday2 = doyref(12);
        edday2 = doyref(12)+30;
        dylen = 90;
    else
        if(fseason(ri,2) == 12)
            flag = 2;
            bgday = doyref(fseason(ri,1));
            edday = doyref(12)+30;
            dylen = edday - bgday+1;
        else
            flag = 2;
            bgday = doyref(fseason(ri,1));
            edday = doyref(fseason(ri,2)+1)-1;
            dylen = edday - bgday+1;
        end
    end
    dylenall(ri) = dylen;
    htt = nan(70,100);
    
    for ii = 1 : 100
        if(ii <=50)
            load(['d1_htwv_ratio_new_reg51new21/htwv_ratio.',ensnb{ii},'.region_',num2str(ri),'.mat']);
        else
            load(['d1_htwv_ratio_new_reg51new21/htwv_ratio.',ensnb2{ii-50},'.region_',num2str(ri),'.mat']);
        end
        
        for i = 1 : 70
            tmp = yt(i).ytmx;
            if(flag ==1)
                htt(i,ii) = sum(tmp(bgday1:edday1)) + sum(tmp(bgday2:edday2));
            else
                htt(i,ii) = sum(tmp(bgday:edday));
            end
            
        end
    end
    
    
    httmax = max(htt,[],2);
    httmax2 = prctile(htt,95,2);
    subplot(8,3,(kk-1)*3+1),
    for ii = 1 : 100
%         p1(ii) = plot([1981:1:2050]',htt(:,ii)-mean(htt(2003-1980:2018-1980,ii))+mean(htwdobs));
        p1(ii) = plot([1981:1:2040]',htt(1:60,ii));
        p1(ii).Color = [0.8 0.8 0.8 0.3];
        p1(ii).LineWidth = 1.2;
        hold on,
        
    end
    httavg = mean(htt,2);
    httstd = std(htt,0,2);
    x = [1981:1:2040]';
    httavgall(:,kk) = httavg;
    httavg = httavg - mean(httavg(2003-1980:2018-1980)) + mean(htwdobs);
%     httmax2 = httmax2 - mean(httavg(2003-1980:2021-1980)) + mean(htwdobs);
    
    hold on,
  
%     l11 = line([1980 2050],[mean(htwdobs) mean(htwdobs)],'Color',[0.8 0.8 0.8],'LineWidth',1.2);
      
    hold on,
    p11 = plot([1981:1:2040]',httavg(1:60));
    p11.Color = 'k';
    p11.LineWidth = 1.8;
    
    hold on,
    line([1981 2040],[mean(htwdobs) mean(htwdobs)],'LineStyle','--','Color','r')
    text(2025,35,['+',num2str(   round((mean(httavg(end-25:end-10))-mean(httavg(2003-1980:2021-1980)))*10)/10  )])
%     hold on,
%     p00 = plot([1981:1:2050]',httmax2);
%     p00.Color = 'r';
%     p00.LineWidth = 0.8;
%     p00.LineStyle = '-';
if(kk ==8)
    xlabel('Year')
end
ylabel({'Heatwave', 'days (D_H)'})
text(1970, 48, nbb{kk},'FontWeight','bold','FontSize',14)
text(1983, 35, yname{kk})
    set(gca,'YLim',[0 40])
    set(gca,'XLim',[1980 2040])
%     if(kk ==1)
%         legend([p00 p11],{'95% percentile','Mean projection'},'Location','best')
%     end
    set(gca,'FontSize',8)
    
    % fire
    load(['D:\Study\fires\Extreme_fires_relationship\MODISv61_newanalysis\2021.10.14.time_series2\big_fire\region_',num2str(ri),'_all_fire.mat'],'xdata','yf');
    firenbobs = nan(19,1);
    fireszobs = nan(19,1);
    for yr = 2003 : 2021
        if(fseason(ri,2) == 1) % for rare cases in the SH
            if(yr < 2021)
                tmp2 = [yf(yr-2002).yfnbht(end-60 : end) yf(yr+1-2002).yfnbht(1:31)];
                tmpn2 = [yf(yr-2002).yfnbnht(end-60 : end) yf(yr+1-2002).yfnbnht(1:31)];
                tmp3 = [yf(yr-2002).yfszht(end-60 : end) yf(yr+1-2002).yfszht(1:31)];
                tmpn3 = [yf(yr-2002).yfsznht(end-60 : end) yf(yr+1-2002).yfsznht(1:31)];
                sublen = 92;
            else
                tmp2 = yf(yr-2002).yfnbht(end-60 : end);
                tmpn2 = yf(yr-2002).yfnbnht(end-60 : end);
                tmp3 = yf(yr-2002).yfszht(end-60 : end);
                tmpn3 = yf(yr-2002).yfsznht(end-60 : end);
                sublen = 61;
            end
        elseif(fseason(ri,2) == 2)
            if(yr < 2021)
                tmp2 = [yf(yr-2002).yfnbht(end-30 : end) yf(yr+1-2002).yfnbht(1:59)];
                tmpn2 = [yf(yr-2002).yfnbnht(end-30 : end) yf(yr+1-2002).yfnbnht(1:59)];
                tmp3 = [yf(yr-2002).yfszht(end-30 : end) yf(yr+1-2002).yfszht(1:59)];
                tmpn3 = [yf(yr-2002).yfsznht(end-30 : end) yf(yr+1-2002).yfsznht(1:59)];
                sublen = 90;
            else
                tmp2 = yf(yr-2002).yfnbht(end-30 : end);
                tmpn2 = yf(yr-2002).yfnbnht(end-30 : end);
                tmp3 = yf(yr-2002).yfszht(end-30 : end);
                tmpn3 = yf(yr-2002).yfsznht(end-30 : end);
                sublen = 31;
            end
        else
            if(fseason(ri,2) == 12)
                xxdata = [doyref(fseason(ri,1)) : 1 : doyref(12)+30];
            else
                xxdata = [doyref(fseason(ri,1)) : 1 : doyref(fseason(ri,2)+1)-1];
            end
            % determine the fire season and subtract it from the original time
            % series of fire activities in that region
            sublen = length(xxdata);
            t = strfind(xdata,xxdata);
            tmp2 = yf(yr-2002).yfnbht(t: t+sublen-1);
            tmpn2 = yf(yr-2002).yfnbnht(t: t+sublen-1);
            tmp3 = yf(yr-2002).yfszht(t: t+sublen-1);
            tmpn3 = yf(yr-2002).yfsznht(t: t+sublen-1);
        end
        firenbobs(yr-2002) = sum(tmp2)+sum(tmpn2);
        fireszobs(yr-2002) = sum(tmp3)+sum(tmpn3);
    end
    
    httavg1 = httavg+httstd;
    httavg2 = httavg-httstd;
    httavg2(httavg2<0) = 0;
    
    subplot(8,3,(kk-1)*3+2),
    
    for ii = 1 : 100
%         zz = htt(:,ii)-mean(htt(2003-1980:2018-1980,ii))+mean(htwdobs);
        zz = htt(1:60,ii);
%         p1(ii) = plot([1981:1:2050]',(zz*dataall(4,2,1,ri)+(dylen-zz)*dataall(4,1,1,ri))/mean(firenbobs)*100 - 100);
        p1(ii) = plot([1981:1:2040]',(zz*dataall(4,2,1,ri)+(dylen-zz)*dataall(4,1,1,ri)));
        p1(ii).Color = [0.8 0.8 0.8 0.3];
        p1(ii).LineWidth = 1.2;
        hold on,
    end
    firenbprdct = (httavg*dataall(4,2,1,ri)+(dylen-httavg)*dataall(4,1,1,ri));
    b1 = plot([1981:1:2040]',firenbprdct(1:60));
    b1.Color = 'k';
    hold on,
    line([1981 2040],[mean(firenbobs) mean(firenbobs)],'LineStyle','--','Color','r');
    yllm = get(gca,'YLim');
    text(2025,(yllm(2)-yllm(1))*7/8+yllm(1),['+',num2str(   round((mean(firenbprdct(end-25:end-10))-mean(firenbprdct(2003-1980:2021-1980)))/mean(firenbprdct(2003-1980:2021-1980))*100)/1  ),'%'])

%     plot(2003:2018,firenbobs,'LineStyle','--','Color','r');
    
%     l3 = plot([1981:1:2050]',(httmax2*dataall(4,2,1,ri)+(dylen-httmax2)*dataall(4,1,1,ri))/mean(firenbobs)*100 - 100);
%     l3.Color = 'r';
%     l3.LineStyle = '-';
%     l3.LineWidth = 0.8;
%     hold on,

%     legend([l3 b1],{'95th percentile','Mean projection','2003-2018 Obs mean'},'Location','best')
% if(kk==8)
%     set(gca,'YLim',[235 275])
% end
% % % if(kk== 7 || kk == 8)
% % %     set(gca,'YLim',[0 130])
% % % else
% % %     set(gca,'YLim',[0 65])
% % % end
if(kk ==8)
    xlabel('Year')
end
ylabel({'Fire numbers',''})
set(gca,'FontSize',8)
set(gca,'XLim',[1980 2040])
    
    subplot(8,3,(kk-1)*3+3),
    
    for ii = 1 : 100
%         zz = htt(:,ii)-mean(htt(2003-1980:2018-1980,ii))+mean(htwdobs);
        zz = htt(1:60,ii);
%         p1(ii) = plot([1981:1:2050]',(zz*dataall(5,2,1,ri)+(dylen-zz)*dataall(5,1,1,ri))/mean(fireszobs)*100 - 100);
        p1(ii) = plot([1981:1:2040]',(zz*dataall(5,2,1,ri)+(dylen-zz)*dataall(5,1,1,ri)));
        p1(ii).Color = [0.8 0.8 0.8 0.3];
        p1(ii).LineWidth = 1.2;
        hold on,
    end
    
%     b1 = plot([1981:1:2050]',(httavg*dataall(5,2,1,ri)+(dylen-httavg)*dataall(5,1,1,ri))/mean(fireszobs)*100 - 100);
    fireszprdct = (httavg*dataall(5,2,1,ri)+(dylen-httavg)*dataall(5,1,1,ri));
    b1 = plot([1981:1:2040]',fireszprdct(1:60));
    b1.Color = 'k';
    hold on,
    line([1981 2040],[mean(fireszobs) mean(fireszobs)],'LineStyle','--','Color','r')
    yllm = get(gca,'YLim');
    text(2025,(yllm(2)-yllm(1))*7/8+yllm(1),['+',num2str(   round((mean(fireszprdct(end-25:end-10))-mean(fireszprdct(2003-1980:2021-1980)))/mean(fireszprdct(2003-1980:2021-1980))*100)/1  ),'%'])
    
%     l3 = plot([1981:1:2050]',(httmax2*dataall(5,2,1,ri)+(dylen-httmax2)*dataall(5,1,1,ri))/mean(fireszobs)*100 - 100);
%     l3.Color = 'r';
%     l3.LineStyle = '-';
%     l3.LineWidth = 0.8;
%     hold on,

%     legend([l3 b1],{'95th percentile','Mean projection','2003-2018 Obs mean'},'Location','best')


% % % if(kk== 7 || kk == 8)
% % %     set(gca,'YLim',[0 130])
% % % else
% % %     set(gca,'YLim',[0 70])
% % % end
if(kk ==8)
    xlabel('Year')
end
ylabel({'Burned area','(km^2)'})
set(gca,'FontSize',8)
set(gca,'XLim',[1980 2040])

%     saveas(gcf,['D:\Study\fires\Extreme_fires_relationship\2021.11.18.cesm2_les\draw_script\fire_prediction2\fut_firepred_region',num2str(ri),'_',yvalues{ri},'.firenumber.jpg']);
end
set(gcf,'position',[304          -142        1012        4613])

% save(['D:\Study\fires\Extreme_fires_relationship\2021.11.18.cesm2_les\draw_script\fire_prediction2\datafirerisk_firenumber.mat'],'datafirerisk');
% save dylenall.mat dylenall
% save htwdobsall.mat htwdobsall
