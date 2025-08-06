%% 1. amplification factor - no MODIS fire - big fire
load D:\Study\fires\Extreme_fires_relationship\MODISv61_newanalysis\2021.10.16.heatwv_nheatwv_comp3\big_fire\amplification_factor_htwv.mat
% yvalues = {'ALA','CGI','WNA','CNA','ENA','CAM','AMZ','NEB','WSA','SSA','NEU','CEU','MED',...
%     'SAH','NAF','SAF','NAS','WAS','CAS','TIB','EAS','SAS','SEA','NAU','SAU'};
yvalues = {'NWN','NEN','WNA','CNA','ENA','NCA','SCA','CAR','NWS','NSA','NES','SAM','SWS','SES','SSA',... %1-15, need to skip 8 - CAR
    'NEU','WCE','EEU','MED','SAH','WAF','NCAF','NEAF','SEAF','WSAF','ESAF','MDG',... % 16-27, need to skip 27 - MDG
    'RAR','WSB','ESB','RFE','WCA','ECA','TIB','EAS','ARP','SAS','SEAN','NAU','CAU','EAU','SAU','NZ','SCAF','SEAS'}; % 28-45
latt = [83,82.9000000000000,71,70.9000000000000,70.8000000000000,70.3000000000000,68,67.5000000000000,30,25.9000000000000,25.8400000000000,25.8500000000000,20,19.9000000000000,19.8000000000000,82.8000000000000,82.6000000000000,82.5000000000000,70.7000000000000,70.2000000000000,25.8000000000000,25.7000000000000,25.6000000000000,25.5000000000000,18,17.5000000000000,17,82.7000000000000,82.4000000000000,82.3000000000000,82.2000000000000,70.7000000000000,70.6000000000000,70.4000000000000,70.5000000000000,70.1000000000000,70,25.4000000000000,15,14,13,12,11, 25.65, 25];
[yyv inddd] = sort(latt,'descend');
xvalues = {{'Fire number'}, {'Burned area'},{'Final fire size'}};
nbb = {'a','b','c'};
% max1 = max(dataamp(:,1,:))

% 1st filter, heatwave duration less than 3days per year will be neglected
% for ri = 1 : 26
% %     if(ri == 26)
% %         continue;
% %     end
%     for i = 1 : 3
%         if(dataall(1,2,i,ri) < 3) % heatwave days < 3days during the 14 year (3/14=0.2143)
%             dataamp(ri,:,i) = nan;
%         end
%     end
% end

% % % % % % change on July 26/2024
% % % % % dataamp(8,:,:)= nan;
% % % % % dataamp(13,:,:)= nan;
% % % % % dataamp(15,:,:) = nan;
% % % % % dataamp(16,:,:) = nan;
% % % % % dataamp(20,:,:) = nan;
% % % % % dataamp(27,:,:) = nan;
% % % % % dataamp(33,:,:) = nan;
% % % % % dataamp(36,:,:) = nan;
% % % % % dataamp(43,:,:) = nan;
% % % % % 
% % % % % % 2nd filter, forest fire number < 1% of the total fire number will
% % % % % % neglected
% % % % % for ri = 1 : 45
% % % % %     for i = 2 : 3
% % % % %         if(  sum(dataall(2,:,i,ri)) / sum(sum(dataall(2,:,2:3,ri))) < 0.05 || sum(dataall(3,:,i,ri)) / sum(sum(dataall(3,:,2:3,ri))) < 0.05 )
% % % % %             dataamp(ri,:,i) = nan;
% % % % %         end
% % % % %     end
% % % % % end

yyvalues = {};
for ri = 1 : 45
    if(inddd(ri) ~= 8 && inddd(ri) ~=13 && inddd(ri) ~= 15 && inddd(ri) ~= 16 && inddd(ri) ~= 20 && inddd(ri) ~= 27 && inddd(ri) ~= 33 && inddd(ri) ~= 36 && inddd(ri) ~= 43)
        yyvalues = {yyvalues{:}, yvalues{inddd(ri)} };        
    end
end
figure,

for ci = 1 : 3
    if(ci ==1)
        i = 1;
    elseif(ci ==2)
        i = 3;
    else
        i = 2;
    end
    subplot(1,3,ci);
    
    cnt = 1;
    for ri = 1 : 45
        if(inddd(ri) ~= 8 && inddd(ri) ~=13 && inddd(ri) ~= 15 && inddd(ri) ~= 16 && inddd(ri) ~= 20 && inddd(ri) ~= 27 && inddd(ri) ~= 33 && inddd(ri) ~= 36 && inddd(ri) ~= 43)
            %         l1 = line([0 dataamp(ri,i,1)],[26-ri+1+0.2 26-ri+1+0.2],'Color',[254 124 0]/255,'LineWidth',1.8);
            l1 = line([0 dataamp(inddd(ri),i,1)],[36-cnt+1+0.2 36-cnt+1+0.2],'Color',[0 0 0]/255,'LineWidth',1.8);
            hold on,
            %         l2 = line([0 dataamp(ri,i,2)],[26-ri+1 26-ri+1],'Color',[0 180 171]/255,'LineWidth',1.8);
            l2 = line([0 dataamp(inddd(ri),i,2)],[36-cnt+1 36-cnt+1],'Color',[0 171 40]/255,'LineWidth',1.8);
            hold on,
            %         l3 = line([0 dataamp(ri,i,3)],[26-ri+1-0.2 26-ri+1-0.2],'Color',[255 216 50]/255,'LineWidth',1.8);
            l3 = line([0 dataamp(inddd(ri),i,3)],[36-cnt+1-0.2 36-cnt+1-0.2],'Color',[0 240 0]/255,'LineWidth',1.8);            
            hold on,
%             l4 = line([0 dataamp22(inddd(ri),i,1)],[36-cnt+1+0.4 36-cnt+1+0.4],'Color',[151 41 181]/255,'LineWidth',1.8);
            cnt = cnt +1;
        end

    end
    line([1 1],[0 37],'Color','k','LineStyle',':','LineWidth',1.2)
    if(i ==1)
