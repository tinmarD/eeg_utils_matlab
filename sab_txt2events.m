

%% Parameters
filepathIn      = 'C:\Users\deudon\Desktop\SAB\_Data\001_CC\Eprime_txt\SAB_REC_2_500ms.txt';
imTimeCol       = 1;
rtTimeCol    	= 2;
respCol         = 4;
crespCol        = 5;
%
numHeaderLines  = 4;
sepIn           = char(9); % tab: char(9)
sepOut          = ',';

tOffset         = 16842;

%% Main
fidIn           = fopen(filepathIn,'r');
filepathOut     = [filepathIn(1:end-4),'_EVENTS.txt'];
fidOut          = fopen(filepathOut,'w');
fwrite(fidOut,['Latency',sepOut,'Type',char(10)]);

for i=1:numHeaderLines
    fgets(fidIn);
end

eventLine       = fgets(fidIn);
while eventLine~=-1
    eventValue      = regexp(eventLine,sepIn,'split');
    
    imTime          = str2double(eventValue(imTimeCol))-tOffset;
    rtTime          = str2double(eventValue(rtTimeCol))-tOffset;
    resp            = str2double(eventValue(respCol));
    cresp           = str2double(eventValue(crespCol));

    % If subject response
    if ~isnan(imTime)
        if ~isempty(resp) && resp==1
            % Hit
            if ~isempty(cresp) && cresp==1
                fwrite(fidOut,[num2str(imTime),sepOut,'Hit',char(10)]);
                fwrite(fidOut,[num2str(rtTime),sepOut,'RT-Hit',char(10)]);
            % False Alarm
            else
                fwrite(fidOut,[num2str(imTime),sepOut,'False Alarm',char(10)]);
                fwrite(fidOut,[num2str(rtTime),sepOut,'RT-FA',char(10)]);
            end
        else
            % Omission
            if ~isempty(cresp) && cresp==1
                fwrite(fidOut,[num2str(imTime),sepOut,'Omission',char(10)]);
            % Correct Rejection
            else  
                fwrite(fidOut,[num2str(imTime),sepOut,'Correct Rejection',char(10)]);
            end
        end
    end
    eventLine       = fgets(fidIn);
end
        
        
        
        