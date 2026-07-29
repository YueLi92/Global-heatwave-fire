%% Scatter plot (FWI), Latitudinal integration & scatter plot between Cumulative VPD and Cumulative burned area
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

% id1 = [1 2 17 18 28 29 30 31];
% % id2 = [3 4 5 6 19 32 33 34 35 36 38];
% id2 = [3 4 5 6 19 32 34 36 38];
% id3 = [7 9 10 11 12 21 22 23 24 37 39 44,45];
% id4 = [14 25 26 40 41 42];

vdcuall_total = nan(13,19,36);
fwcuall_total = nan(13,19,36);
vdnhall_total = nan(1,19,36);
labell = {'a','','b','','c','','d',''};
labell2 = {'Boreal','','NH Temperate','','Tropical','','SH Temperate',''};
figure,
for ki = 1 : 4
    if(ki ==1)
        cnt = 0;
        idd = id1;
    elseif(ki ==2)
        idd = id2;
    elseif(ki ==3)
        idd = id3;
    else
        idd = id4;
    end
    rlen = length(idd);
    
    vdmata = nan(13,19,rlen); % vpd matrix, -3 -2 -1 1 2 3..10;   2003-2018
    fwmata = nan(13,19,rlen); % fwi matrix, -3 -2 -1 1 2 3..10;   2003-2018
    tmmata = nan(13,19,rlen); % tmean
    txmata = nan(13,19,rlen); % tmax
    vnhtmata = nan(3,19,rlen); % vpd non-heatwave     
    
    fnmata = nan(13,19,rlen); % 
    szmata = nan(13,19,rlen); % 
    hdmata = nan(13,19,rlen); % 
    firenhtmata = nan(3,19,rlen); % 
    
    for rri = 1 : rlen
        ri = idd(rri);
        if(ri ==8 || ri ==13 ||ri ==15 ||ri ==16 || ri ==20 ||ri ==27 ||ri ==33 ||ri ==36 ||ri ==43)
            continue;
        end
        load(['D:\Study\fires\Extreme_fires_relationship\MODISv61_newanalysis\2025.04.08.vpd_evolution\vpd_evo_region_',num2str(ri),'.mat'],'vdmat','tmmat','txmat','vdt_nht');
        vdmat = vdmat/ 100000; % from 0.01 Pa to kPa
        vdt_nht(1,:) = vdt_nht(1,:) / 100000;
        tmmat = tmmat - 273.15;
        txmat = txmat - 273.15;
        vdt_nht(2:3,:) = vdt_nht(2:3,:) - 273.15;
        
        load(['D:\Study\fires\Extreme_fires_relationship\MODISv61_newanalysis\2026.04.02.cumulative_VPD\fwi_evo_region_',num2str(ri),'.mat'],'fwimat','fwi_nht');        
        
        load(['D:\Study\fires\Extreme_fires_relationship\MODISv61_newanalysis\2026.04.02.cumulative_VPD\fire_dur_region_',num2str(ri),'.mat'],'fnmat','szmat','hdmat','firenht');
        ff = nan(13,19);
        ss = nan(13,19);
        hh = nan(13,19);
        
        szz = size(fnmat);
        ff(1:szz(1),:) = fnmat(:,:);
        
        szz = size(szmat);
        ss(1:szz(1),:) = szmat(:,:);
        
        szz = size(hdmat);
        hh(1:szz(1),:) = hdmat(:,:);
        
        for yr = 2003 : 2021
            
            vdmata(:,yr-2002,rri) = vdmat(:,yr-2002);
            fwmata(:,yr-2002,rri) = fwimat(:,yr-2002);
            tmmata(:,yr-2002,rri) = tmmat(:,yr-2002);
            txmata(:,yr-2002,rri) = txmat(:,yr-2002);
            vnhtmata(1,yr-2002,rri) = vdt_nht(1,yr-2002);
            vnhtmata(2,yr-2002,rri) = vdt_nht(2,yr-2002);
            vnhtmata(3,yr-2002,rri) = vdt_nht(3,yr-2002);      
            
            fnmata(:,yr-2002,rri) = ff(:,yr-2002);
            szmata(:,yr-2002,rri) = ss(:,yr-2002);
            hdmata(:,yr-2002,rri) = hh(:,yr-2002);
            firenhtmata(1,yr-2002,rri) = firenht(1);
            firenhtmata(2,yr-2002,rri) = firenht(2);
            firenhtmata(3,yr-2002,rri) = firenht(3);
        end
    end
    
    vdcuall = vdmata;
    fwcuall = fwmata;
    szcuall = szmata;
    fncuall = fnmata;
    for rri = 1 : rlen               
        vdmat = vdmata(:,:,rri); % 
        fwmat = fwmata(:,:,rri);
        tmmat = tmmata(:,:,rri); % 
        txmat = txmata(:,:,rri); %   
        
        fnmat = fnmata(:,:,rri);
        szmat = szmata(:,:,rri);
        hdmat = hdmata(:,:,rri);
        
        durk = 11;
        % cumulative vpd & fire
        vdcu = vdmat;
        fwcu = fwmat;
        szcu = szmat;
        fncu = fnmat;
        for kki = 2 : durk % heatwave day 1 starts from index 4, index 5 starts the accumulation
            vdcu(kki,:) = sum(vdmat(1:kki,:),1);
            fwcu(kki,:) = sum(fwmat(1:kki,:),1);
            szcu(kki,:) = sum(szmat(1:kki,:),1);
            fncu(kki,:) = sum(fnmat(1:kki,:),1);
        end
                
        vdmat(durk:end,:) = nan;
        tmmat(durk:end,:) = nan;
        txmat(durk:end,:) = nan;
        vdcu(durk:end,:) = nan;
        fwcu(durk:end,:) = nan;
        
        fnmat(durk:end,:) = nan;        
        szmat(durk:end,:) = nan;
        hdmat(durk:end,:) = nan;
        szcu(durk:end,:) = nan;
        fncu(durk:end,:) = nan;
        
        vdmata(:,:,rri) = vdmat;
        tmmata(:,:,rri) = tmmat;
        txmata(:,:,rri) = txmat;
        vdcuall(:,:,rri) = vdcu;
        fwcuall(:,:,rri) = fwcu;
        
        fnmata(:,:,rri) = fnmat;
        szmata(:,:,rri) = szmat;
        hdmata(:,:,rri) = hdmat;
        szcuall(:,:,rri) = szcu;
        fncuall(:,:,rri) = fncu;
    end
    vdcuall_total(:,:,cnt+1:cnt+rlen) = vdcuall;
    fwcuall_total(:,:,cnt+1:cnt+rlen) = fwcuall;
    vdnhall_total(1,:,cnt+1:cnt+rlen) = vnhtmata(1,:,:);
    cnt = cnt + rlen;
    durk = 13;
    
    % 2024.07.17, change to relative risks
    vdmat = nanmean(vdmata,3); % 
    tmmat = nanmean(tmmata,3); % 
    txmat = nanmean(txmata,3); % 
    vdnhtmat = reshape(nanmean(vnhtmata(1,:,:),3),19,1);
    tmnhtmat = reshape(nanmean(vnhtmata(2,:,:),3),19,1);
    txnhtmat = reshape(nanmean(vnhtmata(3,:,:),3),19,1);
    
    vdmean = nanmean(vdmat,2)./nanmean(vdnhtmat);
    tmmean = nanmean(tmmat,2)./nanmean(tmnhtmat);
    txmean = nanmean(txmat,2)./nanmean(txnhtmat);
    vdmeanpall = nan(13,rlen);
    tmmeanpall = nan(13,rlen);
    txmeanpall = nan(13,rlen);
    vdcumeanpall = nan(13,rlen);
    vdmeanall = nan(13,rlen);
    tmmeanall = nan(13,rlen);
    txmeanall = nan(13,rlen);
    vdcumeanall = nan(13,rlen);
    
    fnmeanpall = nan(13,rlen);
    mzmeanpall = nan(13,rlen);
    szmeanpall = nan(13,rlen);
    szcumeanpall = nan(13,rlen);
    fncumeanpall = nan(13,rlen);
    fnmeanall = nan(13,rlen);
    mzmeanall = nan(13,rlen);
    szmeanall = nan(13,rlen);
    szcumeanall = nan(13,rlen);
    fncumeanall = nan(13,rlen);
        
    for rri = 1 : rlen
        aaa = reshape ( nanmean(vdmata(:,:,rri),2)./ nanmean(vnhtmata(1,:,rri),2) , 13,1 );
        bbb = reshape ( nanmean(tmmata(:,:,rri),2)./ nanmean(vnhtmata(2,:,rri),2) , 13,1 );
        ccc = reshape ( nanmean(txmata(:,:,rri),2)./ nanmean(vnhtmata(3,:,rri),2) , 13,1 );
        ddd = reshape ( nanmean(vdcuall(:,:,rri),2)./ nanmean(vnhtmata(1,:,rri),2) , 13,1 );
        vdmeanpall(:,rri) = aaa*100;
        tmmeanpall(:,rri) = bbb*100;
        txmeanpall(:,rri) = ccc*100;
        vdcumeanpall(:,rri) = ddd*100;
        
        aaa = reshape ( nanmean(vdmata(:,:,rri),2) , 13,1 );
        bbb = reshape ( nanmean(tmmata(:,:,rri),2) , 13,1 );
        ccc = reshape ( nanmean(txmata(:,:,rri),2) , 13,1 );
        ddd = reshape ( nanmean(vdcuall(:,:,rri),2) , 13,1 );
        eee = reshape ( nanmean(fwcuall(:,:,rri),2), 13,1);
        vdmeanall(:,rri) = aaa;
        tmmeanall(:,rri) = bbb;
        txmeanall(:,rri) = ccc;
        vdcumeanall(:,rri) = ddd;
        fwcumeanall(:,rri) = eee;
        
        % 2026.4.14, 
        % add fire A_H change
        aaa = reshape ( nanmean(fnmata(:,:,rri)./ hdmata(:,:,rri),2)./ nanmean(firenhtmata(1,:,rri),2), 13,1 );
        bbb = reshape ( nanmean(szmata(:,:,rri)./ fnmata(:,:,rri),2)./ nanmean(firenhtmata(2,:,rri),2), 13,1 );
        ccc = reshape ( nanmean(szmata(:,:,rri)./ hdmata(:,:,rri),2)./ nanmean(firenhtmata(3,:,rri),2), 13,1 );
        ddd = reshape ( nanmean(szcuall(:,:,rri)./ hdmata(:,:,rri),2)./ nanmean(firenhtmata(3,:,rri),2), 13,1 );
        eee = reshape ( nanmean(fncuall(:,:,rri)./ hdmata(:,:,rri),2)./ nanmean(firenhtmata(1,:,rri),2), 13,1 );
        fnmeanpall(:,rri) = aaa;
        mzmeanpall(:,rri) = bbb;
        szmeanpall(:,rri) = ccc;
        szcumeanpall(:,rri) = ddd;
        fncumeanpall(:,rri) = eee;
        
        % add fire km^2/day
        aaa = reshape ( nanmean(fnmata(:,:,rri)./ hdmata(:,:,rri),2), 13,1 );
        bbb = reshape ( nanmean(szmata(:,:,rri)./ fnmata(:,:,rri),2), 13,1 );
        ccc = reshape ( nanmean(szmata(:,:,rri)./ hdmata(:,:,rri),2), 13,1 );
        ddd = reshape ( nanmean(szcuall(:,:,rri)./ hdmata(:,:,rri),2), 13,1 );
        eee = reshape ( nanmean(fncuall(:,:,rri)./ hdmata(:,:,rri),2), 13,1 );
        fnmeanall(:,rri) = aaa;
        mzmeanall(:,rri) = bbb;
        szmeanall(:,rri) = ccc;
        szcumeanall(:,rri) = ddd;
        fncumeanall(:,rri) = eee;
    end
    % relative change
    vdmeanp = nanmean(vdmeanpall,2);
    tmmeanp = nanmean(tmmeanpall,2);
    txmeanp = nanmean(txmeanpall,2);
    vdcumeanp = nanmean(vdcumeanpall,2);
    
    vdmeanpstd = nanstd(vdmeanpall,0,2);
    tmmeanpstd = nanstd(tmmeanpall,0,2);
    txmeanpstd = nanstd(txmeanpall,0,2);
    vdcumeanpstd = nanstd(vdcumeanpall,0,2);
    
    fnmeanp = nanmean(fnmeanpall,2);
    mzmeanp = nanmean(mzmeanpall,2);
    szmeanp = nanmean(szmeanpall,2);
    szcumeanp = nanmean(szcumeanpall,2);
    
    fnmeanpstd = nanstd(fnmeanpall,0,2);
    mzmeanpstd = nanstd(mzmeanpall,0,2);
    szmeanpstd = nanstd(szmeanpall,0,2);
    szcumeanpstd = nanstd(szcumeanpall,0,2);
    
    % no relative change
    vdmean = nanmean(vdmeanall,2);
    tmmean = nanmean(tmmeanall,2);
    txmean = nanmean(txmeanall,2);
    vdcumeanall(isinf(vdcumeanall)) = nan;
    vdcumean = nanmean(vdcumeanall,2);
    fwcumeanall(isinf(fwcumeanall)) = nan;
    fwcumean = nanmean(fwcumeanall,2);
    
    vdmeanstd = nanstd(vdmeanall,0,2);
    tmmeanstd = nanstd(tmmeanall,0,2);
    txmeanstd = nanstd(txmeanall,0,2);
    vdcumeanstd = nanstd(vdcumeanall,0,2);
    fwcumeanstd = nanstd(fwcumeanall,0,2);
    
    fnmean = nanmean(fnmeanall,2);
    mzmean = nanmean(mzmeanall,2);
    szmean = nanmean(szmeanall,2);
    szcumeanall(isinf(szcumeanall)) = nan;
    szcumean = nanmean(szcumeanall,2);
    fncumeanall(isinf(fncumeanall)) = nan;
    fncumean = nanmean(fncumeanall,2);
    
    fnmeanstd = nanstd(fnmeanall,0,2);
    mzmeanstd = nanstd(mzmeanall,0,2);
    szmeanstd = nanstd(szmeanall,0,2);
    szcumeanstd = nanstd(szcumeanall,0,2);
    fncumeanstd = nanstd(fncumeanall,0,2);
    

