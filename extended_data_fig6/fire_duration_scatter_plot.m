%% all fires, plot 1, scatter plot of fire characteristics
clear,clc;
yvalues = {'NWN','NEN','WNA','CNA','ENA','NCA','SCA','CAR','NWS','NSA','NES','SAM','SWS','SES','SSA',... %1-15, need to skip 8 - CAR
    'NEU','WCE','EEU','MED','SAH','WAF','NCAF','NEAF','SEAF','WSAF','ESAF','MDG',... % 16-27, need to skip 27 - MDG
    'RAR','WSB','ESB','RFE','WCA','ECA','TIB','EAS','ARP','SAS','SEAN','NAU','CAU','EAU','SAU','NZ','SCAF','SEAS'}; % 28-45

% fseason3 = repmat([6 8], 44,1); % fireseason for statistics e.g., from Jun to Aug
% fseason3(4,:) = [2 4];
% fseason3(5,:) = [1 3];
% fseason3(6,:) = [4 6];
% fseason3(7,:) = [3 5];
% fseason3(8,:) = [1 12]; %% should kick this out
% fseason3(9,:) = [1 3];
% fseason3(10,:) = [1 3];
% fseason3(11,:) = [8 10];
% fseason3(12,:) = [7 9];
% fseason3(13,:) = [1 3];
% fseason3(14,:) = [7 9];
% fseason3(15,:) = [12 2];
% fseason3(16,:) = [3 5];
% fseason3(17,:) = [7 9];
% fseason3(18,:) = [6 8];
% fseason3(19,:) = [7 9];
% fseason3(20,:) = [10 12];
% fseason3(21,:) = [11 1];
% fseason3(22,:) = [11 1];
% fseason3(23,:) = [11 1];
% fseason3(24,:) = [6 8];
% fseason3(25,:) = [7 9];
% fseason3(26,:) = [7 9];
% fseason3(27,:) = [1 12]; %% shoudl kick this out
% fseason3(28,:) = [6 8];
% fseason3(29,:) = [6 8];
% fseason3(30,:) = [6 8]; %%% ESB adjust to summer
% fseason3(31,:) = [6 8]; %%% RFE adjust to summer
% fseason3(32,:) = [6 8];
% fseason3(33,:) = [8 10];
% fseason3(34,:) = [9 11];
% fseason3(35,:) = [4 6];
% fseason3(36,:) = [6 8];
% fseason3(37,:) = [2 4];
% fseason3(38,:) = [1 3];
% fseason3(39,:) = [9 11];
% fseason3(40,:) = [9 11];
% fseason3(41,:) = [9 11];
% fseason3(42,:) = [11 1];
% fseason3(43,:) = [1 3];
% fseason3(44,:) = [5 7];


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

fseason = fseason3;

doy_leap   = [1 32 61 92 122 153 183 214 245 275 306 336];
doy_noleap = [1 32 60 91 121 152 182 213 244 274 305 335];

rsqall = nan(45,4);

for ri = 1 : 1
    if(ri ==8 || ri ==13 ||ri ==15 ||ri ==16 || ri == 20 ||ri ==27 ||ri ==33 ||ri ==36 ||ri ==43)
        continue;
    end
    load(['D:\Study\fires\Extreme_fires_relationship\MODISv61_newanalysis\2021.12.01.duration_ehfy_errorbar\region_',num2str(ri),'_xth_ehf.mat'],'xdata','yt');
    load(['D:\Study\fires\Extreme_fires_relationship\MODISv61_newanalysis\2021.10.14.time_series2\big_fire\region_',num2str(ri),'_all_fire_xth2.mat'],'xdata','yf');
    
    htmat = nan(13,19); % ehf matrix, -3 -2 -1 1 2 3..10;   2003-2018
    fnmat = nan(13,19); % fire number
    szmat = nan(13,19); % fire size
    hdmat = nan(13,19); % heatwave days
    for yr = 2003 : 2021
        
        if(~mod(yr,400) || ( mod(yr,400) && ~mod(yr,4)))
            doyref = doy_leap;
            dylen = 366;
        else
            doyref = doy_noleap;
            dylen = 365;
        end
        
        if(fseason(ri,2) ~=1 && fseason(ri,2) ~=2)
            bgi = doyref(fseason(ri,1));
            if(fseason(ri,2) ==12)
                edi = doyref(12)+30;
            else
                edi = doyref(fseason(ri,2)+1)-1;
            end
            
            hdmat(:,yr-2002)= sum(yt(yr-2002).htdy(:,bgi:edi),2);
            htmat(:,yr-2002) = nanmean(yt(yr-2002).hteh(:,bgi:edi),2);
            fnmat(:,yr-2002) = sum(yf(yr-2002).yfnbht(:,bgi:edi),2);
            szmat(:,yr-2002) = sum(yf(yr-2002).yfszht(:,bgi:edi),2);
            
        elseif(fseason(ri,2) ==1)
            bgi1 = doyref(fseason(ri,1));
            edi1 = doyref(12)-1+31;
            bgi2 = 1;
            edi2 = doyref(2)-1;
            
            hdmat(:,yr-2002)= sum([yt(yr-2002).htdy(:,bgi1:edi1) yt(yr-2002).htdy(:,bgi2:edi2)],2);
            htmat(:,yr-2002) = nanmean([yt(yr-2002).hteh(:,bgi1:edi1) yt(yr-2002).hteh(:,bgi2:edi2)],2);
            fnmat(:,yr-2002) = sum([yf(yr-2002).yfnbht(:,bgi1:edi1) yf(yr-2002).yfnbht(:,bgi2:edi2)],2);
            szmat(:,yr-2002) = sum([yf(yr-2002).yfszht(:,bgi1:edi1) yf(yr-2002).yfszht(:,bgi2:edi2)],2);
        else
            bgi1 = doyref(fseason(ri,1));
            edi1 = doyref(12)-1+31;
            bgi2 = 1;
            edi2 = doyref(3)-1;
            
            hdmat(:,yr-2002)= sum([yt(yr-2002).htdy(:,bgi1:edi1) yt(yr-2002).htdy(:,bgi2:edi2)],2);
            htmat(:,yr-2002) = nanmean([yt(yr-2002).hteh(:,bgi1:edi1) yt(yr-2002).hteh(:,bgi2:edi2)],2);
            fnmat(:,yr-2002) = sum([yf(yr-2002).yfnbht(:,bgi1:edi1) yf(yr-2002).yfnbht(:,bgi2:edi2)],2);
            szmat(:,yr-2002) = sum([yf(yr-2002).yfszht(:,bgi1:edi1) yf(yr-2002).yfszht(:,bgi2:edi2)],2);
            
        end
    end
    
    htmat(hdmat<0.01) = nan;
    htmat2 = htmat;
    for k = 5 : 13
        for i = 4 : k-1
            htmat2(k,:) = htmat2(k,:) + htmat(i,:);
        end
    end
    
    fnmat(hdmat <0.01) = nan;
    szmat(hdmat <0.01) = nan;
    for k = 4 : 13
        tmp = fnmat(k,:);
        missnb = length(tmp(isnan(tmp)))/19;
        %         if(missnb > 0.5)
