open Sys
open Genetic
open Simulation

type options = {
  mutation_rate : float;
  num_cars : int;
  eval_func : eval_function;
}

let parse_opts argv : options = 
  { mutation_rate = 0.0; num_cars = 0; eval_func = LongestDistance } 

let rec run opts prev_pop prev_scores = 
  let new_pop = Genetic.new_population prev_pop prev_scores opts.mutation_rate in
  let new_scores = eval_pop new_pop opts.eval_func in
  run opts new_pop new_scores

let main = 
  let opts = parse_opts Sys.argv in
  run opts (Empty opts.num_cars) []

let () = main
