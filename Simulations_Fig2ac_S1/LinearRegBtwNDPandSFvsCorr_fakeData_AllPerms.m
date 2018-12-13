clear
close all

% Create ensemble of rasters of 6 bins that can be 0, 1 or 2
V = [0 1 2];
N = 6; %number of bins for each fake spike raster 
Rast = permn(V, N); % matrix of all permutations (number of permutations with repetitions for 6 bins = 3^6 = 729)

% for choosing 2 rasters to compare at a time
VCOMB = 1:size(Rast,1); % indices for each rasters
Combi = nchoosek(VCOMB,2); %an array of 2 integers combination taken in a pool of size(Rast,2) integers. k columns (here = 2), nchoosek rows.

% inflate the firing rate but keep the spiketrain structure: for all bins i, Ai = k*Xi
K = [0 1 10 100]; %

for m = 1:length(K)
%    KRast{m} = K(m).*Rast;
     KRast{m} = Rast + K(m).*ones(size(Rast));
     KRast{m}(KRast{m}==K(m)) = 0; % to conserve the "spiking structure", i.e. the zeros. 
   
    % compute NDP, SF and Rb between all rasters
         
        for n = 1:size(Combi,1)
            rast1 = KRast{m}(Combi(n,1),:);
            rast2 = KRast{m}(Combi(n,2),:);
            
            fr1 = sum(rast1);
            fr2 = sum(rast2);
            geomFR(n,m) = sqrt(fr1*fr2); %geometric mean of the two "firing rates" (actually just the number of spikes)
            
            DP = dot(rast1,rast2);
            N1 = norm(rast1);
            N2 = norm(rast2);
            Norm = N1.*N2;
            NDP(n,m) = DP./Norm; % NB: if one of the vector is filled with zeros, the NDP will be a NaN.

            if N1>0 && N2>0 % both norms are non-zero
                if rast1 > rast2
                SF(n,m) = N2./N1;
                elseif rast1 < rast2
                SF(n,m) = N1./N2;
                else
                SF(n,m) = 1;    
                end
            elseif xor(N1==0,N2==0)==1 %either N1 or N2 is 0, but not both
                SF(n,m) = 0;
            elseif N1==0 && N2==0 % both norms are 0
                SF(n,m) = NaN;
            else
                SF(n,m) = 1.5;
            end

            R = corrcoef(rast1,rast2);   
            Rb(n,m) = R(1,2);
            clear rast1 rast2 DP N1 N2 Norm R
        end
end