%         if(missnb >= 0.75)
%             %         if(missnb > 0.94)
%             break;
%         end
    end
    if(ri == 19)
        k = k-1;
    end
    durk = k;
    %     % % % % % maybe delete later % % %
    %     if(ri == 3)
    %         durk = 13;
    %     end
    %     % % % % % % % % % %
    fnmat(durk:end,:) = nan;
    szmat(durk:end,:) = nan;
    fnmat = fnmat(1:durk-1,:);
    szmat = szmat(1:durk-1,:);
    hdmat = hdmat(1:durk-1,:);
    htmat = htmat(1:durk-1,:);
    htmat2 = htmat2(1:durk-1,:);
    
    ehfmean = nanmean(htmat2,2);
    ehfstd = nanstd(htmat2,0,2);
    
    
    fnmean = nansum(fnmat,2)./nansum(hdmat,2);
    szmean = nansum(szmat,2)./nansum(hdmat,2);
       
    fnstd = nanstd(fnmat./hdmat,0,2);
    szstd = nanstd(szmat./hdmat,0,2);
    
    % load D:\Study\fires\Extreme_fires_relationship\2021.10.16.heatwv_nheatwv_comp2\amplification_factor_htwv_xth2.mat
    % dataxth = dataamp;
    % dataxthall = dataall;
    load D:\Study\fires\Extreme_fires_relationship\MODISv61_newanalysis\2021.10.16.heatwv_nheatwv_comp3\big_fire\amplification_factor_htwv.mat
    
    %
    xdata = 1 : 1 : durk-1;
    
    % ri = 1;
    figure,
    
    ydata = fnmean;
    ydata2 = ydata / dataall(4,1,1,ri);
    ydata(end-1:end) = nan;
    % ydata3 = prctile(fnmat./hdmat,90,2);
    xxf = [xdata fliplr(xdata)];
    xl = length(xdata);
    xxf(1) = 0;xxf(xl) = xl+1; xxf(xl+1) = xl+1; xxf(end) = 0;
    
    subplot(1,3,1),
% %     negstd = ydata-fnstd;
% %     negstd2 = fnstd;
% %     negstd2(negstd<0) = ydata(negstd<0);
% %     ee1 = errorbar(xdata,ydata,negstd2,fnstd);
% %     ee1.Color = [0.40 0.40 0.40];
% %     hold on,
%     yyf = [zeros(1,xl) repmat(dataall(4,1,1,ri),1,xl)];
%     f11 = fill(xxf,yyf,[130 130 130]./255);
%     f11.FaceAlpha = 0.2;
%     f11.EdgeColor = 'none';
%     hold on,
    p1 = plot(xdata,ydata,'k-');
    hold on,
    s1 = scatter(xdata,ydata,40,ydata2,'filled');
    s1.MarkerEdgeColor = 'k';
    colormap(flipud(hot))
    caxis([0 9])
    c1 = colorbar;
    c1.Location = 'Northoutside';
    set(c1,'YTick',[1 3 5 7 9]);
    grid on
    set(gca,'GridLineStyle','-.')
    set(gca,'XTick',[1 :1: 11],'XTickLabel',{'-3','-2','-1','1','2','3','4','5','6','7','8','9','10'})
    ymaxx = max(ydata+fnstd);
    if(ri ==1)
        text(4,ymaxx*1.05,'Heatwave starts')
%         text(5,40,'Non-heatwave level','Color',[130 130 130]./255)
    end
    line([3.5 3.5],[0 ymaxx*1.1],'Color','k','LineStyle','--')
    line([0 13], [dataall(4,1,1,ri) dataall(4,1,1,ri)],'Color','k','LineStyle','-')
    set(gca,'YLim',[0 ymaxx*1.1],'XLim',[0 11],'YColor','k')
    ylabel('Fire number (n d^{-1})')
    xlabel('day before after a heat wave')
    get(gca,'position');
    set(gca,'position',[0.1500    0.600    0.2134    0.2753]);
    set(gca,'FontSize',10)
    
    subplot(1,3,2),
    ydata = szmean./fnmean;
    ydata2 = ydata / dataall(6,1,1,ri);
    ydata(end-1:end) = nan;
%     yyf = [zeros(1,xl) repmat(dataall(6,1,1,ri),1,xl)];
%     f11 = fill(xxf,yyf,[130 130 130]./255);
%     f11.FaceAlpha = 0.2;
%     f11.EdgeColor = 'none';
%     hold on,
    p1 = plot(xdata,ydata,'k-');
    hold on,
    s1 = scatter(xdata,ydata,40,ydata2,'filled');
    s1.MarkerEdgeColor = 'k';
    colormap(flipud(hot))
    caxis([0 9])
    c1 = colorbar;
    c1.Location = 'Northoutside';
    set(c1,'YTick',[1 3 5 7 9]);
    grid on
    set(gca,'GridLineStyle','-.')
    set(gca,'XTick',[1 :1: 11],'XTickLabel',{'-3','-2','-1','1','2','3','4','5','6','7','8','9','10'})
    ymaxx = max(ydata);
    % text(4,ymaxx*1.05,'Heatwave starts')
    line([3.5 3.5],[0 ymaxx*1.1],'Color','k','LineStyle','--')
    set(gca,'YLim',[0 ymaxx*1.1],'XLim',[0 11],'YColor','k')
    ylabel('Mean size (km^2 n^{-1})')
    xlabel('day before or after a heat wave')
    get(gca,'position');
    set(gca,'position',[0.4500    0.600    0.2134    0.2753]);
    set(gca,'FontSize',10)
    
    subplot(1,3,3),
    ydata = szmean;
    ydata2 = ydata / dataall(5,1,1,ri);
    ydata(end-1:end) = nan;
% %     negstd = ydata-szstd;
% %     negstd2 = szstd;
% %     negstd2(negstd<0) = ydata(negstd<0);
% % %     ydata(end-2:end) = nan;
% %     ee2 = errorbar(xdata,ydata,negstd2,szstd);
% %     ee2.Color = [0.40 0.40 0.40];
% %     hold on,
%     yyf = [zeros(1,xl) repmat(dataall(5,1,1,ri),1,xl)];
%     f11 = fill(xxf,yyf,[130 130 130]./255);
%     f11.FaceAlpha = 0.2;
%     f11.EdgeColor = 'none';
%     hold on,
    p1 = plot(xdata,ydata,'k-');
    hold on,
    s1 = scatter(xdata,ydata,40,ydata2,'filled');
    s1.MarkerEdgeColor = 'k';
    colormap(flipud(hot))
    caxis([0 9])
    c1 = colorbar;
    c1.Location = 'Northoutside';
    set(c1,'YTick',[1 3 5 7 9]);
    grid on
    set(gca,'GridLineStyle','-.')
    set(gca,'XTick',[1 :1: 11],'XTickLabel',{'-3','-2','-1','1','2','3','4','5','6','7','8','9','10'})
    ymaxx = max(ydata+szstd);
    % text(4,ymaxx*1.05,'Heatwave starts')
    line([3.5 3.5],[0 ymaxx*1.1],'Color','k','LineStyle','--')
    line([0 13], [dataall(5,1,1,ri) dataall(5,1,1,ri)],'Color','k','LineStyle','-')
    set(gca,'YLim',[0 ymaxx*1.1],'XLim',[0 11],'YColor','k')
    ylabel('Burned area (km^2 d^{-1})')
    xlabel('day before or after a heat wave')
    get(gca,'position');
    set(gca,'position',[0.7500    0.60    0.2134    0.2753]);
    set(gca,'FontSize',10)
    
    
    
    
    set(gcf,'position',[   492   0   954   720])
%     saveas(gcf,['D:\Study\fires\Extreme_fires_relationship\MODISv61_newanalysis\2021.12.03.ehf_relationship_fire\simple_version_regionIntegral\big_fire\fire_htduration_',num2str(ri),'_',yvalues{ri},'.pdf']);
end

% save D:\Study\fires\Extreme_fires_relationship\2022.02.15.newregion_recomp2\2021.12.03.ehf_relationship_fire\simple_version

% save D:\Study\fires\Extreme_fires_relationship\2021.12.09.newregion_recomp\2021.12.03.ehf_relationship_fire\rsqall.mat rsqall betafnall betafn2all betaszall betasz2all

