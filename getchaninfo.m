function chanStats = getchaninfo (EEG,showchannel)
% chanStats = getchaninfo (EEG,showchannel)
% Construct a structure with information about channels and electrodes of
% the EEGLAB structure EEG
% Structure fields (chanStats) : 
%   - nElectrodes       : number of electrodes
%   - nChannels         : number of channels
%   - channelNames      : list of channel names
%   - electrodeNames    : list of electrode names
%   - electrodeInd      : list of channel position belonging to each
%                         electrode
%
% Author(s) : Martin Deudon (2016)

%== structure fields
nElectrodes     = 0;
nChannels       = length(EEG.chanlocs);
channelNames    = cell(nChannels,1);
electrodeNames  = {};
electrodeInd    = {};
%===================
inc             = 0;
for i=1:nChannels
    chanName           = EEG.chanlocs(i).labels;
    chanName           = strtrim(chanName);
	channelNames{i}    = chanName;
    % Remove the EEG part in the name
    if strcmpi(chanName(1:3),'EEG')
        chanName = chanName(4:end);
    end
    % Get the electrode name from the channel name
    elecName   = regexp (chanName,'[a-zA-Z'']*','match','once');
    % If it's a new electrode name add it to the list
    inc                             = inc+1;
    if sum(strcmp(elecName,electrodeNames)) == 0
        nElectrodes                     = nElectrodes+1;
        electrodeNames{nElectrodes,1}  = elecName;
        if nElectrodes>1
            electrodeInd{nElectrodes-1,1} = i-inc:i-1;
        end
        inc = 0;
    end
end
electrodeInd{nElectrodes}   = nChannels-inc:nChannels;
chanStats.nElectrodes       = nElectrodes;
chanStats.nChannels         = nChannels;
chanStats.electrodeNames    = electrodeNames;
chanStats.channelNames      = channelNames;
chanStats.electrodeInd      = electrodeInd;

if nargin==2 && showchannel
    for i=1:nChannels
        disp([num2str(i),' - ',channelNames{i}]);
    end
end

end