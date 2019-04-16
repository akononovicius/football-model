% outcome = generateGame(laHG, laAG, attHome, attAway, defHome, defAway);
%
% This function generates a single game outcome according to the statistical
% model we have discussed during the lecture.
%
% In:
%   laHG - goal scoring potential for any home team
%   laAG - goal scoring potential for any away team
%   attHome - relative attacking potential of the home team
%   attAway - relative attacking potential of the away team
%   defHome - relative defensive potential of the home team
%   defAway - relative defensive potential of the away team
% Out:
%   outcome - a vector with goals scored by home and away team
%
function outcome = generateGame(laHG, laAG, attHome, attAway, defHome, defAway)
    homeGoals = poissrnd(laHG*attHome*defAway);
    awayGoals = poissrnd(laAG*defHome*attAway);
    outcome = [homeGoals awayGoals];
end
