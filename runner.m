% Main file that runs the simulation

clear all
close all


map=cell2mat(struct2cell(load('map20.mat'))); %Choose which map to use from .mat files 
numAgents=6; % Number of drones
radius=2.237; % Sensing/coverage radius
moveRadius=1; % Movement radius

% Generate drones at random
agents = getRandomAgents(numAgents, size(map));
tau = 3.14*radius*radius * mean(map, 'all') * 0.5; 

% Or place drones in predetermined positions
% agents={{1,1};{2,1};{1,2};{2,2};{3,1};{1,3}};
% tau = 3.14*radius*radius * mean(map, 'all') * 1.0; % This is the value if
% placed in one corner, change 1.0 for other positions

% Use the automatic tau value definition above or define your own
% tau = 50


%Prepare heatmap
hold off
saveas(heatmap(map, 'CellLabelColor','none','GridVisible','off'),'heatmap.png');
clf

% Arguments
p=false;
h=false;
alg = lower(input("Which algorithm?",'s'));
str = lower(input("Plot or heatmap",'s'));
if (str=="p") || (str=="plot")
    p=true;
    h=false;
elseif (str=="h")
    p=false;
    h=true;
end
        
if alg == "g" || alg == "greedy" 
    [value,objects,agents,valueHistory] = Greedy2DMovement(agents, map, radius, moveRadius, h, p);
elseif  alg == "l" || alg == "lll" 
    [value,objects,agents,valueHistory] = Greedy2DMovementLLL(agents, map, radius, moveRadius, tau, h, p);
else
    ME = MException('Error:invalidOption','Choose either g/greedy or l/lll');
    throw(ME)
end

plot(valueHistory)
