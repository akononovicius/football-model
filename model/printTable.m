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
    [~, idx] = sort(tableStruct.points);
    sortedStruct = applyDataMask(tableStruct,idx);
    
    % print in the reverse order (from top to bottom)
    fprintf('%30s\n','----- Season Table -----');
    for i = totalTeams:-1:1
        fprintf('%20s %d %d:%d\n',...
               sortedStruct.teamNames{i},...
               sortedStruct.points(i),...
               sortedStruct.goalsFor(i),...
               sortedStruct.goalsAgainst(i));
    end
end