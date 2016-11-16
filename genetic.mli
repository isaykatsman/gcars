(* type for a car (genome) 
 * genome has 8 genes for vertices of car body, and for each of the two wheels,
 * one gene for radius and one for the number of the vertex it will be attached
 * to *)
type car_genome = {
  v1: float * float;
  v2: float * float;
  v3: float * float;
  v4: float * float;
  v5: float * float;
  v6: float * float;
  v7: float * float;
  v8: float * float;
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

(* [new_population pop scores rate] is a new population, calculated via a genertic
 * algorithm, given the scores [scores] of the previous population and the
 * and old population [pop] itself. If population is Empty n, then an inital
 * population of size n. The mutation rate is specified by [mutation_rate] *)
val new_population : population -> scores -> float -> population
