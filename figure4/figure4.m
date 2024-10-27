%% 2.0, Big fires - relative risks
% % Code to reproduce the Amplification factor as in figure 3/figure 2
% % in figure22_statistics\figure1.m:
% % open ddmp01

% % in new_fig3_latIntegral_relative_risk.m:
% % aaa = reshape(nansum(nansum(fnmata(4:end,:,:),2),1)./nansum(nansum(hdmata(4:end,:,:),2),1),1,rlen);
% % aa2 = aaa./firenh(1,:);
% % open aa2

% because regions with lower fire amplification by heatwave (e.g., western
% central Europe) tend to have varied fire nb within the heatwave
clear,clc;
load D:\Study\fires\Extreme_fires_relationship\MODISv61_newanalysis\2021.10.16.heatwv_nheatwv_comp3\big_fire\amplification_factor_htwv.mat
yvalues = {'NWN','NEN','WNA','CNA','ENA','NCA','SCA','CAR','NWS','NSA','NES','SAM','SWS','SES','SSA',... %1-15, need to skip 8 - CAR
    'NEU','WCE','EEU','MED','SAH','WAF','NCAF','NEAF','SEAF','WSAF','ESAF','MDG',... % 16-27, need to skip 27 - MDG
    'RAR','WSB','ESB','RFE','WCA','ECA','TIB','EAS','ARP','SAS','SEAN','NAU','CAU','EAU','SAU','NZ','SCAF','SEAS'}; % 28-45

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

id1 = [1 2 17 18 28 29 30 31];
id2 = [3 4 5 6 19 32 34 35];
id3 = [7 9 10 11 12 21 22 23 24 37 38 44 45];
id4 = [14 25 26 39 40 41 42];

    
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
    htmata = nan(13,19,rlen); % ehf matrix, -3 -2 -1 1 2 3..10;   2003-2018
    fnmata = nan(13,19,rlen); % fire number
    szmata = nan(13,19,rlen); % fire size
    hdmata = nan(13,19,rlen); % heatwave days
    
    firenh = nan(3,rlen); %fire number, size, burned area during non-heatwave
    
    for rri = 1 : rlen
        ri = idd(rri);
        if(ri ==8 || ri ==13 ||ri ==15 ||ri ==16 || ri ==20 ||ri ==27 ||ri ==33 ||ri ==36 ||ri ==43)
            continue;
        end
        load(['D:\Study\fires\Extreme_fires_relationship\MODISv61_newanalysis\2021.12.01.duration_ehfy_errorbar\region_',num2str(ri),'_xth_ehf.mat'],'xdata','yt');
        load(['D:\Study\fires\Extreme_fires_relationship\MODISv61_newanalysis\2021.10.14.time_series2\big_fire\region_',num2str(ri),'_all_fire_xth2.mat'],'xdata','yf');
        firenh(1,rri) = dataall(4,1,1,ri);
        firenh(2,rri) = dataall(6,1,1,ri);
        firenh(3,rri) = dataall(5,1,1,ri);
        
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
            missnb = length(tmp(isnan(tmp)))/19;
            if(missnb >= 0.75) % missing ratio >= 3/4 will not be consider to be representative
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
    % 2024.07.17, change to relative risks
    fnmat = nansum(fnmata,3); % fire number
    szmat = nansum(szmata,3); % fire size
    hdmat = nansum(hdmata,3); % heatwave days    
    
    fnmean = nansum(fnmat,2)./nansum(hdmat,2);
    szmean = nansum(szmat,2)./nansum(hdmat,2);
    fnmeanpall = nan(13,rlen);
    szmeanpall = nan(13,rlen);
    
    aaa = reshape(nansum(fnmata,2)./nansum(hdmata,2),13,rlen);
    bbb = reshape(nansum(szmata,2)./nansum(hdmata,2),13,rlen);
    for rri = 1 : rlen
        fnmeanpall(:,rri) = aaa(:,rri)/firenh(1,rri)*100;
        szmeanpall(:,rri) = bbb(:,rri)/firenh(3,rri)*100;
    end
    fnmeanp = nanmean(fnmeanpall,2);
    szmeanp = nanmean(szmeanpall,2);
    fnmeanstd = nanstd(fnmeanpall,0,2);
    szmeanstd = nanstd(szmeanpall,0,2);
