% burst analysis comparing all celltypes

clear 
close all

% BurstAnalysis (measures from FSINcharacteristics.m)
load('/Users/antoine/Google Drive/LabReasearch/Projects/PatSepSingleGC/upto12-06-2016/Analysis/10Hz/JitterReliab_FitXCorr_Bursts/GC/SpikeCharacteristics_GC.mat');
burstCT{1} = collate; % GC young animals 2010-2014
clearvars -except burstCT noise
load('/Users/antoine/Google Drive/LabReasearch/Projects/PatSepSingleGC/upto12-06-2016/Analysis/10Hz/JitterReliab_FitXCorr_Bursts/FS/All2010sansAntiDrom/SpikeCharacteristicsFSIN.mat');
burstCT{2} = collate; % FS 2010
clearvars -except burstCT noise
load('/Users/antoine/Google Drive/LabReasearch/Projects/PatSepSingleGC/upto12-06-2016/Analysis/Hilus/Burst/SpikeCharacteristics_HMC.mat');
burstCT{3} = collate; % HMC 2017
clearvars -except burstCT noise
load('/Users/antoine/Google Drive/LabReasearch/Projects/PatSepSingleGC/upto12-06-2016/Analysis/CA3pyr_Gzine/30Hz/Noise_Burst/GCctrl/SpikeCharacteristics_GC.mat');
burstCT{4} = collate; % GC young animals 30Hz + gzn 2017 (Ctrl for CA3) 
clearvars -except burstCT noise
load('/Users/antoine/Google Drive/LabReasearch/Projects/PatSepSingleGC/upto12-06-2016/Analysis/CA3pyr_Gzine/30Hz/Noise_Burst/SpikeCharacteristics_CA3.mat');
burstCT{5} = collate; % CA3 young animals 30Hz + gzn 2017
clearvars -except burstCT noise

valid{1} = [1, 3:12];
valid{2} = [1:5];
valid{3} = [1:3];
valid{4} = [1 2];
valid{5} = [1 2];

for ct = 1:length(burstCT) % ct --> celltype
    
ok = valid{ct};


    for n = 1:length(burstCT{ct}) % n --> catnum = Rin
    ALL = cat(1, burstCT{ct}{n}{:}); 
    FiringRateD{ct}{n} = cat(1, ALL.FiringRate);
    MaxNumD{ct}{n} = cat(1, ALL.MaxNum);
    MeanNumD{ct}{n} = cat(1, ALL.CountOutInterAverage); % mean number of spike for each recording (zeros included)
    ReliabAll{ct}{n} = cat(1, ALL.Reliab);
    COIA{ct}{n} = cat(1, ALL.CountOutInter);
    IIIA{ct}{n} = cat(1, ALL.IIIVect);
    IIIpreA{ct}{n} = cat(1, ALL.IIIpreVect);
    
    ISIstim{ct}{n} = burstCT{ct}{n}{1}.ISIstim.*1000;
    
    
        for i = 1:length(burstCT{ct}{n}) % i --> itemnum = recordings
        Dummy = burstCT{ct}{n}{i}.CountOutInter;    
        MeanCountNoZeros{ct}{n}(i,1) = mean(Dummy(Dummy>0)); %mean number of spikes after an input, when there's at least one after an input
        probaBurst{ct}{n}(i,1) = sum(Dummy>1)./length(Dummy);% proba of firing more than once between 2 inputs for each recording
        Dum{ct}{n}(i,1) = mean(Dummy(Dummy>1));%mean count just for bursts, i.e. when more than 1 spike btw 2 inputs
        
        ISIout{ct}{n}{i} = burstCT{ct}{n}{i}.ISIoutput.*1000;
        end
    MeanCountBurst{ct}{n} = Dum{ct}{n}(~isnan(Dum{ct}{n})); %to exclude NaNs due to zero bursting detected
    ISIoutAll{ct}{n} = cat(1, ISIout{ct}{n}{:});
    end

