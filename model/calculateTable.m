% tableStruct = calculateTable(dataStruct);
%
% This function produces league table based on data structure containing game
% data.
%
% In:
%   dataStruct - data structure containing football games
% Out:
%   tableStruct - data structure containg league table data (team name, points,
%                 goals for, goals against)
%
function tableStruct = calculateTable(dataStruct)
    teamNames = unique(dataStruct.homeTeam);
    totalTeams = length(teamNames);
    
    pts = zeros(totalTeams,1);
    gf = zeros(totalTeams,1);
    ga = zeros(totalTeams,1);

    for i = 1:totalTeams
        homeTeamMask = getHomeTeamMask(dataStruct,teamNames(i));
        awayTeamMask = getAwayTeamMask(dataStruct,teamNames(i));
        teamGoals = [dataStruct.homeGoals(homeTeamMask); dataStruct.awayGoals(awayTeamMask)];
        oppGoals = [dataStruct.awayGoals(homeTeamMask); dataStruct.homeGoals(awayTeamMask)];
        gf(i) = sum(teamGoals);
        ga(i) = sum(oppGoals);
        pts(i) = 3*sum(teamGoals>oppGoals) + sum(teamGoals==oppGoals);
    end
    
    tableStruct = struct();
    tableStruct.teamNames = teamNames;
    tableStruct.points = pts;
    tableStruct.goalsFor = gf;
    tableStruct.goalsAgainst = ga;
end