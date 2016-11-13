open Genetic

(* Evaluates a population by running a physics simulation and returning the
 * results. Starts a new physics simulation, steps the simulation until all
 * cars stop moving, displays the progress, and returns the results. *)
val eval_pop : (pop : population) -> (eval_func : eval_function) -> 
  (pop_scores : scores)
