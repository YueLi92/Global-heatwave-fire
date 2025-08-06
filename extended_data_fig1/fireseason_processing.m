%% code to process the data showing fireseason map

exreg2 = ncread('climate_region2.nc','exregion2');
figure,imagesc(exreg2)
figure,imagesc(rot90(exreg2))
fsmap = exreg2;

fseason2 = repmat([6 8], 25,1); % fireseason for statistics e.g., from Jun to Aug
fseason2(4,:) = [2 4];
fseason2(5,:) = [2 4];
fseason2(6,:) = [3 5];
fseason2(7,:) = [7 9];
fseason2(8,:) = [8 10];
fseason2(9,:) = [11 1];
fseason2(10,:) = [7 9];
fseason2(11,:) = [3 5];
fseason2(12,:) = [7 9];
fseason2(13,:) = [7 9];
fseason2(14,:) = [6 8];
fseason2(15,:) = [11 1];
fseason2(16,:) = [7 9];
fseason2(17,:) = [4 6];
fseason2(18,:) = [6 8];
fseason2(19,:) = [6 8];
fseason2(20,:) = [9 11];
fseason2(21,:) = [3 5];
fseason2(22,:) = [2 4];
fseason2(23,:) = [1 3];
fseason2(24,:) = [9 11];
fseason2(25,:) = [11 1];

for ri = 1 : 25
    if(ri ==9 || ri == 11 || ri== 14)
        fsmap(exreg2 == ri) = nan;
    else
        fsmap(exreg2 == ri) = fseason2(ri,1);
    end
end

figure,imagesc(rot90(fsmap))

ncwrite('climate_region2_fireseason.nc','exregion2',fsmap);

%% create region3

load D:\Study\fires\Extreme_fires_relationship\2021.12.08.new_climregion_ar6\world_extreme_region3.mat climregion3
figure,imagesc(rot90(climregion3,-1))
fsmap = climregion3;
fsmap(climregion3 < 1 | climregion3 > 43) = nan;
fsmap(climregion3 ==8 | climregion3 ==27) = nan;
figure,imagesc(fsmap)

ncwrite('climate_region3.nc','exregion2',rot90(fsmap,-1))

fseason2 = repmat([6 8], 43,1); % fireseason for statistics e.g., from Jun to Aug
fseason2(4,:) = [2 4]; 
fseason2(5,:) = [1 3];
fseason2(6,:) = [4 6];
fseason2(7,:) = [3 5];
fseason2(8,:) = [1 12]; %% should kick this out
fseason2(9,:) = [1 3];
fseason2(10,:) = [1 3];
fseason2(11,:) = [8 10];
fseason2(12,:) = [7 9]; 
fseason2(13,:) = [1 3];
fseason2(14,:) = [7 9];
fseason2(15,:) = [12 2];
fseason2(16,:) = [3 5];
fseason2(17,:) = [7 9];
fseason2(18,:) = [6 8];
fseason2(19,:) = [7 9];
fseason2(20,:) = [10 12];
fseason2(21,:) = [11 1];
fseason2(22,:) = [11 1];
fseason2(23,:) = [11 1];
fseason2(24,:) = [6 8];
fseason2(25,:) = [7 9];
fseason2(26,:) = [7 9];
fseason2(27,:) = [1 12]; %% shoudl kick this out
fseason2(28,:) = [6 8];
fseason2(29,:) = [6 8];
fseason2(30,:) = [3 5];
fseason2(31,:) = [5 7];
fseason2(32,:) = [6 8];
fseason2(33,:) = [8 10];
fseason2(34,:) = [9 11];
fseason2(35,:) = [4 6];
fseason2(36,:) = [6 8];
fseason2(37,:) = [2 4];
fseason2(38,:) = [1 3];
fseason2(39,:) = [9 11];
fseason2(40,:) = [9 11];
fseason2(41,:) = [9 11];
fseason2(42,:) = [11 1];
fseason2(43,:) = [1 3];

for ri = 1 : 43
    if(ri ==8 || ri ==27 || ri == 13 || ri == 15 || ri ==16 || ri == 33 || ri ==36 || ri==43)
        fsmap(climregion3 ==ri) = nan;
    else
        fsmap(climregion3==ri) = fseason2(ri,1);
    end
end

figure,imagesc(fsmap)
ncwrite('climate_region3_fireseason.nc','exregion2',rot90(fsmap,-1));


%% create region4

load D:\Study\fires\Extreme_fires_relationship\2022.02.14.climregion_adjust\world_extreme_region4.mat climregion4
load D:\Study\fires\Extreme_fires_relationship\2021.08.16.region_map\1.read_region_map_fromGFED\region_map.mat
figure,imagesc(rot90(climregion4,-1))
fsmap = climregion4;
fsmap(region_map==0) = nan;
fsmap(climregion4 < 1 | climregion4 > 44) = nan;
fsmap(climregion4 ==8 | climregion4 ==13 |climregion4 ==15 |climregion4 ==16 |climregion4 ==27 |climregion4 ==33 |climregion4 ==36 |climregion4 ==43) = nan;
figure,imagesc(fsmap)
%
ncwrite('climate_region4.nc','exregion2',rot90(fsmap,-1))

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
fseason2 = fseason3;

for ri = 1 : 44
    if(ri ==8 || ri ==27 || ri == 13 || ri == 15 || ri ==16 || ri == 33 || ri ==36 || ri==43)
        fsmap(climregion4 ==ri) = nan;
    else
        if(fseason2(ri,1) < 12)
            fsmap(climregion4==ri & region_map ~=0) = fseason2(ri,1)+1;
        else
            fsmap(climregion4==ri  & region_map ~=0) = 1;
        end
    end
end

figure,imagesc(fsmap)
ncwrite('climate_region4_fireseason.nc','exregion2',rot90(fsmap,-1));


%% create region5

load D:\Study\fires\Extreme_fires_relationship\2022.02.14.climregion_adjust\world_extreme_region5.mat climregion5
load D:\Study\fires\Extreme_fires_relationship\2021.08.16.region_map\1.read_region_map_fromGFED\region_map.mat
climregion4 = climregion5;
figure,imagesc(rot90(climregion4,-1))
fsmap = climregion4;
fsmap(region_map==0) = nan;
fsmap(climregion4 < 1 | climregion4 > 45) = nan;
fsmap(climregion4 ==8 | climregion4 ==13 |climregion4 ==15 |climregion4 ==16 | climregion4 == 20|climregion4 ==27 |climregion4 ==33 |climregion4 ==36 |climregion4 ==43) = nan;
figure,imagesc(fsmap)
%
ncwrite('climate_region5.nc','exregion2',rot90(fsmap,-1))
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

for ri = 1 : 45
    if(ri ==8 || ri ==27 || ri == 13 || ri == 15 || ri ==16 || ri == 20 || ri == 33 || ri ==36 || ri==43)
        fsmap(climregion4 ==ri) = nan;
    else
        if(fseason2(ri,1) < 12)
            fsmap(climregion4==ri & region_map ~=0) = fseason2(ri,1)+1;
        else
            fsmap(climregion4==ri  & region_map ~=0) = 1;
        end
    end
end

figure,imagesc(fsmap)
ncwrite('climate_region5_fireseason.nc','exregion2',rot90(fsmap,-1));