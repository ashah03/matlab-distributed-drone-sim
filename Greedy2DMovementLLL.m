% Greedy2DMovementLLL: This is the main function for calculating the positions of each
% agent with the greedy algorithm with log-linear learning
% Parameters:
%   agents: Defines the starting positions of each agent
%   map: Defines the values of each location (object) 
%   radius: Defines area that each agent can cover
%   moveRadius: Defines area that an agent can move within at each move
%   showHeatmap: Boolean for showing heatmap at each iteration (warning:
%       reduces speed by about 10x)
%   plotHistory: Boolean for showing plot of valueHistory: reduces speed,
%       but not as much as heatmap
function [value,objects,agents,valueHistory] = Greedy2DMovementLLL(agents, map, radius, moveRadius, tau, showHeatmap, plotHistory)
    valueHistory = []
    I = (imread('heatmap.png')); 
    iterCount=0;
    mapSize = size(map);
    objects=cell(mapSize);
    objects(:)={0};
    value=-1;
    last_value=0;
    iter=0;
    colors=rand(length(agents),3);
%     colors = [
%     0 1 0
%     0.2 0. 0.1
%     0.9 0.3 0
%     0.9 0.9 0.1];
    colors(:,3)=colors(:,3)*.7;
    % Populate initial locations onto object map
    for agent = 1:length(agents)
      value=value+getValue(agents{agent},map,objects,radius);
      objects=updateObjects(objects, agents{agent}, mapSize, radius, agent);
    end
    
    visualize(agents,map,radius,colors,I)
    % Until the value stabilizes
    sameValue=0;
    

    while sameValue<(length(agents)*3)
        iter=iter+1;
        if value == last_value
            sameValue=sameValue+1;
        else
            sameValue=0;
        end
        last_value=value;
        agent=randsample(1:length(agents),1);
        if showHeatmap
            visualize(agents,map,radius,colors,I)
        end
        if plotHistory
            plot(valueHistory)
        end
        objects = agentRemove(objects,agent); 
        value = value - getValue(agents{agent},map,objects,radius);
        %maxPos = agents{agent};
        %maxValue=getValue(maxPos, map, objects, radius);
        positions = {};
        for row = max([1,agents{agent}{1}-ceil(moveRadius)]):min([mapSize(1),agents{agent}{1}+ceil(moveRadius)])
            for col = max([1,agents{agent}{2}-ceil(moveRadius)]):min([mapSize(2),agents{agent}{2}+ceil(moveRadius)])
                %distance({row,col},agents{agent})
                if ~collision(agents, agent, {row,col}) && distance({row,col},agents{agent})<=moveRadius
                    %Square root of 2 rounded up, i.e within one square away
                    utility = {row, col,getValue({row,col},map,objects,radius)};
                    positions=[positions; utility];
                end
            end
        end
        tau=tau*.997;
        positions = cell2mat(positions);
        utilities = positions(:,end);
        positions = positions(:,1:end-1);

        try
            gibbs = exp(utilities./tau)/sum(exp(utilities./tau));
            chosenIndex = positions(randsample(size(positions,1), 1, true, gibbs),:);
            chosenPos = {chosenIndex(1),chosenIndex(2)};
            moveValue=getValue(chosenPos, map, objects, radius);
        catch ex
            figure(2)
            plot(valueHistory)
            print(value)
            rethrow(ex)
        end

        objects = updateObjects(objects, chosenPos, mapSize, radius, agent);

        agents{agent}=chosenPos; %Update positions array
        value = value + moveValue; %Update total value
        pause(.0000001);
        valueHistory(end+1)=value;
    end
    disp(iter)
    visualize(agents,map,radius,colors,I)
end

         








