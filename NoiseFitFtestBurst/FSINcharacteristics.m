clear
close all
clc

resultspath = 'yourpath';
cd(resultspath)

PatSepFileListAllGC_2010toDec2015 %GCyo 10Hz
% PatSepFilesListFS
% PatSepHilarMossyCells
% PatSepFiles_DGGCctrl_gzine_30Hz
% PatSepFiles_CA3_gzine_30Hz
% PatSepFilesBeforeGabazine
% PatSepFilesAfterGabazine

for catnum = 1:length(Files.Stim.File)
      for itemnum = 1:length(Files.Resp.File{catnum}(:))
            
            % Load Data files
            stimfilespec    = Files.Stim.File{catnum};
            datafilespec    = Files.Resp.File{catnum}{itemnum};
            
            [stimtime, stimgroup, S] = parse_axograph( stimfilespec, 0) ;
            [datatime, datagroup, S] = parse_axograph( datafilespec, 0) ;
            clear S
            time = datatime;

            % Analysis Params          
            lags = [0:40]./1000; %window for crosscorr, 1ms bins, axis in seconds
            
            signaltype  = 'raw';
            threshtype  = 'direct';
            thresh      = -20e-3; 
            peakflag    = 0;
            displayflag = 0;
          
            % get stim times 
            stim = cat( 2, stimgroup{:} );
            for n = 1:size(stim, 2)
                stimtimes{n} = datatime( stim(:,n)>0 );
            end
            stimtimesList = cat(1,stimtimes{:}); %single vector containing all stimtimes from the 5 traces
            
            % get data spike times
            data = datagroup{:};
            [spiketimes, spikelocs, peaktimes, peaklocs] = detectspikes(time, data, signaltype, threshtype, thresh, peakflag, displayflag);
            
            % mean firing rate of the recording
            nsweeps = length(spiketimes);
            for ns = 1:nsweeps %for all 50 sweeps
                Nout(ns,1) = length(spiketimes{ns}); %number of output spike
            end
            FiringRateSweep = Nout./2; %single vector column of length(spiketimes), i.e 50, with each element the firing rate of a sweep 
            FiringRate = mean(FiringRateSweep);
            
            % ISI of inputs and outputs
            [ISIstim] = ISI(stimtimes);
            [ISIoutput] = ISI(spiketimes);
            
            % Cross Co-occurence between stim times and each corresponding response spike times 
            
            lagAll = [-20:100]./1000; %in sec
            lags2 = [-250:250]./1000; %window for auto-occurence
            for n = 1:size(stim, 2)
                groupedtimes{n} = spiketimes(n:size(stim, 2):end); %spiketimes is a cell array of column vectors of spike times. So groupedtimes{n} is a sub-ensemble of this cell array
                times1 = stimtimes{n};
                for trial = 1:size(groupedtimes{n},2)
                times2 = groupedtimes{n}{trial};
                [XCorrAll{n}{trial}, lags] = SpiketimeXCorrs( times1, times2, lagAll, 0); %XCorr gives the count of spikes in the lag window at each bin.
                % auto-occurence (i.e crossoccurence on the same spiketrain, to assess spike clustering/burstiness
                [AutoC{n}{trial}, lagsAutoC] = SpiketimeXCorrs( times2, times2, lags2, 0);
                end
            end
            
            Dummy = cat(2, XCorrAll{:});
            SumXCorrB = sum( cat(2, Dummy{:}), 2); % sum all xcorr of the same file
            SumXCorrB(1) = 0; %correction because weird thing happening in the first bin
            
            Baseline = mean(SumXCorrB(1:20)); %find baseline of spiking in the 20 first ms before lag=0
            SumXCorr = SumXCorrB - Baseline; %corrected XCorr
            if ~isempty(SumXCorr<0)
                SumXCorr(SumXCorr<0) = 0; %to avoid negative number of occurence
            end
            SumXCorr = SumXCorr(21:121); %to only take in account what comes after lag 0 in proba distrib
            PDFxcorr = SumXCorr./sum(SumXCorr); %proba distribution by dividing by the total number of events (=output spikes minus baseline without negative values)
            sumPDFxcorr = sum(PDFxcorr); %check it is equal to 1
            
            % Auto occurence
            DummyA = cat(2, AutoC{:});
            SumAutoC = sum( cat(2, DummyA{:}), 2);
            SumAutoC(251) = 0; %blank the autocorrleation peak at lag = 0, i.e. on itself

            %Associate a number to each output spike: 1st, 2nd, 3rd etc spike after an input
            % + count number of spikes for each inter input intervals. + find the average count
            for n = 1:size(stim, 2) % for each stimgroup (1-5)
                
                groupedtimes{n} = spiketimes(n:5:end); % Regroup (stim waveforms 1-5, with series repeated 10x)
                
                for i = 1:size(groupedtimes{n},2); % for each sweep (ie each column of groupedtimes)
                    
                    Sweep = groupedtimes{n}{:,i}; %vector column of output spiketimes from the ith sweep
                    
%                   OutInterTimes{n}{i} = [];    %it's going to end up like Sweep               
                    for input = 1:length(stimtimes{n}) % for each input spike

                        t1 = stimtimes{n}(input); %time of first imput
                            if input == length(stimtimes{n}) % for the last input
                                t2 = max(time);
                            else
                                t2 = stimtimes{n}(input+1); %time of next input
                            end

                        DumOutInterTimes = Sweep(Sweep>t1 & Sweep<=t2); %returns times of output spikes occuring  in ]t1 t2] interval
                            if isempty(DumOutInterTimes)==1  % When no spikes detected in interval
                                DumOutInterTimes = 0;
                                Count = 0;
                            else
                                Count = length(DumOutInterTimes); % Number of output spikes between inputs.  
                            end

                        CountOutInter{n}(input,i) = Count; %To save and average over all dimensions for a given recording to get average number
                        NormOutInter{n}(input,i) = Count./((t2-t1).*1000); %Count normalized by inter inputs interval. In ms^-1 (maybe not a valid normalization then...?)
                        III{n}(input,i) = t2-t1; %matrix to keep track of the Inter-input intervals associated with each count of output spikes.
                            if input ==1
                                IIIpre{n}(input,i) = t1;    
                            else
                                IIIpre{n}(input,i) = III{n}(input-1,i);
                            end
                        
                            if DumOutInterTimes > 0 %this way, nothing happens (OutInterTimes stays empty) when DumOutInterTimes =0, i.e when there were no output spikes in the interval
                                    if input == 1 %beginning of a sweep
                                        Last = 0; 
                                    elseif input>1 && ~exist('OutInterTimes','var') %if there was no spikes detected until ith input in first sweep
                                        Last = 0;
                                    elseif input>1 && n>size(OutInterTimes, 2) % when starting a new group and no spikes detected in this group n before
                                        Last = 0;
                                    elseif input>1 && i>size(OutInterTimes{n},2) %if there was no spike detected in this sweep i before
                                        Last = 0;
                                    else
                                        Last = find(OutInterTimes{n}{i}, 1,'last');
                                    end
                            OutInterTimes{n}{i}(Last+1:Last+Count,1) = DumOutInterTimes;  % List of output spiketimes (equivalent to sweep)
                            NumSpikeInBurst{n}{i}(Last+1:Last+Count,1) = find(DumOutInterTimes); % List of the number-in-burst associated with each spike of a sweep    
                            end
                            clear DumOutInterTimes Count
                    end
                                     
                end    
            OutInterTimesVector{n} = cat(1 , OutInterTimes{n}{:});
            NumSpikeInBurstVector{n} = cat(1, NumSpikeInBurst{n}{:});
            CountOutInterVector{n} = reshape(CountOutInter{n}, size(CountOutInter{n},1).*size(CountOutInter{n},2),1); % make the matrix MxN a single vector column with MxN elements
            NormOutInterVector{n} = reshape(NormOutInter{n}, size(NormOutInter{n},1).*size(NormOutInter{n},2),1);
            IIIVector{n} = reshape(III{n},size(III{n},1).*size(III{n},2),1);
            IIIpreVector{n} = reshape(IIIpre{n},size(IIIpre{n},1).*size(IIIpre{n},2),1); 
            end
            
       OutInterTimesVect = cat(1 , OutInterTimesVector{:});  % make the cell array a single vector column containing all spiketimes. grouped. 
       NumSpikeInBurstVect = cat(1,NumSpikeInBurstVector{:}); % idem. The vector contains associated number for each spiketime in OutInterTimes
       CountOutInterVect = cat(1,CountOutInterVector{:});
       NormOutInterVect = cat(1,NormOutInterVector{:});
       IIIVect = cat(1,IIIVector{:});
       IIIpreVect = cat(1,IIIpreVector{:});
       CountOutInterAverage = mean(CountOutInterVect);
       NormOutInterAverage = mean(NormOutInterVect);
       
       %to look at relationship between number of spikes in an interval and
       % the duration of the PRECEDING interval
       
       
       
       
