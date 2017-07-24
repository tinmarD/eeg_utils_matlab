function [EEGout] = removeduplicatechannels(EEGin)
% [EEGout] = REMOVEDUPLICATECHANNELS(EEG_in)
% Look for channels with the same name, and if some are found, compare the
% data of these 2 channels. If the data is the same, the 2nd channels is
% removed from the EEGLAB structure.
%
% See also : removenoeegchannels, mvpa_preprocessing
%
% Author(s) : Martin Deudon (2016)

disp('Removing duplicate channels');

EEGout = EEGin;

chan_names      = arrayfun (@(x)(x.labels),EEGin.chanlocs,'UniformOutput',false);

[chan_unique, ia, ~]    = unique (chan_names);
% If found a duplicate channel
if length(chan_unique) ~= length(chan_names)
    duplicate_ind  	= setdiff (1:length(chan_names),ia);
    for i=1:length(duplicate_ind)
        same_channels   = arrayfun (@(x)(strcmp(x,chan_names(duplicate_ind(i)))),chan_names);
        same_channels   = same_channels(:).';
        same_channels   = nonzeros (same_channels.*(1:length(same_channels)));
        disp (['Channels ',num2str(same_channels'),' have the same label: ',EEGin.chanlocs(same_channels(1)).labels]);
        % Look if they have the same data
        chan_data_diff  = sum (EEGin.data(same_channels(1),:) - EEGin.data(same_channels(2),:));
        if chan_data_diff == 0
             disp (['Channels ',num2str(same_channels'),' have the same data.']);
             disp (['Removing channel ', num2str(same_channels(2))]);
             EEGin.chanlocs(same_channels(2)).labels = 'toBe_deletEd';
             EEGout = pop_select (EEGin, 'nochannel', same_channels(2));
        end
    end
end

