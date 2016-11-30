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
      let radius = (Random.float 50.0) +. 50.0 in
      make_chassis (n-1) ((radius, angle)::acc)
    else
      let chassis = List.sort (fun x y -> compare (snd x) (snd y)) acc in
      chassis

  let make_car () =
    let w1_vert = Random.int 7 in
    {
      chassis = make_chassis 8 [];
      wheels = (
        {radius=25.0; vert = w1_vert    },
        {radius=25.0; vert = w1_vert + 1}
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

module RealGenetic : GeneticCarAlgo = struct
  let pi = 3.14159265359
  let max_wheel_radius = 50.0
  let min_wheel_radius = 50.0
  let gen_size = 20

  (* remember entire module only responsible for generating a new population,
   * based on scoring metric. also determines similarity rating as a
   * sanity check. *)

  let rec make_chassis n acc =
    if n > 0 then
      let angle = Random.float (2.0 *. pi) in
      let radius = (Random.float max_wheel_radius) +. min_wheel_radius in
      make_chassis (n-1) ((radius, angle)::acc)
    else
      let chassis = List.sort (fun x y -> compare (snd x) (snd y)) acc in
      chassis

  let make_car () =
    let w1_vert = Random.int 7 in
    {
      chassis = make_chassis 8 [];
      wheels = (
        {radius=25.0; vert = w1_vert    },
        {radius=25.0; vert = w1_vert + 1}
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

  (* negative log distribution for parent selection *)
  let get_parent gen_size =
    let rand = Random.float 1. in
    if rand = 0. then
      0
    else
      (* healthy parents assumed to be 0-4, 5 carries this emphasis *)
      (int_of_float (floor(-.1. *. log(rand) *. 5.))) mod gen_size

  (* uses swap points to return what parent to use
   * assum there are only 2 parents for a car *)
  let choose_parent swap_point1 swap_point2 cur_parent gene_index =
    if swap_point1 = gene_index || swap_point2 = gene_index then
      if cur_parent = 1 then 0 else 1
    else
      cur_parent (* no swap necessary *)

  (* mutates the traits according to the mutation rate (probability)
   * this is AFTER a new car is synthesized from 2 parents *)


  (* computes euclidean distance between the lists of points
   * precondition: lists are of same length *)
  let rec list_dist l1 l2 accum =
    match l1,l2 with
    | [],[] -> accum
    | h1::t1,h2::t2 -> list_dist t1 t2 (accum+.((fst h1)-.(fst h2))**2. +.
                                              ((snd h1)-.(snd h2))**2.)

  (* euclidean distance between the feature genomes of two cars
   * TODO: do feature normalization *)
  let car_dist c1 c2 =
    sqrt (((fst c1.wheels).radius-.(fst c2.wheels).radius)**2. +.
          (* ((fst c1.wheels).vert-.(fst c2.wheels).vert)**2. + *)
          ((snd c1.wheels).radius-.(snd c2.wheels).radius)**2. +.
          (* ((snd c1.wheels).vert-.(snd c2.wheels).vert)**2. + *)
          (list_dist c1.chassis c2.chassis 0.))

  (* determines similarity of a generation to a car
   * used to diagnose whether the genetic algorithm really
   * is using the best car for gene pool influence *)
   let similarity_diagnostic pop car =
     let car_list =
       match pop with
       | Empty n -> []
       | Population lst -> lst
     in
     let rec compute_dist_car_list cars c accum =
       match cars with
       | [] -> accum
       | h::t -> compute_dist_car_list t c (accum+.(car_dist h c))
     in
     (* now compute averaged euclidean distance *)
     (compute_dist_car_list car_list car 0.) /. (float_of_int (List.length car_list))

end

module Genetic = FakeGenetic
