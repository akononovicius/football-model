%% Statistical model inspired by the data analysis
%
% *Author*: <http://kononovicius.lt Aleksejus Kononovicius>
%
% *Note*: This approach is quite similar to the one discussed by prof. Tony
% Padilla in the following Numberphile video
% <https://www.youtube.com/watch?v=Vv9wpQIGZDw>. Yet it was developed atleast
% somewhat independently (I have promissed my students to do such model few days
% before actually seeing this video).
%

clear all;

%% Dependencies
%
% Octave users need this line. Matlab users should delete it.
%
%pkg load statistics;

%% Load the data
%
% We have already prepared and cleaned up the data and saved it as workspace
% file (mat file). So let us take advantage of it and load it.
%
load('engData.mat');

%% Determining model parameters
%
% First let us gell all unique team names and the total number of teams, which
% will be used in our simulation
% 

teamNames = unique(engData.homeTeam);

totalTeams = length(teamNames);

%%
% Based on the data we have let us estimate the parameters of the statistical 
% model. Recall that our model depends on six parameters:
% * overall scoring potential of an average home team (lambdaHG; single value)
% * overall scoring potential of an average away team (lambdaAG; single value)
% * relative attacking potential of a specific home team (attHome; team vector)
% * relative attacking potential of a specific away team (attAway; team vector)
% * relative defensive potential of a specific home team (defHome; team vector)
% * relative defensive potential of a specific away team (defAway; team vector)
%

% Calculate the first two parameters
lambdaHG = mean(engData.homeGoals); % overall scoring potential at home
lambdaAG = mean(engData.awayGoals); % overall scoring potential away

% initialize values of the other four parameters
attHome = zeros(totalTeams,1); % attacking potential per team at home
defHome = zeros(totalTeams,1); % defence potential per team at home
attAway = zeros(totalTeams,1); % attacking potential per team at away
defAway = zeros(totalTeams,1); % defence potential per team at away

% actual calculation for the other four parameters
for i = 1:totalTeams
    % if the team plays home
    homeTeamMask = getHomeTeamMask(engData, teamNames(i,1));
    attHome(i,1) = mean(engData.homeGoals(homeTeamMask)) / lambdaHG;
    defHome(i,1) = mean(engData.awayGoals(homeTeamMask)) / lambdaAG;
    % if the team plays away
    awayTeamMask = getAwayTeamMask(engData, teamNames(i,1));
    attAway(i,1) = mean(engData.awayGoals(awayTeamMask)) / lambdaAG;
    defAway(i,1) = mean(engData.homeGoals(awayTeamMask)) / lambdaHG;
end

clear i homeTeamMask awayTeamMask;

%% Generate single season
%
% Let us generate the season. Each team plays each other team twice: once home,
% once away. So we have 38 games per team.
%
modelData = generateSeason(teamNames, lambdaHG, lambdaAG,...
                           attHome, attAway, defHome, defAway);

% Let us now figure out the points scored by each team within our fake season.
tableData = calculateTable(modelData);

% Let us print out the standings.
printTable(tableData);

%% Generate multiple seasons
%
% Getting one season is fun and all, but what we are interested in is to get
% insights from multiple runs. As an example of insight lets get a sample of
% points which Manchester United (champion of 2000/01) could have scored as
% well as number of points the second team has scored. Lets get 1000 samples
% (it will take some time).
%

muPoints=[];
secPoints=[];
for i=1:1000
    modelData = generateSeason(teamNames, lambdaHG, lambdaAG,...
                               attHome, attAway, defHome, defAway);
    tableData = calculateTable(modelData);
    muPoints(i) = tableData.points(14);
    points = sort(tableData.points);
    secPoints(i) = points(end-1);
end

%%
% Let us plot the respective PDFs (for Manchester United and the second team).
%
figure(1);
clf();
hold on;

pdf = getPdf(muPoints,30);
plot(pdf(:,1),pdf(:,2),'r');

pdf = getPdf(secPoints,30);
plot(pdf(:,1),pdf(:,2),'k');

legend('Machester United','Second team in PRL');

%%
% Also let us report the number of times (in our sample) Manchester United has
% also won the league.
%
fprintf('\nManchester United has won the league %d of %d\n',...
       sum(muPoints>secPoints),length(muPoints));
