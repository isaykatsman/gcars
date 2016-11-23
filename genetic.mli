(* type for a car (genome) 
 * genome has 8 genes for vertices of car chassis, and for each of the two wheels,
 * one gene for radius and one for the number of the vertex it will be attached
 * to. The position of each vertex is expressed in polar coordinates, with
 * the second float in the pair being the angle and the first being the
 * radius *)
type car_genome = {
  chassis : (float * float) list;
  w1_radius: float;
  w2_radius: float;
  w1_vert: int;
  w2_vert: int;
}
 
(* An existing population is represented by a Population type; an empty one
 * is represented by Empty n where n is the size of the desired population *)
type population = 
  | Population of car_genome list
  | Empty of int

type scores = float list

module type GeneticCarAlgo = sig
  (* [new_population pop scores rate] is a new population, calculated via a genertic
   * algorithm, given the scores [scores] of the previous population and the
   * and old population [pop] itself. If population is Empty n, then an inital
   * population of size n. The mutation rate is specified by [mutation_rate] *)
  val new_population : population -> scores -> float -> population
end

module Genetic : GeneticCarAlgo
module FakeGenetic : GeneticCarAlgo