%% forest fires, plot 1, scatter plot of fire characteristics
clear,clc;
yvalues = {'NWN','NEN','WNA','CNA','ENA','NCA','SCA','CAR','NWS','NSA','NES','SAM','SWS','SES','SSA',... %1-15, need to skip 8 - CAR
    'NEU','WCE','EEU','MED','SAH','WAF','NCAF','NEAF','SEAF','WSAF','ESAF','MDG',... % 16-27, need to skip 27 - MDG
    'RAR','WSB','ESB','RFE','WCA','ECA','TIB','EAS','ARP','SAS','SEA','NAU','CAU','EAU','SAU','NZ','SCAF'}; % 28-44

fseason3 = repmat([6 8], 44,1); % fireseason for statistics e.g., from Jun to Aug
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
fseason3(20,:) = [10 12];
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
fseason3(38,:) = [1 3];
fseason3(39,:) = [9 11];
fseason3(40,:) = [9 11];
fseason3(41,:) = [9 11];
fseason3(42,:) = [11 1];
fseason3(43,:) = [1 3];
fseason3(44,:) = [5 7];

fseason = fseason3;

doy_leap   = [1 32 61 92 122 153 183 214 245 275 306 336];
doy_noleap = [1 32 60 91 121 152 182 213 244 274 305 335];

rsqall = nan(44,4);

for ri = 1 : 44
    if(ri ==8 || ri ==13 ||ri ==15 ||ri ==16 ||ri ==27 ||ri ==33 ||ri ==36 ||ri ==43)
        continue;
    end
    load D:\Study\fires\Extreme_fires_relationship\2022.02.15.newregion_recomp2\2021.10.16.heatwv_nheatwv_comp2\amplification_factor_htwv.mat
    if(  sum(dataall(2,:,2,ri)) / sum(sum(dataall(2,:,2:3,ri))) < 0.05)
        continue;
    end
    
    load(['D:\Study\fires\Extreme_fires_relationship\2022.02.15.newregion_recomp2\2021.12.01.duration_ehfy_errorbar\region_',num2str(ri),'_xth_ehf.mat'],'xdata','yt');
    load(['D:\Study\fires\Extreme_fires_relationship\2022.02.15.newregion_recomp2\2021.10.14.time_series2\region_',num2str(ri),'_forest_fire_xth2.mat'],'xdata','yf');
    
    htmat = nan(13,16); % ehf matrix, -3 -2 -1 1 2 3..10;   2003-2018
    fnmat = nan(13,16); % fire number
    szmat = nan(13,16); % fire size
    hdmat = nan(13,16); % heatwave days
    for yr = 2003 : 2018
        
        if(~mod(yr,400) || ( mod(yr,400) && ~mod(yr,4)))
            doyref = doy_leap;
            dylen = 366;
        else
            doyref = doy_noleap;
            dylen = 365;
        end
        
        if(fseason(ri,2) ~=1 && fseason(ri,2) ~=2)
            bgi = doyref(fseason(ri,1));
            if(fseason(ri,2) ==12)
                edi = doyref(12)+30;
            else
                edi = doyref(fseason(ri,2)+1)-1;
            end
            
            hdmat(:,yr-2002)= sum(yt(yr-2002).htdy(:,bgi:edi),2);
            htmat(:,yr-2002) = nanmean(yt(yr-2002).hteh(:,bgi:edi),2);
            fnmat(:,yr-2002) = sum(yf(yr-2002).yfnbht(:,bgi:edi),2);
            szmat(:,yr-2002) = sum(yf(yr-2002).yfszht(:,bgi:edi),2);
            
        elseif(fseason(ri,2) ==1)
            bgi1 = doyref(fseason(ri,1));
            edi1 = doyref(12)-1+31;
            bgi2 = 1;
            edi2 = doyref(2)-1;
            
            hdmat(:,yr-2002)= sum([yt(yr-2002).htdy(:,bgi1:edi1) yt(yr-2002).htdy(:,bgi2:edi2)],2);
            htmat(:,yr-2002) = nanmean([yt(yr-2002).hteh(:,bgi1:edi1) yt(yr-2002).hteh(:,bgi2:edi2)],2);
            fnmat(:,yr-2002) = sum([yf(yr-2002).yfnbht(:,bgi1:edi1) yf(yr-2002).yfnbht(:,bgi2:edi2)],2);
            szmat(:,yr-2002) = sum([yf(yr-2002).yfszht(:,bgi1:edi1) yf(yr-2002).yfszht(:,bgi2:edi2)],2);
        else
            bgi1 = doyref(fseason(ri,1));
            edi1 = doyref(12)-1+31;
            bgi2 = 1;
            edi2 = doyref(3)-1;
            
            hdmat(:,yr-2002)= sum([yt(yr-2002).htdy(:,bgi1:edi1) yt(yr-2002).htdy(:,bgi2:edi2)],2);
            htmat(:,yr-2002) = nanmean([yt(yr-2002).hteh(:,bgi1:edi1) yt(yr-2002).hteh(:,bgi2:edi2)],2);
            fnmat(:,yr-2002) = sum([yf(yr-2002).yfnbht(:,bgi1:edi1) yf(yr-2002).yfnbht(:,bgi2:edi2)],2);
            szmat(:,yr-2002) = sum([yf(yr-2002).yfszht(:,bgi1:edi1) yf(yr-2002).yfszht(:,bgi2:edi2)],2);
            
        end
    end
    
    htmat(hdmat<0.01) = nan;
    htmat2 = htmat;
    for k = 5 : 13
        for i = 4 : k-1
            htmat2(k,:) = htmat2(k,:) + htmat(i,:);
        end
    end
    
    fnmat(hdmat <0.01) = nan;
    szmat(hdmat <0.01) = nan;
    for k = 4 : 13
        tmp = fnmat(k,:);
        missnb = length(tmp(isnan(tmp)))/16;
        %         if(missnb > 0.5)
        if(missnb >= 0.75)
            %         if(missnb > 0.94)
            break;
        end
    end
    if(ri == 19)
        k = k-1;
    end
    durk = k;
    %     % % % % % maybe delete later % % %
    %     if(ri == 3)
    %         durk = 13;
    %     end
    %     % % % % % % % % % %
    fnmat(durk:end,:) = nan;
    szmat(durk:end,:) = nan;
    fnmat = fnmat(1:durk-1,:);
    szmat = szmat(1:durk-1,:);
    hdmat = hdmat(1:durk-1,:);
    htmat = htmat(1:durk-1,:);
    htmat2 = htmat2(1:durk-1,:);
    
    ehfmean = nanmean(htmat2,2);
    ehfstd = nanstd(htmat2,0,2);
    
    
    fnmean = nansum(fnmat,2)./nansum(hdmat,2);
    szmean = nansum(szmat,2)./nansum(hdmat,2);
    
    fnstd = nanstd(fnmat./hdmat,0,2);
    szstd = nanstd(szmat./hdmat,0,2);
    
    % load D:\Study\fires\Extreme_fires_relationship\2021.10.16.heatwv_nheatwv_comp2\amplification_factor_htwv_xth2.mat
    % dataxth = dataamp;
    % dataxthall = dataall;
    load D:\Study\fires\Extreme_fires_relationship\2022.02.15.newregion_recomp2\2021.10.16.heatwv_nheatwv_comp2\amplification_factor_htwv.mat
    
    %
    xdata = 1 : 1 : durk-1;
    
    % ri = 1;
    figure,
    
    ydata = fnmean;
    ydata2 = ydata / dataall(4,1,2,ri);
    % ydata3 = prctile(fnmat./hdmat,90,2);
    xxf = [xdata fliplr(xdata)];
    xl = length(xdata);
    xxf(1) = 0;xxf(xl) = xl+1; xxf(xl+1) = xl+1; xxf(end) = 0;
    
    subplot(1,3,1),
    yyf = [zeros(1,xl) repmat(dataall(4,1,2,ri),1,xl)];
    f11 = fill(xxf,yyf,[130 130 130]./255);
    f11.FaceAlpha = 0.2;
    f11.EdgeColor = 'none';
    hold on,
    p1 = plot(xdata,ydata,'k-');
    hold on,
    s1 = scatter(xdata,ydata,40,ydata2,'filled');
    s1.MarkerEdgeColor = 'k';
    colormap(flipud(hot))
    caxis([1 9])
    c1 = colorbar;
    c1.Location = 'Northoutside';
    set(c1,'YTick',[1 3 5 7 9]);
    grid on
    set(gca,'GridLineStyle','-.')
    set(gca,'XTick',[1 :1: 13],'XTickLabel',{'-3','-2','-1','1','2','3','4','5','6','7','8','9','10'})
    ymaxx = max(ydata);
    if(ri ==1)
        text(4,ymaxx*1.05,'Heatwave starts')
        text(5,40,'Non-heatwave level','Color',[130 130 130]./255)
    end
    line([3.5 3.5],[0 ymaxx*1.1],'Color','k','LineStyle','--')
    set(gca,'YLim',[0 ymaxx*1.1],'XLim',[0 durk],'YColor','k')
    ylabel('Fire number (n d^{-1})')
    xlabel('day before after a heat wave')
    get(gca,'position');
    set(gca,'position',[0.1500    0.600    0.2134    0.2753]);
    set(gca,'FontSize',10)
    
    subplot(1,3,2),
    ydata = szmean./fnmean;
    ydata2 = ydata / dataall(6,1,2,ri);
    yyf = [zeros(1,xl) repmat(dataall(6,1,2,ri),1,xl)];
    f11 = fill(xxf,yyf,[130 130 130]./255);
    f11.FaceAlpha = 0.2;
    f11.EdgeColor = 'none';
    hold on,
    p1 = plot(xdata,ydata,'k-');
    hold on,
    s1 = scatter(xdata,ydata,40,ydata2,'filled');
    s1.MarkerEdgeColor = 'k';
    colormap(flipud(hot))
    caxis([1 9])
    c1 = colorbar;
    c1.Location = 'Northoutside';
    set(c1,'YTick',[1 3 5 7 9]);
    grid on
    set(gca,'GridLineStyle','-.')
    set(gca,'XTick',[1 :1: 13],'XTickLabel',{'-3','-2','-1','1','2','3','4','5','6','7','8','9','10'})
    ymaxx = max(ydata);
    % text(4,ymaxx*1.05,'Heatwave starts')
    line([3.5 3.5],[0 ymaxx*1.1],'Color','k','LineStyle','--')
    set(gca,'YLim',[0 ymaxx*1.1],'XLim',[0 durk],'YColor','k')
    ylabel('Mean size (km^2 n^{-1})')
    xlabel('day before or after a heat wave')
    get(gca,'position');
    set(gca,'position',[0.4500    0.600    0.2134    0.2753]);
    set(gca,'FontSize',10)
    
    subplot(1,3,3),
    ydata = szmean;
    ydata2 = ydata / dataall(5,1,2,ri);
    yyf = [zeros(1,xl) repmat(dataall(5,1,2,ri),1,xl)];
    f11 = fill(xxf,yyf,[130 130 130]./255);
    f11.FaceAlpha = 0.2;
    f11.EdgeColor = 'none';
    hold on,
    p1 = plot(xdata,ydata,'k-');
    hold on,
    s1 = scatter(xdata,ydata,40,ydata2,'filled');
    s1.MarkerEdgeColor = 'k';
    colormap(flipud(hot))
    caxis([1 9])
    c1 = colorbar;
    c1.Location = 'Northoutside';
    set(c1,'YTick',[1 3 5 7 9]);
    grid on
    set(gca,'GridLineStyle','-.')
    set(gca,'XTick',[1 :1: 13],'XTickLabel',{'-3','-2','-1','1','2','3','4','5','6','7','8','9','10'})
    ymaxx = max(ydata);
    % text(4,ymaxx*1.05,'Heatwave starts')
    line([3.5 3.5],[0 ymaxx*1.1],'Color','k','LineStyle','--')
    set(gca,'YLim',[0 ymaxx*1.1],'XLim',[0 durk],'YColor','k')
    ylabel('Burned area (km^2 d^{-1})')
    xlabel('day before or after a heat wave')
    get(gca,'position');
    set(gca,'position',[0.7500    0.60    0.2134    0.2753]);
    set(gca,'FontSize',10)
    
    
    
    
    set(gcf,'position',[   492   297   954   720])
    saveas(gcf,['D:\Study\fires\Extreme_fires_relationship\2022.02.15.newregion_recomp2\2021.12.03.ehf_relationship_fire\simple_version_regionIntegral\fire_htduration_',num2str(ri),'_',yvalues{ri},'.forest.jpg']);