%         set(gca,'YTick',[1 : 26],'YTickLabel',fliplr(yvalues));
        set(gca,'YTick',[1 : 36],'YTickLabel',fliplr(yyvalues));
    else
        set(gca,'YTick',[1 : 36],'YTickLabel',{});
    end
    if(i ==1)
        set(gca,'YLim',[0 37],'XLim',[0 8], 'XTick',[0 1 2 3 4 5 6]);
    elseif(i ==2)
        set(gca,'YLim',[0 37],'XLim',[0 15],'XTick',[0 1 2 4 6 8 10 12 14]);
    else
        set(gca,'YLim',[0 37],'XLim',[0 3],'XTick',[0 1 2 3 4 5]);
    end
    if(i<2)
        text(-1.5, 37.5,nbb{ci},'FontWeight','bold','FontSize',13)
    else
        text(-1, 37.5,nbb{ci},'FontWeight','bold','FontSize',13)
    end
    xlabel(xvalues{i});
    box on
    grid on
    if(ci==3)
        legend([l1 l2 l3],{'All','Forest','Non-forest)'})
    end
    set(gca,'FontSize',12)
end

set(gcf,'position',[428   308   812   670])

%% 1. amplification factor - with MODIS fire
load D:\Study\fires\Extreme_fires_relationship\2021.11.10.active_fire_modis\comp2\amplification_factor_htwv2.mat
dataall2 = dataall;
dataamp22 = dataamp;
dataamp222 = dataamp2;
load amplification_factor_htwv.mat
% yvalues = {'ALA','CGI','WNA','CNA','ENA','CAM','AMZ','NEB','WSA','SSA','NEU','CEU','MED',...
%     'SAH','NAF','SAF','NAS','WAS','CAS','TIB','EAS','SAS','SEA','NAU','SAU'};
yvalues = {'NWN','NEN','WNA','CNA','ENA','NCA','SCA','CAR','NWS','NSA','NES','SAM','SWS','SES','SSA',... %1-15, need to skip 8 - CAR
    'NEU','WCE','EEU','MED','SAH','WAF','CAF','NEAF','SEAF','WSAF','ESAF','MDG',... % 16-27, need to skip 27 - MDG
    'RAR','WSB','ESB','RFE','WCA','ECA','TIB','EAS','ARP','SAS','SEA','NAU','CAU','EAU','SAU','NZ'}; % 28-43
latt = [83,82.9000000000000,71,70.9000000000000,70.8000000000000,70.3000000000000,68,67.5000000000000,30,25.9000000000000,25.8400000000000,25.8500000000000,20,19.9000000000000,19.8000000000000,82.8000000000000,82.6000000000000,82.5000000000000,70.7000000000000,70.2000000000000,25.8000000000000,25.7000000000000,25.6000000000000,25.5000000000000,18,17.5000000000000,17,82.7000000000000,82.4000000000000,82.3000000000000,82.2000000000000,70.7000000000000,70.6000000000000,70.4000000000000,70.5000000000000,70.1000000000000,70,25.4000000000000,15,14,13,12,11];
[yyv inddd] = sort(latt,'descend');
xvalues = {{'Fire number'}, {'Burned area'},{'Mean size'}};
nbb = {'a','b','c'};
% max1 = max(dataamp(:,1,:))

% 1st filter, heatwave duration less than 3days per year will be neglected
% for ri = 1 : 26
% %     if(ri == 26)
% %         continue;
% %     end
%     for i = 1 : 3
%         if(dataall(1,2,i,ri) < 3) % heatwave days < 3days during the 14 year (3/14=0.2143)
%             dataamp(ri,:,i) = nan;
%         end
%     end
% end
dataamp(8,:,:)= nan;
dataamp(13,:,:)= nan;
dataamp(15,:,:) = nan;
dataamp(16,:,:) = nan;
dataamp(27,:,:) = nan;
dataamp(33,:,:) = nan;
dataamp(36,:,:) = nan;
dataamp(43,:,:) = nan;

dataamp22(8,:,:)= nan;
dataamp22(13,:,:)= nan;
dataamp22(15,:,:) = nan;
dataamp22(16,:,:) = nan;
dataamp22(27,:,:) = nan;
dataamp22(33,:,:) = nan;
dataamp22(36,:,:) = nan;
dataamp22(43,:,:) = nan;


% 2nd filter, forest fire number < 1% of the total fire number will
% neglected
for ri = 1 : 43
    for i = 2 : 3
        if(  sum(dataall(2,:,i,ri)) / sum(sum(dataall(2,:,2:3,ri))) < 0.25 || sum(dataall(3,:,i,ri)) / sum(sum(dataall(3,:,2:3,ri))) < 0.25 )
            dataamp(ri,:,i) = nan;
            dataamp22(ri,:,i) = nan;
        end
    end
end

yyvalues = {};
for ri = 1 : 43    
    if(inddd(ri) ~= 8 && inddd(ri) ~=13 && inddd(ri) ~= 15 && inddd(ri) ~= 16 && inddd(ri) ~= 27 && inddd(ri) ~= 33 && inddd(ri) ~= 36 && inddd(ri) ~= 43)
        yyvalues = {yyvalues{:}, yvalues{inddd(ri)} };        
    end
end
figure,

for ci = 1 : 3
    if(ci ==1)
        i = 1;
    elseif(ci ==2)
        i = 3;
    else
        i = 2;
    end
    subplot(1,3,ci);
    
    cnt = 1;
    for ri = 1 : 43
        if(inddd(ri) ~= 8 && inddd(ri) ~=13 && inddd(ri) ~= 15 && inddd(ri) ~= 16 && inddd(ri) ~= 27 && inddd(ri) ~= 33 && inddd(ri) ~= 36 && inddd(ri) ~= 43)
            %         l1 = line([0 dataamp(ri,i,1)],[26-ri+1+0.2 26-ri+1+0.2],'Color',[254 124 0]/255,'LineWidth',1.8);
            l1 = line([0 dataamp(inddd(ri),i,1)],[35-cnt+1+0.2 35-cnt+1+0.2],'Color',[254 124 0]/255,'LineWidth',1.8);
            hold on,
            %         l2 = line([0 dataamp(ri,i,2)],[26-ri+1 26-ri+1],'Color',[0 180 171]/255,'LineWidth',1.8);
            l2 = line([0 dataamp(inddd(ri),i,2)],[35-cnt+1 35-cnt+1],'Color',[0 180 171]/255,'LineWidth',1.8);
            hold on,
            %         l3 = line([0 dataamp(ri,i,3)],[26-ri+1-0.2 26-ri+1-0.2],'Color',[255 216 50]/255,'LineWidth',1.8);
            l3 = line([0 dataamp(inddd(ri),i,3)],[35-cnt+1-0.2 35-cnt+1-0.2],'Color',[255 216 50]/255,'LineWidth',1.8);
            hold on,
            l4 = line([0 dataamp22(inddd(ri),i,1)],[35-cnt+1+0.4 35-cnt+1+0.4],'Color',[151 41 181]/255,'LineWidth',1.8);
            cnt = cnt +1;
        end

    end
    line([1 1],[0 36],'Color','k','LineStyle',':')
    if(i ==1)
