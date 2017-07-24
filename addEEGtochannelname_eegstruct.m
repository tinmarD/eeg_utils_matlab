function [ EEGout ] = addEEGtochannelname_eegstruct( EEGin, eegchannelind )
% [ EEGout ] = addEEGtochannelname_eegstruct( EEGin, eegchannelind )
% Add EEG to the channel names specified in eegchannelind [binary vector 1
% if EEG channel 0 otherwise]
% [ EEGout ] = addEEGtochannelname_eegstruct( EEGin ) add EEG to all
% channels' name
%
% Author(s) : Martin Deudon (2016)

if nargin==1
    eegchannelind = ones(1,EEGin.nbchan);
end

nChan   = EEGin.nbchan;
EEGout  = EEGin;
for i=1:nChan
    if eegchannelind(i)==1
        EEGout.chanlocs(i).labels = ['EEG ',EEGout.chanlocs(i).labels];
    end
end

end