%        clear OutInterTimes NumSpikeInBurst OutInterTimesVector NumSpikeInBurstVector CountOutInter CountOutInterVector NormOutInter NormOutInterVector IIIVector III IIIpre IIIpreVector
       
       % Cross-Occurence btw Input and Output Spikes for 1st, 2nd, etc output spikes-in-burst separately
       MaxNum = max(NumSpikeInBurstVect);
           for num = 1:MaxNum
               NumthInBurstTimes = OutInterTimesVect(NumSpikeInBurstVect==num);
               [XCorr{num}, lags] = SpiketimeXCorrs( NumthInBurstTimes, stimtimesList, lags, 0); %XCorr gives the count of spikes in the lag window at each bin.
               XCorr{num}(1) = 0;

                   % gaussian fitting (delay and jitter estimation) and reliability estimation
                    guess = [0.015, 0.025, 40, 0];
                    guess = fminsearch('fit_gauss_w_offset', guess, [], lags(:), XCorr{num}(:), displayflag); %fminsearch arguments: after function handle and starting point, leave option empty and add arguments for function handle (see help fit_gauss...)
                    [mu{num}, sig{num}, amp{num}, base{num}] = deal(  guess(1), guess(2), guess(3), guess(4) );

                    FitEst{num} = amp{num}.*exp(-(lags-mu{num}).^2./sig{num}.^2) + base{num};

                    CorrectedXCorr{num} = XCorr{num} - base{num}; % removes the baseline due to unwanted following spikes occuring in the lag window
                    CorrectedXCorr{num}(CorrectedXCorr{num}<0)=0; %makes negative values = 0, to not have negative probabilities

                    NInputs = 10.*length(stimtimesList);
                    XCorrPDF{num} = CorrectedXCorr{num}./NInputs; % normalizes to the total number of spikes in the stimuli set, repetted 10 times (hence the .*10). If 1 stim spike was always leading to a response spike, this would give the real proba distribution, with area under curve = 1. It is not because of unreliability
                    FitEstPDF{num} = amp{num}.*exp(-(lags-mu{num}).^2./sig{num}.^2)./NInputs; % 

                    Reliability{num} = sum(XCorrPDF{num});
               clear NumthInBurstTimes;     
           end
       
       % display
            [stimfilepath,stimfilename,stimfileext]     = fileparts(stimfilespec);
            [datafilepath,datafilename,datafileext]     = fileparts(datafilespec);
       