end


%% nforest fires, plot 1, scatter plot of fire characteristics
clear,clc;
yvalues = {'NWN','NEN','WNA','CNA','ENA','NCA','SCA','CAR','NWS','NSA','NES','SAM','SWS','SES','SSA',... %1-15, need to skip 8 - CAR
    'NEU','WCE','EEU','MED','SAH','WAF','NCAF','NEAF','SEAF','WSAF','ESAF','MDG',... % 16-27, need to skip 27 - MDG
    'RAR','WSB','ESB','RFE','WCA','ECA','TIB','EAS','ARP','SAS','SEA','NAU','CAU','EAU','SAU','NZ','SCAF'}; % 28-44

fseason3 = repmat([6 8], 44,1); % fireseason for statistics e.g., from Jun to Aug
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
fseason3(20,:) = [10 12];
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
fseason3(38,:) = [1 3];
fseason3(39,:) = [9 11];
fseason3(40,:) = [9 11];
fseason3(41,:) = [9 11];
fseason3(42,:) = [11 1];
fseason3(43,:) = [1 3];
fseason3(44,:) = [5 7];

fseason = fseason3;

doy_leap   = [1 32 61 92 122 153 183 214 245 275 306 336];
doy_noleap = [1 32 60 91 121 152 182 213 244 274 305 335];

rsqall = nan(44,4);

