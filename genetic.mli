(* type for a car (genome) 
 * genome has 8 genes for vertices of car body, 1 gene for front wheel radius,
 * and 1 other gene for back wheel radius *)
type car_genome = {
  v1: float * float;
  v2: float * float;
  v3: float * float;
  v4: float * float;
  v5: float * float;
  v6: float * float;
  v7: float * float;
  v8: float * float;
  r1: float;
  r2: float;
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
