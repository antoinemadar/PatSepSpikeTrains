function CDATA = KreuzStimResp( PARAMS )

stimfilespec    = PARAMS.stimfilespec;
datafilespec    = PARAMS.datafilespec;
% [stimfilepath,stimfilename,stimfileext]     = fileparts(stimfilespec);
[datafilepath,datafilename,datafileext]     = fileparts(datafilespec);

% Load Stim & Data files
[stimtime, stimgroup, S] = parse_axograph( stimfilespec, 0) ;
[datatime, datagroup, S] = parse_axograph( datafilespec, 0) ;
clear S
time = datatime;

% Analysis Params
dts = 0.0001;
bins = [0:dts:time(end)]; % bins of 0.1ms => the rasters reflect almost exactly the raw data resolution (bins of 0.05 ms)

signaltype  = 'raw';
threshtype  = 'direct';
thresh      = -20e-3; 
peakflag    = 0;
displayflag = 0;
colord = lines(5);

%stim times matrix (each row must be a train of spike times, filled with zeros
%at the end so each line is the same length)
data = cat( 2, stimgroup{:} );
for n = 1:size(data, 2)
    stimtimes{n} = time( find(data(:,n)) );
    LenStim(1,n) = length(stimtimes{n});
end

MaxS = max(LenStim);
for n = 1:length(stimtimes)
    stimtimes{n} = stimtimes{n}';
    if length(stimtimes{n})<MaxS
       StartS = length(stimtimes{n});
       stimtimes{n}(1,StartS+1:MaxS) = zeros(1,MaxS-StartS);
    end
end
StimsSpikes = cat(1, stimtimes{:});

% data spike times 
data = datagroup{:};
[spiketimes, spikelocs, peaktimes, peaklocs] = detectspikes(time, data, signaltype, threshtype, thresh, peakflag, displayflag);

% Get matrix of data spike times matrix (rows are sweeps, filled with
% zeros at the end) and Regroup (stim waveforms 1-5, with series repeated 10x)
for n = 1:length(spiketimes)
    LenData(1,n) = length(spiketimes{n});
end

MaxD = max(LenData);
if MaxD <= MaxS %general case: when there are more stimspikes than data spikes, rows are completed with zeros up to the number of max stim spikes.
for n = 1:length(spiketimes)
    spiketimes{n} = spiketimes{n}';
    if length(spiketimes{n})<MaxS
       StartD = length(spiketimes{n});
       spiketimes{n}(1,StartD+1:MaxS) = zeros(1,MaxS-StartD);
    end
end
DataSpikes = cat(1, spiketimes{:});

else % if MaxD>MaxS, i.e there is at least one response train that has more spikes than any stim trace
  for n = 1:length(spiketimes)
    spiketimes{n} = spiketimes{n}';
    if length(spiketimes{n})<MaxD
       StartD = length(spiketimes{n});
       spiketimes{n}(1,StartD+1:MaxD) = zeros(1,MaxD-StartD);
    end
  end 
DataSpikes = cat(1, spiketimes{:});

  for n = 1:length(stimtimes)
    if length(stimtimes{n})<MaxD
       StartS = length(stimtimes{n});
       stimtimes{n}(1,StartS+1:MaxD) = zeros(1,MaxD-StartS);
    end
  end
StimsSpikes = cat(1, stimtimes{:});
end

groupedSpikes = [];
for n = 1:5
    G = size(groupedSpikes,1);
    groupedSpikes(G+1:G+10, :) = DataSpikes(n:5:end, :);
end