for ri = 1 : 44
    if(ri ==8 || ri ==13 ||ri ==15 ||ri ==16 ||ri ==27 ||ri ==33 ||ri ==36 ||ri ==43)
        continue;
    end
    
    load D:\Study\fires\Extreme_fires_relationship\2022.02.15.newregion_recomp2\2021.10.16.heatwv_nheatwv_comp2\amplification_factor_htwv.mat
    if(  sum(dataall(2,:,3,ri)) / sum(sum(dataall(2,:,2:3,ri))) < 0.05)
        continue;
    end
    
    load(['D:\Study\fires\Extreme_fires_relationship\2022.02.15.newregion_recomp2\2021.12.01.duration_ehfy_errorbar\region_',num2str(ri),'_xth_ehf.mat'],'xdata','yt');
    load(['D:\Study\fires\Extreme_fires_relationship\2022.02.15.newregion_recomp2\2021.10.14.time_series2\region_',num2str(ri),'_nforest_fire_xth2.mat'],'xdata','yf');
    
    htmat = nan(13,16); % ehf matrix, -3 -2 -1 1 2 3..10;   2003-2018
    fnmat = nan(13,16); % fire number
    szmat = nan(13,16); % fire size
    hdmat = nan(13,16); % heatwave days
    for yr = 2003 : 2018
        
        if(~mod(yr,400) || ( mod(yr,400) && ~mod(yr,4)))
            doyref = doy_leap;
            dylen = 366;
        else
            doyref = doy_noleap;
            dylen = 365;
        end
        
        if(fseason(ri,2) ~=1 && fseason(ri,2) ~=2)
            bgi = doyref(fseason(ri,1));
            if(fseason(ri,2) ==12)
                edi = doyref(12)+30;
            else
                edi = doyref(fseason(ri,2)+1)-1;
            end
            
            hdmat(:,yr-2002)= sum(yt(yr-2002).htdy(:,bgi:edi),2);
            htmat(:,yr-2002) = nanmean(yt(yr-2002).hteh(:,bgi:edi),2);
            fnmat(:,yr-2002) = sum(yf(yr-2002).yfnbht(:,bgi:edi),2);
            szmat(:,yr-2002) = sum(yf(yr-2002).yfszht(:,bgi:edi),2);
            
        elseif(fseason(ri,2) ==1)
            bgi1 = doyref(fseason(ri,1));
            edi1 = doyref(12)-1+31;
            bgi2 = 1;
            edi2 = doyref(2)-1;
            
            hdmat(:,yr-2002)= sum([yt(yr-2002).htdy(:,bgi1:edi1) yt(yr-2002).htdy(:,bgi2:edi2)],2);
            htmat(:,yr-2002) = nanmean([yt(yr-2002).hteh(:,bgi1:edi1) yt(yr-2002).hteh(:,bgi2:edi2)],2);
            fnmat(:,yr-2002) = sum([yf(yr-2002).yfnbht(:,bgi1:edi1) yf(yr-2002).yfnbht(:,bgi2:edi2)],2);
            szmat(:,yr-2002) = sum([yf(yr-2002).yfszht(:,bgi1:edi1) yf(yr-2002).yfszht(:,bgi2:edi2)],2);
        else
            bgi1 = doyref(fseason(ri,1));
            edi1 = doyref(12)-1+31;
            bgi2 = 1;
            edi2 = doyref(3)-1;
            
            hdmat(:,yr-2002)= sum([yt(yr-2002).htdy(:,bgi1:edi1) yt(yr-2002).htdy(:,bgi2:edi2)],2);
            htmat(:,yr-2002) = nanmean([yt(yr-2002).hteh(:,bgi1:edi1) yt(yr-2002).hteh(:,bgi2:edi2)],2);
            fnmat(:,yr-2002) = sum([yf(yr-2002).yfnbht(:,bgi1:edi1) yf(yr-2002).yfnbht(:,bgi2:edi2)],2);
            szmat(:,yr-2002) = sum([yf(yr-2002).yfszht(:,bgi1:edi1) yf(yr-2002).yfszht(:,bgi2:edi2)],2);
            
        end
    end
    
    htmat(hdmat<0.01) = nan;
    htmat2 = htmat;
    for k = 5 : 13
        for i = 4 : k-1
            htmat2(k,:) = htmat2(k,:) + htmat(i,:);
        end
    end
    
    fnmat(hdmat <0.01) = nan;
    szmat(hdmat <0.01) = nan;
    for k = 4 : 13
        tmp = fnmat(k,:);
        missnb = length(tmp(isnan(tmp)))/16;
        %         if(missnb > 0.5)
        if(missnb >= 0.75)
            %         if(missnb > 0.94)
            break;
        end
    end
    if(ri == 19)
        k = k-1;
    end
    durk = k;
    %     % % % % % maybe delete later % % %
    %     if(ri == 3)
    %         durk = 13;
    %     end
    %     % % % % % % % % % %
    fnmat(durk:end,:) = nan;
    szmat(durk:end,:) = nan;
    fnmat = fnmat(1:durk-1,:);
    szmat = szmat(1:durk-1,:);
    hdmat = hdmat(1:durk-1,:);
    htmat = htmat(1:durk-1,:);
    htmat2 = htmat2(1:durk-1,:);
    
    ehfmean = nanmean(htmat2,2);
    ehfstd = nanstd(htmat2,0,2);
    
    
    fnmean = nansum(fnmat,2)./nansum(hdmat,2);
    szmean = nansum(szmat,2)./nansum(hdmat,2);
    
    fnstd = nanstd(fnmat./hdmat,0,2);
    szstd = nanstd(szmat./hdmat,0,2);
    
    % load D:\Study\fires\Extreme_fires_relationship\2021.10.16.heatwv_nheatwv_comp2\amplification_factor_htwv_xth2.mat
    % dataxth = dataamp;
    % dataxthall = dataall;
    load D:\Study\fires\Extreme_fires_relationship\2022.02.15.newregion_recomp2\2021.10.16.heatwv_nheatwv_comp2\amplification_factor_htwv.mat
    
    %
    xdata = 1 : 1 : durk-1;
    
    % ri = 1;
    figure,
    
    ydata = fnmean;
    ydata2 = ydata / dataall(4,1,3,ri);
    % ydata3 = prctile(fnmat./hdmat,90,2);
    xxf = [xdata fliplr(xdata)];
    xl = length(xdata);
    xxf(1) = 0;xxf(xl) = xl+1; xxf(xl+1) = xl+1; xxf(end) = 0;
    
    subplot(1,3,1),
    yyf = [zeros(1,xl) repmat(dataall(4,1,3,ri),1,xl)];
    f11 = fill(xxf,yyf,[130 130 130]./255);
    f11.FaceAlpha = 0.2;
    f11.EdgeColor = 'none';
    hold on,
    p1 = plot(xdata,ydata,'k-');
    hold on,
    s1 = scatter(xdata,ydata,40,ydata2,'filled');
    s1.MarkerEdgeColor = 'k';
    colormap(flipud(hot))
    caxis([1 9])
    c1 = colorbar;
    c1.Location = 'Northoutside';
    set(c1,'YTick',[1 3 5 7 9]);
    grid on
    set(gca,'GridLineStyle','-.')
    set(gca,'XTick',[1 :1: 13],'XTickLabel',{'-3','-2','-1','1','2','3','4','5','6','7','8','9','10'})
    ymaxx = max(ydata);
    if(ri ==1)
        text(4,ymaxx*1.05,'Heatwave starts')
        text(5,40,'Non-heatwave level','Color',[130 130 130]./255)
    end
    line([3.5 3.5],[0 ymaxx*1.1],'Color','k','LineStyle','--')
    set(gca,'YLim',[0 ymaxx*1.1],'XLim',[0 durk],'YColor','k')
    ylabel('Fire number (n d^{-1})')
    xlabel('day before after a heat wave')
    get(gca,'position');
    set(gca,'position',[0.1500    0.600    0.2134    0.2753]);
    set(gca,'FontSize',10)
    
    subplot(1,3,2),
    ydata = szmean./fnmean;
    ydata2 = ydata / dataall(6,1,3,ri);
    yyf = [zeros(1,xl) repmat(dataall(6,1,3,ri),1,xl)];
    f11 = fill(xxf,yyf,[130 130 130]./255);
    f11.FaceAlpha = 0.2;
    f11.EdgeColor = 'none';
    hold on,
    p1 = plot(xdata,ydata,'k-');
    hold on,
    s1 = scatter(xdata,ydata,40,ydata2,'filled');
    s1.MarkerEdgeColor = 'k';
    colormap(flipud(hot))
    caxis([1 9])
    c1 = colorbar;
    c1.Location = 'Northoutside';
    set(c1,'YTick',[1 3 5 7 9]);
    grid on
    set(gca,'GridLineStyle','-.')
    set(gca,'XTick',[1 :1: 13],'XTickLabel',{'-3','-2','-1','1','2','3','4','5','6','7','8','9','10'})
    ymaxx = max(ydata);
    % text(4,ymaxx*1.05,'Heatwave starts')
    line([3.5 3.5],[0 ymaxx*1.1],'Color','k','LineStyle','--')
    set(gca,'YLim',[0 ymaxx*1.1],'XLim',[0 durk],'YColor','k')
    ylabel('Mean size (km^2 n^{-1})')
    xlabel('day before or after a heat wave')
    get(gca,'position');
    set(gca,'position',[0.4500    0.600    0.2134    0.2753]);
    set(gca,'FontSize',10)
    
    subplot(1,3,3),
    ydata = szmean;
    ydata2 = ydata / dataall(5,1,3,ri);
    yyf = [zeros(1,xl) repmat(dataall(5,1,3,ri),1,xl)];
    f11 = fill(xxf,yyf,[130 130 130]./255);
    f11.FaceAlpha = 0.2;
    f11.EdgeColor = 'none';
    hold on,
    p1 = plot(xdata,ydata,'k-');
    hold on,
    s1 = scatter(xdata,ydata,40,ydata2,'filled');
    s1.MarkerEdgeColor = 'k';
    colormap(flipud(hot))
    caxis([1 9])
    c1 = colorbar;
    c1.Location = 'Northoutside';
    set(c1,'YTick',[1 3 5 7 9]);
    grid on
    set(gca,'GridLineStyle','-.')
    set(gca,'XTick',[1 :1: 13],'XTickLabel',{'-3','-2','-1','1','2','3','4','5','6','7','8','9','10'})
    ymaxx = max(ydata);
    % text(4,ymaxx*1.05,'Heatwave starts')
    line([3.5 3.5],[0 ymaxx*1.1],'Color','k','LineStyle','--')
    set(gca,'YLim',[0 ymaxx*1.1],'XLim',[0 durk],'YColor','k')
    ylabel('Burned area (km^2 d^{-1})')
    xlabel('day before or after a heat wave')
    get(gca,'position');
    set(gca,'position',[0.7500    0.60    0.2134    0.2753]);
    set(gca,'FontSize',10)
    
    
    
    
    set(gcf,'position',[   492   297   954   720])
    saveas(gcf,['D:\Study\fires\Extreme_fires_relationship\2022.02.15.newregion_recomp2\2021.12.03.ehf_relationship_fire\simple_version_regionIntegral\fire_htduration_',num2str(ri),'_',yvalues{ri},'.nforest.jpg']);