%     if(ki == 2)
        fnmeanstd
%     end
    
    %--- 2022.06.09 -- add std for different region
%     nansum(fnmata,2)./nansum(hdmat,2)
% ----- Method 1, show variation of region
    fnstd = nanstd(nansum(fnmata,2)./nansum(hdmata,2),0,3);
    szstd = nanstd(nansum(szmata,2)./nansum(hdmata,2),0,3);
% % % % ----- Method 2, show variation of years
% % %     fnstd = nanstd(nansum(fnmata,3)./nansum(hdmata,3),0,2);
% % %     szstd = nanstd(nansum(szmata,3)./nansum(hdmata,3),0,2);
    
%     fnmean = nanmean(fnmat./hdmat,2);
%     szmean = nanmean(szmat./hdmat,2);
    
%IAV
%     fnstd = nanstd(fnmat./hdmat,0,2);
%     szstd = nanstd(szmat./hdmat,0,2);
    

    
    xdata = 1 : 1 : 13;
    
    figure,
    
    ydata = fnmeanp;
%     ydata2 = ydata / mean(dataall(4,1,1,idd));
    % ydata3 = prctile(fnmat./hdmat,90,2);
    xxf = [xdata fliplr(xdata)];
    xl = length(xdata);
    xxf(1) = 0;xxf(xl) = xl+1; xxf(xl+1) = xl+1; xxf(end) = 0;
    
    subplot(1,3,1),    
    negstd = ydata-fnmeanstd;
    negstd2 = fnmeanstd;
    negstd2(negstd<0) = ydata(negstd<0);
    ydata(end-2:end) = nan;
    ee1 = errorbar(xdata,ydata,negstd2,fnmeanstd);
    ee1.Color = [0.40 0.40 0.40];
    ee1.LineStyle = '--';
%     hold on,
%     yyf = [zeros(1,xl) repmat(mean(dataall(4,1,1,idd)),1,xl)];
    hold on,
    p1 = plot(xdata,ydata,'k-');
%     hold on,
%     line([0 13], [mean(dataall(4,1,1,idd)) mean(dataall(4,1,1,idd))])
    hold on,
    s1 = scatter(xdata,ydata,40,'filled');
    s1.MarkerEdgeColor = 'k';
%     colormap(flipud(hot))
%     caxis([0 9])
%     c1 = colorbar;
%     c1.Location = 'Northoutside';
%     set(c1,'YTick',[1 3 5 7 9]);    
    grid on
    box on
    set(gca,'GridLineStyle','-.')
    set(gca,'XTick',[1 :1: 11],'XTickLabel',{'-3','-2','-1','1','2','3','4','5','6','7','8','9','10'})
    ymaxx = max(ydata+fnmeanstd);
    if(ki ==1)
        text(4,ymaxx*1.05,'Heatwave starts')
%         text(5,40,'Non-heatwave level','Color',[130 130 130]./255)
    end
    line([3.5 3.5],[0 ymaxx*1.1],'Color','k','LineStyle','--')
    line([0 11],[100 100],'Color','k','LineStyle',':')
    set(gca,'YLim',[0 ymaxx*1.1],'XLim',[0 durk-2],'YColor','k')
    ylabel('Fire number (n d^{-1})')
    xlabel('day before after a heat wave')
    get(gca,'position');
    set(gca,'position',[0.1500    0.600    0.2134    0.2253]);
    set(gca,'FontSize',10)
    
    subplot(1,3,2),
    ydata = szmean./fnmean;
    ydata2 = ydata / mean(dataall(6,1,1,idd));
    ydata(end-2:end) = nan;
    yyf = [zeros(1,xl) repmat(mean(dataall(6,1,1,idd)),1,xl)];
%     f11 = fill(xxf,yyf,[130 130 130]./255);
%     f11.FaceAlpha = 0.2;
%     f11.EdgeColor = 'none';
    hold on,
    p1 = plot(xdata,ydata,'k-');