% group Stim and Data spikes together (at this point, groupedSpikes and
% StimSpikes should have lines of the same length

StimRespSpikes = cat(1, StimsSpikes, groupedSpikes);

% parameters for SPIKE-distance function

d_para_default=struct('tmin',[],'tmax',[],'dts',1,...
    'all_train_group_names',[],'all_train_group_sizes',[],'select_train_mode',1,'select_train_groups',[],'select_trains',[],'separators',[],'separators2',[],...
    'select_averages',[],'trigger_averages',[],'markers',[],'markers2',[],'interval_separators',[],'interval_strings',[],'comment_string','');
d_para=d_para_default;

d_para.tmin = 0;
d_para.tmax = time(end);
d_para.dts = 0.0001; %0.1ms bins (the original sampling rate is 1point every 0.05ms, i.e 20.000Hz)
d_para.all_train_group_names = {'Stim1'; 'Stim2'; 'Stim3'; 'Stim4'; 'Stim5'; 'Resp1';'Resp2';'Resp3';'Resp4';'Resp5'};
d_para.all_train_group_sizes = [1 1 1 1 1 10 10 10 10 10];
d_para.select_averages={[d_para.tmin d_para.tmax]}; %to get averaged distance S over the whole length of the recordings. 

% structure 'd_para': parameters that describe the data
%
% tmin: Beginning of recording
% tmax: End of recording
% dts: Sampling interval, precision of spike times
% all_train_group_names: Names of spike train groups
% all_train_group_sizes: Sizes of respective spike train groups
% select_train_mode: Selection of spike trains (1-all,2-selected groups,3-selected trains)
% select_train_groups: Selected spike train groups (if 'select_train_mode==2')
% select_trains: Selected spike trains (if 'select_train_mode==3')
% select_averages: One or more continuous intervals for selective temporal averaging
% trigger_averages: Non-continuous time-instants for triggered temporal averaging, external (e.g. certain stimulus properties) but also internal (e.g. certain event times)
% markers: Relevant time instants
% markers2: Even more relevant time instants
% separators: Relevant seperations between groups of spike trains
% separators2: Even more relevant seperations between groups of spike trains
% interval_separators: Edges of subsections
% interval_strings: Captions for subsections
% comment_string: Additional comment on the example, will be used in file and figure names

f_para_default=struct('imagespath',[],'moviespath',[],...    % Default values
    'matpath',[],'filename','','title_string','',...
    'saving',0,'print_mode',1,'publication',1,'comment_string','','num_fig',1,'pos_fig',[130 120 1320 880],'font_size',14,'multi_figure',1,...
    'timeunit_string','[ms]','xfact',1,'ma_mode',0,'spike_mao',20,'time_mao',10,'dtm',1,...
    'mov_step',0,'mov_frames_per_second',1,'mov_num_average_frames',1,'mov_frames',[],...
    'plot_mode',1,'norm_mode',1,'color_norm_mode',1,'block_matrices',0,'dendrograms',0,'dendro_color_mode',0,'subplot_size',[],...
    'subplot_posi',[0 1  0 0  0 0 0 0  0 0    0 0 0 0 0 0     0 2 0 0 0 0]);
f_para_default.subplot_size=ones(1,length(f_para_default.subplot_posi(f_para_default.subplot_posi>0)));
f_para = f_para_default;

% f_para.subplot_posi=[0 1  0 0  0 0 0 0  0 0     0 0 0 0 0 0   2 0 0 0 0 0]; % Choose what measure is saved and plotted. Here it is Spikes (from the rasters) and St for each pairs of spiketrains.  
% f_para.subplot_posi=[0 1  0 0  0 0 0 0  0 0     0 0 0 0 0 0   2 3 0 0 0 0]; %
f_para.imagespath = datafilepath;
f_para.matpath = datafilepath;
f_para.filename = [datafilename 'KreuzDistance.' ]; 
f_para.saving = 0; %to have a mat file
f_para.timeunit_string = 'sec';
%f_para.xfact = ?;
f_para.dtm = d_para.dts; %not sure...?
f_para.plot_mode = 1; % 8 to plot matrices of S averaged over time and not St
f_para.dendrograms = 1;
f_para.dendro_color_mode = 1; %colors of the groups, not for each spiketrains.
f_para.block_matrices=1; % to have the matrices of the PSTHs

f_para.num_fig = 1;
% structure 'f_para': parameters that determine the appearance of the figures (and the movie)
%
% imagespath: Path where images (postscript) will be stored
% moviespath: Path where movies (avi) will be stored
% matpath: Path where Matlab files (mat) will be stored
% filename: Name under which images, movies and Matlab files will be stored
% title_string: Appears in the figure titles
% saving: Saving to Mat-file? (0-no,1-yes)
% print_mode: Saving to postscript file? (0-no,1-yes)
% publication: Omits otherwise helpful information, such as additional comments (0-no,1-yes)
% comment_string: Additional comment on the example, will be used in file and figure names
% num_fig: Number of figure
% pos_fig: Position of figure
% font_size: Font size of labels (and headlines)
% multi_figure: Open many figures (0-no,1-yes)
% timeunit_string: Time unit, used in labels
% xfact: Conversion of time unit
% ma_mode: Moving average mode: (0-no,1-only,2-both)
% spike_mao: Order of moving average (pooled ISI)
% time_mao: Order of moving average (time)
% dtm: Sampling of measure profile, downsampling possible to facilitate memory management
% mov_step: Step size for movie frames
% mov_frames_per_second: Well, frames per second
% mov_num_average_frames: Number of frames the averages are shown at the end of the movie (if this is too small they are hardly visible)
% mov_frames: Selection of individual frames (e.g. in the movie, replaces use of mov_step as step size if non-empty)
% plot_mode: +1:vs time,+2:different measures and cuts,+4:different measures,+8:different cuts,+16:different cuts-Movie (binary addition allows all combinations)
% norm_mode: normalization of averaged bivariate measure profiles (1-Absolute maximum value 'one',2-Overall maximum value,3-Individual maximum value)
% color_norm_mode: normalization of pairwise color matrices (1-Absolute maximum value,2-Overall maximum value,3-Each one individually)
% block_matrices: Allows tracing the overall synchronization among groups of spike trains (0-no,1-yes)
% dendrograms: Cluster trees from distance matrices (0-no,1-yes)
% dendro_color_mode: coloring of dendrograms (0-no,1-groups,2-trains)
% subplot_posi: Vector with order of subplots
% subplot_size: Vector with relative size of subplots


% Get distances and figure 1 of distance matrices and dendrograms

Results_StimResp=f_distances_MEX(StimRespSpikes,d_para,f_para);
% Results_Stim = f_distances_MEX(StimsSpikes(1:2,:),d_para,f_para);
% Results_GpData = f_distances_MEX(groupedSpikes([1 11],:),d_para, f_para); 

% Compute Similarity matrix 
Similarity_Matrix_StimResp = ones(size(Results_StimResp.distance_matrices)) - Results_StimResp.distance_matrices;
Similarity_Matrix_Resp = Similarity_Matrix_StimResp(5:end,5:end);
Similarity_Matrix_Stim = Similarity_Matrix_StimResp(1:5,1:5);

% Similarity between Stim
nanmask = ones(size(Similarity_Matrix_Stim));
nanmask = triu(nanmask,1)./triu(nanmask,1);
x = nanmask.*triu(Similarity_Matrix_Stim, 1);
x = x(~isnan(x));
Sim_Stim = x;
Sim_StimMean = mean(x);
Sim_StimSEM     = std( x )./sqrt(length(x));
clear x

% Similarity Between (SimB)

RespSimBetween = cell(1,4);
for n = 1:4
    pts1 = 1 + (n-1).*10;
    pts2 = pts1+10-1;
    dumdum1 = Similarity_Matrix_Resp([pts1:pts2], [pts1+10:50]);
    RespSimBetween{n} = dumdum1(~isnan(dumdum1)); %take all the values of the matrix dummy1 to make it a column vector 
end
dumdum2 = cat(1, RespSimBetween{:});  
RespSimBetweenListAll = dumdum2;
RespSimMeanBetween = mean(dumdum2);
RespSimSEMBetween     = std( dumdum2 )./sqrt(length(dumdum2));

% Similarity Within (SimW)

RespSimWithinList = cell(1,5);
for n = 1:5 
    pts1 = 1 + (n-1).*10;
    pts2 = pts1+10-1;
    dummy1 = Similarity_Matrix_Resp([pts1:pts2], [pts1:pts2]);
    nanmask = ones(size(dummy1));
    nanmask = triu(nanmask,1)./triu(nanmask,1);
    x = nanmask.*triu(dummy1, 1);
    x = x(~isnan(x));
    RespSimWithinList{n} = x; 
end
dummy2 = cat(1,RespSimWithinList{:});
RespSimWithinListAll = dummy2;
RespSimMeanWithin    = mean( dummy2 );
RespSimSEMWithin     = std( dummy2 )./sqrt(length(dummy2));

% Average pairwise similarity (i.e. Between groups)
RespSimBetween = cell(1,4);
for n = 1:4
    pts1 = 1 + (n-1).*10;
    pts2 = pts1+10-1;
    dumdum1 = Similarity_Matrix_Resp([pts1:pts2], [pts1+10:50]);
    RespSimBetween{n} = dumdum1(~isnan(dumdum1)); %take all the values of the matrix dumdum1 to make it a column vector
    for c = n+1:5 %for averages of distinct comparison groups (e.g. responses from stim1 against stim2 alone) 
        dumCorrB = Similarity_Matrix_Resp([pts1:pts2], [pts1+10:c*10]);
        BCorrGP{n,c} = dumCorrB(~isnan(dumCorrB)); %list of the non-NaN values of for a given group. To compare pat sep of each group with anova
        RespCorrBtwMeanGp(n, c) = mean(dumCorrB(~isnan(dumCorrB)));
    end
end
% dumdum2 = cat(1, RespSimBetween{:});  
% RespSimBetweenListAll = dumdum2;
% RespSimMeanBetween = mean(dumdum2);
% RespSimSEMBetween     = std( dumdum2 )./sqrt(length(dumdum2));

% remove the zeros that are filling the lower triangle of RespCosBtwMeanGp, and put the upper triangle values in a vector
    nanmask2 = ones(size(RespCorrBtwMeanGp));
    nanmask2 = triu(nanmask2,1)./triu(nanmask2,1);
    RespSimGP = nanmask2.*triu(RespCorrBtwMeanGp, 1);
    RespSimGP = RespSimGP(~isnan(RespSimGP)); % vector column listing mean Cos of each resp classe comparison group (e.g 1vs2)

%% Display 

% figure(3)
% 
% a = ['Sim_{Stim} = ' num2str(Sim_StimMean, '%0.2f') ' ± ' num2str(Sim_StimSEM, '%0.2f')];
% b = ['Sim_{Resp}B = ' num2str(RespSimMeanBetween, '%0.2f') ' ± ' num2str(RespSimSEMBetween, '%0.2f')];
% c = ['Sim_{Resp}W = ' num2str(RespSimMeanWithin, '%0.2f') ' ± ' num2str(RespSimSEMWithin, '%0.2f')];
% titlabel = { 'Similarity (1 - SPIKEdistance)';[]; [ a '     ' b '     ' c ] };
% 
% ytickpos    = [2.5 10.*[1:5]];
% yticklabs   = {'Stim Set'; 'Resp #1'; 'Resp #2'; 'Resp #3'; 'Resp #4'; 'Resp #5'};
% xticklabs   = {'S'; '#1'; '#2'; '#3'; '#4'; '#5'};
% 
% linesx = [ [0 2]' [0 2]'    [0 2]'      [0 2]'      [0 2]'      ];
% linesy = [ [5 5]' [15 15]'  [25 25]'    [35 35]'    [45 45]'    ] + 0.5;
% % plot(linesx, linesy)
% 
% % map = [ [0.5 0.5 0.5]; jet];
% 
% dummy = Similarity_Matrix_StimResp;
% % dummy(isnan(dummy)) = -0.1;
% imagesc(dummy); hold on
% % colormap(gray)
% axis square
% set(gca, 'ytick', ytickpos, 'yticklabel', yticklabs)
% set(gca, 'xtick', ytickpos, 'xticklabel', xticklabs)
% ylabel('Stimulus & Response Classes', 'rot', 90)
% xlabel('Stimulus & Response Classes', 'rot', 0)
% plot(30.*linesx, linesy, 'k--', 'linewidth', 2)
% plot(linesy, 30.*linesx, 'k--', 'linewidth', 2)
% axis square
% caxis([0 1]);
% colormap(jet)
% colorbar
% title( titlabel )
% 
% cd(datafilepath)
% 
% outname = [ 'Kreuz_SimilarityMatrix.' datafilename ]; 
% 
% print( [outname '.eps'] , '-depsc' )
% print( [outname '.tif'] , '-dtiff', '-r150' )

%% Package Data Output
CDATA.PARAMS                = PARAMS;
CDATA.Results_StimResp      = Results_StimResp;
CDATA.Similarity_Matrix_StimResp = Similarity_Matrix_StimResp;
CDATA.Similarity_Matrix_Resp = Similarity_Matrix_Resp;
CDATA.RespSimBetweenListAll = RespSimBetweenListAll;
CDATA.RespSimMeanBetween = RespSimMeanBetween;
CDATA.RespSimSEMBetween = RespSimSEMBetween;
CDATA.RespSimWithinListAll = RespSimWithinListAll;
CDATA.RespSimMeanWithin = RespSimMeanWithin;
CDATA.RespSimSEMWithin = RespSimSEMWithin;
CDATA.Sim_Stim = Sim_Stim;
CDATA.Sim_StimMean = Sim_StimMean;
CDATA.Sim_StimSEM = Sim_StimSEM;
CDATA.RespSimGP = RespSimGP;
%






