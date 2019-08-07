%Remove all instances of an agent from the object array
function objects = agentRemove(objects, agent)
    for i = 1:numel(objects)
        j=1;
        while j<=length(objects{i})
            if objects{i}(j)==agent
                objects{i}(j)=[];
            else
                j=j+1;
            end
        end
        if length(objects{i})==0
            objects{i}=0;
        end        
    end 
end