%        figure(1) % Number of Spikes per inter-input interval + normalized to III
%             
%        title('Distribution of the number of output spikes between 2 inputs');
%        
            bins = [0:MaxNum];
%             
%             subplot(3,1,1) % histogram of number of outspikes 
%             
            BinCount = hist(CountOutInterVect,bins)./length(CountOutInterVect); 
            Reliab = (length(CountOutInterVect) - length(CountOutInterVect(CountOutInterVect==0)))./length(CountOutInterVect); % Spike Reliability of the given recording (Ninput-Nzerospike)/Ninput
%             bar(bins, BinCount, 'k'); hold on; box off; axis square;
%             plot(CountOutInterAverage.*ones(size(BinCount)), BinCount, 'r-');
%             text(0.5.*bins(end), 0.5.*max(BinCount), {['average count = ' num2str(CountOutInterAverage, '%2.4f')]})
%             xlabel('number of output spikes between two inputs'); ylabel('probability');
%             text(0.5.*bins(end), max(BinCount), {['Reliability = ' num2str(Reliab)]})
%             set(gca, 'xlim', [0,MaxNum])
% %             if bins(end)>1
% %             end
% %             set(gca, 'xlim', [0 max(BinCount)])
%             
%             
%             subplot(3,1,2) % Number of output spikes between 2 inputs as a function of Inter-Input Interval
%             
%             scatter(IIIVect.*1000,CountOutInterVect, 25, 'k')
%             box off; axis square;
%             set(gca, 'xlim', [min(IIIVect).*1000,max(IIIVect).*1000]);
%             xlabel('Inter-Input-Interval, ms'); ylabel('Number of Output Spikes between 2 inputs');
%             
%             subplot(3,1,3)
%             scatter(IIIpreVect.*1000,CountOutInterVect, 25, 'k')
%             box off; axis square;
%             set(gca, 'xlim', [min(IIIVect).*1000,max(IIIVect).*1000]);
%             xlabel('preceding Inter-Input-Interval, ms'); ylabel('Number of Output Spikes between 2 inputs');
%             
% %             subplot(3,1,2) % Normalized per Inter Input Interval Histogram = distrib of spiking frequency between 2 inputs
% %             
% % %             [BinNorm, Edges, BINS] = histcounts(NormOutInterVect,'BinLimits',[min(NormOutInterVect),max(NormOutInterVect)]); 
% % %             bar(BINS,BinNorm,'k');
% % %            plot(NormOutInterAverage.*ones(size(BinNorm)), BinNorm, 'r-');
% % %            set(gca, 'xlim', BIN([1,end]))
% %             histogram(NormOutInterVect, 'BinLimits',[min(NormOutInterVect),max(NormOutInterVect)]); 
% % 
% %             hold on; box off; axis square;
% %  
% %             text(max(NormOutInterVect).*0.5, 100, {['average count = ' num2str(NormOutInterAverage, '%2.4f')]})
% %             xlabel('number of output spikes between two inputs / corresponding Inter input Interval, ms-1'); ylabel('count of occurences')
%             
%             
% 
%             
% %             cd(datafilepath)
% %             outname = [datafilename '.OutputSpikesNumberBtw2Inputs']; 
% %             print( [outname '.epsf'] , '-depsc' )
% %             print( [outname '.tif'] , '-dtiff', '-r150' )
%             
%        figure(2) %3D plot of count of spikes between 2 inputs as function of current and preceding Inter-Inpulse-Intervals
%        
%        scatter3(IIIVect.*1000,IIIpreVect.*1000,CountOutInterVect, 'k');
%        box off; axis square;
%        set(gca, 'xlim', [min(IIIVect).*1000,max(IIIVect).*1000]);
%        xlabel('Inter-Input-Interval, ms'); ylabel('preceding III, ms'); zlabel('Number of Output Spikes between 2 inputs');
%        title('number of spikes between 2 inputs as function of current and preceding Inter-Inpulse-Intervals');  
%        
% %        cd(datafilepath)
% %             outname = [datafilename '.3DcountVSiiiVSiiiPre']; 
% %             print( [outname '.epsf'] , '-depsc' )
% %             print( [outname '.tif'] , '-dtiff', '-r150' )
%             
%        figure(3) %ISI plots (histo and cdf)
%        
%        subplot(3,1,1)
%        bins2 = [0:10:round(max(ISIstim).*1000)]; %in 10ms bins, with time in mseconds
%        ISIstimCount = hist(ISIstim.*1000,bins2); 
%        bar(bins2, ISIstimCount, 'k'); hold on; box off; axis square;
% %        histogram(ISIstim.*1000, 'BinLimits',[min(ISIstim.*1000),max(ISIstim.*1000)]);
%        xlabel('ms'); ylabel('count')
%        title('Inter-Input-Interval Distribution')
%        set(gca, 'xlim', [0,max(ISIstim)].*1000);
%        
%        subplot(3,1,2)
%        bins3 = [0:10:round(max(ISIoutput).*1000)]; %in 10ms bin
%        ISIoutputCount = hist(ISIoutput.*1000,bins3); 
%        bar(bins3, ISIoutputCount, 'k'); hold on; box off; axis square;
% %        histogram(ISIoutput.*1000, 'BinLimits',[min(ISIoutput.*1000),max(ISIoutput.*1000)]);
% %        box off; axis square;
%        xlabel('ms'); ylabel('count')
%        title('Response Inter-Spike-Interval Distribution')
%        set(gca, 'xlim', [0,max(ISIoutput).*1000]);
%        
%        subplot(3,1,3)
%        [Hstim,CDFstim] = cdfplot(ISIstim.*1000);
%        hold on
%        [Houtput,CDFoutput] = cdfplot(ISIoutput.*1000);
%        xlabel('ms'); ylabel('cdf')
%        set(gca, 'xlim', [0,max(ISIstim)].*1000);
%        box off; axis square;
%        legend('stim ISI = III', 'output ISI', 'Location', 'SouthEast' )
%        text(0.15, 0.4, {['meanISIstim = ' num2str(CDFstim.mean, '%2.4f'), 'meanISIoutput = ' num2str(CDFoutput.mean, '%2.4f')]})
%        
% %        cd(datafilepath)
% %             outname = [datafilename '.ISIandIII']; 
% %             print( [outname '.epsf'] , '-depsc' )
% %             print( [outname '.tif'] , '-dtiff', '-r150' )
%             
%  figure(4) %XCorr between stim and all output spikes. Draw from the PDF (i.e 3rd graph) to get realistic random delay with jitter
%         
%      subplot(3,1,1)
%      
%      lagms = lagAll.*1000; %to have x axis in milliseconds
%      bar(lagms, SumXCorrB, 'k'); hold on;
%      plot([-20:0], Baseline.*ones(1,21), 'r');
%      xlabel('lags, ms'); ylabel('Number of spikes')
%      title('binned Cross-Occurence between Stim Spikes and Response Spikes')
%      set(gca, 'xlim', lagms([1,end]))
% 
%      subplot(3,1,2)
% 
%      lagC = lagAll(21:end).*1000;
%      bar(lagC, SumXCorr, 'k');
%      xlabel('lags, ms'); ylabel('Number of spikes')
%      title('XCorr minus Baseline, no negative values')
%      set(gca, 'xlim', lagC([1,end]))
%      
%      subplot(3,1,3)
%      
%      bar(lagC, PDFxcorr, 'k');
%      xlabel('lags, ms'); ylabel('probability')
%      text(0.5.*lagC(end), max(PDFxcorr), {['sum of proba = ' num2str(sumPDFxcorr)]})
%      title('Probability Distribution of Spiking After an Input')
%      set(gca, 'xlim', lagC([1,end]), 'ylim', [0 max(PDFxcorr)+0.1])
     

