function  [time, data, dt, fs, numsweeps, S] = loadaxograph(filespec);

% Load and parse Axograph files
% 
% MJ 2009



if nargin < 1
    [filename, pathname] = uigetfile('*.*', 'Load an Axograph file:');
    filespec = [pathname, filename];
end    


% Call the function that reads the data (read_axograph()) and load all the data into variable S (of type STRUCT). 
% Look at Command Window to see the contents of STRUCT S
S = read_axograph(filespec)

% Load the time points from S.columnData{1} into their own array
time = S.columnData{1};

% Derive sampling freq
dt = mean(diff(time));
fs = 1./dt;

numsweeps = S.numColumns-1;

% Create a new array "DATA" to hold all the y-values, and pre-size it to be [# timepoints, # data sweeps ].
data = zeros(S.columnPts(2), numsweeps);

% Load each amplitude into the columns of a new array DATA
for n = 1:numsweeps
    data(:,n) = S.columnData{n+1};
end

% clear leftover graphics (e.g., waitbar usually)
drawnow
