# OCaml Genetic Cars
Our final project is a genetic algorithm that optimizes a 2D car design. It was
made with the Chipmunk2D physics library for collision detection/simulation. 

# Running the Project
First, you will need to install the dependencies for Chipmunk2D and OpenGL. To
do this, run ./getdependencies.sh. This script has been tested to work on the
3110 VM. Then, you can run the project with ./run.sh. For the on-screen
prompts, press enter for each to use the default values for the simulation, and
after the final prompt the simulation window should pop up.

# User-Configuarable Parameters
When the program starts, you will be asked to input a mutation rate. This rate
should be in the range of (0.0, 1.0), exclusive.