%        cd(datafilepath)
%             outname = [datafilename '.StimOutputXCorr']; 
%             print( [outname '.epsf'] , '-depsc' )
%             print( [outname '.tif'] , '-dtiff', '-r150' )

     
% figure
% 
%      lagA = lags2.*1000;
%      bar(lagA, SumAutoC, 'k');
%      xlabel('lags, ms'); ylabel('Number of spikes')
%      title('Auto-occurence')
%      set(gca, 'xlim', lagA([1,end]))

%        for num = 1:MaxNum
%                      
%        figure(num+3)
%        title(['CrossOccurrence between Input and ' num2str(num) 'th spike in "burst"']);    
%        
%          lagms = lags.*1000; %to have x axis in milliseconds
%             subplot(2,1,1)
%             bar(lagms, XCorr{num}, 'k'); hold on; box off
%             plot(lagms, FitEst{num}, 'r-', 'linewidth', 2)
%             text(0.5.*lagms(end), max(FitEst{num}), {['mean delay = ' num2str(mu{num}, '%2.4f')]; ['jitter = ' num2str(sig{num}, '%2.4f')]; ['baseline = ' num2str(base{num}, '%2.2f')]})
%             xlabel('lags, ms'); ylabel('Number of spikes')
%             title('binned Cross-Occurence between Stim Spikes and Response Spikes')
%             set(gca, 'xlim', lagms([1,end]))
%             
%             subplot(2,1,2)
%             bar(lagms, XCorrPDF{num}, 'k'); hold on; box off
%             plot(lagms, FitEstPDF{num}, 'r-', 'linewidth', 2)
%             text(0.5.*lagms(end), max(FitEstPDF{num}), { ['reliability = ' num2str(Reliability{num})] })
%             xlabel('lags, ms'); ylabel('Probability')
%             title('Probability distribution of response spikes co-occuring with stim spikes')
%             set(gca, 'xlim', lagms([1,end]), 'ylim', [0, 0.5])
%            
%             cd(datafilepath)
%             outname = [datafilename '.XCorr' num2str(num) 'thSpike']; 
%             print( [outname '.epsf'] , '-depsc' )
%             print( [outname '.tif'] , '-dtiff', '-r150' )
%        end
       
