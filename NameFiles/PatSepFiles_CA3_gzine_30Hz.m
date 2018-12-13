% CA3 pyramidal cells recordings under 100nM Gabazine - 30Hz

% R=0.750
Files.Stim.File{1} = '/Volumes/cookieMonster/jonesLab_data/falconHawk/ephys_data/protocols/PatSep_R0.75_30Hz.prt.axgx';

Files.Resp.File{1}{1} = '/Volumes/cookieMonster/jonesLab_data/PatchPatSep_2s/Gabazine/PatSep2s_100nM/CA3andGC/2017-7-12/pyr1/PatSep_R0.75_30Hz 002.axgd'; % Vrest = -71mV; Rm = 200MOhm; Cm = 31pF
Files.Resp.File{1}{2} = '/Volumes/cookieMonster/jonesLab_data/PatchPatSep_2s/Gabazine/PatSep2s_100nM/CA3andGC/2017-7-12/pyr2/PatSep_R0.75_30Hz 005.axgd'; % Vrest = -75mV; Rm = 200MOhm; Cm = 40pF
Files.Resp.File{1}{3} = '/Volumes/cookieMonster/jonesLab_data/PatchPatSep_2s/Gabazine/PatSep2s_100nM/CA3andGC/2017-7-12/pyr4/PatSep_R0.75_30Hz 013.axgd'; % Vrest = -68mV; Rm = 290MOhm; Cm = 25pF
Files.Resp.File{1}{4} = '/Volumes/cookieMonster/jonesLab_data/PatchPatSep_2s/Gabazine/PatSep2s_100nM/CA3andGC/2017-7-14/pyr2/PatSep_R0.75_30Hz 002.axgd'; % Vrest = -78mV; Rm = 160MOhm; Cm = 37pF
Files.Resp.File{1}{5} = '/Volumes/cookieMonster/jonesLab_data/PatchPatSep_2s/Gabazine/PatSep2s_100nM/CA3andGC/2017-7-14/pyr3/PatSep_R0.75_30Hz 007.axgd'; % Vrest = -80mV; Rm = 200MOhm; Cm = 34pF 
Files.Resp.File{1}{6} = '/Volumes/cookieMonster/jonesLab_data/PatchPatSep_2s/Gabazine/PatSep2s_100nM/CA3andGC/2017-7-18/pyr1/PatSep_R0.75_30Hz 002.axgd'; % Vrest = -74mV; Rm = 185MOhm; Cm = 32pF
% Files.Resp.File{1}{7} = '/Volumes/cookieMonster/jonesLab_data/PatchPatSep_2s/Gabazine/PatSep2s_100nM/CA3andGC/2017-7-19/CA3pyr1/PatSep_R0.75_30Hz 004.axgd';% Vrest = -66mV; Rm = 100MOhm; Cm = 23pF (these are estimations based on averages of patch start and testcell at end of recording) WARNING: Rs has changed more than usual on this recording and was 14MOhm at the end. 
% Files.Resp.File {1}{?} = '/Volumes/cookieMonster/jonesLab_data/PatchPatSep_2s/Gabazine/PatSep2s_100nM/CA3andGC/2017-7-18/pyr3/PatSep_R0.75_30Hz_incomplete 009.axgd'; % measure just the first 5 sweeps (i.e. sweep #1 for all input trains) Vrest = -80mV; Rm = 160MOhm; Cm = 42pF

Vrest{1}{1} = -71; Rm{1}{1} = 200; Cm{1}{1} = 31; ID{1}{1} = 1;
Vrest{1}{2} = -75; Rm{1}{2} = 200; Cm{1}{2} = 40; ID{1}{2} = 2;
Vrest{1}{3} = -68; Rm{1}{3} = 290; Cm{1}{3} = 25; ID{1}{3} = 3;
Vrest{1}{4} = -78; Rm{1}{4} = 160; Cm{1}{4} = 37; ID{1}{4} = 4;
Vrest{1}{5} = -80; Rm{1}{5} = 200; Cm{1}{5} = 34; ID{1}{5} = 5;
Vrest{1}{6} = -74; Rm{1}{6} = 185; Cm{1}{6} = 32; ID{1}{6} = 6;

% R = 0.25 under 100ms binsize

Files.Stim.File{2} = '/Volumes/cookieMonster/jonesLab_data/falconHawk/ephys_data/protocols/PatSep/2sec_trains(pattern_separation)/5Hz & 30Hz/30Hz_R0.250/30Hz_Poisson_R0.25_100msbin.axgx';

Files.Resp.File{2}{1} = '/Volumes/cookieMonster/jonesLab_data/PatchPatSep_2s/Gabazine/PatSep2s_100nM/CA3andGC/2017-7-27/pyr3/PatSep_R0.25_100msbin_30Hz 005.axgd'; % Vrest = -64mV; Rm = 235MOhm; Cm = 40pF % low firing. Several sweeps without spikes at the end.
Files.Resp.File{2}{2} = '/Volumes/cookieMonster/jonesLab_data/PatchPatSep_2s/Gabazine/PatSep2s_100nM/CA3andGC/2017-7-27/pyr3/PatSep_R0.25_100msbin_30Hz_5repeats 003.axgd'; %same cell as above. first half great, second half with lower FR
Files.Resp.File{2}{3} = '/Volumes/cookieMonster/jonesLab_data/PatchPatSep_2s/Gabazine/PatSep2s_100nM/CA3andGC/2017-8-1/pyr2/PatSep_R0.25_100msbin_30Hz 003.axgd';  % Vrest = -72mV; Rm = 200MOhm; Cm = 34pF % low firing. Several sweeps without spikes
Files.Resp.File{2}{4} = '/Volumes/cookieMonster/jonesLab_data/PatchPatSep_2s/Gabazine/PatSep2s_100nM/CA3andGC/2017-8-1/pyr2/PatSep_R0.25_100msbin_30Hz 004.axgd';  % see above. Slightly higher firing and more stable
Files.Resp.File{2}{5} = '/Volumes/cookieMonster/jonesLab_data/PatchPatSep_2s/Gabazine/PatSep2s_100nM/CA3andGC/2017-8-1/pyr5/PatSep_R0.25_100msbin_30Hz 006.axgd';  % Vrest = -75mV; Rm = 125MOhm; Cm = 45pF; % Rs rised a bit
Files.Resp.File{2}{6} = '/Volumes/cookieMonster/jonesLab_data/PatchPatSep_2s/Gabazine/PatSep2s_100nM/CA3andGC/2017-8-1/pyr6/PatSep_R0.25_100msbin_30Hz 008.axgd';  % Vrest = -58mV; Rm = 150MOhm; Cm = 19pF; % Vrest decreased a lot from -70 to -47mV but Rs and Rm didn't change much
Files.Resp.File{2}{7} = '/Volumes/cookieMonster/jonesLab_data/PatchPatSep_2s/Gabazine/PatSep2s_100nM/CA3andGC/2017-8-3/pyr4/PatSep_R0.25_100msbin_30Hz 004.axgd'; % Vrest = -72.5mV; Rm = 130MOhm; Cm = 42pF; % hold around -55mV instead of between -60 ans -70, to get spiking. Several traces without spikes. 
Files.Resp.File{2}{8} = '/Volumes/cookieMonster/jonesLab_data/PatchPatSep_2s/Gabazine/PatSep2s_100nM/CA3andGC/2017-8-8/pyr2/PatSep_R0.25_100msbin_30Hz 004.axgd';  % Vrest = -90mV; Rm = 200MOhm; Cm = 44pF; 
Files.Resp.File{2}{9} = '/Volumes/cookieMonster/jonesLab_data/PatchPatSep_2s/Gabazine/PatSep2s_100nM/CA3andGC/2017-8-8/pyr3/PatSep_R0.25_100msbin_30Hz 006.axgd';  % Vrest = -68mV; Rm = 147MOhm; Cm = 42pF;

Vrest{2}{1} = -64; Rm{2}{1} = 235; Cm{2}{1} = 40; ID{2}{1} = 7;
Vrest{2}{2} = -64; Rm{2}{2} = 235; Cm{2}{2} = 40; ID{2}{2} = 7;
Vrest{2}{3} = -72; Rm{2}{3} = 200; Cm{2}{3} = 34; ID{2}{3} = 8;
Vrest{2}{4} = -72; Rm{2}{4} = 200; Cm{2}{4} = 34; ID{2}{4} = 8;
Vrest{2}{5} = -75; Rm{2}{5} = 125; Cm{2}{5} = 45; ID{2}{5} = 9;
Vrest{2}{6} = -58; Rm{2}{6} = 150; Cm{2}{6} = 19; ID{2}{6} = 10;
Vrest{2}{7} = -72.5; Rm{2}{7} = 130; Cm{2}{7} = 42; ID{2}{7} = 11;
Vrest{2}{8} = -90; Rm{2}{8} = 200; Cm{2}{8} = 44; ID{2}{8} = 12;
Vrest{2}{9} = -68; Rm{2}{9} = 147; Cm{2}{9} = 42; ID{2}{9} = 13;
% 
% for n = 1:length(Files.Stim.File)
%     V{n} = cat(1,Vrest{n}{:});
%     R{n} = cat(1, Rm{n}{:});
%     C{n} = cat(1, Cm{n}{:});
%     I{n} = cat(1, ID{n}{:});
% end
% Vmean = mean(cat(1,V{:}))
% Rmean = mean(cat(1,R{:}))
% Cmean = mean(cat(1,C{:}))
% 
% Vsem = std(cat(1,V{:}))./sqrt(length(cat(1,V{:})))
% Rsem = std(cat(1,R{:}))./sqrt(length(cat(1,R{:})))
% Csem = std(cat(1,C{:}))./sqrt(length(cat(1,C{:})))