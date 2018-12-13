% DG GCs recordings under 100nM Gabazine same conditions as CA3 (acsf +Gzin right away, wait at least 15min, adjust stim so that don't fire all the time) - 30Hz

% R=0.750
Files.Stim.File{1} = '/Volumes/cookieMonster/jonesLab_data/falconHawk/ephys_data/protocols/PatSep_R0.75_30Hz.prt.axgx';

Files.Resp.File{1}{1} = '/Volumes/cookieMonster/jonesLab_data/PatchPatSep_2s/Gabazine/PatSep2s_100nM/CA3andGC/GCctrl/2017-7-19/GC4/PatSep_R0.75_30Hz 008.axgd'; %Vrest = -76mV; Rm = 325Mohm; Cm = 26pF
Files.Resp.File{1}{2} = '/Volumes/cookieMonster/jonesLab_data/PatchPatSep_2s/Gabazine/PatSep2s_100nM/CA3andGC/GCctrl/2017-8-9/GC1/PatSep_R0.75_30Hz  002.axgd'; %Vrest = -74mV; Rm = 230Mohm; Cm = 19pF
Files.Resp.File{1}{3} = '/Volumes/cookieMonster/jonesLab_data/PatchPatSep_2s/Gabazine/PatSep2s_100nM/CA3andGC/GCctrl/2017-8-9/GC2/PatSep_R0.75_30Hz  006.axgd'; %Vrest = -91mV; Rm = 360MOhm; Cm = 16pF
Files.Resp.File{1}{4} = '/Volumes/cookieMonster/jonesLab_data/PatchPatSep_2s/Gabazine/PatSep2s_100nM/CA3andGC/GCctrl/2017-8-9/GC4/PatSep_R0.75_30Hz  010.axgd'; %Vrest = -81.5mV; Rm = 275MOhm; Cm = 22.5pF
Files.Resp.File{1}{5} = '/Volumes/cookieMonster/jonesLab_data/PatchPatSep_2s/Gabazine/PatSep2s_100nM/CA3andGC/GCctrl/2017-8-15/GC2/PatSep_R0.75_30Hz_incomplete 004.axgd'; %-85mV; Rm = 250MOhm; Cm = 17pF %Warning: stopped at end of 6th repeat, because FR seemed to change, but intrinsic props stable.
Files.Resp.File{1}{6} = '/Volumes/cookieMonster/jonesLab_data/PatchPatSep_2s/Gabazine/PatSep2s_100nM/CA3andGC/GCctrl/2017-8-15/GC2/PatSep_R0.75_30Hz 005.axgd'; %Vrest = -77mV; Rm = 200MOhm; Cm = 10pF %Warning: same cell as the one before. 
Files.Resp.File{1}{7} = '/Volumes/cookieMonster/jonesLab_data/PatchPatSep_2s/Gabazine/PatSep2s_100nM/CA3andGC/GCctrl/2017-8-15/GC3/PatSep_R0.75_30Hz 007.axgd'; %Vrest = -81mV; Rm = 220MOhm; Cm = 19pF %Great cell!
Files.Resp.File{1}{8} = '/Volumes/cookieMonster/jonesLab_data/PatchPatSep_2s/Gabazine/PatSep2s_100nM/CA3andGC/GCctrl/2017-8-16/GC2/PatSep_R0.75_30Hz 005.axgd'; %Vrest = -88.5mV; Rm = 300MOhm; Cm = 22pF
Files.Resp.File{1}{9} = '/Volumes/cookieMonster/jonesLab_data/PatchPatSep_2s/Gabazine/PatSep2s_100nM/CA3andGC/GCctrl/2017-8-18/GC2/PatSep_R0.75_30Hz 004.axgd'; %Vrest = -76.5mV; Rm = 275MOhm; Cm = 22pF
Files.Resp.File{1}{10} = '/Volumes/cookieMonster/jonesLab_data/PatchPatSep_2s/Gabazine/PatSep2s_100nM/CA3andGC/GCctrl/2017-8-18/GC3/PatSep_R0.75_30Hz 008.axgd';%Vrest = -80mV; Rm = 250MOhm; Cm = 23pF
Files.Resp.File{1}{11} = '/Volumes/cookieMonster/jonesLab_data/PatchPatSep_2s/Gabazine/PatSep2s_100nM/CA3andGC/GCctrl/2017-8-18/GC5/PatSep_R0.75_30Hz 016.axgd';%Vrest = -74mV; Rm = 250MOhm; Cm = 18pF; %WARNING: last rec of cell, which died on last sweep + low FR and a few sweeps without spiking... 

Vrest{1}{1} = -76; Rm{1}{1} = 325; Cm{1}{1} = 26; ID{1}{1} = 1;
Vrest{1}{2} = -74; Rm{1}{2} = 230; Cm{1}{2} = 19; ID{1}{2} = 2;
Vrest{1}{3} = -91; Rm{1}{3} = 360; Cm{1}{3} = 16; ID{1}{3} = 3;
Vrest{1}{4} = -81.5; Rm{1}{4} = 275; Cm{1}{4} = 22.5; ID{1}{4} = 4;
Vrest{1}{5} = -85; Rm{1}{5} = 250; Cm{1}{5} = 17; ID{1}{5} = 5; 
Vrest{1}{6} = -77; Rm{1}{6} = 200; Cm{1}{6} = 10; ID{1}{6} = 5;
Vrest{1}{7} = -81; Rm{1}{7} = 220; Cm{1}{7} = 19; ID{1}{7} = 6;
Vrest{1}{8} = -88.5; Rm{1}{8} = 300; Cm{1}{8} = 22; ID{1}{8} = 7;
Vrest{1}{9} = -76.5; Rm{1}{9} = 275; Cm{1}{9} = 22; ID{1}{9} = 8;
Vrest{1}{10} = -80; Rm{1}{10} = 250; Cm{1}{10} = 23; ID{1}{10} = 9;
Vrest{1}{11} = -74; Rm{1}{11} = 250; Cm{1}{11} = 18; ID{1}{11} = 10;

%R = 0.25 with 100ms binsize 
Files.Stim.File{2} = '/Volumes/cookieMonster/jonesLab_data/falconHawk/ephys_data/protocols/PatSep/2sec_trains(pattern_separation)/5Hz & 30Hz/30Hz_R0.250/30Hz_Poisson_R0.25_100msbin.axgx';

Files.Resp.File{2}{1} = '/Volumes/cookieMonster/jonesLab_data/PatchPatSep_2s/Gabazine/PatSep2s_100nM/CA3andGC/GCctrl/2017-8-9/GC2/PatSep_R0.25_100msbin_30Hz 005.axgd'; %Vrest = -92.5mV; Rm = 375Mohm; Cm = 17.5pF
Files.Resp.File{2}{2} = '/Volumes/cookieMonster/jonesLab_data/PatchPatSep_2s/Gabazine/PatSep2s_100nM/CA3andGC/GCctrl/2017-8-9/GC4/PatSep_R0.25_100msbin_30Hz 009.axgd'; % Vrest = -85mV; Rm = 305MOhm; Cm = 25pF
Files.Resp.File{2}{3} = '/Volumes/cookieMonster/jonesLab_data/PatchPatSep_2s/Gabazine/PatSep2s_100nM/CA3andGC/GCctrl/2017-8-15/GC2/PatSep_R0.25_100msbin_30Hz 003.axgd';% Vrest = -87mV; Rm = 250MOhm; Cm = 20pF
Files.Resp.File{2}{4} = '/Volumes/cookieMonster/jonesLab_data/PatchPatSep_2s/Gabazine/PatSep2s_100nM/CA3andGC/GCctrl/2017-8-15/GC3/PatSep_R0.25_100msbin_30Hz 008.axgd';% Vrest = -83mV; Rm = 220MOhm; Cm = 17pF %Great cell!
Files.Resp.File{2}{5} = '/Volumes/cookieMonster/jonesLab_data/PatchPatSep_2s/Gabazine/PatSep2s_100nM/CA3andGC/GCctrl/2017-8-16/GC1/PatSep_R0.25_100msbin_30Hz_incomplete 002.axgd';%-83mV; Rm = 300MOhm; Cm = 18pF % WARNING: incomplete + Cm probably decreased significantly during recording (initial value at 26pF)
Files.Resp.File{2}{6} = '/Volumes/cookieMonster/jonesLab_data/PatchPatSep_2s/Gabazine/PatSep2s_100nM/CA3andGC/GCctrl/2017-8-16/GC2/PatSep_R0.25_100msbin_30Hz 004.axgd';% Vrest = -88mV; Rm = 300MOhm; Cm = 22pF
Files.Resp.File{2}{7} = '/Volumes/cookieMonster/jonesLab_data/PatchPatSep_2s/Gabazine/PatSep2s_100nM/CA3andGC/GCctrl/2017-8-18/GC1/PatSep_R0.25_100msbin_30Hz 002.axgd';% Vrest = -76mV; Rm = 185MOhm; Cm = 26pF
Files.Resp.File{2}{8} = '/Volumes/cookieMonster/jonesLab_data/PatchPatSep_2s/Gabazine/PatSep2s_100nM/CA3andGC/GCctrl/2017-8-18/GC2/PatSep_R0.25_100msbin_30Hz 005.axgd';%Vrest = -76mV; Rm = 260MOhm; Cm = 18.5pF
Files.Resp.File{2}{9} = '/Volumes/cookieMonster/jonesLab_data/PatchPatSep_2s/Gabazine/PatSep2s_100nM/CA3andGC/GCctrl/2017-8-18/GC3/PatSep_R0.25_100msbin_30Hz 007.axgd';%Vrest = -87mV; Rm = 350MOhm; Cm = 23pF
Files.Resp.File{2}{10} = '/Volumes/cookieMonster/jonesLab_data/PatchPatSep_2s/Gabazine/PatSep2s_100nM/CA3andGC/GCctrl/2017-8-18/GC4/PatSep_R0.25_100msbin__30Hz_incomplete  012.axgd';%Vrest = -77mV; Rm = 300MOhm; Cm = 13pF %WARNING incomplete because AP ampli was decreasing. 5 repeats. Intrinsic props were pbly a bit more stable during rec than what the final values would let think
Files.Resp.File{2}{11} = '/Volumes/cookieMonster/jonesLab_data/PatchPatSep_2s/Gabazine/PatSep2s_100nM/CA3andGC/GCctrl/2017-8-18/GC5/PatSep_R0.25_100msbin_30Hz 015.axgd';%Vrest = -74mV; Rm = 275MOhm; Cm = 18pF

Vrest{2}{1} = -95; Rm{2}{1} = 360; Cm{2}{1} = 17; ID{2}{1} = 3;
Vrest{2}{2} = -83; Rm{2}{2} = 290; Cm{2}{2} = 23.5; ID{2}{2} = 4;
Vrest{2}{3} = -87; Rm{2}{3} = 250; Cm{2}{3} = 18; ID{2}{3} = 5;
Vrest{2}{4} = -83.5; Rm{2}{4} = 220; Cm{2}{4} = 17; ID{2}{4} = 6;
Vrest{2}{5} = -83; Rm{2}{5} = 300; Cm{2}{5} = 18; ID{2}{5} = 11;
Vrest{2}{6} = -88; Rm{2}{6} = 300; Cm{2}{6} = 22; ID{2}{6} = 7;
Vrest{2}{7} = -76; Rm{2}{7} = 185; Cm{2}{7} = 26; ID{2}{7} = 12;
Vrest{2}{8} = -76; Rm{2}{8} = 260; Cm{2}{8} = 18; ID{2}{8} = 8;
Vrest{2}{9} = -84; Rm{2}{9} = 300; Cm{2}{9} = 23; ID{2}{9} = 9;
Vrest{2}{10} = -77; Rm{2}{10} = 300; Cm{2}{10} = 13; ID{2}{10} = 13; 
Vrest{2}{11} = -74; Rm{2}{11} = 250; Cm{2}{11} = 17; ID{2}{11} = 10;

% SFrange R=0.75 Poisson FR

Files.StimSF.File{1} = '';

Files.RespSF.File{1}{1} = '/Volumes/cookieMonster/jonesLab_data/PatchPatSep_2s/Gabazine/PatSep2s_100nM/CA3andGC/GCctrl/2017-8-15/GC3/PatSep_SFrange_R0.75_PoissonFR 009.axgd'; %Vrest = -83mV; Rm = 225MOhm; Cm = 17pF %Great cell!
Files.RespSF.File{1}{2} = '/Volumes/cookieMonster/jonesLab_data/PatchPatSep_2s/Gabazine/PatSep2s_100nM/CA3andGC/GCctrl/2017-8-16/GC2/PatSep_SFrange_R0.75_PoissonFR 006.axgd'; %Vrest = -85.5mV; Rm = 290MOhm; Cm = 22pF
Files.RespSF.File{1}{3} = '/Volumes/cookieMonster/jonesLab_data/PatchPatSep_2s/Gabazine/PatSep2s_100nM/CA3andGC/GCctrl/2017-8-18/GC4/PatSep_SFrange_R0.75_PoissonFR 011.axgd'; %Vrest = -78mV; Rm = 320MOhm; Cm = 20pF
Files.RespSF.File{1}{4} = '/Volumes/cookieMonster/jonesLab_data/PatchPatSep_2s/Gabazine/PatSep2s_100nM/CA3andGC/GCctrl/2017-8-18/GC5/PatSep_SFrange_R0.75_poissonFR 014.axgd'; %Vrest = -77mV; Rm = 300MOhm; Cm = 19pF
