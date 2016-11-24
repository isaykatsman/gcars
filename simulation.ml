type eval_function =
  | LongestDistance
  | LongestTime

(* Evaluates a population by running a physics simulation and returning the
 * results. Starts a new physics simulation, steps the simulation until all
 * cars stop moving, displays the progress, and returns the results. *)
let eval_pop population eval_function : Genetic.scores = 
  []