%     subplot(2,2,ki)
%     % Plot with y-error bars
%     yneg = szcumeanstd;
%     ypos = szcumeanstd;
%     xneg = vdcumeanstd;
%     xpos = vdcumeanstd;
%     ee = errorbar(vdcumean, szcumean, yneg, ypos, xneg, xpos, 'o');
%     set(ee, 'MarkerSize',10, 'MarkerEdgeColor','k','MarkerFaceColor','k');
    
    durk = 10;
    if(ki == 4)
        durk = 8;
    end
    vdcumean(durk+1:end) = nan;    
    szcumean(durk+1:end) = nan;
    fncumean(durk+1:end) = nan;
    vdcumeanstd(durk+1:end) = nan;    
    szcumeanstd(durk+1:end) = nan;
    fncumeanstd(durk+1:end) = nan;
    
    subplot(4,3,(ki-1)*3+3)
    % Plot with y-error bars
    yneg = szcumeanstd;
    for zi = 1 : durk
        if(szcumean(zi)-yneg(zi) < 0)
            yneg(zi) =  szcumean(zi);
        end
    end
    ypos = szcumeanstd;
    xneg = fwcumeanstd;
    xpos = fwcumeanstd;
    ee1 = errorbar(fwcumean(1:3), szcumean(1:3), yneg(1:3), ypos(1:3), xneg(1:3), xpos(1:3), 'o');
    hold on,
    ee2 = errorbar(fwcumean(4:durk), szcumean(4:durk), yneg(4:durk), ypos(4:durk), xneg(4:durk), xpos(4:durk), 'o');
    set(ee2, 'MarkerSize',8, 'MarkerEdgeColor','k','MarkerFaceColor','none','Color',[0.6 0.6 0.6],'LineWidth',1.25);
    set(ee1, 'MarkerSize',8, 'MarkerEdgeColor',[0.85 0.85 0.85],'MarkerFaceColor',[0.85 0.85 0.85],'Color',[0.7 0.7 0.7]);
    hold off,
    
    % Linearize: ln(y) = ln(a) + b*x
    xp = fwcumean(~isnan(fwcumean));
    yp = szcumean(~isnan(szcumean));
    xp = xp(~isinf(yp));
    yp = yp(~isinf(yp));
    p = polyfit(xp, log(yp), 1);
    
    b = p(1);
    a = exp(p(2));
    
    % Fitted curve
    xfit = linspace(min(xp), max(xp), 100);
    yfit = a * exp(b * xfit);
    
    % Plot
    hold on    
    plot(xfit, yfit, '--', 'LineWidth', 1.5,'Color',[0.8 0.8 0.8])
    hold off
    xlabel('Cumulative FWI (1 - day)')
    ylabel({'FP_H for cumulative Burned Area', '(km^2 - day d^{-1})'})
    xlim([0 80*7])
    
    if(ki == 2)
        ylim([-5000 50000])
        ax = gca;
        ax.YAxis.Exponent=4;
    else
        ylim([-10000 240000])
        ax = gca;
        ax.YAxis.Exponent=5;
    end
    
    subplot(4,3,(ki-1)*3+2)
    % Plot with y-error bars
    yneg = szcumeanstd;
    for zi = 1 : durk
        if(szcumean(zi)-yneg(zi) < 0)
            yneg(zi) =  szcumean(zi);
        end
    end
    ypos = szcumeanstd;
    xneg = vdcumeanstd;
    xpos = vdcumeanstd;
    ee1 = errorbar(vdcumean(1:3), szcumean(1:3), yneg(1:3), ypos(1:3), xneg(1:3), xpos(1:3), 'o');
    hold on,
    ee2 = errorbar(vdcumean(4:durk), szcumean(4:durk), yneg(4:durk), ypos(4:durk), xneg(4:durk), xpos(4:durk), 'o');
    set(ee2, 'MarkerSize',8, 'MarkerEdgeColor','k','MarkerFaceColor','none','Color',[0.6 0.6 0.6],'LineWidth',1.25);
    set(ee1, 'MarkerSize',8, 'MarkerEdgeColor',[0.85 0.85 0.85],'MarkerFaceColor',[0.85 0.85 0.85],'Color',[0.7 0.7 0.7]);
    hold off,
    
    % Linearize: ln(y) = ln(a) + b*x
    xp = vdcumean(~isnan(vdcumean));
    yp = szcumean(~isnan(szcumean));
    xp = xp(~isinf(yp));
    yp = yp(~isinf(yp));
    p = polyfit(xp, log(yp), 1);
    
    b = p(1);
    a = exp(p(2));
    
    % Fitted curve
    xfit = linspace(min(xp), max(xp), 100);
    yfit = a * exp(b * xfit);
    
    % Plot
    hold on    
    plot(xfit, yfit, '--', 'LineWidth', 1.5,'Color',[0.8 0.8 0.8])
    hold off
    xlabel('Cumulative VPD (kPa - day)')
    ylabel({'FP_H for cumulative Burned Area', '(km^2 - day d^{-1})'})
    xlim([0 27])
    
    if(ki == 2)
        ylim([-5000 50000])
        ax = gca;
        ax.YAxis.Exponent=4;
    else
        ylim([-10000 240000])
        ax = gca;
        ax.YAxis.Exponent=5;
    end