%contains values for each inter-input interval of all recordings
CountOutInterAllCat{ct} = cat(1,COIA{ct}{ok});
CountNoZerosAll{ct} = CountOutInterAllCat{ct}(CountOutInterAllCat{ct}>0);
IIIcat{ct} = cat(1,IIIA{ct}{ok});
IIIprecat{ct}  = cat(1,IIIpreA{ct}{ok});
IIIcatForBurst{ct} = IIIcat{ct}(CountOutInterAllCat{ct}>1);
IIIprecatForBurst{ct} = IIIprecat{ct}(CountOutInterAllCat{ct}>1);

ISIstimCat{ct} = cat(1,ISIstim{ct}{ok});
ISIoutALL{ct} = cat(1, ISIoutAll{ct}{ok});

IIIburstMean{ct} = mean(IIIcatForBurst{ct}); 
IIIburstSEM{ct} = std(IIIcatForBurst{ct})./sqrt(length(IIIcatForBurst{ct}));

IIIpreBurstMean{ct} = mean(IIIprecatForBurst{ct});
IIIpreBurstSEM{ct} = std(IIIcatForBurst{ct})./sqrt(length(IIIcatForBurst{ct}));
IIIpreBurstMedian{ct} = median(IIIprecatForBurst{ct});

% contains a single value for each recording
FiringRateCat{ct} = cat(1,FiringRateD{ct}{ok});
ReliabCat{ct} = cat(1,ReliabAll{ct}{ok});
MeanCountNoZerosCat{ct} = cat(1, MeanCountNoZeros{ct}{ok}); %mean number of spikes after input, excluding times when there was no spikes (i.e excluding zeros)
MeanNumDCat{ct} = cat(1,MeanNumD{ct}{ok}); %mean number of spikes after input, including zeros (when no spikes) 
MaxNumDCat{ct} = cat(1, MaxNumD{ct}{ok});
MeanCountBurstCat{ct} = cat(1, MeanCountBurst{ct}{ok});
ProbaBurstCat{ct} = cat(1,probaBurst{ct}{ok});

FRmean{ct} = mean(FiringRateCat{ct});
FRsem{ct} = std(FiringRateCat{ct})./sqrt(length(FiringRateCat{ct}));

RelMean{ct} = mean(ReliabCat{ct});
RelSEM{ct} = std(ReliabCat{ct})./sqrt(length(ReliabCat{ct}));

MeanCNZ{ct} = mean(MeanCountNoZerosCat{ct});
CNZsem{ct} = std(MeanCountNoZerosCat{ct})./sqrt(length(MeanCountNoZerosCat{ct}));

MeanMN{ct} = mean(MeanNumDCat{ct});
MNsem{ct} = std(MeanNumDCat{ct})./sqrt(length(MeanNumDCat{ct}));

MeanCB{ct} = mean(MeanCountBurstCat{ct});
CBsem{ct} = std(MeanCountBurstCat{ct})./sqrt(length(MeanCountBurstCat{ct}));

MeanMX{ct} = mean(MaxNumDCat{ct});
MXsem{ct} = std(MaxNumDCat{ct})./sqrt(length(MaxNumDCat{ct}));

pBurstMean{ct} = mean(ProbaBurstCat{ct});
pBurstSEM{ct} = std(ProbaBurstCat{ct})./sqrt(length(ProbaBurstCat{ct}));

clear n i

end