%     hold on,
%     line([0 13], [mean(dataall(6,1,1,idd)) mean(dataall(6,1,1,idd))])
    hold on,    
    s1 = scatter(xdata,ydata,40,ydata2,'filled');
    s1.MarkerEdgeColor = 'k';
    colormap(flipud(hot))
    caxis([0 9])
    c1 = colorbar;
    c1.Location = 'Northoutside';
    set(c1,'YTick',[1 3 5 7 9]);
    grid on
    box on
    set(gca,'GridLineStyle','-.')
    set(gca,'XTick',[1 :1: 11],'XTickLabel',{'-3','-2','-1','1','2','3','4','5','6','7','8','9','10'})
    ymaxx = max(ydata);
    % text(4,ymaxx*1.05,'Heatwave starts')
    line([3.5 3.5],[0 ymaxx*1.1],'Color','k','LineStyle','--')
    set(gca,'YLim',[0 ymaxx*1.1],'XLim',[0 durk-2],'YColor','k')
    ylabel('Final fire size (km^2 n^{-1})')
    xlabel('day before or after a heat wave')
    get(gca,'position');
    set(gca,'position',[0.4500    0.600    0.2134    0.2253]);
    set(gca,'FontSize',10)
    
    subplot(1,3,3),
    ydata = szmeanp;
%     ydata2 = ydata / mean(dataall(5,1,1,idd));
    negstd = ydata-szmeanstd;
    negstd2 = szmeanstd;
    negstd2(negstd<0) = ydata(negstd<0);
    ydata(end-2:end) = nan;
    ee2 = errorbar(xdata,ydata,negstd2,szmeanstd);
    ee2.Color = [0.40 0.40 0.40];
    ee2.LineStyle = '--';
%     hold on,
%     yyf = [zeros(1,xl) repmat(mean(dataall(5,1,1,idd)),1,xl)];
    hold on,
    p1 = plot(xdata,ydata,'k-');
%     hold on,
%     line([0 13], [mean(dataall(5,1,1,idd)) mean(dataall(5,1,1,idd))])
    hold on,
    s1 = scatter(xdata,ydata,40,'filled');
    s1.MarkerEdgeColor = 'k';
%     colormap(flipud(hot))
%     caxis([0 9])
%     c1 = colorbar;
%     c1.Location = 'Northoutside';
%     set(c1,'YTick',[1 3 5 7 9]);    
    grid on
    box on
    set(gca,'GridLineStyle','-.')
    set(gca,'XTick',[1 :1: 11],'XTickLabel',{'-3','-2','-1','1','2','3','4','5','6','7','8','9','10'})
    ymaxx = max(ydata+szmeanstd);
    % text(4,ymaxx*1.05,'Heatwave starts')
    line([3.5 3.5],[0 ymaxx*1.1],'Color','k','LineStyle','--')
    line([0 11],[100 100],'Color','k','LineStyle',':')
    set(gca,'YLim',[0 ymaxx*1.1],'XLim',[0 durk-2],'YColor','k')
    ylabel('Burned area (km^2 d^{-1})')
    xlabel('day before or after a heat wave')
    get(gca,'position');
    set(gca,'position',[0.7500    0.60    0.2134    0.2253]);
    set(gca,'FontSize',10)
    
    
    
    
    set(gcf,'position',[   492   297   954   720])
%     saveas(gcf,['D:\Study\fires\Extreme_fires_relationship\2022.02.15.newregion_recomp2\2021.12.03.ehf_relationship_fire\simple_version_regionIntegral\fire_htduration_',num2str(ri),'_',yvalues{ri},'.jpg']);
end        
    
    set(gcf,'position',[   492   297   954   720])
%     saveas(gcf,['D:\Study\fires\Extreme_fires_relationship\2022.02.15.newregion_recomp2\2021.12.03.ehf_relationship_fire\simple_version_regionIntegral\fire_htduration_',num2str(ri),'_',yvalues{ri},'.jpg']);
end
