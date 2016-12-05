#directory "./chipmunk";;
#load "chipmunk.cma";;

#directory "./glMLite/SRC";;
#load "GL.cma";;
#load "Glu.cma";;
#load "Glut.cma";;

#use "vect.ml"
#use "genetic.ml"
#use "world.ml"
#use "graphics.ml"
#use "simulation.ml"

open Sys
(*
open Genetic
open Simulation
*)

exception Invalid_evaluation_function

let parse_stdin_opts =
  let config = ref {mutation_rate = 0.10; num_cars = 10; eval_func = `LongestDistance; car_vel = 20.0; scale = 1.0; gravity = 1.0;} in
  print_endline 
"**********************
* OCaml Genetic Cars *
**********************";

  print_endline "Enter the mutation rate (or Enter for default, 0.10)
The mutation rate should be in the range (0.0, 1.0) exclusive";
  print_string "> ";
  flush stdout;

  let line = input_line stdin in 
  if line <> "" then config := {!config with mutation_rate = (float_of_string line)};

  print_endline "Enter evaluation function (or Enter for default, 1)
1 Longest Distance (Terrain will be rugged. Cars are evaluated)
2 Shortest Time (Terrain will be relatively flat)
3 Longest Jump (Terrain will be a big ramp. Try it with a higher velocity!)";
  print_string "> ";
  flush stdout;

  let line = input_line stdin in 
  (if line <> "" then 
  let v = (int_of_string line) in 
  if v=1 then config := {!config with eval_func = `LongestDistance} 
  else if v=2 then config := {!config with eval_func = `ShortestTime}
  else if v=3 then config := {!config with eval_func = `JumpDistance});
  print_endline "Enter speed of car (or Enter for default, 20.0)";
  print_string "> ";
  flush stdout;

  let line = input_line stdin in 
  (if line <> "" then
  let v = (float_of_string line) in 
  config := {!config with car_vel = v};
  );
  print_endline "Enter a scale for the view. We suggest 0.5 or 0.2 if you chose
  jump (or Enter for default, 1.0";
  print_endline "Do note that any scale other than 1.0 will cause the HUD to
  scale as well.";
  print_string "> ";
  flush stdout;

  let line = input_line stdin in 
  (if line <> "" then 
  let v = (float_of_string line) in 
  config := {!config with scale = v});
  print_endline "Please enter a gravity scale (or enter for standard 1.0)";
  print_string "> ";
  flush stdout;
  let line = input_line stdin in 
  (if line <> "" then
  let v = (float_of_string line) in 
  config := {!config with gravity = v});
  !config


let main () =
  Random.self_init();
  let opts = parse_stdin_opts in
  let sim = Simulation.make opts in
  Simulation.run sim

let () = main ()
