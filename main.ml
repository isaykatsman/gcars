open Sys
open Genetic
open Simulation

let parse_opts argv : options = 
  { mutation_rate = 0.0; num_cars = 2; eval_func = LongestDistance } 

let main () = 
  let opts = parse_opts Sys.argv in
  let sim = Simulation.make opts in
  Simulation.run sim

let () = main ()
