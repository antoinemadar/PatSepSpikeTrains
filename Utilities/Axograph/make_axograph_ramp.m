% Make a ramp protocol for export to Axograph

dt = 1./20e3;
endtime = 3;        % sec
Time = [dt:dt:endtime];

Command = 0.*Time + -70e-3;

basedur = 500e-3;
hypdur1 = 300e-3;
depdur = 700e-3;
hypdur2 = 400e-3;


basepts = 1:round( basedur ./ dt);
hyp1pts  = basepts(end)+1 : basepts(end)+round(hypdur1./dt );
deppts  = hyp1pts(end)+1 : hyp1pts(end)+round(depdur./dt );
hyp2pts  = deppts(end)+1 : deppts(end)+round(hypdur2./dt );



Command(basepts) = -70e-3;
Command(hyp1pts) = linspace(-70e-3, -100e-3, length(hyp1pts));
Command(deppts) = linspace(-100e-3, -30e-3, length(deppts));
Command(hyp2pts) = linspace(-30e-3, -70e-3, length(hyp2pts));

plot(Time, Command)

data = [Time(:) Command(:)]; 
titles = {'Time, s', 'Command, V'};
writeascii( data, titles); % name Ramp.axgd and place wherever you want