%         set(gca,'YTick',[1 : 26],'YTickLabel',fliplr(yvalues));
        set(gca,'YTick',[1 : 35],'YTickLabel',fliplr(yyvalues));
    else
        set(gca,'YTick',[1 : 35],'YTickLabel',{});
    end
    if(i ==1)
        set(gca,'YLim',[0 36],'XLim',[0 9]);
    elseif(i ==2)
        set(gca,'YLim',[0 36],'XLim',[0 9]);
    else
        set(gca,'YLim',[0 36],'XLim',[0 6]);
    end
    if(i<2)
        text(-1.5, 36.5,nbb{ci},'FontWeight','bold','FontSize',13)
    else
        text(-1, 36.5,nbb{ci},'FontWeight','bold','FontSize',13)
    end
    xlabel(xvalues{i});
    box on
    grid on
    if(ci==3)
        legend([l4 l1 l2 l3],{'MCD14ML (all)','GFAtlas (all)','GFAtlas (forest)','GFAtlas (non-forest)'})
    end
    set(gca,'FontSize',12)
end

set(gcf,'position',[428   308   812   670])


%% 1. amplification factor - only MODIS fire
load D:\Study\fires\Extreme_fires_relationship\2021.11.10.active_fire_modis\comp2\amplification_factor_htwv4.mat
% dataall2 = dataall;
% dataamp22 = dataamp;
% dataamp222 = dataamp2;
% load amplification_factor_htwv.mat
% yvalues = {'ALA','CGI','WNA','CNA','ENA','CAM','AMZ','NEB','WSA','SSA','NEU','CEU','MED',...
%     'SAH','NAF','SAF','NAS','WAS','CAS','TIB','EAS','SAS','SEA','NAU','SAU'};
yvalues = {'NWN','NEN','WNA','CNA','ENA','NCA','SCA','CAR','NWS','NSA','NES','SAM','SWS','SES','SSA',... %1-15, need to skip 8 - CAR
    'NEU','WCE','EEU','MED','SAH','WAF','NCAF','NEAF','SEAF','WSAF','ESAF','MDG',... % 16-27, need to skip 27 - MDG
    'RAR','WSB','ESB','RFE','WCA','ECA','TIB','EAS','ARP','SAS','SEA','NAU','CAU','EAU','SAU','NZ','SCAF'}; % 28-44
latt = [83,82.9000000000000,71,70.9000000000000,70.8000000000000,70.3000000000000,68,67.5000000000000,30,25.9000000000000,25.8400000000000,25.8500000000000,20,19.9000000000000,19.8000000000000,82.8000000000000,82.6000000000000,82.5000000000000,70.7000000000000,70.2000000000000,25.8000000000000,25.7000000000000,25.6000000000000,25.5000000000000,18,17.5000000000000,17,82.7000000000000,82.4000000000000,82.3000000000000,82.2000000000000,70.7000000000000,70.6000000000000,70.4000000000000,70.5000000000000,70.1000000000000,70,25.4000000000000,15,14,13,12,11, 25.65];
[yyv inddd] = sort(latt,'descend');
xvalues = {{'Fire count'}, {'Burned area'},{'Mean size'}};
nbb = {'a','b','c'};
% max1 = max(dataamp(:,1,:))

% 1st filter, heatwave duration less than 3days per year will be neglected
% for ri = 1 : 26
% %     if(ri == 26)
% %         continue;
% %     end
%     for i = 1 : 3
%         if(dataall(1,2,i,ri) < 3) % heatwave days < 3days during the 14 year (3/14=0.2143)
%             dataamp(ri,:,i) = nan;
%         end
%     end
% end
dataamp(8,:,:)= nan;
dataamp(13,:,:)= nan;
dataamp(15,:,:) = nan;
dataamp(16,:,:) = nan;
dataamp(27,:,:) = nan;
dataamp(33,:,:) = nan;
dataamp(36,:,:) = nan;
dataamp(43,:,:) = nan;

% dataamp22(8,:,:)= nan;
% dataamp22(13,:,:)= nan;
% dataamp22(15,:,:) = nan;
% dataamp22(16,:,:) = nan;
% dataamp22(27,:,:) = nan;
% dataamp22(33,:,:) = nan;
% dataamp22(36,:,:) = nan;
% dataamp22(43,:,:) = nan;


% 2nd filter, forest fire number < 1% of the total fire number will
% neglected
for ri = 1 : 44
    for i = 2 : 3
        if(  sum(dataall(2,:,i,ri)) / sum(sum(dataall(2,:,2:3,ri))) < 0.05 || sum(dataall(3,:,i,ri)) / sum(sum(dataall(3,:,2:3,ri))) < 0.05 )
            dataamp(ri,:,i) = nan;
%             dataamp22(ri,:,i) = nan;
        end
    end
end

yyvalues = {};
for ri = 1 : 44    
    if(inddd(ri) ~= 8 && inddd(ri) ~=13 && inddd(ri) ~= 15 && inddd(ri) ~= 16 && inddd(ri) ~= 27 && inddd(ri) ~= 33 && inddd(ri) ~= 36 && inddd(ri) ~= 43)
        yyvalues = {yyvalues{:}, yvalues{inddd(ri)} };        
    end
end
figure,