% Indirect measure of burstiness of each recording set and input set, using
% the Kullback-Liebler divergence from an exponential pdf with mean = 1
% (which corresponds to a Poisson distribution of the ISI)
LinEdges = linspace(0,50,250); 
BinCenters = LinEdges(1:end-1) + diff(LinEdges(1:2))./2;
Q = exp(-BinCenters/1); % Exponential normalized to have mean (i.e. time constant) = 1
Q = Q./sum(Q); % normalize to have unit area -> to compare with ISI frequencies of a given recording set, normalized to their mean 

    for ct = 1:length(burstCT)
        medISI = median(ISIstimCat{ct});
        meanISI = mean(ISIstimCat{ct});
        ISIstimed{ct} = ISIstimCat{ct}./medISI;
        ISI = ISIstimCat{ct}./meanISI;
        [Nin{ct},EDGES] = histcounts(ISI, LinEdges, 'Normalization', 'probability');
        KLDin(ct) = kldiv(BinCenters, Nin{ct}+eps, Q+eps, 'js'); % kullback-liebler divergence from an ideal exponential distribution. Add "eps" to avoid dividing by 0 or having log(0) in kldiv
        clear medISI meanISI EDGES ISI
        for n = 1:length(burstCT{ct})
            for i = 1:length(burstCT{ct}{n})
                medISI = median(ISIout{ct}{n}{i});
                meanISI = mean(ISIout{ct}{n}{i});
                ISImed = ISIout{ct}{n}{i}./medISI;
                ISI = ISIout{ct}{n}{i}./meanISI;
                [N,EDGES] = histcounts(ISI, LinEdges, 'Normalization', 'probability');
                KLDout_Nin{ct}{n}(i,1) = kldiv(BinCenters, N+eps, Nin{ct}+eps); % kullback-liebler divergence from the actual input distribution
                KLDout_exp{ct}{n}(i,1) = kldiv(BinCenters, N+eps, Q+eps); % kulman-liebler divergence from an ideal exponential distribution        
                if ct < 4
                ISIstim = ISIstimed{1};
                elseif ct > 3
                ISIstim = ISIstimed{4};    
                end
                [Hks,Pks{ct}{n}(i,1),Dks{ct}{n}(i,1)] = kstest2(ISIstim,ISImed); % KS test on ISI normalized to median, btw inputs and outputs. KS test uses the cdf and computes the maximum absolute difference between the cdf as the test stat Dks.
               clear ISI medISI meanISI N EDGES Hks ISIstim
            end    
        end
        ok = valid{ct};
        KLDout_NinAll{ct} = cat(1, KLDout_Nin{ct}{ok});
        KLDout_expAll{ct} = cat(1, KLDout_exp{ct}{ok});
        DksAll{ct} = cat(1, Dks{ct}{ok}); PksAll{ct} = cat(1, Pks{ct}{ok});
        
        KLDout_NinMean{ct} = mean(KLDout_NinAll{ct}); KLDout_NinSEM{ct} = std(KLDout_NinAll{ct})./sqrt(length(KLDout_NinAll{ct}));
        KLDout_expMean{ct} = mean(KLDout_expAll{ct}); KLDout_expSEM{ct} = std(KLDout_expAll{ct})./sqrt(length(KLDout_expAll{ct}));
        DksMean{ct} = mean(DksAll{ct}); DksSEM{ct} = std(DksAll{ct})./sqrt(length(DksAll{ct}));
        PksMean{ct} = mean(PksAll{ct}); PksSEM{ct} = std(PksAll{ct})./sqrt(length(PksAll{ct}));
        
        Celltype{ct} = ct.*ones(size(DksAll{ct})); %for boxplots and stats
        Xks{ct} = cat(2, ones(size(DksAll{ct})), DksAll{ct});
    end
    DksALL = cat(1, DksAll{:});
    KLDout_expALL = cat(1, KLDout_expAll{:});
    KLDout_NinALL = cat(1, KLDout_NinAll{:});
    CelltypesAll = cat(1,Celltype{:}); 
    
 %% Display
 
 cmap = [0,0.8, 0 ; 1,0, 0; 1,0.5, 0; 0,0.8, 0.8; 0.4,0.4, 0.4];  
 cmap2 = [0,0.4, 0 ; 0.5,0, 0; 0.7,0.2, 0];
 cmap3 = [0,0.5, 0.5; 0,0, 0];
 
 figure(10) % ISI of all recordings of a given celltype, normalized to their medians 

    LinEdges2 = linspace(0,50,1000); 
    % for all 10Hz poisson input sets combined (i.e. GCs, HMCs and FSs)
        medISIstim10 = median(ISIstimCat{1}); 
        ISI10 = ISIstimCat{1}./medISIstim10;
        Hstim10 = cdfplot(ISI10);
        set(Hstim10,'color', 'k'); hold on; box off; axis square
