% totalGoals = getTotalGoals(dataStruct, teamName, mode)
%
% Get total (all, home or away) goals scored by teamName.
%
% In:
%   dataStruct - data structure containing football games
%                (note that this structure must contains fields homeTeam,
%                awayTeam, homeGoals and awayGoals)
%   teamName - team name (single string)
%   mode - string describing which goals we would like to get:
%          if it is 'total' (if we want to get all goals by the team)
%          if it is 'away' (if we want to get away goals by the team)
%          if it is 'home' (if we want to get home goals by the team)
% Out:
%   totalGoals - total goals (ones described by the mode)
%
function totalGoals = getTotalGoals(dataStruct, teamName, mode)
    totalGoals = 0;
    if or(strcmp(mode,'home'), strcmp(mode,'total'))
        homeMask = getHomeTeamMask(dataStruct, {teamName});
        totalGoals = totalGoals + sum(dataStruct.homeGoals(homeMask));
    end
    if or(strcmp(mode,'away'), strcmp(mode,'total'))
        awayMask = getAwayTeamMask(dataStruct, {teamName});
        totalGoals = totalGoals + sum(dataStruct.awayGoals(awayMask));
    end
end