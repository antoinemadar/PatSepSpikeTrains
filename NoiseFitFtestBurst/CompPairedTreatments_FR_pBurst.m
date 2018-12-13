% Compare Burst occurence and Reliability between celltypes or treatments
% it uses aggregated spiking characteristics from a collate struct computed with FSINcharacteristics.m
clear 
close all

dotsize = 50;

%Control dataset (GC before gzn)
load('/Users/antoine/Google Drive/LabReasearch/Projects/PatSepSingleGC/upto12-06-2016/Analysis/10Hz/CorrBetween/spikecount2matrix/Gabazine/Before/SpikeCharacteristics_BeforeGzin.mat');
clear resultspath n i
valid = 1;

for n = 1:length(collate) % catnum = Rin
    ALL = cat(1, collate{n}{:}); 
    FiringRateD{n} = cat(1, ALL.FiringRate);
    MaxNumD{n} = cat(1, ALL.MaxNum);
    MeanNumD{n} = cat(1, ALL.CountOutInterAverage); % mean number of spike for each recording (zeros included)
    ReliabAll{n} = cat(1, ALL.Reliab);
    COIA{n} = cat(1, ALL.CountOutInter);
    IIIA{n} = cat(1, ALL.IIIVect);
    IIIpreA{n} = cat(1, ALL.IIIpreVect);
%     X{n} = xvals(n).*ones(size(FiringRateD{n}));
    
    for i = 1:length(collate{n})
    Dummy = collate{n}{i}.CountOutInter;    
    MeanCountNoZeros{n}(i,1) = mean(Dummy(Dummy>0)); %mean number of spikes after an input, when there's at least one after an input
    probaBurst{n}(i,1) = sum(Dummy>1)./length(Dummy);% proba of firing more than once between 2 inputs for each recording
    Dum{n}(i,1) = mean(Dummy(Dummy>1));%mean count just for bursts, i.e. when more than 1 spike btw 2 inputs
    end
    MeanCountBurst{n} = Dum{n}(~isnan(Dum{n})); %to exclude NaNs due to zero bursting detected
end

%contains values for each inter-input interval of all recordings
CountOutInterAllCat = cat(1,COIA{valid});
CountNoZerosAll = CountOutInterAllCat(CountOutInterAllCat>0);
IIIcat = cat(1,IIIA{valid});
IIIprecat  = cat(1,IIIpreA{valid});
IIIcatForBurst = IIIcat(CountOutInterAllCat>1);
IIIprecatForBurst = IIIprecat(CountOutInterAllCat>1);

IIIburstMean = mean(IIIcatForBurst); 
IIIburstSEM = std(IIIcatForBurst)./sqrt(length(IIIcatForBurst));

IIIpreBurstMean = mean(IIIprecatForBurst);
IIIpreBurstSEM = std(IIIcatForBurst)./sqrt(length(IIIcatForBurst));
IIIpreBurstMedian = median(IIIprecatForBurst);

% contains a single value for each recording
FiringRateCat = cat(1,FiringRateD{valid});
ReliabCat = cat(1,ReliabAll{valid});
MeanCountNoZerosCat = cat(1, MeanCountNoZeros{valid}); %mean number of spikes after input, excluding times when there was no spikes (i.e excluding zeros)
MeanNumDCat = cat(1,MeanNumD{valid}); %mean number of spikes after input, including zeros (when no spikes) 
MaxNumDCat = cat(1, MaxNumD{valid});
MeanCountBurstCat = cat(1, MeanCountBurst{valid});
ProbaBurstCat = cat(1,probaBurst{valid});


FRmean = mean(FiringRateCat);
FRsem = std(FiringRateCat)./sqrt(length(FiringRateCat));

RelMean = mean(ReliabCat);
RelSEM = std(ReliabCat)./sqrt(length(ReliabCat));

MeanCNZ = mean(MeanCountNoZerosCat);
CNZsem = std(MeanCountNoZerosCat)./sqrt(length(MeanCountNoZerosCat));