for ci = 1 : 3
    if(ci ==1)
        i = 1;
    elseif(ci ==2)
        i = 3;
    else
        i = 2;
    end
    subplot(1,3,ci);
    
    cnt = 1;
    for ri = 1 : 44
        if(inddd(ri) ~= 8 && inddd(ri) ~=13 && inddd(ri) ~= 15 && inddd(ri) ~= 16 && inddd(ri) ~= 27 && inddd(ri) ~= 33 && inddd(ri) ~= 36 && inddd(ri) ~= 43)
            %         l1 = line([0 dataamp(ri,i,1)],[26-ri+1+0.2 26-ri+1+0.2],'Color',[254 124 0]/255,'LineWidth',1.8);
            l1 = line([0 dataamp(inddd(ri),i,1)],[36-cnt+1+0.2 36-cnt+1+0.2],'Color',[0 0 0]/255,'LineWidth',1.8);
            hold on,
            %         l2 = line([0 dataamp(ri,i,2)],[26-ri+1 26-ri+1],'Color',[0 180 171]/255,'LineWidth',1.8);
            l2 = line([0 dataamp(inddd(ri),i,2)],[36-cnt+1 36-cnt+1],'Color',[0 171 40]/255,'LineWidth',1.8);
            hold on,
            %         l3 = line([0 dataamp(ri,i,3)],[26-ri+1-0.2 26-ri+1-0.2],'Color',[255 216 50]/255,'LineWidth',1.8);
            l3 = line([0 dataamp(inddd(ri),i,3)],[36-cnt+1-0.2 36-cnt+1-0.2],'Color',[0 240 0]/255,'LineWidth',1.8);
            hold on,
% %             l4 = line([0 dataamp22(inddd(ri),i,1)],[35-cnt+1+0.4 35-cnt+1+0.4],'Color',[151 41 181]/255,'LineWidth',1.8);
            cnt = cnt +1;
        end

    end
    line([1 1],[0 36],'Color','k','LineStyle',':')
    if(i ==1)
%         set(gca,'YTick',[1 : 26],'YTickLabel',fliplr(yvalues));
        set(gca,'YTick',[1 : 36],'YTickLabel',fliplr(yyvalues));
    else
        set(gca,'YTick',[1 : 36],'YTickLabel',{});
    end
%     if(i ==1)
%         set(gca,'YLim',[0 36],'XLim',[0 9]);
%     elseif(i ==2)
%         set(gca,'YLim',[0 36],'XLim',[0 9]);
%     else
%         set(gca,'YLim',[0 36],'XLim',[0 6]);
%     end
    if(i ==1)
        set(gca,'YLim',[0 37],'XLim',[0 10], 'XTick',[0 2 4 6 8 10 ]);
    elseif(i ==2)
        set(gca,'YLim',[0 37],'XLim',[0 15],'XTick',[0 1 2 4 6 8 10 12 14]);
    else
        set(gca,'YLim',[0 37],'XLim',[0 5],'XTick',[0 1 2 3 4 5]);
    end
    if(i<2)
        text(-1.5, 37.5,nbb{ci},'FontWeight','bold','FontSize',13)
    else
        text(-1, 37.5,nbb{ci},'FontWeight','bold','FontSize',13)
    end
    if(ci ==1)
        text(10.5,32,'23.7','Color',[0 171 40]/255)
    end
    xlabel(xvalues{i});
    box on
    grid on
    if(ci==3)
        legend([l1 l2 l3],{'All','Forest','Non-forest'})
    end
    set(gca,'FontSize',12)
end

set(gcf,'position',[428   308   812   670])

%% 1. amplification factor - only MODIS fire - FRP
load D:\Study\fires\Extreme_fires_relationship\2021.11.10.active_fire_modis\comp2\amplification_factor_htwv55.mat
% dataall2 = dataall;
% dataamp22 = dataamp;
% dataamp222 = dataamp2;
% load amplification_factor_htwv.mat
% yvalues = {'ALA','CGI','WNA','CNA','ENA','CAM','AMZ','NEB','WSA','SSA','NEU','CEU','MED',...
%     'SAH','NAF','SAF','NAS','WAS','CAS','TIB','EAS','SAS','SEA','NAU','SAU'};
yvalues = {'NWN','NEN','WNA','CNA','ENA','NCA','SCA','CAR','NWS','NSA','NES','SAM','SWS','SES','SSA',... %1-15, need to skip 8 - CAR
    'NEU','WCE','EEU','MED','SAH','WAF','NCAF','NEAF','SEAF','WSAF','ESAF','MDG',... % 16-27, need to skip 27 - MDG
    'RAR','WSB','ESB','RFE','WCA','ECA','TIB','EAS','ARP','SAS','SEAN','NAU','CAU','EAU','SAU','NZ','SCAF','SEAS'}; % 28-45
latt = [83,82.9000000000000,71,70.9000000000000,70.8000000000000,70.3000000000000,68,67.5000000000000,30,25.9000000000000,25.8400000000000,25.8500000000000,20,19.9000000000000,19.8000000000000,82.8000000000000,82.6000000000000,82.5000000000000,70.7000000000000,70.2000000000000,25.8000000000000,25.7000000000000,25.6000000000000,25.5000000000000,18,17.5000000000000,17,82.7000000000000,82.4000000000000,82.3000000000000,82.2000000000000,70.7000000000000,70.6000000000000,70.4000000000000,70.5000000000000,70.1000000000000,70,25.4000000000000,15,14,13,12,11, 25.65,25];
[yyv inddd] = sort(latt,'descend');
xvalues = {{'Sum of FRP'}, {'Burned area'},{'Final fire size'}};
nbb = {'a','b','c'};
% max1 = max(dataamp(:,1,:))

% 1st filter, heatwave duration less than 3days per year will be neglected
% for ri = 1 : 26
% %     if(ri == 26)
% %         continue;
% %     end
%     for i = 1 : 3
%         if(dataall(1,2,i,ri) < 3) % heatwave days < 3days during the 14 year (3/14=0.2143)
%             dataamp(ri,:,i) = nan;
%         end
%     end
% end
dataamp(8,:,:)= nan;
dataamp(13,:,:)= nan;
dataamp(15,:,:) = nan;
dataamp(16,:,:) = nan;
dataamp(20,:,:) = nan;
dataamp(27,:,:) = nan;
dataamp(33,:,:) = nan;
dataamp(36,:,:) = nan;
dataamp(43,:,:) = nan;

% dataamp22(8,:,:)= nan;
% dataamp22(13,:,:)= nan;
% dataamp22(15,:,:) = nan;
% dataamp22(16,:,:) = nan;
% dataamp22(27,:,:) = nan;
% dataamp22(33,:,:) = nan;
% dataamp22(36,:,:) = nan;
% dataamp22(43,:,:) = nan;


% 2nd filter, forest fire number < 1% of the total fire number will
% neglected
for ri = 1 : 45
    for i = 2 : 3
        if(  sum(dataall(2,:,i,ri)) / sum(sum(dataall(2,:,2:3,ri))) < 0.05 || sum(dataall(3,:,i,ri)) / sum(sum(dataall(3,:,2:3,ri))) < 0.05 )
            dataamp(ri,:,i) = nan;
