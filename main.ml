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
(* let parse_opts : sim_options =
  let mutation_rate = ref 0.05 in
  let num_cars = ref 10 in
  let eval_func = ref `LongestDistance in
  let parse_eval_f s =
    match s with
    | "ld" -> LongestDistance
    | "st" -> ShortestTime
    | _ -> raise Invalid_evaluation_function in
  let speclist = [
    ("-n", Arg.Int (fun n -> num_cars := n), "Number of cars per generation. \
    Default is 10.");
    ("-r", Arg.Float (fun r -> mutation_rate := r), "Mutation rate for genetic \
    algorithm. Default is 5.0.");
    ("-f", Arg.String (fun s -> eval_func := (parse_eval_f s)), "The name of \
    the evaluation function to use for the genetic algorithm. Options are 'ld' \
    for Longest Distance, or 'st' for Shortest Time. Default is Longest \
    Distance.");
  ] in
  let usage_msg = "OCaml Genetic Cars" in
  Arg.parse speclist print_endline usage_msg;
  { mutation_rate = !mutation_rate; num_cars = !num_cars; eval_func = !eval_func } *)

let parse_stdin_opts =
  let config = ref {mutation_rate = 0.10; num_cars = 10; car_vel = 10.0;eval_func = `LongestDistance; scale = 1.0} in
  print_endline "Please enter the mutation rate (or enter for default)";
  print_endline "expected 0.0 - 1.0";
  let line = input_line stdin in
  if line <> "" then config := {!config with mutation_rate = (float_of_string line)};
  print_endline "Please enter optimization type (or enter for standard)";
  print_endline "1 for standard, 2 for speed, 3 for jump";
  let line = input_line stdin in
  (if line <> "" then
  let v = (int_of_string line) in
  if v=1 then config := {!config with eval_func = `LongestDistance}
  else if v=2 then config := {!config with eval_func = `ShortestTime}
  else if v=3 then config := {!config with eval_func = `JumpDistance});
  print_endline "Please enter speed of car (or enter for standard 10.0)";
  let line = input_line stdin in 
  (if line <> "" then
  let v = (float_of_string line) in 
  config := {!config with car_vel = v};
  );
  print_endline "Please enter a scale for the view. Higher scale makes the cars smaller. (or enter for standard scale).";
  print_endline "Do note that any scale other than 1 will break the HUD";
  let line = input_line stdin in 
  (if line <> "" then 
  let v = (float_of_string line) in 
  config := {!config with scale = 1.0/.v});
  !config


let main () =
  Random.self_init();
  let opts = parse_stdin_opts in
  let sim = Simulation.make opts in
  Simulation.run sim

let () = main ()
