%% Football data cleaning
%
% *Author*: <http://kononovicius.lt Aleksejus Kononovicius>
%
% *Note that* |england.csv| file is available on GitHub from
% <https://github.com/jalapic/engsoccerdata/tree/master/data-raw>. You should
% download it prior to runnig this script.
%

clear;

%% Read the data
%
% We will read the data into the structure now (alternatively we could use
% cell arrays). In Matlab it would be better to use readtable function. Usage
% is quite similar to how we work here, but there are some notable differences
% (feel free to explore them on your own).
%
% Note 2022: With more modern version of Matlab it is better to use
% readtable instead of textread, but implementing this would require an
% extensive rewrite of the legacy code.

engData = struct();

[engData.dateString, engData.season, engData.homeTeam, ...
 engData.awayTeam, engData.ftString, engData.homeGoals, ...
 engData.awayGoals, engData.divisionString, engData.tier, ...
 engData.totalGoals, engData.goalDiff, engData.resultString] = textread(...
    'england.csv', '%s %d %s %s %s %d %d %s %d %d %d %s', ...
    'delimiter', ',', 'headerlines', 1);

% Lets now remove irrelevant fields (columns).
engData = rmfield(engData,{'ftString' 'divisionString' ...
    'goalDiff' 'resultString'});

%% Data filtering
%
% Lets select season 2000/2001 (where engData.season equals 2000) in the
% Premier League (where engData.tier equals 1).
%
dataMask = (engData.season == 2000) & (engData.tier == 1);
engData = applyDataMask(engData, dataMask);
clear dataMask;

%%
% Lets once again drop irrelevant fields (columns)
%
engData = rmfield(engData, {'season' 'tier'});

%% Saving the data
%
% Let us save cleaned up empirical data to a mat file (workspace file)
%
save('engData.mat');