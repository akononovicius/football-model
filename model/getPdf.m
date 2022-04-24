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

    edges = linspace(minData, maxData, outPoints+1);
    stepSize = edges(2) - edges(1);

    pdf = histcounts(data,edges);
    pdf = pdf ./ length(data);
    pdf = pdf ./ stepSize;

    bins = (edges(2:end) + edges(1:(end-1)))/2;
    pdf = [bins; pdf]';
end