%     text(-6,600000*1.1,labell{(ki-1)*2+2},'FontSize',16,'FontWeight','bold')
    
    
    
    subplot(4,3,(ki-1)*3+1)
    % Plot with y-error bars
    yneg = fncumeanstd;
    for zi = 1 : durk
        if(fncumean(zi)-yneg(zi) < 0)
            yneg(zi) =  fncumean(zi);
        end
    end
    ypos = fncumeanstd;
    xneg = vdcumeanstd;
    xpos = vdcumeanstd;
    ee1 = errorbar(vdcumean(1:3), fncumean(1:3), yneg(1:3), ypos(1:3), xneg(1:3), xpos(1:3), 'o');
    hold on,
    ee2 = errorbar(vdcumean(4:durk), fncumean(4:durk), yneg(4:durk), ypos(4:durk), xneg(4:durk), xpos(4:durk), 'o');
    set(ee2, 'MarkerSize',8, 'MarkerEdgeColor','k','MarkerFaceColor','none','Color',[0.6 0.6 0.6],'LineWidth',1.25);
    set(ee1, 'MarkerSize',8, 'MarkerEdgeColor',[0.85 0.85 0.85],'MarkerFaceColor',[0.85 0.85 0.85],'Color',[0.7 0.7 0.7]);
    hold off,
    
    % Linearize: ln(y) = ln(a) + b*x
    xp = vdcumean(~isnan(vdcumean));
    yp = fncumean(~isnan(fncumean));
    xp = xp(~isinf(yp));
    yp = yp(~isinf(yp));
    p = polyfit(xp, log(yp), 1);
    
    b = p(1);
    a = exp(p(2));
    
    % Fitted curve
    xfit = linspace(min(xp), max(xp), 100);
    yfit = a * exp(b * xfit);
    
    % Plot
    hold on    
    plot(xfit, yfit, '--', 'LineWidth', 1.5,'Color',[0.8 0.8 0.8])
    hold off
    xlabel('Cumulative VPD (kPa - day)')
    ylabel({'FP_H for cumulative fire number', '(n - day d^{-1})'})
    xlim([0 27])
    if(ki == 2)
        ylim([-500 5000])
        text(-6,5000*1.15,labell{(ki-1)*2+1},'FontSize',16,'FontWeight','bold')
        text(1,5000*0.9,labell2{(ki-1)*2+1},'FontSize',13)
        ax = gca;
        ax.YAxis.Exponent=3;
