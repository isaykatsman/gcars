(* open Chipmunk
open OO *)
open Vect
open Genetic

type car_state = {
  velocity : float;
  pos : Vect.t;
  angle : float; (* in radians *)
}

module type World = sig
  type t
  val make : population -> t
  val step : t -> t
  val get_car_state : t -> car_state list
  val get_terrain : t -> Vect.t list
end

module FakeWorld = struct
  type t = { cars : car_state list; terrain : Vect.t list }

  let pi = 3.14159265359
  
  let rec make_terrain n acc =
    if n = 0 then acc
    else
    match acc with
    | [] -> make_terrain n [Vect.origin]
    | prev_v::t -> 
        let angle = (Random.float pi) -. (pi /. 2.0) in
        let v = Vect.rot (Vect.make 50.0 0.0) angle in
        let v_new = Vect.add v prev_v in
        let v1_str = Vect.to_string prev_v in
        let v2_str = Vect.to_string v_new in
        print_endline ("line from "^v1_str^" to "^v2_str);
        make_terrain (n - 1) (v_new::prev_v::t)

  let make pop =
    match pop with
    | Empty n -> 
        let car1 = { velocity = 0.0; pos = Vect.origin; angle = 0.0 } in
        let car2 = { velocity = 0.0; pos = Vect.origin; angle = 0.0 } in
        let car_states = [car1; car2] in
        { cars = car_states; terrain = (make_terrain 5 [])}
         
    | Population lst -> 
        failwith "FakeWorld.make can only take in an Empty population"

  let get_terrain t = t.terrain
  let get_car_state t = t.cars
  let step world = world
end

module World = FakeWorld

(* module World = struct

  type car_model = {
    chassis : cp_body ref;
    wheel1 : cp_body ref;
    wheel2 : cp_body ref; 
  }

  type t = {
    cars : car_model list;
    terrain : float list;
    space : cp_space ref;
    num_steps : int;
  }
end *)
