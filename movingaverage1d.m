function [smoothedVector] = movingaverage1d (inVector, winLength)
% [smoothedVector] = MOVINGAVERAGE1D (inVector, winLength)
% Smooth the input vector inVector. Output vector smoothedVector is obtained 
% by doing the convolution between the input vector and a rectangular
% window of size winLength. 
%
% Author(s) : Martin Deudon (2016)

inVector        = inVector(:);
smoothedVector  = zeros(length(inVector),1);
if size(inVector,2) ~= 1; error('Input must be a vector, not a matrix'); end;
if ~isscalar(winLength); error('Smoothing window length must be a scalar'); end;
if winLength>size(inVector,1); error('Smoothing window length must be inferior to vector length'); end;

if rem(winLength,2) == 0
    warning('Length of smoothing window should be odd, increase the length of one');
    winLength = winLength+1;
end

smoothedVectorCenter = conv(inVector,(1/winLength).*ones(1,winLength),'valid');
smoothedVector (ceil(winLength/2):length(inVector)-floor(winLength/2)) = smoothedVectorCenter;

for i=1:fix(winLength/2)
    smoothedVector (i) = mean(inVector(1:i));
end
for i=length(inVector)-fix(winLength/2):length(inVector)
    smoothedVector (i) = mean(inVector(i-fix(winLength/2):i));
end


end

