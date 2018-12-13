clear all
close all


resultspath = '/Users/antoine/Google Drive/LabReasearch/Projects/PatSepSingleGC/upto12-06-2016/Analysis';

% valid = [4, 5, 7, 8, 9, 11, 12];
valid = [1, 3:12];
% valid = 1:4
% valid = 1;

colord = lines(length(valid));
% xvals = [1.00, 0.975, 0.95, 0.87, 0.82, 0.75, 0.71, 0.59, 0.51, 0.5, 0.25, 0.05];
% xvals = [0.87, 0.82, 0.71, 0.59, 0.51, 0.05]; 

load('/Users/antoine/Google Drive/LabReasearch/Projects/PatSepSingleGC/upto12-06-2016/Analysis/10Hz/KreuzDistance/AllGC2010-2015/KreuzDistance.mat');

for n = 1:size(Cdata,1)
        
    x10ms1 = cat( 2, Cdata{n,:} );
    x10ms2(n) = mean( cat(1, x10ms1.Sim_StimMean)   );
    x10ms2sem = std( cat(1, x10ms1.Sim_StimMean) ) ./ sqrt(length(cat(1, x10ms1.Sim_StimMean)));
    x10ms3(n) = mean( cat(1, x10ms1.RespSimMeanBetween) );
    x10ms4(n) = std( cat(1, x10ms1.RespSimMeanBetween) ) ./ sqrt(length(cat(1, x10ms1.RespSimMeanBetween)));
    Within10ms{n} = cat(1, x10ms1.RespSimMeanWithin);
    x10ms5(n) = mean( cat(1, x10ms1.RespSimMeanWithin) );
    x10ms6(n) = std( cat(1, x10ms1.RespSimMeanWithin) ) ./ sqrt(length(cat(1, x10ms1.RespSimMeanWithin)));
    Between10ms{n} = cat(1, x10ms1.RespSimMeanBetween);
    Norm10ms(n) = mean(Between10ms{n}./Within10ms{n});
    errNorm10ms(n) = std( Between10ms{n}./Within10ms{n} ) ./ sqrt( length( Between10ms{n}./Within10ms{n} ) );    
     
end

Xstim = x10ms2; % measured input corr

for n=1:length(Xstim)
    xval2 = Xstim;
    X{n}= xval2(n).*ones(size(Between10ms{n}));
    W{n}= xval2(n).*ones(size(Within10ms{n}));
end

X2=cat(1,X{valid}); % abscisse of each data point, i.e corresponding measured stim corr. for Between corr
W2=cat(1,W{valid}); %idem for Within corr
Between10msCat=cat(1,Between10ms{valid}); %list of Between corr values, one for each file, ie each data point
Within10msCat=cat(1,Within10ms{valid}); %list of Within corr values, one for each file, ie each data point

%pool of within and between coor, to check if they are from same distrib
PoolX = cat(1,X2,W2);
PoolY = cat(1, Between10msCat, Within10msCat); 

% 2nd degree polynomial fitting using polyfit
[ESTbtw,S1] = polyfit(X2,Between10msCat,1);%ESTbtw contains the 3 parameters (coeffs) of the polynomial. S contains degrees of freedom S.df and the norm of residual sum of squares S.normr 
SSbtw = sum((Between10msCat - polyval(ESTbtw,X2)).^2); % residual sum of squares 
dfbtw = length(X2) - length(ESTbtw); % degrees of freedom = Number of data points - number of parameters

[ESTwth,S2] = polyfit(W2,Within10msCat,1);
SSwth = sum((Within10msCat - polyval(ESTwth,W2)).^2); 
dfwth = length(W2) - length(ESTwth);

[ESTpool,S3] = polyfit(PoolX,PoolY,1);
SSpool = sum((PoolY - polyval(ESTpool,PoolX)).^2); 
dfpool = length(PoolY) - length(ESTpool);

% F-test to assess significance of separate fittings versus pooled (combined data sets).
    
  % values from polyfit
    % SSsep = S1.normr.^2 + S2.normr.^2 ;
    % dfsep = S1.df + S2.df;
    % SSpool = S3.normr.^2;
    % dfpool = S3.df;
    
  % values computed independently of polyfit
SSsep = SSbtw + SSwth;
dfsep = dfbtw + dfwth;

Fstat_10ms = ((SSpool - SSsep)/(dfpool - dfsep))/(SSsep/dfsep);

df1 = dfpool-dfsep;
df2 = dfsep;
Pdes = 0.05;

% [F, pF, p] = Fdist(df1, df2, Fstat_10ms, Pdes, 1); %also plots a figure giving Fstat and p_value

%% Display
% figure(1)
% title('F-Test, Within Similarity (Kreuz) vs Between Sim distribution')
% grid off

% cd(resultspath)
% print('Ftest-WvsB.tif', '-dtiff', '-r150')
% print('Ftest-WvsB.ai', '-depsc')

figure(2)

Absc = 0:0.01:1;
grey=[0.5, 0.5, 0.5];
    
scatter(X2, Between10msCat, 25, 'r'); hold on
scatter(W2, Within10msCat, 25, 'g'); hold on
legend('Sim{B}', 'Sim{W}'); hold on
errorbar(Xstim(valid), x10ms3(valid), x10ms4(valid), 'o-', 'color', 'k', 'markerfacecolor', 'k') ; hold on
plot(Absc, polyval(ESTbtw,Absc),'r'); hold on
plot(Absc, polyval(ESTwth,Absc),'g'); hold on
plot( [0 1] , [0 1], 'k--')

box off
axis square
xlabel('Measured Input Similarity', 'fontsize', 14)
ylabel('Output Similarity', 'fontsize', 14)
set(gca, 'xlim', [0.7 1.1], 'ylim', [0.7 1.1])
title('Output Similarity versus Input Similarity')

cd(resultspath)
print('PolyFit_WvsB_zoom.tif', '-dtiff', '-r150')
print('PolyFit_WvsB_zoom.ai', '-depsc')