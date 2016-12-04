type wheel = {radius : float; vert : int}

type car_genome = {
  chassis : (float * float) list;
  wheels : (wheel * wheel);
}

type population =
  | Population of car_genome list
  | Empty of int

(* needed to initiate world *)
type world_params = {
  mut_rate : float; (* value: 0-1; fraction of genes that will be mutated
                     * randomly. *)
  mut_range : float; (* value: 0-1; multiplier for actual range*)
  r_min : float; (* value: unconstrained; minimum r value for body vertices *)
  r_range : float; (* value: unconstrained; range r value for body vertices *)
  wheel_min : float; (* value: unconstrained; radius for wheels *)
  wheel_range : float; (* value: unconstrained; range for wheel radius *)
}

(* mutation params for one type of data *)
type mutation_params = {
  mut_rate : float;
  mut_range : float;
  min: float;
  range: float;
}

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
    let fake_r = 100.0 in 
    let w1_vert = Random.int 7 in
    {
      chassis = make_chassis 8 [];
      (* chassis = [(fake_r,0.0);(fake_r,pi/.2.0);(fake_r,pi);(fake_r, 3.0*.pi/.2.0)]; *)
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
    let w1_vert = Random.int 8 in
    let w2_vert_tmp = Random.int 8 in
    let w2_vert = if w1_vert = w2_vert_tmp then (w2_vert_tmp + 1) mod 8 else
      w2_vert_tmp in
    {
      chassis = make_chassis 8 [];
      wheels = (
        {radius=(Random.float 30.0) +. 10.0; vert = w1_vert },
        {radius=(Random.float 30.0) +. 10.0; vert = w2_vert }
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

  (* uses swap points to return what parent to use
   * assum there are only 2 parents for a car *)
  let choose_parent swap_point1 swap_point2 cur_parent gene_index =
    if swap_point1 = gene_index || swap_point2 = gene_index then
      if cur_parent = 1 then 0 else 1
    else
      cur_parent (* no swap necessary *)

  (* mutate value with probability of mutation_rate which is
   * stored in p, the parameters of the mutation *)
  let mutate_value value (p:mutation_params) =
    if Random.float 1. < p.mut_rate then
      let mut_span = p.range *. p.mut_range in
      let mut_base = value -. 0.5 *. mut_span in
      (* prevent mutation from going over allowed
       * max/min value *)
      if mut_base < p.min then
        p.min +. mut_span *. (Random.float 1.)
      else if mut_base > p.min +. (p.range -. mut_span) then
        p.min +. (p.range -. mut_span) +. mut_span *. (Random.float 1.)
      else
        mut_base +. mut_span *. (Random.float 1.)
    else
      (* no mutation applied *)
      value

  (* mutate a vertex of the chassis,
   * uses mutation parameters from p
   * TODO: perturb theta, set as secod coordinate *)
  let mutate_vertex vert p theta =
    let mutatedr = mutate_value (fst vert) p in
    (mutatedr, theta)

  (* mutate 8 vertices of chassis.
   * use mutation parameters provided by p *)
  let rec mutate_chassis chassis p verts accum =
    match chassis with
    | [] -> verts
    | h::t -> mutate_chassis t p ((mutate_vertex h p (accum*.pi/.2.))::verts) (accum+.1.)

  (* mutate wheel vert *)
  let mutate_wheel_vert value num_verts =
    let wheel = (((Random.int (int_of_float num_verts)) - (int_of_float num_verts))
                 + value + (int_of_float num_verts)) mod (int_of_float num_verts)
    in
    wheel

  (* mutate a single wheel *)
  let mutate_wheel w p =
    let newr = mutate_value w.radius p in
    let newv = mutate_wheel_vert w.vert 8. in
    {radius = newr; vert = newv}

  (* mutate wheel radii, with mutation parameters p*)
  let mutate_wheels wheels p =
    let left = mutate_wheel (fst wheels) p in
    let right = mutate_wheel (snd wheels) p in
    (left, right)

  (* mutates the traits according to the mutation rate (probability)
   * this is AFTER a new car is synthesized from 2 parents
   * returns the mutated car *)
  let mutate_car car (p:world_params) =
    let p_wheels = {mut_rate = p.mut_rate; mut_range = p.mut_range;
                    min = p.wheel_min; range = p.wheel_range} in
    let p_chassis = {mut_rate = p.mut_rate; mut_range = p.mut_range;
                    min = p.r_min; range = p.r_range} in
    let prevchassis = car.chassis in
    let prevwheels = car.wheels in
    let newchassis = List.rev (mutate_chassis prevchassis p_chassis [] 0.) in
    let newwheels = mutate_wheels prevwheels p_wheels in
    {chassis = newchassis; wheels = newwheels}

  (* randomly gets two swap points from the number of attributes
   * precondition: if initial call, p1 = p2, so that random
   * points actually get chosen *)
  let rec get_swap_points numgenes p1 p2 =
    if p1 = p2 then
      let p1 = Random.int numgenes in
      let p2 = Random.int numgenes in
      get_swap_points numgenes p1 p2
    else
      (p1, p2)

  (* returns proper parents based on parent index *)
  let get_parent index parent1 parent2 =
    if index = 0 then parent1 else parent2

  (* make wheels of child from parents based on swap points *)
  let make_child_wheels parent1 parent2 swp1 swp2 start_parent start_index =
    let n1_parent = choose_parent swp1 swp2 start_parent start_index in
    let w1_rad = (fst (get_parent n1_parent parent1 parent2).wheels).radius in
    let n2_parent = choose_parent swp1 swp2 n1_parent start_index+1 in
    let w1_vert = (fst (get_parent n2_parent parent1 parent2).wheels).vert in
    let n3_parent = choose_parent swp1 swp2 n2_parent start_index+2 in
    let w2_rad = (snd (get_parent n3_parent parent1 parent2).wheels).radius in
    let n4_parent = choose_parent swp1 swp2 n3_parent start_index+3 in
    let w2_vert = (snd (get_parent n4_parent parent1 parent2).wheels).vert in
    let w1 = {radius = w1_rad; vert = w1_vert} in
    let w2 = {radius = w2_rad; vert = w2_vert} in
    (n4_parent, (w1,w2))

  (* make child vertices from both parents based on swap points
   * TODO?: assumes number of genes before wheels is 4 *)
  let rec make_child_vertices verts parent1 parent2 swp1 swp2 cur_parent cur_index numverts =
    if cur_index < numverts then
      let new_parent = choose_parent swp1 swp2 cur_parent 4+cur_index in
      let newvert = List.nth (get_parent new_parent parent1 parent2).chassis cur_index in
      make_child_vertices (newvert::verts) parent1 parent2 swp1 swp2 new_parent (cur_index+1) numverts
    else
      verts

  (* make a child using the attributes of two parents of the
   * previous generation
   * TODO: assumes that num_genes is 8+4 = 12, indexed from 0-11*)
  let make_child parent1 parent2 =
    let swap_points = get_swap_points 12 0 0 in
    let swp1 = (fst swap_points) in
    let swp2 = (snd swap_points) in
    let start_parent = Random.int 1 in
    let childwheels_pkg = make_child_wheels parent1 parent2 swp1 swp2 start_parent 0 in
    let cur_parent = fst childwheels_pkg in
    let childwheels = snd childwheels_pkg in
    let childverts = make_child_vertices [] parent1 parent2 swp1 swp2 cur_parent 0 8 in
    {chassis = childverts; wheels = childwheels}

  (* sort from highest to lowest score, so that
   * list is sorted from healthiest to leaset healthy parents *)
  let sort_cars pop scores =
    let car_list = match pop with Empty _ -> [] | Population pop -> pop in
    (* when mergin we assume that p and s have the same length *)
    let rec merge_list p s accum =
      match p with
      | [] -> accum
      | h::t -> merge_list t (List.tl s) (((List.hd s), h)::accum)
    in
    let merged_list = merge_list car_list scores [] in
    let sorted_list = List.sort (fun (x,_) (y,_) -> if x > y then -1 else 1)
                                merged_list in
    let rec unmerge_list p accum =
      match p with
      | [] -> accum
      | (s,car)::t -> unmerge_list t (car::accum)
    in
    let cars_sorted_by_score = unmerge_list sorted_list [] in
    cars_sorted_by_score

  (* negative log distribution for parent selection *)
  let generate_parent gen_size =
    let rand = Random.float 1. in
    if rand = 0. then
      0
    else
      (* healthy parents assumed to be 0-4, 5 means 62.3% of the
       * random distribution is covered by the 0-4 values *)
      (int_of_float (floor(-.1. *. log(rand) *. 5.))) mod gen_size

  (* picks two different random numbers according to log distribution
   * for parents - emphasizes earlier, higher-scoring parents *)
  let rec generate_parents gen_size emph p1 p2 =
    if p1 = p2 then
      let p1 = generate_parent gen_size in
      let p2 = generate_parent gen_size in
      generate_parents gen_size emph p1 p2
    else
      (p1, p2)

  (* make gen_size children from parents, selecting two top parents
   * each time *)
  let rec generate_children gen_size parent_list decr_gen_size accum =
    if decr_gen_size > 0 then
      (* 63.2% of parent distribution skewed toward first 5 *)
      let (p1, p2) = generate_parents gen_size 5 0 0 in
      let parent1 = List.nth parent_list p1 in
      let parent2 = List.nth parent_list p2 in
      generate_children gen_size parent_list (decr_gen_size-1)
                        ((make_child parent1 parent2)::accum)
    else
      accum

  (* mutate the children with world parameters p *)
  let rec mutate_children children p accum =
    match children with
    | [] -> accum
    | h::t -> mutate_children t p ((mutate_car h p)::accum)

  (* when make new generation, need initial random generation of
   * a car list, and then if not initial, need parent selection of
   * previous generation based on scores *)
  let new_population pop scores rate =
    let init = match pop with Empty _ -> true | Population _ -> false in
    let size = match pop with Empty n -> n | Population lst -> List.length lst in
    if init then
      (* randomly initialize first population of cars *)
      let cars = make_cars size [] in Population cars
    else
      (* if generating based off of a previous generation,
       * need to sort most healthy parents, and then
       * create new population of children based off of
       * most healthy parents, and then perturb the genes
       * of those children according to mutation rate *)
      let sorted_cars = sort_cars pop scores in
      (* generate a new generation of 20 children populated with top parents'
       * genes *)
      let new_children = generate_children 20 sorted_cars 20 [] in
      let world_parameters = {mut_rate = 0.05; mut_range = 1.0;
                              wheel_min = 50.0; wheel_range = 50.0;
                              r_min = 50.0; r_range = 50.0} in
      (* according to world_parameters, mutate and perturb the genes of
       * the children *)
      let mutated_children = mutate_children new_children world_parameters [] in
      (* now simply return the new generation of cars in a population variant *)
      Population mutated_children

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
