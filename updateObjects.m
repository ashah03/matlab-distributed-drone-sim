% Updates the objects array (map of each agent's range) based on the new positions of every drone
function objects = updateObjects(objects, maxPos, mapSize, radius, agent)
    for row = max([1,maxPos{1}-ceil(radius)]):min([mapSize(1),maxPos{1}+ceil(radius)])
        for col=max([1,maxPos{2}-ceil(radius)]):min([mapSize(2),maxPos{2}+ceil(radius)])
            d=distance(maxPos,{row,col});
            if d<=radius
                if objects{row,col}(1) == 0
                    objects{row,col}(1)=agent;
                else
                    objects{row,col}(end+1)=agent;
                end
            end
        end
    end
end