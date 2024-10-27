%% GlobFireAtlas - write new climate region to nc data - all
clear,clc;
load D:\Study\fires\Extreme_fires_relationship\2022.02.14.climregion_adjust\world_extreme_region5.mat climregion5
climregion3 = climregion5;
load D:\Study\fires\Extreme_fires_relationship\MODISv61_newanalysis\2021.10.16.heatwv_nheatwv_comp3\big_fire\amplification_factor_htwv.mat
load D:\Study\fires\Extreme_fires_relationship\2021.08.16.region_map\1.read_region_map_fromGFED\region_map.mat
climap = climregion3;

climregion3(region_map==0) = nan;
climregion3(climap < 1 | climap > 45) = nan;
climregion3(climap ==8 | climap ==13 |climap ==15 | climap == 20 |climap ==16 |climap ==27 |climap ==33 |climap ==36 |climap ==43) = nan;
figure,imagesc(climregion3)

%

firenbamp = climregion3;
for ri = 1 : 45
    firenbamp(climregion3 == ri) = dataamp(ri,1,1);
end
figure,imagesc(firenbamp)

ncwrite('climate_region5_firenbamp.nc','exregion2',rot90(firenbamp,-1));


fireszamp = climregion3;
for ri = 1 : 45
    fireszamp(climregion3 == ri) = dataamp(ri,2,1);
end
figure,imagesc(fireszamp)

ncwrite('climate_region5_fireszamp.nc','exregion2',rot90(fireszamp,-1));


firemzamp = climregion3;
for ri = 1 : 45
    firemzamp(climregion3 == ri) = dataamp(ri,3,1);
end
figure,imagesc(firemzamp)

ncwrite('climate_region5_firemzamp.nc','exregion2',rot90(firemzamp,-1));


% % load D:\Study\fires\Extreme_fires_relationship\2021.11.10.active_fire_modis\comp2\amplification_factor_htwv2.mat
% % firenbampmd = climregion3;
% % for ri = 1 : 43
% %     firenbampmd(climregion3 == ri) = dataamp(ri,1,1);
% % end
% % figure,imagesc(firenbampmd)
% % 
% % ncwrite('climate_region3_firenbamp_mcd.nc','exregion2',rot90(firenbampmd,-1));



%% GlobFireAtlas - write new climate region to nc data - forest
clear,clc;
load D:\Study\fires\Extreme_fires_relationship\2022.02.14.climregion_adjust\world_extreme_region5.mat climregion5
climregion3 = climregion5;
load D:\Study\fires\Extreme_fires_relationship\MODISv61_newanalysis\2021.10.16.heatwv_nheatwv_comp3\big_fire\amplification_factor_htwv.mat
load D:\Study\fires\Extreme_fires_relationship\2021.08.16.region_map\1.read_region_map_fromGFED\region_map.mat
climap = climregion3;

climregion3(region_map==0) = nan;
climregion3(climap < 1 | climap > 45) = nan;
climregion3(climap ==8 | climap ==13 |climap ==15 |climap == 20|climap ==16 |climap ==27 |climap ==33 |climap ==36 |climap ==43) = nan;
figure,imagesc(climregion3)

% for ri = 1 : 45
%     for i = 2 : 3
%         if(  sum(dataall(2,:,i,ri)) / sum(sum(dataall(2,:,2:3,ri))) < 0.05 || sum(dataall(3,:,i,ri)) / sum(sum(dataall(3,:,2:3,ri))) < 0.05 )
%             dataamp(ri,:,i) = nan;
%         end
%     end
% end

firenbamp = climregion3;
for ri = 1 : 45
    firenbamp(climregion3 == ri) = dataamp(ri,1,2);
end
figure,imagesc(firenbamp)

ncwrite('climate_region5_firenbamp_fr.nc','exregion2',rot90(firenbamp,-1));


fireszamp = climregion3;
for ri = 1 : 45
    fireszamp(climregion3 == ri) = dataamp(ri,2,2);
end
figure,imagesc(fireszamp)

ncwrite('climate_region5_fireszamp_fr.nc','exregion2',rot90(fireszamp,-1));


firemzamp = climregion3;
for ri = 1 : 45
    firemzamp(climregion3 == ri) = dataamp(ri,3,2);
end
figure,imagesc(firemzamp)

ncwrite('climate_region5_firemzamp_fr.nc','exregion2',rot90(firemzamp,-1));


% % load D:\Study\fires\Extreme_fires_relationship\2021.11.10.active_fire_modis\comp2\amplification_factor_htwv2.mat
% % firenbampmd = climregion3;
% % for ri = 1 : 43
% %     firenbampmd(climregion3 == ri) = dataamp(ri,1,1);
% % end
% % figure,imagesc(firenbampmd)
% % 
% % ncwrite('climate_region3_firenbamp_mcd.nc','exregion2',rot90(firenbampmd,-1));

%% GlobFireAtlas - write new climate region to nc data - non- forest
clear,clc;
load D:\Study\fires\Extreme_fires_relationship\2022.02.14.climregion_adjust\world_extreme_region5.mat climregion5
climregion3 = climregion5;
load D:\Study\fires\Extreme_fires_relationship\MODISv61_newanalysis\2021.10.16.heatwv_nheatwv_comp3\big_fire\amplification_factor_htwv.mat
load D:\Study\fires\Extreme_fires_relationship\2021.08.16.region_map\1.read_region_map_fromGFED\region_map.mat
climap = climregion3;

climregion3(region_map==0) = nan;
climregion3(climap < 1 | climap > 45) = nan;
climregion3(climap ==8 | climap ==13 |climap ==15 |climap == 20|climap ==16 |climap ==27 |climap ==33 |climap ==36 |climap ==43) = nan;
figure,imagesc(climregion3)

% % for ri = 1 : 45
% %     for i = 2 : 3
% %         if(  sum(dataall(2,:,i,ri)) / sum(sum(dataall(2,:,2:3,ri))) < 0.05 || sum(dataall(3,:,i,ri)) / sum(sum(dataall(3,:,2:3,ri))) < 0.05 )
% %             dataamp(ri,:,i) = nan;
% %         end
% %     end
% % end

firenbamp = climregion3;
for ri = 1 : 45
    firenbamp(climregion3 == ri) = dataamp(ri,1,3);
end
figure,imagesc(firenbamp)

ncwrite('climate_region5_firenbamp_nf.nc','exregion2',rot90(firenbamp,-1));


fireszamp = climregion3;
for ri = 1 : 45
    fireszamp(climregion3 == ri) = dataamp(ri,2,3);
end
figure,imagesc(fireszamp)

ncwrite('climate_region5_fireszamp_nf.nc','exregion2',rot90(fireszamp,-1));


firemzamp = climregion3;
for ri = 1 : 45
    firemzamp(climregion3 == ri) = dataamp(ri,3,3);
end
figure,imagesc(firemzamp)

ncwrite('climate_region5_firemzamp_nf.nc','exregion2',rot90(firemzamp,-1));


% % load D:\Study\fires\Extreme_fires_relationship\2021.11.10.active_fire_modis\comp2\amplification_factor_htwv2.mat
% % firenbampmd = climregion3;
% % for ri = 1 : 43
% %     firenbampmd(climregion3 == ri) = dataamp(ri,1,1);
% % end
% % figure,imagesc(firenbampmd)
% % 
% % ncwrite('climate_region3_firenbamp_mcd.nc','exregion2',rot90(firenbampmd,-1));
