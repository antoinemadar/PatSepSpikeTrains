% PatSepFilesFalconHawkSFrange: Saline injected

% PoissonFR_R0.75
Files.Stim.File{1} = '/Volumes/mj1lab/falconHawk/ephys_data/protocols/PatSep/10-2s_R0.75_0.6to0.85_SFrange_PoissonFR.axgx' %'/Volumes/cookieMonster/jonesLab_data/falconHawk/ephys_data/protocols/PatSep/10-2s_R0.75_0.6to0.85_SFrange_PoissonFR.axgx';

Files.Resp.File{1}{1} = '/Volumes/cookieMonster/jonesLab_data/falconHawk/ephys_data/1-6f/Sa/2017-9-6/GC2/PatSep_SFrange_R0.75_PoissonFR_0.05mA 004.axgd';
Files.Resp.File{1}{2} = '/Volumes/cookieMonster/jonesLab_data/falconHawk/ephys_data/1-6f/Sa/2017-9-6/GC3/PatSep_SFrange_R0.75_PoissonFR_0.12mA 010.axgd';
Files.Resp.File{1}{3} = '/Volumes/cookieMonster/jonesLab_data/falconHawk/ephys_data/1-6f/Sa/2017-9-14/GC1/PatSep_SFrange_R0.75_PoissonFR_0.12mA 002.axgd';
Files.Resp.File{1}{4} = '/Volumes/cookieMonster/jonesLab_data/falconHawk/ephys_data/1-6f/Sa/2017-9-14/GC3/PatSep_SFrange_R0.75_PoissonFR_0.18mA 007.axgd';
Files.Resp.File{1}{5} = '/Volumes/cookieMonster/jonesLab_data/falconHawk/ephys_data/1-6f/Sa/2017-9-14/GC4/PatSep_SFrange_R0.75_PoissonFR_0.25mA 012.axgd';

Vrest = [-76, -81.5, -83, -72.5, -89]; meanV = mean(Vrest); semV = std(Vrest)./sqrt(length(Vrest)); %in mV   
Rs = [4.7, 5.5, 7, 5.5, 4.7]; meanRs = mean(Rs); semRs = std(Rs)./sqrt(length(Rs)); %in MegaOhm
Cm = [24, 19.5, 16.5, 27.5, 29]; meanCm = mean(Cm); semCm = std(Cm)./sqrt(length(Cm)); % in pF
Rm = [165, 77.5, 178, 177.5, 175]; meanRm = mean(Rm); semRm = std(Rm)./sqrt(length(Rm)); %in MegaOhm
I = [0.05, 0.12, 0.12, 0.18, 0.25]; meanI = mean(I); semI = std(I)./sqrt(length(I)); % Istim in mA


% Burstiness_10HzOverall

Files.StimBurst.File{1} = '/Volumes/mj1lab/falconHawk/ephys_data/protocols/PatSep/10_2s_10Hz_SFrange_Burstiness.axgx' %'/Volumes/cookieMonster/jonesLab_data/falconHawk/ephys_data/protocols/PatSep/10_2s_10Hz_SFrange_Burstiness.axgx';

Files.RespBurst.File{1}{1} = '/Volumes/cookieMonster/jonesLab_data/falconHawk/ephys_data/1-6f/Sa/2017-9-6/GC2/SFrange_Burstiness_0.09mA 007.axgd';
Files.RespBurst.File{1}{2} = '/Volumes/cookieMonster/jonesLab_data/falconHawk/ephys_data/1-6f/Sa/2017-9-14/GC3/SFrange_Burstiness_0.18mA008.axgd';
Files.RespBurst.File{1}{3} = '/Volumes/cookieMonster/jonesLab_data/falconHawk/ephys_data/1-6f/Sa/2017-9-14/GC4/SFrange_Burstiness_0.25mA 014.';

Vrest2 = [-73, -72, -89]; meanV2 = mean(Vrest2); semV2 = std(Vrest2)./sqrt(length(Vrest2));
Rs2 = [5.5, 5.5, 4.6]; meanRs2 = mean(Rs2); semRs2 = std(Rs2)./sqrt(length(Rs2));
Cm2 = [18, 26, 27]; meanCm2 = mean(Cm2); semCm2 = std(Cm2)./sqrt(length(Cm2));
Rm2 = [150, 190, 195]; meanRm2 = mean(Rm2); semRm2 = std(Rm2)./sqrt(length(Rm2)); 
I2 = [0.09, 0.18, 0.25]; meanI2 = mean(I2); semI2 = std(I2)./sqrt(length(I2)); 

%treatment age
NumDays = daysact('14-apr-2017',  '30-may-2017') %p46
