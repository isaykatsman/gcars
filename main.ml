open Sys
open Genetic
open Simluation

let main = 
  let opts = parse_opts Sys.argv in
  run opts (Population opts.num_cars) []

let rec run opts prev_pop prev_scores = 
  let new_pop = new_population prev_pop prev_scores opts.mutation_rate in
  let new_scores = eval_pop new_pop opts.eval_func in
  run opts new_pop new_scores

