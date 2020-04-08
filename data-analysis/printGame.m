% printGame(gameId, dataStruct, prefix)
%
% Print the game whose id is gameId into CLI.
%
% In:
%   gameId - id of the game within dataStruct (single value)
%   dataStruct - data structure containing football games
%                (note that this structure must contains fields homeTeam,
%                awayTeam, homeGoals and awayGoals)
%   prefix - text string we want to append before the output
% Out:
%   nothing
%
function printGame(gameId, dataStruct, prefix)
    fprintf('%s %s vs %s %d:%d\n',...
           prefix,...
           dataStruct.homeTeam{gameId},dataStruct.awayTeam{gameId},...
           dataStruct.homeGoals(gameId),dataStruct.awayGoals(gameId))
end
