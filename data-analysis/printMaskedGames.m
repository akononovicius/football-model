% printMaskedGames(mask, dataStruct, header)
%
% Prints games according to a mask.
%
% In:
%   mask - logical (0 - don't show game; 1 - show game) or numerical (providing
%          ordering) vector
%   dataStruct - data structure containing football games
%                (note that this structure must contains fields homeTeam,
%                awayTeam, homeGoals and awayGoals)
%   header - text string to print before whole output
% Out:
%   nothing
%
function printMaskedGames(mask, dataStruct, header)
    printf('%s\n', header);
    idx = (1:length(dataStruct.homeTeam));
    for gid = idx(mask)
        printGame(gid, dataStruct, '   ');
    end
end
