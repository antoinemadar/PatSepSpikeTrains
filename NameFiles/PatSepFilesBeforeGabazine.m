
% 10Hz Corr R=0.750

Files.Stim.File{1} = '/Users/antoine/Desktop/PatSep8-28-14/Protocols/2sec_trains(pattern_separation)/Set 1/10Hz_R0.750/10Hz_R0.750_CorrelatedPoisson.prt.axgx';

% Files.Resp.File{1}{1} =
% '/Volumes/cookieMonster/jonesLab_data/PatchPatSep_2s/Gabazine/PatSep2s_100nM/2016-6-17/GC3/PatSep_R0.75_0.7mA_beforeGzine_004.axgd';%
% only waited 30s before lauching the after gabazine protocol
Files.Resp.File{1}{1} = '/Volumes/cookieMonster/jonesLab_data/PatchPatSep_2s/Gabazine/PatSep2s_100nM/GCpaired/2016-7-12/GC5/PatSep_R0.75_0.9mA_beforeGzine_007.axgd';
Files.Resp.File{1}{2} = '/Volumes/cookieMonster/jonesLab_data/PatchPatSep_2s/Gabazine/PatSep2s_100nM/GCpaired/2016-10-11/GC5/2016.10.11_GC5_M.p24envigo_beforeGzin_PatSepr0.75_10Hz_0.8mA_CC_008.axgd';
Files.Resp.File{1}{3} = '/Volumes/cookieMonster/jonesLab_data/PatchPatSep_2s/Gabazine/PatSep2s_100nM/GCpaired/2016-11-8/GC1/2016.11.8_GC1_M.p23envigo_beforeGzin_PatSepR0.75_10Hz_0.22mA_CC_004.axgd';
Files.Resp.File{1}{4} = '/Volumes/cookieMonster/jonesLab_data/PatchPatSep_2s/Gabazine/PatSep2s_100nM/GCpaired/2017-2-8/GC4/PatSepR0.75_CC_0.8mA_-70mV_beforeGzin_010.axgd';
Files.Resp.File{1}{5} = '/Volumes/cookieMonster/jonesLab_data/PatchPatSep_2s/Gabazine/PatSep2s_100nM/GCpaired/2017-2-9/PatSep_CC_-70_beforeGbzin_002.axgd';
Files.Resp.File{1}{6} = '/Volumes/cookieMonster/jonesLab_data/PatchPatSep_2s/Gabazine/PatSep2s_100nM/GCpaired/2017-7-5/GC3/PatSep0.75_CC_-70_beforeGzin_004.axgd';
Files.Resp.File{1}{7} = '/Volumes/cookieMonster/jonesLab_data/PatchPatSep_2s/Gabazine/PatSep2s_100nM/GCpaired/2017-7-5/GC4/PatSep0.75_CC_-70_beforeGzin_007.axgd';

Vrest = [-63.5, -80, -72.5, -80, -76, -82.5, -81.5]; meanV = mean(Vrest); semV = std(Vrest)./sqrt(length(Vrest)); %in mV   
Rs = [3, 3.5, 7, 8, 6.3, 9, 5]; meanRs = mean(Rs); semRs = std(Rs)./sqrt(length(Rs)); %in MegaOhm
Cm = [21, 20.5, 16.5, 16.5, 20, 17.5, 27]; meanCm = mean(Cm); semCm = std(Cm)./sqrt(length(Cm)); % in pF
Rm = [90, 115, 150, 300, 265, 255, 187]; meanRm = mean(Rm); semRm = std(Rm)./sqrt(length(Rm)); %in MegaOhm
I = [0.9, 0.8, 0.22, 0.8, 0.8, 0.8, 0.6]; meanI = mean(I); semI = std(I)./sqrt(length(I)); % Istim in mA
age = [32, 24, 23, 22, 23, 24]; meanA = mean(age); semA = std(age)./sqrt(length(age));% in days (1 value per animal)
Wait = [6, 5, 8, 5.5, 5, 6, 8]; meanW = mean(Wait); semW = std(Wait)./sqrt(length(Wait)); %time after solution switch before patsep protocol, in min

% intrinsic props after Gzn
Vrest2 = [-63.5, -75, -74.5, -74.5, -75.5, -79, -79]; meanV2 = mean(Vrest2); semV2 = std(Vrest2)./sqrt(length(Vrest2)); %in mV   
Rs2 = [3, 4.5, 8, 13.5, 7, 10, 5]; meanRs2 = mean(Rs2); semRs2 = std(Rs2)./sqrt(length(Rs2)); %in MegaOhm
Cm2 = [21, 15, 16.4, 12, 16.5, 14, 24]; meanCm2 = mean(Cm2); semCm2 = std(Cm2)./sqrt(length(Cm2)); % in pF
Rm2 = [90, 105, 151, 225, 300, 240, 180]; meanRm2 = mean(Rm2); semRm2 = std(Rm2)./sqrt(length(Rm2)); %in MegaOhm

% paired nonparamtetric Wilcoxon sign rank test
[p,h,stats] = signrank(Vrest-Vrest2)
[p1,h1,stats1] = signrank(Cm-Cm2)
[p2,h2,stats2] = signrank(Rm-Rm2)
[p3,h3,stats3] = signrank(Rs-Rs2)

% display
T = [1 2];
figure
subplot(1,4,1)
for n = 1:length(Rs)
plot(T, [Rs(n) Rs2(n)], 'k-'); hold on
end
title('Rs')
subplot(1,4,2)
for n = 1:length(Rs)
plot(T, [Vrest(n) Vrest2(n)], 'k-'); hold on
end
title('Vrest');
subplot(1,4,3)
for n = 1:length(Rs)
plot(T, [Rm(n) Rm2(n)], 'k-');hold on
end
title('Rm');
subplot(1,4,4)
for n = 1:length(Rs)
plot(T, [Cm(n) Cm2(n)], 'k-'); hold on
end
title('Cm');