%             dataamp22(ri,:,i) = nan;
        end
    end
end

yyvalues = {};
for ri = 1 : 45    
    if(inddd(ri) ~= 8 && inddd(ri) ~=13 && inddd(ri) ~= 15 && inddd(ri) ~= 16 && inddd(ri) ~= 20 && inddd(ri) ~= 27 && inddd(ri) ~= 33 && inddd(ri) ~= 36 && inddd(ri) ~= 43)
        yyvalues = {yyvalues{:}, yvalues{inddd(ri)} };        
    end
end
figure,

for ci = 1 : 3
    if(ci ==1)
        i = 1;
    elseif(ci ==2)
        i = 3;
    else
        i = 2;
    end
    subplot(1,3,ci);
    
    cnt = 1;
    for ri = 1 : 45
        if(inddd(ri) ~= 8 && inddd(ri) ~=13 && inddd(ri) ~= 15 && inddd(ri) ~= 16 && inddd(ri) ~=20 && inddd(ri) ~= 27 && inddd(ri) ~= 33 && inddd(ri) ~= 36 && inddd(ri) ~= 43)
            %         l1 = line([0 dataamp(ri,i,1)],[26-ri+1+0.2 26-ri+1+0.2],'Color',[254 124 0]/255,'LineWidth',1.8);
            l1 = line([0 dataamp(inddd(ri),i,1)],[36-cnt+1+0.2 36-cnt+1+0.2],'Color',[0 0 0]/255,'LineWidth',1.8);
            hold on,
            %         l2 = line([0 dataamp(ri,i,2)],[26-ri+1 26-ri+1],'Color',[0 180 171]/255,'LineWidth',1.8);
            l2 = line([0 dataamp(inddd(ri),i,2)],[36-cnt+1 36-cnt+1],'Color',[0 171 40]/255,'LineWidth',1.8);
            hold on,
            %         l3 = line([0 dataamp(ri,i,3)],[26-ri+1-0.2 26-ri+1-0.2],'Color',[255 216 50]/255,'LineWidth',1.8);
            l3 = line([0 dataamp(inddd(ri),i,3)],[36-cnt+1-0.2 36-cnt+1-0.2],'Color',[0 240 0]/255,'LineWidth',1.8);
            hold on,
% %             l4 = line([0 dataamp22(inddd(ri),i,1)],[35-cnt+1+0.4 35-cnt+1+0.4],'Color',[151 41 181]/255,'LineWidth',1.8);
            cnt = cnt +1;
        end

    end
    line([1 1],[0 36],'Color','k','LineStyle',':')
    if(i ==1)
%         set(gca,'YTick',[1 : 26],'YTickLabel',fliplr(yvalues));
        set(gca,'YTick',[1 : 36],'YTickLabel',fliplr(yyvalues));
    else
        set(gca,'YTick',[1 : 36],'YTickLabel',{});
    end
%     if(i ==1)
%         set(gca,'YLim',[0 36],'XLim',[0 9]);
%     elseif(i ==2)
%         set(gca,'YLim',[0 36],'XLim',[0 9]);
%     else
%         set(gca,'YLim',[0 36],'XLim',[0 6]);
%     end
    if(i ==1)
        set(gca,'YLim',[0 37],'XLim',[0 14], 'XTick',[0 2 4 6 8 10 12 14]);
    elseif(i ==2)
        set(gca,'YLim',[0 37],'XLim',[0 15],'XTick',[0 1 2 4 6 8 10 12 14]);
    else
        set(gca,'YLim',[0 37],'XLim',[0 5],'XTick',[0 1 2 3 4 5]);
    end
    if(i<2)
        text(-1.5, 37.5,nbb{ci},'FontWeight','bold','FontSize',13)
    else
        text(-1, 37.5,nbb{ci},'FontWeight','bold','FontSize',13)
    end
    if(ci ==1)
        text(14.5,32,'21.5','Color',[0 171 40]/255)
    end
    xlabel(xvalues{i});
    box on
    grid on
    if(ci==3)
        legend([l1 l2 l3],{'All','Forest','Non-forest'})
    end
    set(gca,'FontSize',12)
end

set(gcf,'position',[428   308   812   670])


%% 1. amplification factor - only MODIS fire - FRP per fire
load D:\Study\fires\Extreme_fires_relationship\2021.11.10.active_fire_modis\comp2\amplification_factor_htwv6.mat
% dataall2 = dataall;
% dataamp22 = dataamp;
% dataamp222 = dataamp2;
% load amplification_factor_htwv.mat
% yvalues = {'ALA','CGI','WNA','CNA','ENA','CAM','AMZ','NEB','WSA','SSA','NEU','CEU','MED',...
%     'SAH','NAF','SAF','NAS','WAS','CAS','TIB','EAS','SAS','SEA','NAU','SAU'};
yvalues = {'NWN','NEN','WNA','CNA','ENA','NCA','SCA','CAR','NWS','NSA','NES','SAM','SWS','SES','SSA',... %1-15, need to skip 8 - CAR
    'NEU','WCE','EEU','MED','SAH','WAF','NCAF','NEAF','SEAF','WSAF','ESAF','MDG',... % 16-27, need to skip 27 - MDG
    'RAR','WSB','ESB','RFE','WCA','ECA','TIB','EAS','ARP','SAS','SEA','NAU','CAU','EAU','SAU','NZ','SCAF'}; % 28-44
latt = [83,82.9000000000000,71,70.9000000000000,70.8000000000000,70.3000000000000,68,67.5000000000000,30,25.9000000000000,25.8400000000000,25.8500000000000,20,19.9000000000000,19.8000000000000,82.8000000000000,82.6000000000000,82.5000000000000,70.7000000000000,70.2000000000000,25.8000000000000,25.7000000000000,25.6000000000000,25.5000000000000,18,17.5000000000000,17,82.7000000000000,82.4000000000000,82.3000000000000,82.2000000000000,70.7000000000000,70.6000000000000,70.4000000000000,70.5000000000000,70.1000000000000,70,25.4000000000000,15,14,13,12,11, 25.65];
[yyv inddd] = sort(latt,'descend');
xvalues = {{'Fire count'}, {'FRP'},{'FRP per fire'}};
nbb = {'a','b','c'};
% max1 = max(dataamp(:,1,:))

