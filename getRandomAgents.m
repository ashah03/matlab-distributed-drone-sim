% Generate random positions for numAgents agents in a map with size sz
function agents = getRandomAgents(numAgents,sz)
    agents={};
    agentsArr=[randi(sz(1), 1,numAgents);randi(sz(2), 1,numAgents)];
    
    for i=1:numAgents
        %agent = mat2cell(agentsArr(:,i),2,1);
        %agent={agent{1}(1),agent{1}(2)}
        agent = num2cell(agentsArr(:,i));
        agents=[agents;{agent}];
    end
end
