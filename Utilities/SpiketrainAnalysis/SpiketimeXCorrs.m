function [XCorr, lags] = SpiketimeXCorrs( times1, times2, lags, displayflag);
    
% [XCorr, lags] = SpiketimeXCorrs( times1, times2, lags, displayflag);
% 
% Crosscorrelate two lists of spiketimes
% TIMES1 and TIMES2 are vectors of spiketimes
% LAGS is a vector of the binning intervals (e.g., [-100:100])
% DISPLAYFLAG is 1 or 0, 1 will display a graph of the crosscorrelation
% XCORR is a vector of the count of cross-occurrences (NOT the probability)
% - MJones 2009
% 
% example:
% 
% time    = 1:1000;
% delay   = 25;
% jitter  = 5;
% lags = -100:100;
% displayflag = 1;
% for trial = 1:10
%     times1  = sort( ceil( length(time).*rand(0.05.*length(time), 1) ) );
%     times2  = times1 + ceil(jitter.*randn(size(times1)) + delay);
%     rast1   = zeros(length(time));
%     rast2   = zeros(length(time));
%     rast1(times1)   = 1;
%     rast2(times2)   = 1;
%     [XCorr{trial}, lags] = SpiketimeXCorrs( times1, times2, lags, displayflag);
%         subplot(3, 1, 1); 
%             plot(time, rast1, 'b-')
%         subplot(3, 1, 2); 
%             plot(time, rast2, 'r-')    
%         subplot(3, 1, 3); 
%             bar(lags, XCorr{trial}, 'k') 
%             xlabel('lags'); ylabel('Mean XCorr')
%         drawnow
%         pause(1)
%         delete(gcf)
% end
% MeanXCorr = mean( cat(2, XCorr{:}), 2);
% guess = [10, 50, 10, 1];
% guess = fminsearch('fit_gauss_w_offset', guess, [], lags(:), MeanXCorr(:), displayflag);
% [mu sig amp base] = deal(  guess(1), guess(2), guess(3), guess(4) );    
% Est = amp.*exp(-(lags-mu).^2./sig.^2) + base;
%     subplot(3, 1, 1); 
%         plot(time, rast1, 'b-'); box off
%     subplot(3, 1, 2); 
%         plot(time, rast2, 'r-'); box off
%     subplot(3, 1, 3); 
%         bar(lags, MeanXCorr, 'k'); hold on; box off
%         plot(lags, Est, 'r-', 'linewidth', 2)
%         text(0.5.*lags(end), max(Est), {['mean lag = ' num2str(mu, '%2.1f')]; ['spread = ' num2str(sig, '%2.2f')]; ['baseline = ' num2str(base, '%2.2f')]})
%         xlabel('lags'); ylabel('Mean XCorr')
%         set(gca, 'xlim', lags([1,end]))
        
        
        
        







XCorr = zeros(length(lags),1);
for spike = 1:length(times1)
    if mod(spike, 1000) == 0; disp([' - spike ', num2str(spike) ' of ' num2str(length(times1)) ]); end
    t1  = times1(spike);
    i2  = find( abs(times2-t1)<=max(lags) );
    t2  = times2(i2) - t1;
    C = hist(t2, lags);
    XCorr = XCorr + C(:);
end


% Remove lag zero for autocorrs 
% % (nice for display, but probably not a good idea) 
% if length(times1) == length(times2)
%     if all( times1 == times2 )
%         clip = find( lags == min( abs(lags) ) );
%         XCorr( clip ) = 0;
%     end
% end    


% XCorr = XCorr ./ (length(times1)+length(times2));

if displayflag
    figure
    bar( lags, XCorr , 'k' ); box off; hold on
    set(gca, 'xlim', max(lags).*[-1 1], 'fontname', 'times', 'fontsize', 10)
end