figure(1)
    subplot(1,3,1) % Rb = f(NDP)
        scatter(NDP(:,1), Rb(:,1), 25, 'k'); hold on;
        plot([0 1], [0 1], 'r--'); hold on
            box off
            axis square
            xlabel('Output NDP', 'fontsize', 14)
            ylabel('Output Rb', 'fontsize', 14)
            set(gca, 'xlim', [0 1], 'ylim', [-1 1])
            title('Rb = f(NDP)')

    subplot(1,3,2) % Rb = f(SF)
        scatter(SF(:,1), Rb(:,1), 25, 'k'); hold on;
        plot([0 1], [0 1], 'r--'); hold on
            box off
            axis square
            xlabel('Output SF', 'fontsize', 14)
            ylabel('Output Rb', 'fontsize', 14)
            set(gca, 'xlim', [0 1], 'ylim', [-1 1])
            title('Rb = f(SF)')
    
    subplot(1,3,3) % NDP = f(SF)
        scatter(SF(:,1), NDP(:,1), 25, 'k'); hold on;
        plot([0 1], [0 1], 'r--'); hold on
            box off
            axis square
            xlabel('Output SF', 'fontsize', 14)
            ylabel('Output NDP', 'fontsize', 14)
            set(gca, 'xlim', [0 1], 'ylim', [0 1])
            title('NDP = f(SF)')
            
 figure(2) % impact of firing rate inflation on each metric
 
 map = brewermap(9,'Greys');
 
    subplot(1,3,1) % NDP
    scatter(NDP(:,1), NDP(:,4), 20, 'o', 'MarkerEdgeColor', 'none', 'MarkerFaceColor', map(9,:),  'MarkerFaceAlpha', .8); hold on;
    scatter(NDP(:,1), NDP(:,3), 20,'o', 'MarkerEdgeColor', 'none', 'MarkerFaceColor', map(6,:), 'MarkerFaceAlpha', .8); hold on;
    scatter(NDP(:,1), NDP(:,2), 20,'o', 'MarkerEdgeColor', 'none', 'MarkerFaceColor', map(3,:), 'MarkerFaceAlpha', .8); hold on;
    plot([0 1], [0 1], 'r--'); hold on
        xlabel('X NDP', 'fontsize', 14)
        ylabel('X+k NDP', 'fontsize', 14)
        set(gca, 'xlim', [0 1], 'ylim', [0 1])
        box off
        axis square
        
    subplot(1,3,2) % SF
    scatter(SF(:,1), SF(:,4), 20,'o', 'MarkerEdgeColor', 'none', 'MarkerFaceColor', map(9,:),  'MarkerFaceAlpha', .8); hold on;
    scatter(SF(:,1), SF(:,3), 20,'o', 'MarkerEdgeColor', 'none', 'MarkerFaceColor', map(6,:),  'MarkerFaceAlpha', .8); hold on;
    scatter(SF(:,1), SF(:,2), 20,'o', 'MarkerEdgeColor', 'none', 'MarkerFaceColor', map(3,:),  'MarkerFaceAlpha', .8); hold on;
    legend('+100', '+10', '+1','Location','best');
    plot([0 1], [0 1], 'r--'); hold on
        xlabel('X SF', 'fontsize', 14)
        ylabel('X+k SF', 'fontsize', 14)
        set(gca, 'xlim', [0 1], 'ylim', [0 1])
        box off
        axis square
    
    subplot(1,3,3) % SF
    scatter(Rb(:,1), Rb(:,4), 20,'o', 'MarkerEdgeColor', 'none', 'MarkerFaceColor', map(9,:),  'MarkerFaceAlpha', .8); hold on;
    scatter(Rb(:,1), Rb(:,3), 20,'o', 'MarkerEdgeColor', 'none', 'MarkerFaceColor', map(6,:),  'MarkerFaceAlpha', .8); hold on;
    scatter(Rb(:,1), Rb(:,2), 20,'o', 'MarkerEdgeColor', 'none', 'MarkerFaceColor', map(3,:),  'MarkerFaceAlpha', .8); hold on;
    plot([-1 1], [-1 1], 'r--'); hold on
        xlabel('X R', 'fontsize', 14)
        ylabel('X+k R', 'fontsize', 14)
        set(gca, 'xlim', [-1 1], 'ylim', [-1 1])
        box off
        axis square
   
%    cd('/Users/antoine/Google Drive/LabReasearch/Articles/MyArticles/3-Multiplexed codes/Revision 1');     
%    print('FRimpactOnMetrics_6bins_painters','-dpdf')
%    print('FRimpactOnMetrics_6bins_painters','-dsvg')
%         saveas(figure(2),'FRimpactOnMetrics_6bins_highres','pdf')
 figure(3)
    
     subplot(1,3,1) % NDP
    scatter([geomFR(:,1);geomFR(:,2);geomFR(:,3)],[NDP(:,1);NDP(:,2);NDP(:,3)], 25, 'k'); hold on;
        xlabel('geomFR', 'fontsize', 14)
        ylabel('NDP', 'fontsize', 14)
        set(gca, 'xlim', [0 50], 'ylim', [0 1])
        box off
        axis square
        
    subplot(1,3,2) % SF
    scatter([geomFR(:,1);geomFR(:,2);geomFR(:,3)],[SF(:,1);SF(:,2);SF(:,3)], 25, 'k'); hold on;
        xlabel('geomFR', 'fontsize', 14)
        ylabel('SF', 'fontsize', 14)
        set(gca, 'xlim', [0 50], 'ylim', [0 1])
        box off
        axis square
    
    subplot(1,3,3) % SF
    scatter([geomFR(:,1);geomFR(:,2);geomFR(:,3)],[Rb(:,1);Rb(:,2);Rb(:,3)], 25, 'k'); hold on;
        xlabel('geomFR', 'fontsize', 14)
        ylabel('R', 'fontsize', 14)
        set(gca, 'xlim', [0 50], 'ylim', [-1 1])
        box off
        axis square
 
 