%       Hstim10 = histogram(ISI10, LinEdges2, 'Normalization', 'cdf', 'DisplayStyle', 'stairs');
%       set(Hstim10,'edgecolor', 'k'); hold on; 
    % for all 30Hz poisson input sets combined (i.e. GC+gzn and CA3+gzn)
        medISIstim30 = median(ISIstimCat{5}); 
        ISI30 = ISIstimCat{5}./medISIstim30; % for all 10Hz poisson input sets combined
        Hstim30 = cdfplot(ISI30);
        set(Hstim30,'color', 'b'); hold on; box off; axis square
    %   Hstim30 = histogram(ISI30, LinEdges2, 'Normalization', 'cdf', 'DisplayStyle', 'stairs');
%       set(Hstim30,'edgecolor', 'k'); hold on;

        for ct = 1:length(burstCT)     
            medISI = median(ISIoutALL{ct});
            ISI = ISIoutALL{ct}./medISI;
            Houtput(ct) = cdfplot(ISI); 
%           Houtput(ct) = histogram(ISI, LinEdges2, 'Normalization', 'cdf', 'DisplayStyle', 'stairs');
            set(Houtput(ct),'color', cmap(ct,:)); hold on; clear ISI;  box off; axis square         
%             for n = 1:length(burstCT{ct})
%                 for i = 1:length(burstCT{ct}{n})
%                     medISI = median(ISIout{ct}{n}{i});
%                     ISI = ISIout{ct}{n}{i}./medISI;
%                     Houtput(n,i) = histogram(ISI, LinEdges, 'Normalization', 'cdf', 'DisplayStyle', 'stairs');
%                     set(Houtput(n,i),'edgecolor', cmap(ct,:)); hold on;
%                    clear ISI medISI
%                 end
%             end
        end
    legend('input 10Hz','input 30Hz', 'GC', 'FS', 'HMC', 'GC+gzn', 'CA3+gzn', 'Location', 'southeast');
    set(gca, 'ylim', [0 1], 'xlim', [0 10]); xlabel('ISI./median'); ylabel('cum freq');
    box off; axis square; grid off;
    title('ISI distributions in multiple celltypes')
    
    % Display of PDFs in logspace, to better visualize whether multimodal or not
%         LogEdges = logspace(0,4, 500);
    %  ct = 1;     
%         Hstim(ct) = histogram(ISIstimCat{ct}, LogEdges, 'Normalization', 'pdf', 'DisplayStyle', 'stairs');
%         set(gca, 'XScale', 'log'); set(Hstim(ct),'edgecolor', 'k'); hold on;

figure(11) % Kullback-Liblier distances from Poisson Process for each recording set

subplot(1,2,1) % from perfect exponential distribution
            scatter(0.8 + 0.4.*rand(size(KLDout_expAll{1})), KLDout_expAll{1}, 50, 'o','MarkerFaceColor', [0,1, 0], 'MarkerEdgeColor', 'none', 'MarkerFaceAlpha', .5); hold on
            scatter(1.8 + 0.4.*rand(size(KLDout_expAll{2})), KLDout_expAll{2}, 50, 'd','MarkerFaceColor', [1,0, 0], 'MarkerEdgeColor', 'none', 'MarkerFaceAlpha', .5); hold on
            scatter(2.8 + 0.4.*rand(size(KLDout_expAll{3})), KLDout_expAll{3}, 50, '^','MarkerFaceColor', [1,0.5, 0], 'MarkerEdgeColor', 'none', 'MarkerFaceAlpha', .5); hold on
            scatter(3.8 + 0.4.*rand(size(KLDout_expAll{4})), KLDout_expAll{4}, 50, 's','MarkerFaceColor', [0,0.8, 0.8], 'MarkerEdgeColor', 'none', 'MarkerFaceAlpha', .5); hold on
            scatter(4.8 + 0.4.*rand(size(KLDout_expAll{5})), KLDout_expAll{5}, 50, 's','MarkerFaceColor', [0,0, 0], 'MarkerEdgeColor', 'none', 'MarkerFaceAlpha', .5); hold on
            %             boxplot(KLDout_expALL, CelltypesAll, 'boxstyle', 'outline', 'colors', cmap); hold on
            boxplot(KLDout_expALL, CelltypesAll, 'boxstyle', 'outline', 'colors', 'k', 'outliersize', eps); hold on
            [Pkl1,ANOVATABkl1,STATSkl1] = anova1(KLDout_expALL, CelltypesAll, 'off');
            [pk1,tblk1,statsk1] = kruskalwallis(KLDout_expALL, CelltypesAll, 'off');
