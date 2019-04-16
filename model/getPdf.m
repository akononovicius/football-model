% pdf=getPdf(data, outPoints)
%
% Get probability density function of the data. At least I wasn't able to find
% Matlab / Octave function which would fit into my understanding of empirical
% PDF.
%
% In:
%   data - empirical data
%   outPoints - number of points in the PDF
% Out:
%   pdf - actual PDF
%
function pdf = getPdf(data,outPoints)
    minData = min(data);
    maxData = max(data);
    stepSize = (maxData-minData)/(outPoints-1);

    xBins = (minData-stepSize):stepSize:(maxData+stepSize);
    pdf = hist(data,xBins);
    pdf = pdf ./ length(data);
    pdf = pdf ./ stepSize;
    pdf = [xBins; pdf]';
end