% 1st filter, heatwave duration less than 3days per year will be neglected
% for ri = 1 : 26
% %     if(ri == 26)
% %         continue;
% %     end
%     for i = 1 : 3
%         if(dataall(1,2,i,ri) < 3) % heatwave days < 3days during the 14 year (3/14=0.2143)
%             dataamp(ri,:,i) = nan;
%         end
%     end
% end
dataamp(8,:,:)= nan;
dataamp(13,:,:)= nan;
dataamp(15,:,:) = nan;
dataamp(16,:,:) = nan;
dataamp(27,:,:) = nan;
dataamp(33,:,:) = nan;
dataamp(36,:,:) = nan;
dataamp(43,:,:) = nan;

% dataamp22(8,:,:)= nan;
% dataamp22(13,:,:)= nan;
% dataamp22(15,:,:) = nan;
% dataamp22(16,:,:) = nan;
% dataamp22(27,:,:) = nan;
% dataamp22(33,:,:) = nan;
% dataamp22(36,:,:) = nan;
% dataamp22(43,:,:) = nan;


% 2nd filter, forest fire number < 1% of the total fire number will
% neglected
for ri = 1 : 44
    for i = 2 : 3
        if(  sum(dataall(2,:,i,ri)) / sum(sum(dataall(2,:,2:3,ri))) < 0.05 || sum(dataall(3,:,i,ri)) / sum(sum(dataall(3,:,2:3,ri))) < 0.05 )
            dataamp(ri,:,i) = nan;
%             dataamp22(ri,:,i) = nan;
        end
    end
end

yyvalues = {};
for ri = 1 : 44    
    if(inddd(ri) ~= 8 && inddd(ri) ~=13 && inddd(ri) ~= 15 && inddd(ri) ~= 16 && inddd(ri) ~= 27 && inddd(ri) ~= 33 && inddd(ri) ~= 36 && inddd(ri) ~= 43)
        yyvalues = {yyvalues{:}, yvalues{inddd(ri)} };        
    end
end
figure,

for ci = 1 : 3
    if(ci ==1)
        i = 1;
    elseif(ci ==2)
        i = 3;
    else
        i = 2;
    end
    subplot(1,3,ci);
    
    cnt = 1;
    for ri = 1 : 44
        if(inddd(ri) ~= 8 && inddd(ri) ~=13 && inddd(ri) ~= 15 && inddd(ri) ~= 16 && inddd(ri) ~= 27 && inddd(ri) ~= 33 && inddd(ri) ~= 36 && inddd(ri) ~= 43)
            %         l1 = line([0 dataamp(ri,i,1)],[26-ri+1+0.2 26-ri+1+0.2],'Color',[254 124 0]/255,'LineWidth',1.8);
            l1 = line([0 dataamp(inddd(ri),i,1)],[36-cnt+1+0.2 36-cnt+1+0.2],'Color',[0 0 0]/255,'LineWidth',1.8);
            hold on,
            %         l2 = line([0 dataamp(ri,i,2)],[26-ri+1 26-ri+1],'Color',[0 180 171]/255,'LineWidth',1.8);
            l2 = line([0 dataamp(inddd(ri),i,2)],[36-cnt+1 36-cnt+1],'Color',[0 171 40]/255,'LineWidth',1.8);
            hold on,
            %         l3 = line([0 dataamp(ri,i,3)],[26-ri+1-0.2 26-ri+1-0.2],'Color',[255 216 50]/255,'LineWidth',1.8);
            l3 = line([0 dataamp(inddd(ri),i,3)],[36-cnt+1-0.2 36-cnt+1-0.2],'Color',[0 240 0]/255,'LineWidth',1.8);
            hold on,
% %             l4 = line([0 dataamp22(inddd(ri),i,1)],[35-cnt+1+0.4 35-cnt+1+0.4],'Color',[151 41 181]/255,'LineWidth',1.8);
            cnt = cnt +1;
        end

    end
    line([1 1],[0 36],'Color','k','LineStyle',':')
    if(i ==1)
%         set(gca,'YTick',[1 : 26],'YTickLabel',fliplr(yvalues));
        set(gca,'YTick',[1 : 36],'YTickLabel',fliplr(yyvalues));
    else
        set(gca,'YTick',[1 : 36],'YTickLabel',{});
    end
%     if(i ==1)
%         set(gca,'YLim',[0 36],'XLim',[0 9]);
%     elseif(i ==2)
%         set(gca,'YLim',[0 36],'XLim',[0 9]);
%     else
%         set(gca,'YLim',[0 36],'XLim',[0 6]);
%     end
    if(i ==1)
        set(gca,'YLim',[0 37],'XLim',[0 14], 'XTick',[0 2 4 6 8 10 12 14]);
    elseif(i ==2)
        set(gca,'YLim',[0 37],'XLim',[0 15],'XTick',[0 1 2 4 6 8 10 12 14]);
    else
        set(gca,'YLim',[0 37],'XLim',[0 5],'XTick',[0 1 2 3 4 5]);
    end
    if(i<2)
        text(-1.5, 37.5,nbb{ci},'FontWeight','bold','FontSize',13)
    else
        text(-1, 37.5,nbb{ci},'FontWeight','bold','FontSize',13)
    end
%     if(ci ==1)
%         text(14.5,32,'41.9','Color',[0 171 40]/255)
%     end
    xlabel(xvalues{i});
    box on
    grid on
    if(ci==3)
        legend([l1 l2 l3],{'All','Forest','Non-forest'})
    end
    set(gca,'FontSize',12)
end

set(gcf,'position',[428   308   812   670])


%% 2. Increment
load amplification_factor_htwv.mat
yvalues = {'ALA','CGI','WNA','CNA','ENA','CAM','AMZ','NEB','WSA','SSA','NEU','CEU','MED',...
    'SAH','WAF','EAF','SAF','NAS','WAS','CAS','TIB','EAS','SAS','SEA','NAU','SAU'};
xvalues = {{'Heatwave amplification','of fire number'}, {'Heatwave amplification','of total fire size'},{'Heatwave amplification','of mean fire size'}};
nbb = {'a','b','c'};
% max1 = max(dataamp(:,1,:))

% 1st filter, heatwave duration less than 3days per year will be neglected
for ri = 1 : 26
   
    for i = 1 : 3
        if(dataall(1,2,i,ri) < 3)
            dataamp2(ri,:,i) = nan;
        end
    end
