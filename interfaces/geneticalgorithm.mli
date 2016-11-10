(* A [GenAlgorithm] is a module that has genetic algorithm
 * subroutines to generate a new population from an old one 
 * given the results of each car in the old population. It 
 * also has a subroutine for randomly generating a generation of cars
 * from scratch. *)
module type GenAlgorithm = sig
  (* type for a car (genome) 
   * genome has 8 genes for vertices of car body, 1 gene for front wheel radius,
   * and 1 other gene for back wheel radius*)
  type car = {v1:float*float;v2:float*float;v3:float*float;v4:float*float;
              v5:float*float;v6:float*float;v7:float*float;v8:float*float;
              r1:float;r2:float}

  (* population type is simply a list of cars *)
  type population = car list

  (* randomly generated initial population given the number of cars
   * in the population *)
  val initpopulation : int -> population

  (* breed a new population from a previous one given the results 
   * of the previous population *)
  val initpopulation : population -> results -> population

end