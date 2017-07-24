function [commonChannelNames] = getcommonchannelnames( ALLEEG )
% [commonChannelNames] = GETCOMMONCHANNELNAMES (ALLEEG)
% Find the common channels between several EEGLAB sets. 
%
% Author(s) : Martin Deudon (2016)

commonChannelNames = {};

nDatasets = length(ALLEEG);
if nDatasets==1
    warning('Only one dataset');
    commonChannelNames = {ALLEEG.chanlocs.labels};
else
    j=1;
    while isempty(ALLEEG(j))
        j=j+1;
    end
    commonChannelNames = {ALLEEG(j).chanlocs.labels};
    for i=j+1:nDatasets
        commonChannelNames = intersect(commonChannelNames,{ALLEEG(i).chanlocs.labels});
        disp({ALLEEG(i).chanlocs.labels});
    end
end


end

