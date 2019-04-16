% outcomes = generateSeason(teamNames, lambdaHG, lambdaAG,...
%                           attHome, attAway, defHome, defAway)
%
% This function generates outcomes of all games within a single season in which
% all teams play each other twice. Once home and once away.
%
% In:
%   lambdaHG - baseline goal scoring capacity of any home team (single value)
%   lambdaAG - baseline goal scoring capacity of any away team (single value)
%   attHome - attacking potential of all teams playing at home (team vector)
%   attAway - attacking potential of all teams playing away (team vector)
%   defHome - defensive potential of all teams playing at home (team vector)
%   defAway - defensive potential of all teams playing away (team vector)
% Out:
%   dataStruct - data structure containing football games
%
function dataStruct = generateSeason(teamNames, lambdaHG, lambdaAG,...
                                     attHome, attAway, defHome, defAway)
    dataStruct = struct();
    totalTeams = length(attHome);
    gid = 1;
    for i = 1:totalTeams % for all home teams
        for j = 1:totalTeams % for all away teams
            if( i==j ) % because team can't play itself
                continue
            end
            gameOut = generateGame(lambdaHG, lambdaAG,...
                                   attHome(i,1), attAway(j,1), ...
                                   defHome(i,1), defAway(j,1));
            dataStruct.dateString{gid,1} = num2str(gid);
            dataStruct.homeTeam{gid,1} = teamNames{i};
            dataStruct.awayTeam{gid,1} = teamNames{j};
            dataStruct.homeGoals(gid,1) = gameOut(1);
            dataStruct.awayGoals(gid,1) = gameOut(2);
            dataStruct.totalGoals(gid,1) = gameOut(1) + gameOut(2);
            gid = gid +1;
        end
    end
end
