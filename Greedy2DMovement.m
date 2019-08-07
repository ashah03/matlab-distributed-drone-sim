% Greedy2DMovement: This is the main function for calculating the positions of each
% agent with the greedy algorithm
% Parameters:
%   agents: Defines the starting positions of each agent
%   map: Defines the values of each location (object) 
%   radius: Defines area that each agent can cover
%   moveRadius: Defines area that an agent can move within at each move
%   showHeatmap: Boolean for showing heatmap at each iteration (warning:
%       reduces speed by about 10x)
%   plotHistory: Boolean for showing plot of valueHistory: reduces speed,
%       but not as much as heatmap
function [value,objects,agents,valueHistory] = Greedy2DMovement(agents, map, radius, moveRadius, showHeatmap, plotHistory)
    valueHistory = [];
    valueHistory2 = [];
    mapSize = size(map);
    I = (imread('heatmap.png')); 
    objects=cell(mapSize);
    objects(:)={0};
    value=0;
    last_value=-1;
    iter=0;
    colors=rand(length(agents),3);
    colors(:,3)=colors(:,3)*.7;
    % Populate initial locations onto object map
    
    for agent = 1:length(agents)
      value=value+getValue(agents{agent},map,objects,radius);
      objects=updateObjects(objects, agents{agent}, mapSize, radius, agent);
    end
   
    
    % Until the value stabilizes
    sameValue=0;
    while sameValue<(length(agents)*3)
        if value == last_value
            sameValue=sameValue+1;
        else
            sameValue=0;
        end
        
        iter=iter+1;
        last_value=value;
        %value=0;
        agent=randsample(1:length(agents),1);
        
        if showHeatmap
            visualize(agents,map,radius,colors,I)
        end
        if plotHistory
            plot(valueHistory)
        end

        % Find "maxValue" which is the best move for agent
        objects = agentRemove(objects,agent);
        value = value - getValue(agents{agent},map,objects,radius);
        maxPos = agents{agent};
        maxValue=getValue(maxPos, map, objects, radius);

        for row = max([1,agents{agent}{1}-ceil(moveRadius)]):min([mapSize(1),agents{agent}{1}+ceil(moveRadius)])
            for col = max([1,agents{agent}{2}-ceil(moveRadius)]):min([mapSize(2),agents{agent}{2}+ceil(moveRadius)])
                %
                if ~collision(agents, agent, {row,col}) && distance({row,col},agents{agent}) <= moveRadius
                    %Square root of 2 rounded up, i.e within one square away
                    result=getValue({row,col},map,objects,radius);
                    if result>=maxValue
                        maxPos = {row,col};
                        maxValue=result;
                    end
                end
            end
        end


         
        objects = updateObjects(objects, maxPos, mapSize, radius, agent);

        agents{agent}=maxPos; %Update positions array
        value = value + maxValue; %Update total value
        pause(.0000001)

        valueHistory(end+1)=value;
        %valueHistory2(end+1) = sum(sum((cellfun(@(objects)objects(1),objects) > 0).*map))
        %visualize(agents,map,radius,colors,I)
    end
    plot(valueHistory)
end