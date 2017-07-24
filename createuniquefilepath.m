function filePathOut = createuniquefilepath (filePath)
% filePathOut = CREATEUNIQUEFILEPATH (filePath)
% Create a unique file path by adding a number to the filename if it
% already exist. File path must contain the extension 'filepath.truc'
% Ex: \SAB\Results\accuracy.fig   becomes \SAB\Results\accuracy_2.fig
%     \SAB\Results\accuracy_2.fig becomes \SAB\Results\accuracy_3.fig
%
% See also createuniquedir
% 
% Author(s) : Martin Deudon (2016)

%- find extension
pointPos        = regexp(filePath,'\.');
if isempty(pointPos)
    error(['Could not find the extension in file path :',char(10),filePath]);
end
lastPointPos    = pointPos(end);
extStr          = filePath(lastPointPos:end);
filePathPre     = filePath(1:lastPointPos-1);



if exist([filePathPre,extStr],'file')
    filePathPre = [filePathPre,'_2']; 
end
inc         = 3;
while exist([filePathPre,extStr],'file')
    filePathPre = regexprep(filePathPre,'_\d+$',['_',num2str(inc)]);
    inc = inc+1;
end

filePathOut = [filePathPre,extStr];

end