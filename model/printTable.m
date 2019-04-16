% printTable(tableStruct)
%
% This function prints sorted season table in the following format:
%   '<team name> <points> <goalsFor>:<goalsAgainst>'
%
% In:
%   tableStruct - data structure containg league table data (team name, points,
%                 goals for, goals against)
% Out:
%   nothing
%
function printTable(tableStruct)
    % get total number of teams
    totalTeams = length(tableStruct.teamNames);
    
    % sort the data
    [tmp, idx] = sort(tableStruct.points);
    clear tmp;
    sortedStruct = applyDataMask(tableStruct,idx);
    
    % print in the reverse order (from top to bottom)
    printf('%30s\n','----- Season Table -----');
    for i = totalTeams:-1:1
        printf('%20s %d %d:%d\n',...
               sortedStruct.teamNames{i},...
               sortedStruct.points(i),...
               sortedStruct.goalsFor(i),...
               sortedStruct.goalsAgainst(i));
    end
end