%% code to process the data showing fireseason map
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
