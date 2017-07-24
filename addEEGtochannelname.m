% Take a .edf file as input, add 'EEG ' to each channel name except the
% last one (which is the trigger channel usually)
%
% Author(s) : Martin Deudon (2016)

%% Parameters
filePathIn      = 'C:\Users\deudon\Desktop\SABclean\_Data\009_LD\009_LD_EEG';
filenameIn      = 'SAB_REC_10_600ms.edf';
filePathOut     = 'C:\Users\deudon\Desktop\SABclean\_Data\009_LD\SAB_bipolaire';

%% Modify channel names except last one (trigger channel)
EEGin  = pop_biosig(fullfile(filePathIn,filenameIn));
EEGout = EEGin;

for i=1:EEGout.nbchan-1
    EEGout.chanlocs(i).labels = ['EEG ',EEGout.chanlocs(i).labels];
end

%% Display modifications
for i=1:EEGout.nbchan
    disp([EEGin.chanlocs(i).labels,' - ',EEGout.chanlocs(i).labels]);
end

%% Write output file as edf
if ~exist(filePathOut,'file')
    mkdir(filePathOut);
end
pop_writeeeg(EEGout,fullfile(filePathOut,filenameIn),'TYPE','EDF');

