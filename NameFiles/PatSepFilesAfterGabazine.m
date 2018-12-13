
% % 10Hz Corr R=0.950
% Files.Stim.File{1} = '/Volumes/cookieMonster/jonesLab_data/PatchPatSep_2s/Gabazine/PatSep2s_100nM/2016-7-12/GC5/PatSep_R0.95_0.9mA_afterGzine_009.axgd';
% 
% Files.Resp.File{1}{1} = '/Volumes/cookieMonster/jonesLab_data/PatchPatSep_2s/Gabazine/PatSep2s_100nM/2016-7-12/GC5/PatSep_R0.95_0.9mA_afterGzine_009.axgd';

% 10Hz Corr R=0.750

Files.Stim.File{1} = '/Users/antoine/Desktop/PatSep8-28-14/Protocols/2sec_trains(pattern_separation)/Set 1/10Hz_R0.750/10Hz_R0.750_CorrelatedPoisson.prt.axgx';

% Files.Resp.File{1}{0} = '/Volumes/cookieMonster/jonesLab_data/PatchPatSep_2s/Gabazine/PatSep2s_100nM/GCpaired/2016-6-17/GC3/PatSep_R0.75_0.7mA_after30sGzine_005.axgd'; % !!only waited ~30s after starting Gabazine!!
Files.Resp.File{1}{1} = '/Volumes/cookieMonster/jonesLab_data/PatchPatSep_2s/Gabazine/PatSep2s_100nM/GCpaired/2016-7-12/GC5/PatSep_R0.75_0.9mA_afterGzine_008.axgd';
Files.Resp.File{1}{2} = '/Volumes/cookieMonster/jonesLab_data/PatchPatSep_2s/Gabazine/PatSep2s_100nM/GCpaired/2016-10-11/GC5/2016.10.11_GC5_M.p24envigo_afterGzin_PatSep0.75_10Hz_0.8mA_CC_009.axgd';
Files.Resp.File{1}{3} = '/Volumes/cookieMonster/jonesLab_data/PatchPatSep_2s/Gabazine/PatSep2s_100nM/GCpaired/2016-11-8/GC1/2016.11.8_GC1_M.p23envigo_afterGzin_PatSepR0.75_10Hz_0.22mA_CC_006.axgd';
Files.Resp.File{1}{4} = '/Volumes/cookieMonster/jonesLab_data/PatchPatSep_2s/Gabazine/PatSep2s_100nM/GCpaired/2017-2-8/GC4/PatSepR0.75_CC_0.8mA_-70mV_afterGzin_011.axgd';
Files.Resp.File{1}{5} = '/Volumes/cookieMonster/jonesLab_data/PatchPatSep_2s/Gabazine/PatSep2s_100nM/GCpaired/2017-2-9/PatSep_CC_-70_afterGzin_003.axgd';
Files.Resp.File{1}{6} = '/Volumes/cookieMonster/jonesLab_data/PatchPatSep_2s/Gabazine/PatSep2s_100nM/GCpaired/2017-7-5/GC3/PatSep0.75_CC_-70_afterGzin_005.axgd';
Files.Resp.File{1}{7} = '/Volumes/cookieMonster/jonesLab_data/PatchPatSep_2s/Gabazine/PatSep2s_100nM/GCpaired/2017-7-5/GC4/PatSep0.75_CC_-70_afterGzin_008.axgd';

Vrest = [-63.5, -75, -74.5, -74.5, -75.5, -79, -79]; meanV = mean(Vrest); semV = std(Vrest)./sqrt(length(Vrest)); %in mV   
Rs = [3, 4.5, 8, 13.5, 7, 10, 5]; meanRs = mean(Rs); semRs = std(Rs)./sqrt(length(Rs)); %in MegaOhm
Cm = [21, 15, 16.4, 12, 16.5, 14, 24]; meanCm = mean(Cm); semCm = std(Cm)./sqrt(length(Cm)); % in pF
Rm = [90, 105, 151, 225, 300, 240, 180]; meanRm = mean(Rm); semRm = std(Rm)./sqrt(length(Rm)); %in MegaOhm