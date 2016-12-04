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

let parse_opts : sim_options = 
  let mutation_rate = ref 5.0 in
  let num_cars = ref 10 in
  let eval_func = ref LongestDistance in
  let parse_eval_f s =
    match s with
    | "ld" -> LongestDistance
    | "st" -> ShortestTime in
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
  { mutation_rate = !mutation_rate; num_cars = !num_cars; eval_func = !eval_func }

let main () = 
  let opts = parse_opts in
  let sim = Simulation.make opts in
  Simulation.run sim

let () = main ()
