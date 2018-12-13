function [ISI] = isi(times1)
% [ISI] = isi(times1)
%
% times1 is a cell array containing n time series (times1{1}, times1{2},
% ..., times1{n} each time serie is a vector column of the events times
% 
% ISI is a vector column containing all the inter-events-intervals from all
% the time series in the cell times1
%
% To plot a histogram of the ISI:
% histogram(ISI.*1000, 'BinLimits',[min(ISI.*1000),max(ISI.*1000)]); to get
% Xaxis in ms
%
% Antoine Madar, Nov. 2015           
 for n = 1:length(times1)
                for spike = 1:length(times1{n})-1
                t1 = times1{n}(spike);
                t2 = times1{n}(spike+1);
                ISIdum{n}(spike,1) = t2-t1;
                end
 end
 
 ISI = cat(1,ISIdum{:});