%Determines if agent will collide with another agent at pos
function isCollision = collision(agents, agent, pos)
    isCollision=false;
     for ag=1:length(agents)
         if ag~=agent
             if agents{ag}{1} == pos{1} && agents{ag}{2} == pos{2}
                 isCollision=true;
                 return
             end
         end
     end
end