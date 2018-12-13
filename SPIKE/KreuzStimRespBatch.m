
clear
close all
clc

resultspath = '/Users/antoine/Google Drive/LabReasearch/Projects/PatSepSingleGC/upto12-06-2016/Analysis'
cd(resultspath)

PatSepFileListAllGC_2010toDec2015

sttime1 = cputime; 
 for catnum = 1:length(Files.Stim.File)
%  for catnum = 12
    PARAMS.stimfilespec = Files.Stim.File{catnum};
       for itemnum = 1:length(Files.Resp.File{catnum}(:))
%     for itemnum = 3
        PARAMS.datafilespec = Files.Resp.File{catnum}{itemnum};
            sttime2 = cputime;
            disp('********************************')
            Cdata{catnum, itemnum} = KreuzStimResp( PARAMS );
            endtime2 = cputime;
            disp([catnum itemnum])
            disp( [ 'Time to do correlations = ' num2str(endtime2-sttime2)] )
            disp('********************************')
    end
end
endtime1 = cputime;
disp( [ 'Time to do ALL correlations = ' num2str(endtime1-sttime1)] )


cd(resultspath)
outname = ['KreuzDistance.mat']; 
save( outname )