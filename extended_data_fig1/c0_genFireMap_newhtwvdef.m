%% c0, gen fire map
yvalues = {'NWN','NEN','WNA','CNA','ENA','NCA','SCA','CAR','NWS','NSA','NES','SAM','SWS','SES','SSA',... %1-15, need to skip 8 - CAR
    'NEU','WCE','EEU','MED','SAH','WAF','NCAF','NEAF','SEAF','WSAF','ESAF','MDG',... % 16-27, need to skip 27 - MDG
    'RAR','WSB','ESB','RFE','WCA','ECA','TIB','EAS','ARP','SAS','SEAN','NAU','CAU','EAU','SAU','NZ','SCAF','SEAS'}; % 28-45
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

% 3. print the fire number/ burned area in each fire season
datafire = zeros(16,2); % fire number / burned area
fbafr = zeros(600,1440,16);
fbanfr = zeros(600,1440,16);
for ri = 1 : 45
    ri    
    if(ri ==8 || ri ==13 ||ri ==15 ||ri ==16 || ri == 20||ri ==27 ||ri ==33 ||ri ==36 ||ri ==43)
        continue;
    end
    
    for yr = 2003 : 2018
        yr        
        subfireid = [];
        subfiresz = [];
        subfireyr = [];
        subfiremth = [];
        ii = [];
        jj = [];
        load(['D:\Study\fires\Extreme_fires_relationship\2022.05.31.heatwave_newdef\2021.09.24.fire_temp_analysis_newregion3\sf_new_region.',num2str(yr),'.mat'], 'sf_forest', 'sf_nforest');
        load(['D:\Study\fires\Extreme_fires_relationship\2022.05.31.heatwave_newdef\2021.09.24.fire_temp_analysis_newregion3\sf2_new_region.',num2str(yr),'.mat'], 'sf_forest2', 'sf_nforest2');
        load(['D:\Study\fires\Extreme_fires_relationship\2022.05.31.heatwave_newdef\2021.09.24.fire_temp_analysis_newregion3\sf3_new_region.',num2str(yr),'.mat'], 'sf_forest3', 'sf_nforest3');
        subfireid = [subfireid sf_forest(ri).subfireid sf_nforest(ri).subfireid];
        subfiresz = [subfiresz sf_forest(ri).subfiresz sf_nforest(ri).subfiresz];
        subfireyr = [subfireyr sf_forest(ri).subfireyr sf_nforest(ri).subfireyr];
        subfiremth = [subfiremth sf_forest(ri).subfiremth sf_nforest(ri).subfiremth];
        ii = [ii sf_forest3(ri).ii sf_nforest3(ri).ii];
        jj = [jj sf_forest3(ri).jj sf_nforest3(ri).jj];
        
        subfireid = subfireid';
        subfiresz = subfiresz';
        subfireyr = subfireyr';
        subfiremth = subfiremth';
        ii = ii';
        jj  = jj';
        
        if(fseason3(ri,2) == 1)
            ffseason = [11 12 1];
        elseif(fseason3(ri,2) == 2)
            ffseason = [12 1 2];
        else
            ffseason = [fseason3(ri,1):1:fseason3(ri,2)];
        end
        
        for k = 1 : 3
            datafire(yr-2002,1) = datafire(yr-2002,1)+  length(subfiresz(subfiremth == ffseason(k)));
            datafire(yr-2002,2) = datafire(yr-2002,2)+  sum(subfiresz(subfiremth == ffseason(k)));
        end
        
        % forest only -----------------
        subfireid = [];
        subfiresz = [];
        subfireyr = [];
        subfiremth = [];
        ii = [];
        jj = [];
        subfireid = [subfireid sf_forest(ri).subfireid];
        subfiresz = [subfiresz sf_forest(ri).subfiresz];
        subfireyr = [subfireyr sf_forest(ri).subfireyr];
        subfiremth = [subfiremth sf_forest(ri).subfiremth];
        ii = [ii sf_forest3(ri).ii];
        jj = [jj sf_forest3(ri).jj];        
        subfireid = subfireid';
        subfiresz = subfiresz';
        subfireyr = subfireyr';
        subfiremth = subfiremth';
        ii = ii';
        jj  = jj';
        for ti = 1 : length(subfireid)
            if(subfiremth(ti) == ffseason(1) || subfiremth(ti) == ffseason(2) || subfiremth(ti) == ffseason(3))
                fbafr(ii(ti),jj(ti),yr-2002) = fbafr(ii(ti),jj(ti),yr-2002) + subfiresz(ti);
            end
        end
        
         % non-forest only -----------------
        subfireid = [];
        subfiresz = [];
        subfireyr = [];
        subfiremth = [];
        ii = [];
        jj = [];
        subfireid = [subfireid sf_nforest(ri).subfireid];
        subfiresz = [subfiresz sf_nforest(ri).subfiresz];
        subfireyr = [subfireyr sf_nforest(ri).subfireyr];
        subfiremth = [subfiremth sf_nforest(ri).subfiremth];
        ii = [ii sf_nforest3(ri).ii];
        jj = [jj sf_nforest3(ri).jj];        
        subfireid = subfireid';
        subfiresz = subfiresz';
        subfireyr = subfireyr';
        subfiremth = subfiremth';
        ii = ii';
        jj  = jj';
        for ti = 1 : length(subfireid)
            if(subfiremth(ti) == ffseason(1) || subfiremth(ti) == ffseason(2) || subfiremth(ti) == ffseason(3))
                fbanfr(ii(ti),jj(ti),yr-2002) = fbanfr(ii(ti),jj(ti),yr-2002) + subfiresz(ti);
            end
        end
        
    end    
