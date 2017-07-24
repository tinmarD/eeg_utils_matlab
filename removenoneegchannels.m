function [EEG] = removenoneegchannels(EEG)
%EEG = REMOVENONEEGCHANNELS(EEG)
% Remove non-eeg channels based on the rule that eeg channels start with
% 'EEG' in their labels
% If no EEG channels is found, all the channels are kept
%
% See also : mvpa_preprocessing removeduplicatechannels
% 
% Author: Martin Deudon (2016)

disp('Removing non-eeg channels');
eegChannelInd = zeros(1,EEG.nbchan);
for i=1:EEG.nbchan
    eegChannelInd(i) = strcmpi(EEG.chanlocs(i).labels(1:3), 'EEG');
end
eegChannelPos = find(eegChannelInd);
if ~isempty(eegChannelPos)
    EEG     = pop_select (EEG,'channel',eegChannelPos);
else
    warning(['Could not find any EEG channels in the EEG structure. ',...
        'EEG channels should start with ''EEG''. Keep all the channels.']);
end

end

