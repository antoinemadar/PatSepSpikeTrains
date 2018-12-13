function h = raster3d(z, varargin);

%     h = raster3d(z, varargin);
% 
% Make a 3d raster of the data in Z.
% Each column of Z should be a data vector (e.g., a sweep).
% Optionally specify the spacing of data points in the vector X.
% H is a handle to the axes object in which the raster is drawn. This will
% be the current axes, or if no axes exists one will be created in a new
% figure.
% The BLACK filled points are the mean across all sweeps, drawn at the
% front and back of the raster.
% 
% MJ 2007
% 
% example:
% [x, y, z] = peaks(20);
% x = 100.*x(1,:);
% figh = raster3d(z, x);


if isempty(varargin)
    x = 1:size(z, 1);
%     y = 1:size(z, 2);
%     colord = hsv( length(y) );
elseif length(varargin)==1
    x = varargin{1};
%     y = 1:size(z, 2);
%     colord = hsv( length(y) );
% elseif length(varargin)==2
%     x = varargin{1}; 
%     y = varargin{2};    
%     colord = hsv( length(y) );
% elseif length(varargin)==2
%     x = varargin{1}; 
%     y = varargin{2};   
%     colord = varargin{3};
end   
x = x(:);
y = 1:size(z, 2);
colord = hsv( length(y) );



h = gca;
set(h, 'ydir', 'reverse', 'nextplot', 'replacechildren', 'colororder', colord, 'fontname', 'times', 'fontsize', 14)
hold on;         
    mz          = z;
    mx          = repmat(x, 1, size(mz, 2));
    my          = repmat(y, size(mz, 1), 1);


plot3(mx, my, mz, '-')
view(3)

% plot3(x, 0.*x, mean(mz'), 'k-', 'linewidth', 2)
% plot3(x, 0.*x+max(y)+1, mean(mz'), 'k-', 'linewidth', 2)
set(gca, 'xlim', [min(x) max(x)], 'ylim', [0 max(y)+1])
hold off
grid on
% xlabel('Sweep #','fontname', 'times', 'fontsize', 14)
% ylabel('Time','fontname', 'times', 'fontsize', 14)
