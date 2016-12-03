open Chipmunk
open OO
open Low_level
(*
open Vect
open Genetic
*)

type car_state = {
  velocity : float;
  pos : Vect.t;
  angle : float; (* in radians *)
  wheel_angles : float * float;
}

module type World = sig
  type t
  val make : population -> t
  val with_terrain : (Vect.t list) -> population -> t
  val step : t -> t
  val get_car_state : t -> car_state list
  val get_terrain : t -> Vect.t list
end

module RealWorld = struct
  type car_model = {
    chassis : cp_body ref;
    wheel1 : cp_body ref;
    wheel2 : cp_body ref; 
  }

  type terrain = {
    points : Vect.t list;
    body : cp_body;
    shapes: cp_shape list;
  }

  type t = {
    cars : car_model list;
    space : cp_space;
    terrain : terrain;
  } 


  let cpv_of_vect v = cpv (Vect.x v) (Vect.y v)

  let make_terrain len (space : cp_space) =
    let empty_terrain = {
      points = [Vect.origin];
      body = new cp_body infinity infinity;
      shapes = [];
    } in

    let rec make_terrain_inner n terr =
      if n = 0 then 
        terr
      else
        let prev_v::t = terr.points in
        let angle = (Random.float pi) -. (pi /. 2.0) in
        let v = Vect.rot (Vect.make 50.0 0.0) angle in
        let new_v = Vect.add v prev_v in
        let new_points = new_v::prev_v::t in

        let cp_prev_v = cpv_of_vect prev_v in
        let cp_new_v = cpv_of_vect new_v in
        
        (* Attach the shape to the body and put it in the space *)
        let shape = new cp_shape terr.body (SEGMENT_SHAPE(cp_prev_v, cp_new_v, 0.0)) in
        shape#set_friction 1.0;
        space#add_static_shape shape;
        let new_shapes = shape::terr.shapes in

        let new_terr = { terr with points = new_points; shapes = new_shapes } in
        make_terrain_inner (n - 1) new_terr 
    in

    make_terrain_inner len empty_terrain

  let make pop =
    let space = new cp_space in
    space#set_gravity (cpv 0.0 (-980.0)); 
    let terr = make_terrain 100 space in
     
    { cars = []; space = space; terrain = terr }
     
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
        make_terrain (n - 1) (v_new::prev_v::t)

  let rec make_states n acc =
    if n = 0 then acc 
    else 
      let car = { 
        velocity = Random.float 10.0; 
        pos = Vect.make 0.0 0.0; 
        angle = 0.0;
        wheel_angles = (1.0, 2.0)
      } in
      make_states (n-1) (car::acc)

  let with_terrain terr pop = 
    let size = 
      match pop with
      | Empty n -> n
      | Population lst -> List.length lst in
    let car_states = make_states size [] in
    { cars = car_states; terrain = terr }

  let make pop =
    let terr = make_terrain 100 [] in
    with_terrain terr pop

  let get_terrain t = t.terrain
  let get_car_state t = t.cars

  let step_car car_state =
    let vel = car_state.velocity in
    let dx = Vect.make vel 0.0 in
    let new_pos = Vect.add car_state.pos dx in
    let new_wheel_angles = 
      match car_state.wheel_angles with
      | (a1, a2) -> (a1 +. 0.5, a2 +. 0.5) in
    { car_state with pos = new_pos; angle = (car_state.angle +. 0.05);
      wheel_angles = new_wheel_angles }

  let step world = 
    let new_states = List.map step_car world.cars in
    { world with cars = new_states }
end

module World = FakeWorld