MeanMN = mean(MeanNumDCat);
MNsem = std(MeanNumDCat)./sqrt(length(MeanNumDCat));

MeanCB = mean(MeanCountBurstCat);
CBsem = std(MeanCountBurstCat)./sqrt(length(MeanCountBurstCat));

MeanMX = mean(MaxNumDCat);
MXsem = std(MaxNumDCat)./sqrt(length(MaxNumDCat));

pBurstMean = mean(ProbaBurstCat);
pBurstSEM = std(ProbaBurstCat)./sqrt(length(ProbaBurstCat));

clear n i collate

%% datasets to compare to Ctrl
load('/Users/antoine/Google Drive/LabReasearch/Projects/PatSepSingleGC/upto12-06-2016/Analysis/10Hz/CorrBetween/spikecount2matrix/Gabazine/After/pairedwith before Gzine/SpikeCharacteristics_AfterGzin.mat');

valid = 1; % write in matrix appropriately to match data

for n = 1:length(collate) % catnum = Rin
    ALLKA = cat(1, collate{n}{:}); 
    FiringRateKA{n} = cat(1, ALLKA.FiringRate);
    MaxNumKA{n} = cat(1, ALLKA.MaxNum);
    MeanNumKA{n} = cat(1, ALLKA.CountOutInterAverage); % mean count with zeros and ones included
    ReliabAllKA{n} = cat(1, ALLKA.Reliab);
    COIAKA{n} = cat(1, ALLKA.CountOutInter);
    IIIAKA{n} = cat(1, ALLKA.IIIVect);
    IIIpreAKA{n} = cat(1, ALLKA.IIIpreVect);
%     XKA{n} = xvals(n).*ones(size(FiringRateDKA{n}));
    
    for i = 1:length(collate{n})
    DummyKA = collate{n}{i}.CountOutInter;    
    MeanCountNoZerosKA{n}(i,1) = mean(DummyKA(DummyKA>0)); %mean number of spikes after an input, when there's at least one after an input
    DumKA{n}(i,1) = mean(DummyKA(DummyKA>1)); %mean count justnfor bursts, i.e. when more than 1 spike btw 2 inputs
    probaBurstKA{n}(i,1) = sum(DummyKA>1)./length(DummyKA);% proba of firing more than once between 2 inputs for each recording
    end
    MeanCountBurstKA{n} = DumKA{n}(~isnan(DumKA{n})); %to exclude NaNs due to zero bursting detected
end

%contains values for each inter-input interval of all recordings
CountOutInterAllKACat = cat(1,COIAKA{valid});
IIIKAcat = cat(1,IIIAKA{valid});
IIIpreKAcat  = cat(1,IIIpreAKA{valid});
IIIcatForBurstKA = IIIKAcat(CountOutInterAllKACat>1);
IIIprecatForBurstKA = IIIpreKAcat(CountOutInterAllKACat>1);

IIIburstMeanKA = mean(IIIcatForBurstKA); 
IIIburstSEMKA = std(IIIcatForBurstKA)./sqrt(length(IIIcatForBurstKA));

IIIpreBurstMeanKA = mean(IIIprecatForBurstKA);
IIIpreBurstSEMKA = std(IIIcatForBurstKA)./sqrt(length(IIIcatForBurstKA));
IIIpreBurstMedianKA = median(IIIprecatForBurstKA);

% contains a single value for each recording
FiringRateKACat = cat(1,FiringRateKA{valid});
ReliabKACat = cat(1,ReliabAllKA{valid});
MeanCountNoZerosKACat = cat(1, MeanCountNoZerosKA{valid});
MeanNumKACat = cat(1,MeanNumKA{valid});
ProbaBurstKACat = cat(1,probaBurstKA{valid});
MeanCountBurstKACat = cat(1, MeanCountBurstKA{valid});
MaxNumKACat = cat(1, MaxNumKA{valid});