%        pause(10);
       
       % packaging items to save
       
       collate{catnum}{itemnum}.OutInterTimesSweep = OutInterTimes;
       collate{catnum}{itemnum}.NumSpikeInBurstSweep = NumSpikeInBurst;
       collate{catnum}{itemnum}.OutInterTimes = OutInterTimesVect; %single vect with all the output spike times 
       collate{catnum}{itemnum}.NumSpikeInBurst = NumSpikeInBurstVect; %single vector with the "number in burst" associated to each spike time (i.e. each element is a spike and tells the position between 2 inputs).
       collate{catnum}{itemnum}.CountOutInter = CountOutInterVect; % vector of the number of spikes between each pair of inputs. including zeros. 
       collate{catnum}{itemnum}.NormOutInter = NormOutInterVect; % vector of the number of spikes between each pair of inputs ./ associated inter-input-interval
       collate{catnum}{itemnum}.IIIVect = IIIVect;
       collate{catnum}{itemnum}.IIIpreVect = IIIpreVect;
       collate{catnum}{itemnum}.CountOutInterAverage = CountOutInterAverage; %mean number of spikes between 2 inputs
       collate{catnum}{itemnum}.NormOutInterAverage = NormOutInterAverage; % mean ratio of number of spikes btw 2 inputs divided by associated inter-input-interval
       collate{catnum}{itemnum}.Nout = Nout; %number of output spikes in the 50 response trains
       collate{catnum}{itemnum}.FiringRate = FiringRate;
       collate{catnum}{itemnum}.MaxNum = MaxNum; %maximum number of spikes in input interval in this recording
       collate{catnum}{itemnum}.XCorr = XCorr; %cell array for all numth in burst
       collate{catnum}{itemnum}.FitEst = FitEst; % cell array. gaussian estimate of the cross-occurrence
       collate{catnum}{itemnum}.FitEstPDF = FitEstPDF; %cell array. gaussian estimate of proba of co-occurence = estimate of the (cross-occurence - base)./number of stim spikes
       collate{catnum}{itemnum}.Reliability = Reliability; % cell array. Empirical measure(not based on fitting): sum of (cross-occurence - base)./number of stim spikes
       collate{catnum}{itemnum}.Jitter = sig; %cell array
       collate{catnum}{itemnum}.Delay = mu; %cell array 
       collate{catnum}{itemnum}.Base = base; %cell array
       collate{catnum}{itemnum}.Amplitude = amp; %cell array
       collate{catnum}{itemnum}.ISIstim = ISIstim; %vector of time intervals between input spikes
       collate{catnum}{itemnum}.ISIoutput = ISIoutput; %idem for output spikes
