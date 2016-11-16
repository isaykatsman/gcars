open Simulation

type options = {
  mutation_rate : float;
  num_cars : int;
  eval_func : eval_function;
}

(* Entry point into the program. Recives command line options and parses them
 * parse_opts *)
val main : ()

(* [parse_opts argv] parses the command line input and returns an opts record
 * to represent the options set *)
val parse_opts : string array -> options

(* Continually run the simulation, evaluating the current population,
 * generating a new population from the old one, and evaluating that as well *)
val run : options -> population -> scores -> ()

