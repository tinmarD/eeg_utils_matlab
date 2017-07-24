function [ chan_ind ] = channelname2channelind (EEG, chan_name_list)
% [ chan_ind ] = channelname2channelind (EEG, chan_name_list)
%   ??? 
%
% Author(s) : Martin Deudon (2016)

chan_ind = zeros(1,length(chan_name_list));

% Remove the 'EEG' part in chan_name_list if any
for i=1:length(chan_name_list)
    pos = regexpi(chan_name_list{i},'EEG','end');
    if ~isempty(pos)
        chan_name_list {i} = chan_name_list{i}(pos+1:end);
    end
    if ~isempty (regexp (chan_name_list{i},'[^\w-'' ]','once'))
        warning (['Unexpected character found in channel name ',chan_name_list{i}]);
    end
end
% Remove the 'EEG' part in EEG.chan if any
EEG_channames = cell(1,length(EEG.chanlocs));
for i=1:length(EEG.chanlocs)
    pos = regexpi(EEG.chanlocs(i).labels,'EEG','end');
    if ~isempty(pos)
        EEG_channames {i} = EEG.chanlocs(i).labels(pos+1:end);
    else
        EEG_channames {i} = EEG.chanlocs(i).labels;
    end
    if ~isempty (regexp (EEG.chanlocs(i).labels,'[^\w-'' ]','once'))
        warning (['Unexpected character found in channel name ',num2str(i),EEG.chanlocs(i).labels]);
    end
end

% Remove spaces
channel_names = cellfun( @(x) cell2mat(regexp (x,'[^ ]*','match')), chan_name_list, 'UniformOutput',false);
EEG_channames = cellfun( @(x) cell2mat(regexp (x,'[^ ]*','match')), EEG_channames,  'UniformOutput',false);
for i=1:length(chan_name_list)
    index = nonzeros(strcmp(channel_names{i},EEG_channames).*(1:length(EEG_channames)));
    if isempty(index)
        warning (['Could not find the corresponding channel of ',channel_names{i},' in the EEGLAB structure']);
    else
        chan_ind(i) = index;
    end    
end

end

