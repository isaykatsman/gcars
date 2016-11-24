type car_genome = {
  chassis : (float * float) list;
  w1_radius: float;
  w2_radius: float;
  w1_vert: int;
  w2_vert: int;
}
 
type population = 
  | Population of car_genome list
  | Empty of int

type scores = float list

module type GeneticCarAlgo = sig
  val new_population : population -> scores -> float -> population
end

module FakeGenetic = struct
  let new_population pop scores rate = pop
end

module Genetic = FakeGenetic
