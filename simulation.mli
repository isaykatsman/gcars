open Genetic

type eval_function =
  | LongestDistance
  | ShortestTime

type options = {
  mutation_rate : float;
  num_cars : int;
  eval_func : eval_function;
}

module type Simulation = sig
  type t
  val make : options -> t
  val run : t -> unit
end

module Simulation : Simulation