end

%% plot 2, latitudinal integration of the results - does not work!!!!!!!!
% because regions with lower fire amplification by heatwave (e.g., western
% central Europe) tend to have varied fire nb within the heatwave
clear,clc;
yvalues = {'NWN','NEN','WNA','CNA','ENA','NCA','SCA','CAR','NWS','NSA','NES','SAM','SWS','SES','SSA',... %1-15, need to skip 8 - CAR
    'NEU','WCE','EEU','MED','SAH','WAF','NCAF','NEAF','SEAF','WSAF','ESAF','MDG',... % 16-27, need to skip 27 - MDG
    'RAR','WSB','ESB','RFE','WCA','ECA','TIB','EAS','ARP','SAS','SEA','NAU','CAU','EAU','SAU','NZ','SCAF'}; % 28-44

fseason3 = repmat([6 8], 44,1); % fireseason for statistics e.g., from Jun to Aug
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
fseason3(20,:) = [10 12];
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
fseason3(38,:) = [1 3];
fseason3(39,:) = [9 11];
fseason3(40,:) = [9 11];
fseason3(41,:) = [9 11];
fseason3(42,:) = [11 1];
fseason3(43,:) = [1 3];
fseason3(44,:) = [5 7];

fseason = fseason3;

doy_leap   = [1 32 61 92 122 153 183 214 245 275 306 336];
doy_noleap = [1 32 60 91 121 152 182 213 244 274 305 335];

id1 = [1 2 17 18 28 29 30 31];
id2 = [3 4 5 6 19 20 32 33 34 35 36];
id3 = [7 9 10 11 12 21 22 23 24 37 38 39 44];
id4 = [14 25 26 40 41 42];

% id1 = [1 30];
% id2 = [3 19];
% id3 = [7 9];
% id4 = [41 42];

for ki = 1 : 4
    if(ki ==1)
        idd = id1;
    elseif(ki ==2)
        idd = id2;
    elseif(ki ==3)
        idd = id3;
    else
        idd = id4;
    end
    rlen = length(idd);
    htmata = nan(13,16,rlen); % ehf matrix, -3 -2 -1 1 2 3..10;   2003-2018
    fnmata = nan(13,16,rlen); % fire number
    szmata = nan(13,16,rlen); % fire size
    hdmata = nan(13,16,rlen); % heatwave days
    
    for rri = 1 : rlen
        ri = idd(rri);
        if(ri ==8 || ri ==13 ||ri ==15 ||ri ==16 ||ri ==27 ||ri ==33 ||ri ==36 ||ri ==43)
            continue;
        end
        load(['D:\Study\fires\Extreme_fires_relationship\2022.02.15.newregion_recomp2\2021.12.01.duration_ehfy_errorbar\region_',num2str(ri),'_xth_ehf.mat'],'xdata','yt');
        load(['D:\Study\fires\Extreme_fires_relationship\2022.02.15.newregion_recomp2\2021.10.14.time_series2\region_',num2str(ri),'_all_fire_xth2.mat'],'xdata','yf');
        
        for yr = 2003 : 2018
            
            if(~mod(yr,400) || ( mod(yr,400) && ~mod(yr,4)))
                doyref = doy_leap;
                dylen = 366;
            else
                doyref = doy_noleap;
                dylen = 365;
            end
            
            if(fseason(ri,2) ~=1 && fseason(ri,2) ~=2)
                bgi = doyref(fseason(ri,1));
                if(fseason(ri,2) ==12)
                    edi = doyref(12)+30;
                else
                    edi = doyref(fseason(ri,2)+1)-1;
                end
                
                hdmata(:,yr-2002,rri)= sum(yt(yr-2002).htdy(:,bgi:edi),2);
                htmata(:,yr-2002,rri) = nanmean(yt(yr-2002).hteh(:,bgi:edi),2);
                fnmata(:,yr-2002,rri) = sum(yf(yr-2002).yfnbht(:,bgi:edi),2);
                szmata(:,yr-2002,rri) = sum(yf(yr-2002).yfszht(:,bgi:edi),2);
                
            elseif(fseason(ri,2) ==1)
                bgi1 = doyref(fseason(ri,1));
                edi1 = doyref(12)-1+31;
                bgi2 = 1;
                edi2 = doyref(2)-1;
                
                hdmata(:,yr-2002,rri)= sum([yt(yr-2002).htdy(:,bgi1:edi1) yt(yr-2002).htdy(:,bgi2:edi2)],2);
                htmata(:,yr-2002,rri) = nanmean([yt(yr-2002).hteh(:,bgi1:edi1) yt(yr-2002).hteh(:,bgi2:edi2)],2);
                fnmata(:,yr-2002,rri) = sum([yf(yr-2002).yfnbht(:,bgi1:edi1) yf(yr-2002).yfnbht(:,bgi2:edi2)],2);
                szmata(:,yr-2002,rri) = sum([yf(yr-2002).yfszht(:,bgi1:edi1) yf(yr-2002).yfszht(:,bgi2:edi2)],2);
            else
                bgi1 = doyref(fseason(ri,1));
                edi1 = doyref(12)-1+31;
                bgi2 = 1;
                edi2 = doyref(3)-1;
                
                hdmata(:,yr-2002,rri)= sum([yt(yr-2002).htdy(:,bgi1:edi1) yt(yr-2002).htdy(:,bgi2:edi2)],2);
                htmata(:,yr-2002,rri) = nanmean([yt(yr-2002).hteh(:,bgi1:edi1) yt(yr-2002).hteh(:,bgi2:edi2)],2);
                fnmata(:,yr-2002,rri) = sum([yf(yr-2002).yfnbht(:,bgi1:edi1) yf(yr-2002).yfnbht(:,bgi2:edi2)],2);
                szmata(:,yr-2002,rri) = sum([yf(yr-2002).yfszht(:,bgi1:edi1) yf(yr-2002).yfszht(:,bgi2:edi2)],2);
                
            end
        end
    end
    
    for rri = 1 : rlen               
        fnmat = fnmata(:,:,rri); % fire number
        szmat = szmata(:,:,rri); % fire size
        hdmat = hdmata(:,:,rri); % heatwave days
        
        fnmat(hdmat <0.01) = nan;
        szmat(hdmat <0.01) = nan;
        for k = 4 : 13
            tmp = fnmat(k,:);
            missnb = length(tmp(isnan(tmp)))/16;
            if(missnb >= 0.75)
                break;
            end
        end
        
        durk = k;
        fnmat(durk:end,:) = nan;
        szmat(durk:end,:) = nan;
        hdmat(durk:end,:) = nan;
        
        fnmata(:,:,rri) = fnmat;
        szmata(:,:,rri) = szmat;
        hdmata(:,:,rri) = hdmat;
    end
    durk = 13;
    fnmat = nansum(fnmata,3); % fire number
    szmat = nansum(szmata,3); % fire size
    hdmat = nansum(hdmata,3); % heatwave days
    
    fnmean = nansum(fnmat,2)./nansum(hdmat,2);
    szmean = nansum(szmat,2)./nansum(hdmat,2);
    