end

% 2nd filter, forest fire number < 1% of the total fire number will
% neglected
for ri = 1 : 26
    for i = 2 : 3
        if(  sum(dataall(2,:,i,ri)) / sum(sum(dataall(2,:,2:3,ri))) < 0.05 )
            dataamp2(ri,:,i) = nan;
        end
    end
end

figure,

for i = 1 : 3
    subplot(1,3,i);
    
    for ri = 1 : 26
        l1 = line([0 dataamp2(ri,i,1)],[26-ri+1+0.2 26-ri+1+0.2],'Color',[254 124 0]/255,'LineWidth',1.8);
        hold on,
        l2 = line([0 dataamp2(ri,i,2)],[26-ri+1 26-ri+1],'Color',[0 180 171]/255,'LineWidth',1.8);
        hold on,
        l3 = line([0 dataamp2(ri,i,3)],[26-ri+1-0.2 26-ri+1-0.2],'Color',[255 216 50]/255,'LineWidth',1.8);

    end
    line([1 1],[0 27],'Color','k','LineStyle',':')
    if(i ==1)
        set(gca,'YTick',[1 : 26],'YTickLabel',fliplr(yvalues));
    else
        set(gca,'YTick',[1 : 26],'YTickLabel',{});
    end
    if(i < 3)
        set(gca,'YLim',[0 27]);
    else
        set(gca,'YLim',[0 27]);
    end
    text(-1, 27.5,nbb{i},'FontWeight','bold','FontSize',13)
    xlabel(xvalues{i});
    box on
    grid on
    if(i==3)
        legend([l1 l2 l3],{'All','Forest','Non-forest'})
    end
    set(gca,'FontSize',12)
end

set(gcf,'position',[428   308   812   670])

%% 3. bar plot for different regions - amplification
load amplification_factor_htwv.mat
yvalues = {'ALA','CGI','WNA','CNA','ENA','CAM','AMZ','NEB','WSA','SSA','NEU','CEU','MED',...
    'SAH','WAF','EAF','SAF','NAS','WAS','CAS','TIB','EAS','SAS','SEA','NAU','SAU'};
latt = [66.277,67.5,44.283,39.283,37.5,16.833,0.409,-10,-31.98,-45.852,64.83,49.83,...
    37.5,22.5,1.817,1.817,-23.18,60,32.5,40,40,35,21.25,5,-20,-40];
[yyv inddd] = sort(latt,'descend');
xvalues = {{'Heatwave amplification','of fire number'}, {'Heatwave amplification','of total burned area'},{'Heatwave amplification','of mean fire size'}};
nbb = {'a','b','c'};
mkstyle = {'o','+','*','x','s','d','^','v','p','h'};
id1 = [1 2 18];
id2 = [12 3 20 21 4 5 13 22 19 14];
id3 = [23 6 24 15 16 7 8];
id4 = [25 17 26 10];
dataamp(11,:,:)= nan;
dataamp(9,:,:) = nan;

figure,

for i = 1 : 3        
    subplot(3,1,i);
    % i = 1 fire number
    xdata = [1 2 4 5 7 8 10 11];
    xdata2 = [ 1 2 3 4];
    
    ydata = [mean(dataall(i+3,1,1,id1)) mean(dataall(i+3,2,1,id1)) ...
        mean(dataall(i+3,1,1,id2)) mean(dataall(i+3,2,1,id2)) ...
        mean(dataall(i+3,1,1,id3)) mean(dataall(i+3,2,1,id3)) ...
        mean(dataall(i+3,1,1,id4)) mean(dataall(i+3,2,1,id4)) ];
    tmp = reshape(ydata,2,4);
    tmp = tmp(2,:) ./ tmp(1,:);
    ydata2 = tmp;
    
    zdata = [std(dataall(i+3,1,1,id1)) std(dataall(i+3,2,1,id1)) ...
        std(dataall(i+3,1,1,id2)) std(dataall(i+3,2,1,id2)) ...
        std(dataall(i+3,1,1,id3)) std(dataall(i+3,2,1,id3)) ...
        std(dataall(i+3,1,1,id4)) std(dataall(i+3,2,1,id4)) ];
    
    b1 = bar(xdata2,ydata2);
    b1.FaceColor = [0.99 0.7 0.5];
    hold on,
    line([0 5],[1 1],'LineStyle',':','LineWidth',1.5,'Color',[0.86 0.86 0.86])
    
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
        for ki = 1 : length(idd)
            pp1 = plot(k, mean(dataall(i+3,2,1,idd(ki)))/mean(dataall(i+3,1,1,idd(ki))), 'ko');
            pp1.Marker = mkstyle{ki};            
            hold on,
        end
    end
    
    
%     hold on,
%     e1 = errorbar(xdata,ydata, zeros(1,8), zdata);
    set(gca,'XLim',[0 5])
    if(i ==1)
        set(gca,'YLim',[0 6])
    elseif(i ==2)
        set(gca,'YLim',[0 8])
    else
        set(gca,'YLim',[0 3])
    end
       
    if(i ==3)
        set(gca,'XTick',[1 :1: 4],'XTickLabel',{'Boreal','Temperate','Tropical','Austral'});
    else
        set(gca,'XTick',[1 : 1 : 4],'XTickLabel',{});
    end
    set(gca,'FontSize',12)
end

set(gcf,'position',[428   441   478   537])


%% 3.2 bar plot for different regions - absolute values
load amplification_factor_htwv.mat
yvalues = {'ALA','CGI','WNA','CNA','ENA','CAM','AMZ','NEB','WSA','SSA','NEU','CEU','MED',...
    'SAH','WAF','EAF','SAF','NAS','WAS','CAS','TIB','EAS','SAS','SEA','NAU','SAU'};
latt = [66.277,67.5,44.283,39.283,37.5,16.833,0.409,-10,-31.98,-45.852,64.83,49.83,...
    37.5,22.5,1.817,1.817,-23.18,60,32.5,40,40,35,21.25,5,-20,-40];
[yyv inddd] = sort(latt,'descend');
xvalues = {{'Heatwave amplification','of fire number'}, {'Heatwave amplification','of total burned area'},{'Heatwave amplification','of mean fire size'}};
nbb = {'a','b','c'};
mkstyle = {'o','+','*','x','s','d','^','v','p','h'};
id1 = [1 2 18];
id2 = [12 3 20 21 4 5 13 22 19 14];
id3 = [23 6 24 15 16 7 8];
id4 = [25 17 26 10];
dataamp(11,:,:)= nan;
dataamp(9,:,:) = nan;

