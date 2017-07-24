function [] = saveparams2txt(txtFilePath, varargin)
%[] = SAVEPARAMS2TXT (txtFilePath, varargin)
% Save variables to a text file
% Can only print scalar, 1D or 2D matrices, char/string variables and 1D
% cell.
%
% Author(s) : Martin Deudon (2016)

if rem(length(varargin),2)~=0
    error('varargin must contain paired elements: name of the variable / variable');
end
txtFilePath = createuniquefilepath(txtFilePath);
fid     = fopen(txtFilePath,'w');
if fid==-1
    error(['Error creating file : ',txtFilePath,'. Check path.']);
end

nVar    = length(varargin)/2;
for i=1:nVar
    %- Write variable name 
    varName_i   = varargin{2*(i-1)+1};
    if ~ischar(varName_i); error('Missing variable name'); end;
    fwrite(fid,[varName_i,' : ']); 
    %- Write variable content
    var_i       = varargin{2*i};
    if iscell(var_i)
        if min(size(var_i))~=1
            warning('Can only save to text 1D-cells');
        else
            for j=1:length(var_i)
                writevariable2txt(fid,var_i{j});
                fwrite(fid,' ');
            end
        end
    else
        writevariable2txt(fid,var_i);
    end
    %- end line
    fwrite(fid,char(10));
end

end

function writevariable2txt(fid, variable)
    if ischar(variable)
        fwrite(fid,variable);
    elseif isnumeric(variable)
        if length(size(variable))>2
            warning('Cannot write 3D or more matrices to text file');
            warning(variable);
        else
            fwrite(fid,num2str(variable));
        end
    else
        warning('Cannot write this variable to text file');
        warning(variable);
    end
end