%     fnmean = nanmean(fnmat./hdmat,2);
%     szmean = nanmean(szmat./hdmat,2);
    
    fnstd = nanstd(fnmat./hdmat,0,2);
    szstd = nanstd(szmat./hdmat,0,2);
    
    load D:\Study\fires\Extreme_fires_relationship\2022.02.15.newregion_recomp2\2021.10.16.heatwv_nheatwv_comp2\amplification_factor_htwv.mat
    
    xdata = 1 : 1 : 13;
    
    figure,
    
    ydata = fnmean;
    ydata2 = ydata / mean(dataall(4,1,1,idd));
    % ydata3 = prctile(fnmat./hdmat,90,2);
    xxf = [xdata fliplr(xdata)];
    xl = length(xdata);
    xxf(1) = 0;xxf(xl) = xl+1; xxf(xl+1) = xl+1; xxf(end) = 0;
    
    subplot(1,3,1),
    yyf = [zeros(1,xl) repmat(mean(dataall(4,1,1,idd)),1,xl)];
    f11 = fill(xxf,yyf,[130 130 130]./255);
    f11.FaceAlpha = 0.2;
    f11.EdgeColor = 'none';
    hold on,
    p1 = plot(xdata,ydata,'k-');
    hold on,
    s1 = scatter(xdata,ydata,40,ydata2,'filled');
    s1.MarkerEdgeColor = 'k';
    colormap(flipud(hot))
    caxis([1 9])
    c1 = colorbar;
    c1.Location = 'Northoutside';
    set(c1,'YTick',[1 3 5 7 9]);
    grid on
    set(gca,'GridLineStyle','-.')
    set(gca,'XTick',[1 :1: 13],'XTickLabel',{'-3','-2','-1','1','2','3','4','5','6','7','8','9','10'})
    ymaxx = max(ydata);
%     if(ri ==1)
        text(4,ymaxx*1.05,'Heatwave starts')
        text(5,40,'Non-heatwave level','Color',[130 130 130]./255)
%     end
    line([3.5 3.5],[0 ymaxx*1.1],'Color','k','LineStyle','--')
    set(gca,'YLim',[0 ymaxx*1.1],'XLim',[0 durk],'YColor','k')
    ylabel('Fire number (n d^{-1})')
    xlabel('day before after a heat wave')
    get(gca,'position');
    set(gca,'position',[0.1500    0.600    0.2134    0.2753]);
    set(gca,'FontSize',10)
    
    subplot(1,3,2),
    ydata = szmean./fnmean;
    ydata2 = ydata / mean(dataall(6,1,1,idd));
    yyf = [zeros(1,xl) repmat(mean(dataall(6,1,1,idd)),1,xl)];
    f11 = fill(xxf,yyf,[130 130 130]./255);
    f11.FaceAlpha = 0.2;
    f11.EdgeColor = 'none';
    hold on,
    p1 = plot(xdata,ydata,'k-');
    hold on,
    s1 = scatter(xdata,ydata,40,ydata2,'filled');
    s1.MarkerEdgeColor = 'k';
    colormap(flipud(hot))
    caxis([1 9])
    c1 = colorbar;
    c1.Location = 'Northoutside';
    set(c1,'YTick',[1 3 5 7 9]);
    grid on
    set(gca,'GridLineStyle','-.')
    set(gca,'XTick',[1 :1: 13],'XTickLabel',{'-3','-2','-1','1','2','3','4','5','6','7','8','9','10'})
    ymaxx = max(ydata);
    % text(4,ymaxx*1.05,'Heatwave starts')
    line([3.5 3.5],[0 ymaxx*1.1],'Color','k','LineStyle','--')
    set(gca,'YLim',[0 ymaxx*1.1],'XLim',[0 durk],'YColor','k')
    ylabel('Mean size (km^2 n^{-1})')
    xlabel('day before or after a heat wave')
    get(gca,'position');
    set(gca,'position',[0.4500    0.600    0.2134    0.2753]);
    set(gca,'FontSize',10)
    
    subplot(1,3,3),
    ydata = szmean;
    ydata2 = ydata / mean(dataall(5,1,1,idd));
    yyf = [zeros(1,xl) repmat(mean(dataall(5,1,1,idd)),1,xl)];
    f11 = fill(xxf,yyf,[130 130 130]./255);
    f11.FaceAlpha = 0.2;
    f11.EdgeColor = 'none';
    hold on,
    p1 = plot(xdata,ydata,'k-');
    hold on,
    s1 = scatter(xdata,ydata,40,ydata2,'filled');
    s1.MarkerEdgeColor = 'k';
    colormap(flipud(hot))
    caxis([1 9])
    c1 = colorbar;
    c1.Location = 'Northoutside';
    set(c1,'YTick',[1 3 5 7 9]);
    grid on
    set(gca,'GridLineStyle','-.')
    set(gca,'XTick',[1 :1: 13],'XTickLabel',{'-3','-2','-1','1','2','3','4','5','6','7','8','9','10'})
    ymaxx = max(ydata);
    % text(4,ymaxx*1.05,'Heatwave starts')
    line([3.5 3.5],[0 ymaxx*1.1],'Color','k','LineStyle','--')
    set(gca,'YLim',[0 ymaxx*1.1],'XLim',[0 durk],'YColor','k')
    ylabel('Burned area (km^2 d^{-1})')
    xlabel('day before or after a heat wave')
    get(gca,'position');
    set(gca,'position',[0.7500    0.60    0.2134    0.2753]);
    set(gca,'FontSize',10)
    
    
    
    
    set(gcf,'position',[   492   297   954   720])
%     saveas(gcf,['D:\Study\fires\Extreme_fires_relationship\2022.02.15.newregion_recomp2\2021.12.03.ehf_relationship_fire\simple_version_regionIntegral\fire_htduration_',num2str(ri),'_',yvalues{ri},'.jpg']);
end


%% test boreal region , plot, latitudinal integration of the results 
clear,clc;
yvalues = {'NWN','NEN','WNA','CNA','ENA','NCA','SCA','CAR','NWS','NSA','NES','SAM','SWS','SES','SSA',... %1-15, need to skip 8 - CAR
    'NEU','WCE','EEU','MED','SAH','WAF','NCAF','NEAF','SEAF','WSAF','ESAF','MDG',... % 16-27, need to skip 27 - MDG
    'RAR','WSB','ESB','RFE','WCA','ECA','TIB','EAS','ARP','SAS','SEA','NAU','CAU','EAU','SAU','NZ','SCAF'}; % 28-44