figure,

for i = 1 : 3        
    subplot(3,1,i);
    % i = 1 fire number
    xdata = [1 2 4 5 7 8 10 11];
    xdata2 = [ 1 2 3 4];
    
    ydata = [mean(dataall(i+3,1,1,id1)) mean(dataall(i+3,2,1,id1)) ...
        mean(dataall(i+3,1,1,id2)) mean(dataall(i+3,2,1,id2)) ...
        mean(dataall(i+3,1,1,id3)) mean(dataall(i+3,2,1,id3)) ...
        mean(dataall(i+3,1,1,id4)) mean(dataall(i+3,2,1,id4)) ];
    tmp = reshape(ydata,2,4);
    tmp = tmp(2,:) ./ tmp(1,:);
    ydata2 = tmp;
    
    zdata = [std(dataall(i+3,1,1,id1)) std(dataall(i+3,2,1,id1)) ...
        std(dataall(i+3,1,1,id2)) std(dataall(i+3,2,1,id2)) ...
        std(dataall(i+3,1,1,id3)) std(dataall(i+3,2,1,id3)) ...
        std(dataall(i+3,1,1,id4)) std(dataall(i+3,2,1,id4)) ];
    
    b1 = bar(xdata,ydata);
    b1.FaceColor = [0.99 0.7 0.5];
%     hold on,
%     line([0 5],[1 1],'LineStyle',':','LineWidth',1.5,'Color',[0.86 0.86 0.86])
%     
%     for k = 1 : 4
%         if(k==1)
%             idd = id1;
%         elseif(k==2)
%             idd = id2;
%         elseif(k==3)
%             idd = id3;
%         else
%             idd = id4;
%         end
%         for ki = 1 : length(idd)
%             pp1 = plot(k, mean(dataall(i+3,2,1,idd(ki)))/mean(dataall(i+3,1,1,idd(ki))), 'ko');
%             pp1.Marker = mkstyle{ki};            
%             hold on,
%         end
%     end
%     
    
    hold on,
    e1 = errorbar(xdata,ydata, zeros(1,8), zdata);
    e1.LineStyle = 'none';
%     set(gca,'XLim',[0 5])
%     if(i ==1)
%         set(gca,'YLim',[0 6])
%     elseif(i ==2)
%         set(gca,'YLim',[0 8])
%     else
%         set(gca,'YLim',[0 3])
%     end

    if(i ==1)
        ylabel('Fire number (n d^{-1})');
    elseif(i ==2)
        ylabel('Burned area (km^2 d^{-1})');
    else
        ylabel('Mean size (km^2 per fire)');
    end
       
    if(i ==3)
        set(gca,'XTick',[1.5 : 3 : 10.5],'XTickLabel',{'Boreal','Temperate','Tropical','Austral'});
    else
        set(gca,'XTick',[1.5 : 3 : 10.5],'XTickLabel',{});
    end
    set(gca,'FontSize',10)
end

set(gcf,'position',[428   441   478   537])


%% 4. amplification factor for different regions
load amplification_factor_htwv.mat
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


%% 5. draw the circle for each region
clear,clc;
load amplification_factor_htwv.mat
dataall(:,:,:,8) = nan;
dataall(:,:,:,13) = nan;
dataall(:,:,:,15) = nan;
dataall(:,:,:,16) = nan;
dataall(:,:,:,27) = nan;
dataall(:,:,:,33) = nan;
dataall(:,:,:,36) = nan;
dataall(:,:,:,43) = nan;

% figure,
% s1 = scatter([1 1 1],[3   2  1],200);
% s1.MarkerFaceColor = [153 217 234]/255;
% hold on,
% s2 = scatter([2 2 2],[ 3 2 1],200);
% s2.MarkerFaceColor = [255 139 148]/255;
% axis off
% set(gca,'XLim',[0 3],'YLim',[0 4])
% set(gcf,'position',[ 680   558   360   220])

% for ri = 1 : 25
%     figure,
%     s1 = scatter(1,1,dataall(4,1,1,ri));
%     s1.MarkerFaceColor = [153 217 234]/255;
%     hold on,
%     s2 = scatter(2,1,dataall(4,2,1,ri));
%     s2.MarkerFaceColor = [255 139 148]/255;
%     axis off
%     set(gca,'XLim',[0 3],'YLim',[0 2])
%     set(gcf,'position',[ 680   558   360   220])    
%     
%     saveas(gcf,['D:\Study\fires\Extreme_fires_relationship\2021.10.16.heatwv_nheatwv_comp2\circle\region_',num2str(ri),'_firenb.jpg'])
% end


for ri = 1 : 43
    figure,
    s1 = scatter(1,1,dataall(5,1,1,ri)/2);
    s1.MarkerFaceColor = [153 217 234]/255;
    hold on,
    s2 = scatter(2,1,dataall(5,2,1,ri)/2);
    s2.MarkerFaceColor = [255 139 148]/255;
    axis off
    set(gca,'XLim',[0 3],'YLim',[0 2])
    set(gcf,'position',[ 680   558   360   220])    
    
    saveas(gcf,['D:\Study\fires\Extreme_fires_relationship\2021.12.09.newregion_recomp\2021.10.16.heatwv_nheatwv_comp2\circle\region_',num2str(ri),'_firesz.jpg'])
end

figure,
s1 = scatter(1,1,100/2);
s1.MarkerFaceColor = [100 100 100]/255;
s1.MarkerEdgeColor = 'none';
hold on,
s2 = scatter(1.5,1,1000/2);
s2.MarkerFaceColor = [100 100 100]/255;
s2.MarkerEdgeColor = 'none';
hold on,
s3 = scatter(3,1,5000/2);
s3.MarkerFaceColor = [100 100 100]/255;
s3.MarkerEdgeColor = 'none';
axis off
set(gca,'XLim',[0 4],'YLim',[0 2])
set(gcf,'position',[ 680   558   360   220])

saveas(gcf,['D:\Study\fires\Extreme_fires_relationship\2021.12.09.newregion_recomp\2021.10.16.heatwv_nheatwv_comp2\circle\sample_100_1000_10000km2d_1_',num2str(ri),'_firesz.jpg'])
