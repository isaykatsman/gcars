# OCaml Genetic Cars
Our final project is a genetic algorithm that optimizes a 2D car design. It was
made with the Chipmunk2D physics library for collision detection/simulation. 

# Running the Project
First, you will need to install Chipmunk2D and OpenGL, their dependencies, and
build the bindings for these libraries. The source code for the Chipmunk2D and
OpenGL bindings themselves are included in this repository, under the chipmunk
and glMLite directories, respectively. 

The project is most easily run the on the 3110 VM. To get the dependencies, and
build the bindings, run ./getdependencies.sh. This script has been tested to
work on the 3110 VM. Then, you can run the project with ./run.sh. Follow the
on-screen prompts, press <Enter> for each to use the default values for the
simulation, and after the final prompt the simulation window should pop up.

# User-Configuarable Parameters
When the program starts, you will be asked to input a mutation rate. This rate
should be in the range of (0.0, 1.0), exclusive.
