% Hilar putative Mossy Cells (n = 11 cells)

% 10Hz Corr R=0.750

Files.Stim.File{1} = '/Users/antoine/Desktop/PatSep8-28-14/Protocols/2sec_trains(pattern_separation)/Set 1/10Hz_R0.750/10Hz_R0.750_CorrelatedPoisson.prt.axgx';

Files.Resp.File{1}{1} = '/Volumes/cookieMonster/jonesLab_data/PatchPatSep_2s/Hilus/2017-8-24/HC3/PatSepR0.75_10Hz 007.axgd'; % Vrest = -51mV; Rm = 120MOhm; Cm = 30pF. % CCIV: regular firing. No AHP
Files.Resp.File{1}{2} = '/Volumes/cookieMonster/jonesLab_data/PatchPatSep_2s/Hilus/2017-8-30/HC1/PatSepR0.75_10Hz_incomplete6repeats 002.axgd'; % Vrest = -70mV; Rm = 150MOhm; Cm = 39pF  % CCIV: unclear (some bursts? or just epsps during step?). Likely an MC because no AHP.
Files.Resp.File{1}{3} = '/Volumes/cookieMonster/jonesLab_data/PatchPatSep_2s/Hilus/2017-8-30/HC2/PatSepR0.75_10Hz 004.axgd'; % Vrest = -63mV; Rm = 200MOhm; Cm = 35pF. % CCIV: regular firing and no AHP (but the recording isn't clean, cell is too active) 
Files.Resp.File{1}{4} = '/Volumes/cookieMonster/jonesLab_data/PatchPatSep_2s/Hilus/2017-8-30/HC3/PatSepR0.75_10Hz 008.axgd'; % Vrest = -80mV; Rm = 220MOhm; Cm = 50pF. % CCIV: regular firing and no AHP.
Files.Resp.File{1}{5} = '/Volumes/cookieMonster/jonesLab_data/PatchPatSep_2s/Hilus/2017-8-30/HC4/PatSepR0.75_10Hz_incomplete8repeats 012.axgd'; % Vrest = -60mV; Rm = 190MOhm; Cm = 55pF. % CCIV: regular firing and no AHP.  
Files.Resp.File{1}{6} = '/Volumes/cookieMonster/jonesLab_data/PatchPatSep_2s/Hilus/2017-8-31/HC5/PatSepR0.75_10Hz 007.axgd'; % Vrest = -61mV; Rm = 155MOhm; Cm = 14pF. % CCIV: regular firing and no AHP. Lots of accomodation at high steps (a few funky "bursts")
Files.Resp.File{1}{7} = '/Volumes/cookieMonster/jonesLab_data/PatchPatSep_2s/Hilus/2017-8-31/HC6/PatSepR0.75_10Hz 013.axgd'; % Vrest = -84mV; Rm = 120MOhm; Cm = 25pF. % CCIV: regular firing and no AHP

Vrest{1}{1} = -51; Rm{1}{1} = 120; Cm{1}{1} = 30; ID{1}{1} = 1;
Vrest{1}{2} = -70; Rm{1}{2} = 150; Cm{1}{2} = 39; ID{1}{2} = 2;
Vrest{1}{3} = -63; Rm{1}{3} = 200; Cm{1}{3} = 35; ID{1}{3} = 3;
Vrest{1}{4} = -80; Rm{1}{4} = 220; Cm{1}{4} = 50; ID{1}{4} = 4;
Vrest{1}{5} = -60; Rm{1}{5} = 190; Cm{1}{5} = 55; ID{1}{5} = 5; 
Vrest{1}{6} = -61; Rm{1}{6} = 155; Cm{1}{6} = 14; ID{1}{6} = 6;
Vrest{1}{7} = -84; Rm{1}{7} = 120; Cm{1}{7} = 25; ID{1}{7} = 7;

% 10Hz Corr R=0.5
Files.Stim.File{2} = '/Users/antoine/Desktop/PatSep8-28-14/Protocols/2sec_trains(pattern_separation)/Set 1/10Hz_R0.500/10Hz_R0.500_CorrelatedPoisson.prt.axgx';

Files.Resp.File{2}{1} = '/Volumes/cookieMonster/jonesLab_data/PatchPatSep_2s/Hilus/2017-8-30/HC3/PatSepR0.50_10Hz 010.axgd'; % Vrest = -90mV; Rm = 190MOhm; Cm = 47pF. % CCIV: regular firing and no AHP
Files.Resp.File{2}{2} = '/Volumes/cookieMonster/jonesLab_data/PatchPatSep_2s/Hilus/2017-8-31/HC5/PatSepR0.50_10Hz 008.axgd'; % Vrest = -67mV; Rm = 145MOhm; Cm = 16pF. % CCIV: regular firing and no AHP. Lots of accomodation at high steps (a few funky "bursts")
Files.Resp.File{2}{3} = '/Volumes/cookieMonster/jonesLab_data/PatchPatSep_2s/Hilus/2017-8-31/HC6/PatSepR0.50_10Hz 011.axgd'; % Vrest = -71mV; (couldn't assess intrinsic values until end: Rm = 120MOhm Cm =25pF.) % CCIV: regular firing and no AHP
Files.Resp.File{2}{4} = '/Volumes/cookieMonster/jonesLab_data/PatchPatSep_2s/Hilus/2017-12-19/MC1/PatSepR0.5_10Hz_0.17mA_-70mV 002.axgd'; % Vrest = -60mV; Rm = 150MOhm; Cm = 45-30pF; CCIV: no AHP, regular spiking, lots of EPSPs 
% Files.Resp.File{2}{5} = '/Volumes/cookieMonster/jonesLab_data/PatchPatSep_2s/Hilus/2017-12-19/MC4/PatSepR0.5_10Hz_0.1mA_-70mV 008.axgd'; % Vrest = -68mV, Rm = 240MOhm, Cm = 37pF. CCIV: great! no AHP, regular, lots of EPSPs but not too moo much so baseline is easily detectable
Files.Resp.File{2}{5} = '/Volumes/cookieMonster/jonesLab_data/PatchPatSep_2s/Hilus/2017-12-19/MC4/PatSepR0.5_10Hz_0.2mA_-70mV_incomplete 007.axgd'; % same cell as above, but incomplete recording (great until repeat 7, when I stopped)
% Files.Resp.File{2}{7} = '/Volumes/cookieMonster/jonesLab_data/PatchPatSep_2s/Hilus/2017-12-14/MC3/PatSepR0.50_10Hz_006.axgd';% with intra solution new recipe + irregular firing, probabably due to EPSPs, no AHP. Low Firing. Vrest= -70mV; Rm = 6MOhm (4 start, 8 end); Cm = 45pF (30pF at the end)

Vrest{2}{1} = -87.5; Rm{2}{1} = 140; Cm{2}{1} = 34; ID{2}{1} = 4;
Vrest{2}{2} = -67; Rm{2}{2} = 140; Cm{2}{2} = 16; ID{2}{2} = 6;
Vrest{2}{3} = -60; Rm{2}{3} = 150; Cm{2}{3} = 38; ID{2}{3} = 7;
Vrest{2}{4} = -60; Rm{2}{4} = 150; Cm{2}{4} = 38; ID{2}{4} = 8;
Vrest{2}{5} = -68; Rm{2}{5} = 240; Cm{2}{5} = 37; ID{2}{5} = 9;

% 10Hz Corr R=0.25

Files.Stim.File{3} = '/Users/antoine/Desktop/PatSep8-28-14/Protocols/2sec_trains(pattern_separation)/Set 2/10Hz_R0.250/10Hz_R0.250_CorrelatedPoisson.prt.axgx';

Files.Resp.File{3}{1} = '/Volumes/cookieMonster/jonesLab_data/PatchPatSep_2s/Hilus/2017-8-30/HC2/PatSepR0.25_10Hz 005.axgd'; % Vrest = -66mV; Rm = 200MOhm; Cm = 30pF. % CCIV: regular firing and no AHP (but the recording isn't clean, cell is too active)  
Files.Resp.File{3}{2} = '/Volumes/cookieMonster/jonesLab_data/PatchPatSep_2s/Hilus/2017-8-30/HC3/PatSepR0.25_10Hz 009.axgd'; % Vrest = -88mV; Rm = 150MOhm; Cm = 34pF. % CCIV: regular firing and no AHP
Files.Resp.File{3}{3} = '/Volumes/cookieMonster/jonesLab_data/PatchPatSep_2s/Hilus/2017-8-31/HC3/PatSepR0.25_10Hz_incomplete5repeats 003.axgd'; % Vrest = -57mV; Rm = 150MOhm; Cm = 55pF. % CCIV: regular firing and no AHP. Long relaxation after step
Files.Resp.File{3}{4} = '/Volumes/cookieMonster/jonesLab_data/PatchPatSep_2s/Hilus/2017-8-31/HC4/PatSepR0.25_10Hz 005.axgd'; % Vrest = -56mV; Rm = 180MOhm; Cm = 38pF. % CCIV: regular firing and no AHP. good looking for figure? 
Files.Resp.File{3}{5} = '/Volumes/cookieMonster/jonesLab_data/PatchPatSep_2s/Hilus/2017-8-31/HC6/PatSepR0.25_10Hz 012.axgd'; % Vrest = -78mV; (couldn't assess intrinsic values until end: Rm = 120MOhm Cm =25pF.) % CCIV: regular firing and no AHP. 
Files.Resp.File{3}{6} = '/Volumes/cookieMonster/jonesLab_data/PatchPatSep_2s/Hilus/2017-12-19/MC4/PatSepR0.25_10Hz_0.12mA_-70mV 009.axgd'; % Vrest = -65mV, Rm = 18--250MOhm, Cm = 35-30pF; CCIV: great! no AHP, regular, lots of EPSPs but not too moo much so baseline is easily detectable 

Vrest{3}{1} = -66; Rm{3}{1} = 250; Cm{3}{1} = 30; ID{3}{1} = 3;
Vrest{3}{2} = -79.5; Rm{3}{2} = 160; Cm{3}{2} = 48; ID{3}{2} = 4;
Vrest{3}{3} = -57; Rm{3}{3} = 150; Cm{3}{3} = 55; ID{3}{3} = 10;
Vrest{3}{4} = -56; Rm{3}{4} = 180; Cm{3}{4} = 38; ID{3}{4} = 11;
Vrest{3}{5} = -80; Rm{3}{5} = 120; Cm{3}{5} = 25; ID{3}{5} = 7;
Vrest{3}{6} = -65; Rm{3}{6} = 250; Cm{3}{6} = 32; ID{3}{6} = 9;