%         ytickformat('%.1e')
    else
        ylim([-1000 20000])
        text(-6,20000*1.15,labell{(ki-1)*2+1},'FontSize',16,'FontWeight','bold')
        text(1,20000*0.9,labell2{(ki-1)*2+1},'FontSize',13)
        ax = gca;
        ax.YAxis.Exponent=4;
    end
    
    
% % % %     szmeanstd = nanstd(szmeanpall,0,2);
% % % % %     if(ki == 2)
% % % % %         fnmeanstd
% % % % %     end
% % % %     
% % % %     %--- 2022.06.09 -- add std for different region
% % % % %     nansum(fnmata,2)./nansum(hdmat,2)
% % % % % ----- Method 1, show variation of region
% % % %     vdstd = nanstd(  reshape(nanmean(vdmata,2),13,rlen) ,0,2);
% % % %     tmstd = nanstd(  reshape(nanmean(tmmata,2),13,rlen) ,0,2);
% % % %     txstd = nanstd(  reshape(nanmean(txmata,2),13,rlen) ,0,2);
% % % % 
% % % %     % relative std
% % % %     vdstdp = nanstd(  reshape(nanmean(vdmata,2),13,rlen)./repmat(reshape(nanmean(vnhtmata(1,:,:),2),1,rlen) ,13,1 )    ,0,3);
% % % %     tmstdp = nanstd(  reshape(nanmean(tmmata,2),13,rlen)./repmat(reshape(nanmean(vnhtmata(2,:,:),2),1,rlen) ,13,1 )    ,0,3);
% % % %     txstdp = nanstd(  reshape(nanmean(txmata,2),13,rlen)./repmat(reshape(nanmean(vnhtmata(3,:,:),2),1,rlen) ,13,1 )    ,0,3);
% % % % % % % % ----- Method 2, show variation of years
% % % % % % %     fnstd = nanstd(nansum(fnmata,3)./nansum(hdmata,3),0,2);
% % % % % % %     szstd = nanstd(nansum(szmata,3)./nansum(hdmata,3),0,2);
% % % %     
% % % % %     fnmean = nanmean(fnmat./hdmat,2);
% % % % %     szmean = nanmean(szmat./hdmat,2);
% % % %     
% % % % %IAV
% % % % %     fnstd = nanstd(fnmat./hdmat,0,2);
% % % % %     szstd = nanstd(szmat./hdmat,0,2);
% % % %     
% % % % 
% % % %     
% % % %     xdata = 1 : 1 : 13;
% % % %     
% % % %     if(ki ==1)
% % % %     figure,
% % % %     end
% % % %     
% % % %     ydata = vdmeanp;
% % % % %     ydata2 = ydata / mean(dataall(4,1,1,idd));
% % % %     % ydata3 = prctile(fnmat./hdmat,90,2);
% % % %     xxf = [xdata fliplr(xdata)];
% % % %     xl = length(xdata);
% % % %     xxf(1) = 0;xxf(xl) = xl+1; xxf(xl+1) = xl+1; xxf(end) = 0;
% % % %     
% % % %     subplot(4,3,(ki-1)*3+1),    
% % % %     negstd = ydata-vdmeanstd;
% % % %     negstd2 = vdmeanstd;
% % % %     negstd2(negstd<0) = ydata(negstd<0);
% % % %     ydata(end-2:end) = nan;
% % % %     ee1 = errorbar(xdata,ydata,negstd2,vdmeanstd);
% % % %     ee1.Color = [0.40 0.40 0.40];
% % % %     ee1.LineStyle = '--';
% % % % %     hold on,
% % % % %     yyf = [zeros(1,xl) repmat(mean(dataall(4,1,1,idd)),1,xl)];
% % % %     hold on,
% % % %     p1 = plot(xdata,ydata,'k-');
% % % % %     hold on,
% % % % %     line([0 13], [mean(dataall(4,1,1,idd)) mean(dataall(4,1,1,idd))])
% % % %     hold on,
% % % %     s1 = scatter(xdata,ydata,40,'filled');
% % % %     s1.MarkerEdgeColor = 'k';
% % % % %     colormap(flipud(hot))
% % % % %     caxis([0 9])
% % % % %     c1 = colorbar;
% % % % %     c1.Location = 'Northoutside';
% % % % %     set(c1,'YTick',[1 3 5 7 9]);    
% % % %     grid on
% % % %     box on
% % % %     set(gca,'GridLineStyle','-.')
% % % %     set(gca,'XTick',[1 :1: 11],'XTickLabel',{'-3','-2','-1','1','2','3','4','5','6','7','8','9','10'})
% % % %     ymaxx = max(ydata+vdmeanstd);
% % % %     if(ki ==1)
% % % %         text(4,ymaxx*1.05,'Heatwave starts')
% % % % %         text(5,40,'Non-heatwave level','Color',[130 130 130]./255)
% % % %     end
% % % %     line([3.5 3.5],[0 ymaxx*1.1],'Color','k','LineStyle','--')
% % % %     line([0 11],[100 100],'Color','k','LineStyle',':')
% % % %     set(gca,'YLim',[50 ymaxx*1.1],'XLim',[0 durk-2],'YColor','k')
% % % %     ylabel('VPD (%)')
% % % %     xlabel('day before after a heat wave')
% % % % %     get(gca,'position');
% % % % %     set(gca,'position',[0.1500    0.600    0.2134    0.2253]);
% % % %     set(gca,'FontSize',10)
% % % %     
% % % %     subplot(4,3,(ki-1)*3+2),
% % % %     ydata = txmeanp;
% % % %     negstd = ydata-txmeanstd;
% % % %     negstd2 = txmeanstd;
% % % %     negstd2(negstd<0) = ydata(negstd<0);
% % % %     ydata(end-2:end) = nan;
% % % %     ee1 = errorbar(xdata,ydata,negstd2,txmeanstd);
% % % %     ee1.Color = [0.40 0.40 0.40];
% % % %     ee1.LineStyle = '--';
% % % %     hold on,
% % % %     p1 = plot(xdata,ydata,'k-');
% % % % %     hold on,
% % % % %     line([0 13], [mean(dataall(6,1,1,idd)) mean(dataall(6,1,1,idd))])
% % % %     hold on,    
% % % %     s1 = scatter(xdata,ydata,40,'filled');
% % % %     s1.MarkerEdgeColor = 'k';
% % % % %     colormap(flipud(hot))
% % % % %     caxis([0 9])
% % % % %     c1 = colorbar;
% % % % %     c1.Location = 'Northoutside';
% % % % %     set(c1,'YTick',[1 3 5 7 9]);
% % % %     grid on
% % % %     box on
% % % %     set(gca,'GridLineStyle','-.')
% % % %     set(gca,'XTick',[1 :1: 11],'XTickLabel',{'-3','-2','-1','1','2','3','4','5','6','7','8','9','10'})
% % % %     ymaxx = max(ydata+txmeanstd);
% % % %     % text(4,ymaxx*1.05,'Heatwave starts')
% % % %     line([3.5 3.5],[0 ymaxx*1.1],'Color','k','LineStyle','--')
% % % %     set(gca,'YLim',[50 ymaxx*1.1],'XLim',[0 durk-2],'YColor','k')
% % % %     ylabel('T_{max} (%)')
% % % %     xlabel('day before or after a heat wave')
% % % % %     get(gca,'position');
% % % % %     set(gca,'position',[0.4500    0.600    0.2134    0.2253]);
% % % %     set(gca,'FontSize',10)
% % % %     
% % % %     subplot(4,3,(ki-1)*3+3),
% % % %     ydata = tmmeanp;
% % % % %     ydata2 = ydata / mean(dataall(5,1,1,idd));
% % % %     negstd = ydata-tmmeanstd;
% % % %     negstd2 = tmmeanstd;
% % % %     negstd2(negstd<0) = ydata(negstd<0);
% % % %     ydata(end-2:end) = nan;
% % % %     ee2 = errorbar(xdata,ydata,negstd2,tmmeanstd);
% % % %     ee2.Color = [0.40 0.40 0.40];
% % % %     ee2.LineStyle = '--';
% % % % %     hold on,
% % % % %     yyf = [zeros(1,xl) repmat(mean(dataall(5,1,1,idd)),1,xl)];
% % % %     hold on,
% % % %     p1 = plot(xdata,ydata,'k-');
% % % % %     hold on,
% % % % %     line([0 13], [mean(dataall(5,1,1,idd)) mean(dataall(5,1,1,idd))])
% % % %     hold on,
% % % %     s1 = scatter(xdata,ydata,40,'filled');
% % % %     s1.MarkerEdgeColor = 'k';
% % % % %     colormap(flipud(hot))
% % % % %     caxis([0 9])
% % % % %     c1 = colorbar;
% % % % %     c1.Location = 'Northoutside';
% % % % %     set(c1,'YTick',[1 3 5 7 9]);    
% % % %     grid on
% % % %     box on
% % % %     set(gca,'GridLineStyle','-.')
% % % %     set(gca,'XTick',[1 :1: 11],'XTickLabel',{'-3','-2','-1','1','2','3','4','5','6','7','8','9','10'})
% % % %     ymaxx = max(ydata+tmmeanstd);
% % % %     % text(4,ymaxx*1.05,'Heatwave starts')
% % % %     line([3.5 3.5],[0 ymaxx*1.1],'Color','k','LineStyle','--')
% % % %     line([0 11],[100 100],'Color','k','LineStyle',':')
% % % %     set(gca,'YLim',[50 ymaxx*1.1],'XLim',[0 durk-2],'YColor','k')
% % % %     ylabel('T_{mean} (%)')
% % % %     xlabel('day before or after a heat wave')
% % % % %     get(gca,'position');
% % % % %     set(gca,'position',[0.7500    0.60    0.2134    0.2253]);
% % % %     set(gca,'FontSize',10)
% % % %     
% % % %     
% % % %     
% % % %     
% % % %     set(gcf,'position',[  698   387   862   951])
% % % % %     saveas(gcf,['D:\Study\fires\Extreme_fires_relationship\2022.02.15.newregion_recomp2\2021.12.03.ehf_relationship_fire\simple_version_regionIntegral\fire_htduration_',num2str(ri),'_',yvalues{ri},'.jpg']);
end

set(gcf,'position',[561         160        1090        1118]);
