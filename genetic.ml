type wheel = {radius : float; vert : int}

type car_genome = {
  chassis : (float * float) list;
  wheels : (wheel * wheel);
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
