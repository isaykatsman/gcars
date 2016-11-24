open Chipmunk
open OO


module FakeWorld = struct
  type t = { cars : car_state list; terrain : Vect.t list }

  let pi = 3.14159265359
  
  let rec make_terrain n acc =
    if n = 0 then acc
    else
    match acc with
    | [] -> Vect.origin  
    | lst -> 
        let angle = (Random.float pi) -. (pi/2) in
        let v = Vect.rot (Vect.make 50.0 0) angle in
        v::lst

  let create_world pop =
    match population with
    | Empty n -> 
        (* let car1 = { velocity = 0.0; pos = Vect.origin; angle = 0.0 } in
        let car2 = { velocity = 0.0; pos = Vect.origin; angle = 0.0 } in
        let car_states = [car1; car2] in *)
        { cars = []; terrain = make_terrain 50 }
         
    | Population lst -> 
        failwith "FakeWorld.make can only take in an Empty population"
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