end
datafire = datafire*100/1000000; % km^2 -> Mha
fbaall = nanmean(fbafr+fbanfr,3);
save fbaall_newhtwvdef.mat fbaall

%%
area = nan(720,1440);
for i = 1 : 720
    for j = 1 : 1440
        area(i,j) = (111*111)*cos(  (90-i/4)/180*pi);
    end
end
area = area(1:600,:);
load fbaall_newhtwvdef.mat fbaall

bapct = fbaall./area*100;

%% 90% burned regions 
clear,clc;
load fbaall_newhtwvdef.mat fbaall

load D:\Study\fires\Extreme_fires_relationship\2021.08.16.region_map\1.read_region_map_fromGFED\region_map.mat
regmap2 = region_map(1:600,:);
load D:\Study\fires\Extreme_fires_relationship\2022.02.14.climregion_adjust\world_extreme_region5.mat climregion5
climregion4 = climregion5(1:600,:);

threti = nan(45,1);
for ri = 1 : 45
    ri    
    if(ri ==8 || ri ==13 ||ri ==15 ||ri ==16 || ri == 20 ||ri ==27 ||ri ==33 ||ri ==36 ||ri ==43)
        continue;
    end
    
    tp = fbaall(regmap2 ~= 0 & climregion4 == ri); %% total area burned
    tp = tp(~isnan(tp));
    sumtp = sum(tp);
    slen = size(tp);
    
    [stp indd] = sort(tp,'descend');
    for ti = 1 : slen
        if(sum(stp(1:ti))/sumtp > 0.9)
            threti(ri) = stp(ti);
            break;
        end
    end
end

fbaalln = fbaall;
for i = 1 : 600
    for j = 1 : 1440
        if(regmap2(i,j) ==0 || climregion4(i,j) < 1 || climregion4(i,j) > 45 || isnan(climregion4(i,j)) )
            continue;
        end
        
        if(fbaalln(i,j) < threti( climregion4(i,j)))
            fbaalln(i,j) = 0;
        end
    end
end

save fbaalln_newhtwvdef.mat fbaalln
fbaall(fbaall > 0) = 10000;
fbaalln(fbaalln > 0) = 10000;
figure,imagesc(fbaall)
figure,imagesc(fbaalln)


%% save to nc file
load fbaalln_newhtwvdef.mat fbaalln
data = nan(720,1440);
data(1:600,:) = fbaalln;
lat = ncread('fire_90pct_burnedarea_newhtwvdef.nc','lat');
lon = ncread('fire_90pct_burnedarea_newhtwvdef.nc','lon');
    
ncwrite('fire_90pct_burnedarea_newhtwvdef.nc','fbaalln',data');


load fbaall_newhtwvdef.mat fbaall
data = nan(720,1440);
data(1:600,:) = fbaall;
lat = ncread('fire_100pct_burnedarea_newhtwvdef.nc','lat');
lon = ncread('fire_100pct_burnedarea_newhtwvdef.nc','lon');
    
ncwrite('fire_100pct_burnedarea_newhtwvdef.nc','fbaalln',data');