%        collate{catnum}{itemnum}.CDFoutput = CDFoutput; %stat about ISI of the output inter-spike-intervals
%        collate{catnum}{itemnum}.CDFstim = CDFstim;
       collate{catnum}{itemnum}.SumXCorrB = SumXCorrB;
       collate{catnum}{itemnum}.SumXCorr = SumXCorr;
       collate{catnum}{itemnum}.PDFxcorr = PDFxcorr;
       collate{catnum}{itemnum}.sumPDFxcorr = sumPDFxcorr;
       collate{catnum}{itemnum}.Reliab = Reliab; %spike reliability of the recording. Assessed as (Ninput-Nzerospike)/Ninput 
       collate{catnum}{itemnum}.SumAutoC = SumAutoC;
       
       clear OutInterTimes NumSpikeInBurst OutInterTimesVector NumSpikeInBurstVector CountOutInter CountOutInterVector NormOutInter NormOutInterVector IIIVector III IIIpre IIIpreVector
       clear OutInterTimesVect NumSpikeInBurstVect CountOutInterVect NormOutInterVect CountOutInterAverage NormOutInterAverage Nout FiringRate MaxNum XCorr FitEst FitEstPDF Reliability sig mu base amp
       clear ISIstim ISIoutput CDFoutput CDFstim IIIVect IIIpreVect SumAutoC AutoC
%        close all
       
            disp([catnum itemnum])
            disp('********************************')
      end
end

cd(resultspath)
outname = ['SpikeCharacteristics.mat']; 
save( outname )