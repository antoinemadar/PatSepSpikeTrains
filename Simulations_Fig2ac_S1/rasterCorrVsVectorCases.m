close all
clear all

% R=-1 NDP=1
Atimes = [200 400 600];
Btimes = [100 300 500]; % B = [80 120 280 320 480 520]
spikecount = [0 1 0 1 0 1; 1 0 1 0 1 0];
[ Struct ] = rasterCorrVsVector( Atimes, Btimes, spikecount );

% R=1 ie correlated, NDP=1 ie colinear, but not similar because SF=0.5, not 0
clear all
Atimes = [200 400 600];
Btimes = [180 220 380 420 580 620]; 
spikecount = [0 1 0 1 0 1; 0 2 0 2 0 2];
[ Struct ] = rasterCorrVsVector( Atimes, Btimes, spikecount );

% uncorrelated (R=0) but not orthogonal (theta<90degrees, NDP>0)
clear all
Atimes = [200 280 320 500 580 620]; 
Btimes = [100 200 300 380 420 480 520 580 620];
spikecount = [0 1 2 0 1 2; 1 1 1 2 2 2];
[ Struct ] = rasterCorrVsVector( Atimes, Btimes, spikecount );

% NDP=0 but R>-1
clear all
Atimes = [200 500 ]; 
Btimes = [280 320 380 420];
spikecount = [0 1 0 0 1 0; 0 0 2 2 0 0];
[ Struct ] = rasterCorrVsVector( Atimes, Btimes, spikecount );

% R<0 but NDP>0
clear all
Atimes = [100 200 500 ]; 
Btimes = [100 280 320 380 420];
spikecount = [1 1 0 0 1 0; 1 0 2 2 0 0];
[ Struct ] = rasterCorrVsVector( Atimes, Btimes, spikecount );

% different FR but very similar SF (and R=0)
clear all 
Atimes = [200 400 500 ]; 
Btimes = [200 300 400 500];
spikecount = [0 1 0 1 1 0; 0 1 1 0 1 1];
[ Struct ] = rasterCorrVsVector( Atimes, Btimes, spikecount );

% NDP = 1 (perfectly similar), same FR but dissimilar SF
clear all 
Atimes = [180 220 480 520 ]; 
Btimes = [200 475 500 525];
spikecount = [0 2 0 0 2 0; 0 1 0 0 3 0];
[ Struct ] = rasterCorrVsVector( Atimes, Btimes, spikecount );

% same FR, SF = 1, NDP < 1
clear all 
Atimes = [100 280 320 ]; 
Btimes = [80 120 300 ];
spikecount = [1 0 2 0; 2 0 1 0];
[ Struct ] = rasterCorrVsVector( Atimes, Btimes, spikecount );

% different FR, fire all in same bins but NDP < 1 => NDP cares about local
% firing also to some extent
clear all
Atimes = [200 400 600];
Btimes = [220 380 420 580 620]; 
spikecount = [0 1 0 1 0 1; 0 1 0 2 0 2];
[ Struct ] = rasterCorrVsVector( Atimes, Btimes, spikecount );

%
% clear all
% A = [200 400 500 ]; 
% B = [280 320 380 420];
% spikecount = [0 1 0 1 1 0; 0 0 2 2 0 0];
% [ Struct ] = rasterCorrVsVector( A, B, spikecount );
% 
% %
% clear all
% A = [80 120 300 480 520 600];
% B = [100 200 300 400 500 600]; 
% spikecount = [1 1 1 1 1 1; 2 0 1 0 2 1];
% [ Struct ] = rasterCorrVsVector( A, B, spikecount );