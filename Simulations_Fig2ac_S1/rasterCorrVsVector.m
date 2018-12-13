function [ Struct ] = rasterCorrVsVector( Atimes, Btimes, spikecount )
%rasterCorrVsVector plots rasters of 2 spiketrains A and B,
%which are vector rows, containing the spiketimes, and S the spikecounts in predetermined bins.
%It also plots the Correlation diagram and
%the 2 vectors with associated angle and scaling factor.

% example
% A = [200 400 600]
% B = [80 120 280 320 480 520]
% spikecount = [0 1 0 1 0 1; 2 0 2 0 2 0]

L = size(spikecount,2);
Sa = length(Atimes);
Sb = length(Btimes);
A = spikecount(1,:);
B = spikecount(2,:);
bins = 100:100:L*100; %arbitrary time units
binedges = [bins-50 bins+50]; %bins of 100 a.u.

R = corrcoef(A', B');
R = R(1,2); 
NDP = dot(A,B)/(norm(A)*norm(B));
Theta = real(acosd(NDP));
rad = real(acos(NDP));



if norm(A)>=norm(B)
SF = norm(B)./norm(A);
elseif norm(A)<norm(B)
SF = norm(A)./norm(B);
else
SF = 1;
end

P = polyfit(A,B,1);
x = [-1:0.1:3];
y = polyval(P,x);

Struct.R = R;
Struct.NDP = NDP;
Struct.theta = Theta;
Struct.SF = SF;
Struct.normA = norm(A);
Struct.normB = norm(B);

figure
% rasters
subplot(1,3,1)
clear n
    for n=1:Sa
    plot([Atimes(n) Atimes(n)], [1.5 2.5], 'k-', 'linewidth', 2); hold on
    end
    for m=1:Sb
    plot([Btimes(m) Btimes(m)], [0 1], 'k-', 'linewidth', 2); hold on
    end
    for l=1:L*2
    plot([binedges(l) binedges(l)], [-0.5 2.5], 'k--', 'linewidth', 1);hold on 
    end
    plot([0 700], [0 0], 'k-', 'linewidth', 2); hold on
    plot([0 700], [1.5 1.5], 'k-', 'linewidth', 2);
    text(700, 0.5, 'B');
    text(700, 2, 'A');
        axis square
    xlabel('time, a.u.')
    ylim([-0.5 2.5]);
    xlim([0 750]);

    axis off
    
% correlation
subplot(1,3,2)
    
    jitA=A+randn(size(A))./20;
    jitB=B+randn(size(B))./20;
    scatter(jitA, jitB, 'ko'); hold on
    plot(x, y, 'r-')
    title({'R = ' num2str(R)});
    axis square
    grid on
%     grid off
    xlim([-1,max(A)+0.5])
    ylim([-1, max(B)+0.5])
    xlabel('A: number of spikes for each bin')
    ylabel('B: number of spikes for each bin')
    
% vector analysis and representation
subplot(1,3,3)
if norm(A)<norm(B)
    [X,Y] = pol2cart(rad,norm(B));
    plot([0 X], [0 Y], 'b', 'linewidth', 2); hold on % draw line symbolizing vector A, of same norm with an agnle theta with the x-axis, on which vector B will be.
    plot([0 norm(A)], [0 0], 'g', 'linewidth', 2);hold on
    legend('B','A','location', 'Best')
else
    [X,Y] = pol2cart(rad,norm(A));
    plot([0 X], [0 Y], 'b', 'linewidth', 2); hold on % draw line symbolizing vector A, of same norm with an agnle theta with the x-axis, on which vector B will be.
    plot([0 norm(B)], [0 0], 'g', 'linewidth', 2);hold on
    legend('A','B','location', 'Best')
end
    
    ylim([-0.5 Y+0.5])
    xlim([min(0,X)-0.5 max([Y, norm(A), norm(B)])+0.5])
    
%     % plot arc between 2 vectors
%      n = 1000; % The number of points in the arc
%      va = [X,Y];
%      vb = [1,0];
%      c = det([va',vb']); % "cross product" of v1 and v2
%      a = linspace(0,atan2(abs(c),dot(va,vb)),n); % Angle range
%      v3 = [0,-c;c,0]*va; % v3 lies in plane of v1 and v2 and is orthog. to v1
%      v = va*cos(a)+((norm(va)/norm(v3))*v3)*sin(a); % Arc, center at (0,0)
%      plot(v(1,:),v(2,:),'b.') % Plot arc, centered at P0
%      axis equal
     
     axis square
%      axis off
     grid off
     title({'Theta= ' num2str(Theta) ' NDP= ' num2str(NDP) ' SF= ' num2str(SF)});
    
    
    
    


end

