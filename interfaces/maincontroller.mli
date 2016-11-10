(* [Main] is the module responsible for maintenance of an internal
 * state and coordinating *)
module type Main = sig
  (* type for a car (genome) 
   * genome has 8 genes for vertices of car body, 1 gene for front wheel radius,
   * and 1 other gene for back wheel radius*)
  type car = {v1:float*float;v2:float*float;v3:float*float;v4:float*float;
              v5:float*float;v6:float*float;v7:float*float;v8:float*float;
              r1:float;r2:float}

  (* population type is simply a list of cars *)
  type population = car list

  (* state type maintains population and some contants *)
  type state = {pop:population; mutationrate: float; numcars: int}
  
  (* initiate the simulation *)
  val runsimulation : int -> population

end