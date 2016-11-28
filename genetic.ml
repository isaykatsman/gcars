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
  let pi = 3.14159265359

  let rec make_chassis n acc = 
    if n > 0 then
      let angle = Random.float (2.0 *. pi) in
      let radius = (Random.float 100.0) +. 100.0 in 
      make_chassis (n-1) ((radius, angle)::acc)
    else
      let chassis = List.sort (fun x y -> compare (snd x) (snd y)) acc in 
      chassis
  
  let make_car () = 
    let w1_vert = Random.int 7 in
    {
      chassis = make_chassis 8 [];
      wheels = (
        {radius=50.0; vert = w1_vert    },
        {radius=50.0; vert = w1_vert + 1}
      )
    }

  let rec make_cars n acc =
    if n = 0 then acc 
    else make_cars (n - 1) ((make_car ())::acc)

  let new_population pop scores rate = 
    let size = 
      match pop with
      | Empty n -> n
      | Population lst -> List.length lst in
    let w1_vert = Random.int 7 in
    let cars = make_cars size [] in
    Population cars    
end

module Genetic = FakeGenetic
