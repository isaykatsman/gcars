(* open Chipmunk
open OO *)
open Vect
open Genetic

type car_state = {
  velocity : float;
  pos : Vect.t;
  angle : float; (* in radians *)
  wheel_angles : float * float;
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
        let v = Vect.rot (Vect.make 100.0 0.0) angle in
        let v_new = Vect.add v prev_v in
        let v1_str = Vect.to_string prev_v in
        let v2_str = Vect.to_string v_new in
        make_terrain (n - 1) (v_new::prev_v::t)


  let initial_state () = { 
    velocity = Random.float 1.0; 
    pos = Vect.make 0.0 0.0; 
    angle = 0.0;
    wheel_angles = (1.0, 2.0)
  }

  let make_states n acc =
    if n = 0 then acc 
    else (initial_state ())::acc

  let make pop =
    let size = 
      match pop with
      | Empty n -> n
      | Population lst -> List.length lst in
    let car_states = make_states size [] in
    { cars = car_states; terrain = (make_terrain 20 [])}

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
