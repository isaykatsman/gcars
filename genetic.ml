module type GeneticCarAlgo = sig
  val new_population : population -> scores -> float -> population
end

module FakeGenetic = struct
  let new_population pop scores rate = pop
end

module Genetic = FakeGenetic
