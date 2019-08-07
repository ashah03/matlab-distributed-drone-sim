# RMP Decentralized Multi-Drone Simulation
This project was developed at the UCSB Research Mentorship Program in collaboration with Bryce Ferguson. The goal is to simulate a multi-agent coverage system where the agents are given limited information about their environments, and are attempting to cover a weighted map effectively.

My research paper on this project can be found [here](Shah-Adit_Paper.pdf).

##  Usage

> **runner.m**: Main file of the repository, used to run the simulation. Can specify which algorithm to use, which map to use, number of agents, movement and sensing radii, and the tau (randomness) constant. 

> **Greedy2DMovement.m**: Main file for the Greedy algorithm code – contains core logic. 

> **Greedy2DMovementLLL.m**: Main file for the Log-Linear Learning algorithm code – contains core logic. 

> **.mat files**: Contain the five maps that the algorithm can be run on. 

> **genMap.m files**: Can be used to generate additional maps

> **All other files**: Supporting functions for  Greedy2DMovement and Greedy2DMovementLLL (see comments at the top of each file for more info)



