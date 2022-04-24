%% Football data analysis
%
% *Author*: <http://kononovicius.lt Aleksejus Kononovicius>
%
% *Note*: prior to running this script you should run |footballClean.m| script,
% which prepares raw csv data and translates it into workspace file.
%

clear all;

%% Load workspace
%
% To save us some time we have done data cleaning prior to this analysis and
% saved the clean data set as workspace file. Now we just have to load the data.
%

load('engData.mat');

%% Highest scoring games
% 
% Let us figure out number of differrent highest scoring games. Let us start
% simply with highest total goals, $ TG $:
%
% $$ TG = G_h + G_v $$
%

maxTotalGoals = max(engData.totalGoals);
dataMask = (engData.totalGoals == maxTotalGoals);

printMaskedGames(dataMask, engData, 'Highest total goals');

clear maxTotalGoals dataMask;

%%
% Let us repeat the same, but not for total goals, but for home goals and
% visitor (away) goals. Lets start with home goals.
%

maxHomeGoals = max(engData.homeGoals);
dataMask = (engData.homeGoals == maxHomeGoals);

printMaskedGames(dataMask, engData, 'Highest home goals');

clear dataMask maxAwayGoals;

%%
% Lets continue with away goals.
%

maxAwayGoals = max(engData.awayGoals);
dataMask = (engData.awayGoals == maxAwayGoals);

printMaskedGames(dataMask, engData, 'Highest away goals');

clear dataMask maxAwayGoals;

%% Is there a home advantage in Premier League?
%
% We will calculate number of home wins, away wins (home losses) and draws in
% our data set.
%

homeWins = sum(engData.homeGoals > engData.awayGoals);
homeLost = sum(engData.homeGoals < engData.awayGoals);
draws = sum(engData.homeGoals == engData.awayGoals);
totalGames = length(engData.homeGoals);

figure(1);
clf();

pie([homeWins homeLost draws],{'Home Wins' 'Home Losses', 'Draws'});

fprintf('Home Team game result absolute and relative frequencies:\n');
fprintf('    Won:   %02d (%.2f)\n', homeWins, homeWins/totalGames);
fprintf('    Lost:  %02d (%.2f)\n', homeLost, homeLost/totalGames);
fprintf('    Drawn: %02d (%.2f)\n', draws, draws/totalGames);

clear homeWins homeLost draws totalGames;

%%
% What about if the home team is one of the top 5 teams?
%

dataMask = getHomeTeamMask(engData,{'Manchester United' 'Arsenal' 'Liverpool'...
                                    'Leeds United' 'Ipswitch Town'});
topHomeGames = applyDataMask(engData, dataMask);

homeWins = sum(topHomeGames.homeGoals > topHomeGames.awayGoals);
homeLost = sum(topHomeGames.homeGoals < topHomeGames.awayGoals);
homeDraws = sum(topHomeGames.homeGoals == topHomeGames.awayGoals);
totalHomeGames = length(topHomeGames.homeGoals);

dataMask = getAwayTeamMask(engData,{'Manchester United' 'Arsenal' 'Liverpool'...
                                    'Leeds United' 'Ipswitch Town'});
topAwayGames = applyDataMask(engData, dataMask);

awayWins = sum(topAwayGames.homeGoals < topAwayGames.awayGoals);
awayLost = sum(topAwayGames.homeGoals > topAwayGames.awayGoals);
awayDraws = sum(topAwayGames.homeGoals == topAwayGames.awayGoals);
totalAwayGames = length(topAwayGames.homeGoals);

figure(2);
clf();

subplot(121);
pie([homeWins homeLost homeDraws],{'Home Wins' 'Home Losses', 'Home Draws'});
title('Top teams playing home');

subplot(122);
pie([awayWins awayLost awayDraws],{'Away Wins' 'Away Losses', 'Away Draws'});
title('Top teams playing away');

fprintf('Home Team (Top 5 team) game result absolute and relative frequencies:\n');
fprintf('    Won:   %02d (%.2f)\n', homeWins, homeWins/totalHomeGames);
fprintf('    Lost:  %02d (%.2f)\n', homeLost, homeLost/totalHomeGames);
fprintf('    Drawn: %02d (%.2f)\n', homeDraws, homeDraws/totalHomeGames);
fprintf('Away Team (Top 5 team) game result absolute and relative frequencies:\n');
fprintf('    Won:   %02d (%.2f)\n', awayWins, awayWins/totalAwayGames);
fprintf('    Lost:  %02d (%.2f)\n', awayLost, awayLost/totalAwayGames);
fprintf('    Drawn: %02d (%.2f)\n', awayDraws, awayDraws/totalAwayGames);
    
clear homeWins homeLost homeDraws totalHomeGames ...
      awayWins awayLost awayDraws totalAwayGames ...
      dataMask topHomeGames topAwayGames;
      
%% Preparing data for further analysis
%
% Lets get all team names within our data set.
%
teamNames = unique(engData.homeTeam);

%%
% Lets do data sorting by the date game was played.
%
[tmp, idx] = sort(engData.dateString);
clear tmp;
engData = applyDataMask(engData, idx);

%% Is there a difference between goals scored at home and away?
%
% We will calculate home and away goals for each team.
%
goalsHA = zeros(length(teamNames),2);
fprintf('\n%40s\n','------ Home / Away Goals ------');
for i = 1:length(teamNames)
    goalsHA(i,1) = getTotalGoals(engData, teamNames{i}, 'home');
    goalsHA(i,2) = getTotalGoals(engData, teamNames{i}, 'away');
    fprintf('%20s %d %d %.3f\n',teamNames{i},...
                               goalsHA(i,1),goalsHA(i,2),...
                               goalsHA(i,1)/goalsHA(i,2));
end
clear goalsHA;

%% Is there a difference between goals scored during the first and second half of the season?
%
% We will calculate the first 19 games goals and the last 19 games goals for
% each team.
%
goalsFS = zeros(length(teamNames),2);
fprintf('\n%40s\n','------ First / Second Half of the season ------');
for i = 1:length(teamNames)
    % select games with teamNames(i)
    homeMask = getHomeTeamMask(engData, teamNames(i));
    awayMask = getAwayTeamMask(engData, teamNames(i));
    teamMask = homeMask | awayMask;
    teamData = applyDataMask(engData, teamMask);
    % create masks home and away games within teamData
    homeMask = getHomeTeamMask(teamData, teamNames(i,1));
    awayMask = getAwayTeamMask(teamData, teamNames(i,1));
    
    firstHalfMask = ([ones(19,1); zeros(19,1)] > 0.5)';
    
    goalsFS(i,1) = sum(homeMask(firstHalfMask) .* teamData.homeGoals(firstHalfMask) + awayMask(firstHalfMask) .* teamData.awayGoals(firstHalfMask));
    goalsFS(i,2) = sum(homeMask(~firstHalfMask) .* teamData.homeGoals(~firstHalfMask) + awayMask(~firstHalfMask) .* teamData.awayGoals(~firstHalfMask));
    
    fprintf('%20s %d %d %.3f\n',teamNames{i},...
                               goalsFS(i,1),goalsFS(i,2),...
                               goalsFS(i,1)/goalsFS(i,2));
end
