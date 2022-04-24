%% Main data analysis script
%
% *Author*: <http://kononovicius.lt Aleksejus Kononovicius>
%

clear;

%%
% You might want to run these scripts on your own as your analysis evolves.
% In general |footballClean.m| script should be run once (with a goal to
% generate |engData.mat| file), while |footballAnalysis.m| could be run
% multiple times based on your specific use case.

footballClean

footballAnalysis