% mask = getHomeTeamMask(dataStruct, teamNames)
%
% Get logical mask, which would select games where home team is from teamNames.
%
% In:
%   dataStruct - data structure containing football games
%                (note that this structure must contain field 'homeTeam')
%   teamNames - a cell array of away team names (row array)
%
% Out:
%   mask - logical vector (contains 1 if away team is in the teamNames,
%          contains 0 if away team is not in the teamNames)
%
function mask = getHomeTeamMask(dataStruct, teamNames)
    mask = zeros(length(dataStruct.homeTeam),1);
    for i=1:length(teamNames)
        mask = (mask | strcmp(dataStruct.homeTeam,teamNames{i}));
    end
end
