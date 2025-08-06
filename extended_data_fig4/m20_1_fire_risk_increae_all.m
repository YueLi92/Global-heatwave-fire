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

