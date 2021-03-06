function [F, pF, p] = Ftest_Antoine(df1, df2, Fstat, Pdes, displayflag)

% F Distribution and significance test.
% 
% [F, pF, p] = Fdist(df1, df2, Fstat, Pdes)
% 
% The F distribution (for x > 0) has density function (for v = 1, 2, ...;  w = 1, 2, ...): 
% 
% pF = [G((v+w)/2) .* (v./w).^(v./2).*F.^(v./2-1)] ./ [G(v./2).*G(w./2).*(1+(v./w).*F).^((v+w)./2)]
% 
% for all 
% 0 < F < inf
% v = 1, 2, ..., �� 
% w = 1, 2, ... 
% 
% F is a vector of values for the F statistic 
% (which value is obtained experimentally depends on specific type of analysis being done)
% pF is the probability of achieving each F, depending on df1 (i.e., df_numerator on F-Table) and df2 (df_denominator in F-table) (i.e., v and w)
% p is the probability of achieving the observed F (i.e., the P-Value, e.g., significant if p<=0.05)
% v, w  are the degrees of freedom
% G (gamma) is the Gamma function. 
% Fstat	  the computed F-statistic provided by experiment
% Pdes    the desired significance level for a ONE-TAILED F-test  (e.g., p ? 0.05)
% 
% refs: 
% http://www.itl.nist.gov/div898/handbook/eda/section3/eda366.htm
% http://www.itl.nist.gov/div898/handbook/eda/section3/eda3665.htm
% 
% Matt Jones 2005
% 
% WARNING: implementing this formula directly (as is done in
% "Fdist" and "Fdist_display") is problematic in Matlab because the gamma
% function yields very high values quickly and for v > 171, gamma(v) = inf
% in Matlab because it goes above the realmax (maximum floating point value
% handled by matlab). A way to go around this is to write the F
% distribution using gammaln (the logarithm of the gamma function) instead
% of gamma, because it grows a ot more slowly and doesn't overflow as quickly. 
% 
% Matlab has also its own tools to plot the pdf and cdf of the F
% distrib. Which I use here. 
%
% Antoine Madar October 2017


% To compute the whole 3D field of all F's for all x, v and w:
% dummy data
% xx = 0 : 0.01 : 5;
% vv = 1:10;
% ww = 1:10;
% 
% [x,v,w] = ndgrid(xx, vv, ww);
% F = [gamma((v+w)./2) .* (v./w).^(v./2).*x.^(v./2-1)] ./ [gamma(v./2).*gamma(w./2).*(1+(v./w).*x).^((v+w)./2)];
% plot a cross-section at a specific pair of df's
% plot(xx, squeeze( F(:, 5, 5) ), 'o-'); zoom on; grid on


% To compute one F-distribution at a time, for a range of x, and one v and one w

% dummy data:
% df1 	= 172;
% df2 	= 10;
% Pdes	= 0.05;
% Fstat	= 3;

v 		= df1;
w 		= df2;
F = 0 : 0.01 : 1000;

pF = fpdf(F, v, w);
cF = fcdf(F,v,w);
dummycF = cF + 1e-12.*[1:length(cF)]; % Add a shallow ramp to make things monotonic. Otherwise, problems using interp1

Fcrit 	= interp1(dummycF, F, [1-Pdes]);
p		= 1-interp1(F, dummycF, Fstat);
tail 	= find( F >= Fcrit );


if displayflag == 1

plot(F,  pF , '-'); zoom on; grid on; hold on
plot(F,  cF , 'r-'); 
b = bar(F(tail:end),  pF(tail:end), 1, 'r'); set(b, 'edgecolor', 'none')
xlim([0 10])
xlabel('F-value', 'fontname', 'times', 'fontsize', 18)
ylabel('Probability Density', 'fontname', 'times', 'fontsize', 18)

text( 10/2, 0.7, ['P_{des} = ' num2str(Pdes)], 'fontname', 'times', 'fontsize', 18)
text( 10/2, 0.6, ['F_{crit} = ' num2str(Fcrit)], 'fontname', 'times', 'fontsize', 18)
text( 10/2, 0.5, ['F_{stat} = ' num2str(Fstat)], 'fontname', 'times', 'fontsize', 18)

if p > 0.01
    text( 10/2, 0.3, ['P < ' num2str(p)], 'fontname', 'times', 'fontsize', 18)
else
    text( 10/2, 0.3, ['P < 0.01' ], 'fontname', 'times', 'fontsize', 18)
end

if Fstat > Fcrit
	text( 10/2, 0.4, ['F_{stat} > F_{crit} '], 'fontname', 'times', 'fontsize', 18)
	text( 10/2, 0.2, ['result IS significant'], 'fontname', 'times', 'fontsize', 18, 'color', 'g')
else
	text( 10/2, 0.4, ['F_{stat} > F_{crit} '], 'fontname', 'times', 'fontsize', 18)
	text( 10/2, 0.2, ['result is NOT significant'], 'fontname', 'times', 'fontsize', 18, 'color', 'r')

end
end