FRmeanKA = mean(FiringRateKACat);
FRsemKA = std(FiringRateKACat)./sqrt(length(FiringRateKACat));

RelKAMean = mean(ReliabKACat);
RelKASEM = std(ReliabKACat)./sqrt(length(ReliabKACat));

MeanKACNZ = mean(MeanCountNoZerosKACat);
CNZKAsem = std(MeanCountNoZerosKACat)./sqrt(length(MeanCountNoZerosKACat));

MeanKAMN = mean(MeanNumKACat);
MNKAsem = std(MeanNumKACat)./sqrt(length(MeanNumKACat));

pBurstMeanKA = mean(ProbaBurstKACat);
pBurstKASEM = std(ProbaBurstKACat)./sqrt(length(ProbaBurstKACat));

MeanKACB = mean(MeanCountBurstKACat);
CBKAsem = std(MeanCountBurstKACat)./sqrt(length(MeanCountBurstKACat));

MeanKAMX = mean(MaxNumKACat);
MXKAsem = std(MaxNumKACat)./sqrt(length(MaxNumKACat));

clear collate n i

%% Stats

%normality test
[hFRn, pFRn] = kstest((FiringRateCat-mean(FiringRateCat))./std(FiringRateCat)); %
[hFRKAn, pFRKAn] = kstest((FiringRateKACat-mean(FiringRateKACat))./std(FiringRateKACat)); %

[hPBurstn, pPBurstn] = kstest((ProbaBurstCat-mean(ProbaBurstCat))./std(ProbaBurstCat));
[hPBurstKAn, pPBurstKAn] = kstest((ProbaBurstKACat-mean(ProbaBurstKACat))./std(ProbaBurstKACat));

% %paired ttest (for Gzin exp)
[Hpf, Ppf, CIpf, STATpf] = ttest(FiringRateKACat - FiringRateCat);
[Hpb, Ppb, CIpb, STATpb] = ttest(ProbaBurstKACat - ProbaBurstCat);

% % paired non-parametric: wilcoxon sign-rank test
[Pupf, Hupf, STATupf] = signrank(FiringRateKACat - FiringRateCat);
[Pupb, Hupb, STATupb] = signrank(ProbaBurstKACat - ProbaBurstCat);

%% Display

figure(1) % p(bursting) for Gzine: paired tests
colord = repmat([0.5, 0.5, 0.5],length(ProbaBurstCat),1); %grey
colormap(colord);

subplot(1,2,1)
for n = 1:length(ProbaBurstCat)
  plot(1:2, [FiringRateCat(n), FiringRateKACat(n)], 'Color', colord(n,:)); hold on
end
  text(1,-0.1,'before Gzin');
  text(2,-0.1,'after Gzin')
errorbar(1:2, [FRmean FRmeanKA], [FRsem FRsemKA], 'o', 'color', 'k', 'markerfacecolor', 'k') ; hold on 
title({['paired t-test p = ' num2str(Ppf) ' ; w-signrank p = ' num2str(Pupf)]});
axis square
box off
ylabel('Firing Rate (Hz)');
xlim([0.5 2.5]);
ylim([0 10]);

subplot(1,2,2)
for n = 1:length(ProbaBurstCat)
  plot(1:2, [ProbaBurstCat(n), ProbaBurstKACat(n)], 'Color', colord(n,:)); hold on
end
  text(1,-0.1,'before Gzin');
  text(2,-0.1,'after Gzin')
errorbar(1:2, [pBurstMean pBurstMeanKA], [pBurstSEM pBurstKASEM], 'o', 'color', 'k', 'markerfacecolor', 'k') ; hold on 
title({['paired t-test p = ' num2str(Ppb) ' ; w-signrank p = ' num2str(Pupb)]});
axis square
box off
ylabel('p(Burst)');
xlim([0.5 2.5]);
ylim([0 0.2]);