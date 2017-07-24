function [badChannelsInd] = searchbadchannels ( EEGin )
%searchBadChannels looks for bad channels by computing the zscore of each
%channel standard deviation. A channel with a Zscore > ZSCORE_MAX is 
%considered bad.
%   badChannelsInd = SEARCHBADCHANNELS (EEG_IN)
%   Input   : EEGLAB structure 
%   Output  : Indices of detected bad channels
%
% Author(s) : Martin Deudon (2016)

ZSCORE_MAX = 2;

% Check that EEG_in has only one epoch (to modify)
if size(EEGin.data,3)~=1
    error ('In searchBadChannels(), EEG structure must have only 1 epoch');
end

% Get the number and indices of eeg channels
eegChanInd = zeros(EEGin.nbchan,1);
for i=1:EEGin.nbchan
    eegChanInd(i) = i*strcmp(EEGin.chanlocs(i).labels(1:3),'EEG');
end
eegChanInd 	= nonzeros(eegChanInd);
nEegChan 	= length(eegChanInd);

% Compute the mean and standard deviation (only for eeg channels)
channel_std     = zeros(nEegChan,1);
for i=1:nEegChan
    channel_std (i)     = std(EEGin.data(eegChanInd(i),:));
end
% mean_mean   = mean(channel_mean);
meanStd    = mean(channel_std);
stdStd     = std(channel_std);

% Compute Z-score 
channelStdScore  = abs(zeros(nEegChan,1));
for i=1:nEegChan
    channelStdScore(i) = (channel_std(i) - meanStd) / stdStd;
end

badChannelsInd = nonzeros(eegChanInd.*(channelStdScore>ZSCORE_MAX));

end

