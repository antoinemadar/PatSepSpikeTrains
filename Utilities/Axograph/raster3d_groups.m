function figh = raster3d_groups(S, time, datagroups, group);

%     figh = meshgroups(S, time, datagroups, group);
% 
% Create Raster of AxoGraph data, grouped by unique column titles.
% FIGH is handle of the figure generated.
% S must be a struct generated by passing an AxoGraph file to read_axograph().
%     S must contain exactly one (1) time column, denoted by the field S.timeGroup
%     (i.e., sum(S.timeGroup) must equal 1)
% TIME, DATAGROUPS and GROUP must have been generated by calling group_axograph(S), e.g.:
%     [time, datagroups, group] = group_axograph(S);
% TIME is a double array containing time sample points (units = sec).
% DATAGROUPS is a double array of indices into the original struct field S.groupNames.
% GROUP is a cell array containing the sweeps organized by "groups" (i.e., each unique column name is a separate group).
% 
% Matt Jones, 2007


% Plot each group in a separate subplot, with the same labels as AxoGraph etc:



figh = figure('units', 'cent', 'pos', [2 10 20 20], 'color', 'w');
colord = hsv(length(group{1}(1,:)));
colormap(colord)
for groupnum = 1:length(group)
    subplot( length(group), 1, groupnum, 'Fontname', 'times', 'fontsize', 14)
        set(gca, 'ydir', 'reverse', 'nextplot', 'replacechildren', 'colororder', colord)
        hold on;         
    
        mdata   = group{groupnum}(:,:);
        mtime   = repmat(time, 1, size(mdata, 2));
        msweep  = repmat(1:size(mdata, 2), size(mdata, 1), 1);

        plot3(mtime, msweep, mdata)
        view(3)

        title( ['GROUP #' num2str(groupnum)] , 'Fontname', 'times', 'fontsize', 18 )
        xlabel( S.groupNames( S.timeGroup ), 'Fontname', 'times', 'fontsize', 18 )
        ylabel( 'Sweep #', 'Fontname', 'times', 'fontsize', 18 )
        zlabel( S.groupNames( datagroups(groupnum) ) , 'Fontname', 'times', 'fontsize', 18 )   
        box off; zoom on
end