%             [c,m,h,nms] = multcompare(STATSkl1);
            
%                 for ct = 1:length(burstCT)
%             errorbar(ct, KLDout_expMean{ct}, KLDout_expSEM{ct}, '+', 'color', 'k', 'markerfacecolor', 'k', 'LineWidth', 1.5) ; hold on 
%                 end
            axis square
            box off
            ylabel('K-L distance from exp');
            xlim([0 5.5]);
%             ylim([0 16])
            set(gca,'ysc', 'lin', 'XTick', [1:5], 'XTickLabel', {'GC', 'FS', 'HMC', 'GC+gzn', 'CA3+gzn'}) ; xtickangle(45);
            title('Kullback-Liebler divergence for each recording') 
            
subplot(1,2,2) % from input distrib
            scatter(0.8 + 0.4.*rand(size(KLDout_NinAll{1})), KLDout_NinAll{1}, 50, 'o','MarkerFaceColor', [0,1, 0], 'MarkerEdgeColor', 'none', 'MarkerFaceAlpha', .5); hold on
            scatter(1.8 + 0.4.*rand(size(KLDout_NinAll{2})), KLDout_NinAll{2}, 50, 'd','MarkerFaceColor', [1,0, 0], 'MarkerEdgeColor', 'none', 'MarkerFaceAlpha', .5); hold on
            scatter(2.8 + 0.4.*rand(size(KLDout_NinAll{3})), KLDout_NinAll{3}, 50, '^','MarkerFaceColor', [1,0.5, 0], 'MarkerEdgeColor', 'none', 'MarkerFaceAlpha', .5); hold on
            scatter(3.8 + 0.4.*rand(size(KLDout_NinAll{4})), KLDout_NinAll{4}, 50, 's','MarkerFaceColor', [0,0.8, 0.8], 'MarkerEdgeColor', 'none', 'MarkerFaceAlpha', .5); hold on
            scatter(4.8 + 0.4.*rand(size(KLDout_NinAll{5})), KLDout_NinAll{5}, 50, 's','MarkerFaceColor', [0,0, 0], 'MarkerEdgeColor', 'none', 'MarkerFaceAlpha', .5); hold on
            %             boxplot(KLDout_NinALL, CelltypesAll, 'boxstyle', 'outline', 'colors', cmap); hold on
            boxplot(KLDout_NinALL, CelltypesAll, 'boxstyle', 'outline', 'colors', 'k', 'outliersize', eps); hold on
            [Pkl2,ANOVATABkl2,STATSkl2] = anova1(KLDout_NinALL, CelltypesAll, 'off');
            [pk2,tblk2,statsk2] = kruskalwallis(KLDout_NinALL, CelltypesAll, 'off');
            [c,m,h,nms] = multcompare(STATSkl2, 'display', 'off');
            
%                 for ct = 1:length(burstCT)
%             errorbar(ct, KLDout_NinMean{ct}, KLDout_NinSEM{ct}, '+', 'color', 'k', 'markerfacecolor', 'k', 'LineWidth', 1.5) ; hold on 
%                 end
            axis square
            box off
            ylabel('K-L distance from input');
            xlim([0 5.5]);
%             ylim([0 16])
            set(gca,'ysc', 'lin', 'XTick', [1:5], 'XTickLabel', {'GC', 'FS', 'HMC', 'GC+gzn', 'CA3+gzn'}) ; xtickangle(45);
            title('Kullback-Liebler divergence for each recording') 

 
 