fseason3 = repmat([6 8], 44,1); % fireseason for statistics e.g., from Jun to Aug
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
fseason3(20,:) = [10 12];
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
fseason3(38,:) = [1 3];
fseason3(39,:) = [9 11];
fseason3(40,:) = [9 11];
fseason3(41,:) = [9 11];
fseason3(42,:) = [11 1];
fseason3(43,:) = [1 3];
fseason3(44,:) = [5 7];

fseason = fseason3;

doy_leap   = [1 32 61 92 122 153 183 214 245 275 306 336];
doy_noleap = [1 32 60 91 121 152 182 213 244 274 305 335];

id1 = [1 2 17 18 28 29 30 31];
id2 = [3 4 5 6 19 20 32 33 34 35 36];
id3 = [7 9 10 11 12 21 22 23 24 37 38 39 44];
id4 = [14 25 26 40 41 42];

for ki = 1 : 1
    if(ki ==1)
        idd = id1;
    elseif(ki ==2)
        idd = id2;
    elseif(ki ==3)
        idd = id3;
    else
        idd = id4;
    end
    rlen = length(idd);
    htmata = nan(13,16,rlen); % ehf matrix, -3 -2 -1 1 2 3..10;   2003-2018
    fnmata = nan(13,16,rlen); % fire number
    szmata = nan(13,16,rlen); % fire size
    hdmata = nan(13,16,rlen); % heatwave days
    
    for rri = 1 : rlen
        ri = idd(rri);
        if(ri ==8 || ri ==13 ||ri ==15 ||ri ==16 ||ri ==27 ||ri ==33 ||ri ==36 ||ri ==43)
            continue;
        end
        load(['D:\Study\fires\Extreme_fires_relationship\2022.02.15.newregion_recomp2\2021.12.01.duration_ehfy_errorbar\region_',num2str(ri),'_xth_ehf.mat'],'xdata','yt');
        load(['D:\Study\fires\Extreme_fires_relationship\2022.02.15.newregion_recomp2\2021.10.14.time_series2\region_',num2str(ri),'_all_fire_xth2.mat'],'xdata','yf');
        
        for yr = 2003 : 2018
            
            if(~mod(yr,400) || ( mod(yr,400) && ~mod(yr,4)))
                doyref = doy_leap;
                dylen = 366;
            else
                doyref = doy_noleap;
                dylen = 365;
            end
            
            if(fseason(ri,2) ~=1 && fseason(ri,2) ~=2)
                bgi = doyref(fseason(ri,1));
                if(fseason(ri,2) ==12)
                    edi = doyref(12)+30;
                else
                    edi = doyref(fseason(ri,2)+1)-1;
                end
                
                hdmata(:,yr-2002,rri)= sum(yt(yr-2002).htdy(:,bgi:edi),2);
                htmata(:,yr-2002,rri) = nanmean(yt(yr-2002).hteh(:,bgi:edi),2);
                fnmata(:,yr-2002,rri) = sum(yf(yr-2002).yfnbht(:,bgi:edi),2);
                szmata(:,yr-2002,rri) = sum(yf(yr-2002).yfszht(:,bgi:edi),2);
                
            elseif(fseason(ri,2) ==1)
                bgi1 = doyref(fseason(ri,1));
                edi1 = doyref(12)-1+31;
                bgi2 = 1;
                edi2 = doyref(2)-1;
                
                hdmata(:,yr-2002,rri)= sum([yt(yr-2002).htdy(:,bgi1:edi1) yt(yr-2002).htdy(:,bgi2:edi2)],2);
                htmata(:,yr-2002,rri) = nanmean([yt(yr-2002).hteh(:,bgi1:edi1) yt(yr-2002).hteh(:,bgi2:edi2)],2);
                fnmata(:,yr-2002,rri) = sum([yf(yr-2002).yfnbht(:,bgi1:edi1) yf(yr-2002).yfnbht(:,bgi2:edi2)],2);
                szmata(:,yr-2002,rri) = sum([yf(yr-2002).yfszht(:,bgi1:edi1) yf(yr-2002).yfszht(:,bgi2:edi2)],2);
            else
                bgi1 = doyref(fseason(ri,1));
                edi1 = doyref(12)-1+31;
                bgi2 = 1;
                edi2 = doyref(3)-1;
                
                hdmata(:,yr-2002,rri)= sum([yt(yr-2002).htdy(:,bgi1:edi1) yt(yr-2002).htdy(:,bgi2:edi2)],2);
                htmata(:,yr-2002,rri) = nanmean([yt(yr-2002).hteh(:,bgi1:edi1) yt(yr-2002).hteh(:,bgi2:edi2)],2);
                fnmata(:,yr-2002,rri) = sum([yf(yr-2002).yfnbht(:,bgi1:edi1) yf(yr-2002).yfnbht(:,bgi2:edi2)],2);
                szmata(:,yr-2002,rri) = sum([yf(yr-2002).yfszht(:,bgi1:edi1) yf(yr-2002).yfszht(:,bgi2:edi2)],2);
                
            end
        end
    end
    % %     fnmat = nansum(fnmata,3); % fire number
    % %     szmat = nansum(szmata,3); % fire size
    % %     hdmat = nansum(hdmata,3); % heatwave days
    figure,
    
    clcc = jet(rlen);
    for tt = 1 : rlen
        fnmat = fnmata(:,:,tt); % fire number
        szmat = szmata(:,:,tt); % fire size
        hdmat = hdmata(:,:,tt); % heatwave days
        
        fnmat(hdmat <0.01) = nan;
        szmat(hdmat <0.01) = nan;
        for k = 4 : 13
            tmp = fnmat(k,:);
            missnb = length(tmp(isnan(tmp)))/16;
            if(missnb >= 0.75)
                break;
            end
        end
        
        durk = k;
        fnmat(durk:end,:) = nan;
        szmat(durk:end,:) = nan;
        fnmat = fnmat(1:durk-1,:);
        szmat = szmat(1:durk-1,:);
        hdmat = hdmat(1:durk-1,:);
        
        fnmean = nansum(fnmat,2)./nansum(hdmat,2);
        szmean = nansum(szmat,2)./nansum(hdmat,2);
        
        xdata = 1 : 1 : durk-1;
        ydata = fnmean;
        p1 = plot(xdata,ydata,'-','Color',clcc(tt,:));
        hold on,
    end
    
    set(gcf,'position',[   492   297   954   720])
    
    
    figure,
    
    clcc = jet(rlen);
    for tt = 1 : rlen
        fnmat = fnmata(:,:,tt); % fire number
        szmat = szmata(:,:,tt); % fire size
        hdmat = hdmata(:,:,tt); % heatwave days
        
        fnmat(hdmat <0.01) = nan;
        szmat(hdmat <0.01) = nan;
        for k = 4 : 13
            tmp = fnmat(k,:);
            missnb = length(tmp(isnan(tmp)))/16;
            if(missnb >= 0.75)
                break;
            end
        end
        
        durk = k;
        fnmat(durk:end,:) = nan;
        szmat(durk:end,:) = nan;
        fnmat = fnmat(1:durk-1,:);
        szmat = szmat(1:durk-1,:);
        hdmat = hdmat(1:durk-1,:);
        
        fnmean = nansum(fnmat,2)./nansum(hdmat,2);
        szmean = nansum(szmat,2)./nansum(hdmat,2);
        
        xdata = 1 : 1 : durk-1;
        ydata = szmean;
        p1 = plot(xdata,ydata,'-','Color',clcc(tt,:));
        hold on,
    end
    
    set(gcf,'position',[   492   297   954   720])
end