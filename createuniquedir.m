function dirPath = createuniquedir (dirPath)
% dirPath = CREATEUNIQUEDIR (dirPath);
% Create a unique directory. If the directory dirPath already exists, adds
% a new unique directory by incrementing the path in dirPath.
% Ex: SAB\Results\COG_027_FeatEv becomes SAB\Results\COG_027_FeatEv_2
%
% See also : createuniquefilepath
%
% Author : Martin Deudon (2016)

% Create a result directory for this run
if exist(dirPath,'file')
    dirPath = [dirPath,'_2']; 
end
inc         = 3;
while exist(dirPath,'file')
    dirPath = regexprep(dirPath,'_\d+$',['_',num2str(inc)]);
    inc = inc+1;
end
mkdir(dirPath);

end