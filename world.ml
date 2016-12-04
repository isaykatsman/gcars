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
  let cpv_zero = cpvzero ()

  type car_model = {
    chassis : cp_body;
    wheel1 : cp_body;
    wheel2 : cp_body; 
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

  let cpv_of_polar (r, theta) =
    let x = r *. cos(theta) in
    let y = r *. sin(theta) in
    cpv x y

(*
  let add_wheel car_genome body space wheel =
    let pos_polar = List.nth car_genome.chassis wheel.vert in
    let pos_cpv = cpv_of_polar pos_polar in
    let radius = wheel.radius in
    ()
*)
  (* TODO: Support more than 1 car *)
  let make_cars (space : cp_space) pop = 
    match pop with
    | Population lst ->
        if (List.length lst) > 1 then
          failwith "More than 1 car not implemented"
        else
          let car = List.hd lst in
          (* TODO: Cacluate moment of interia and mass for body *)
          let body = new cp_body 5.0 3.0 in 

          let add_chassis_triangle verts : unit =
            let shape_verts = [|
              cpv (-50.) (-50.);
              cpv (-50.) ( 50.);
              cpv ( 50.) ( 50.);
              cpv ( 50.) (-50.);
            |] in
            print_string "[|";
            Array.iter (fun x -> print_string ("("^(string_of_float x.cp_x)^", \
            "^(string_of_float x.cp_y)^"); "))
                       verts;
            print_string "|]";
            print_newline ();
            let shape = new cp_shape body (POLY_SHAPE(verts, cpv_zero)) in
            shape#set_friction 0.5;
            space#add_shape shape;
          in

          let rec chassis_triangles lst : unit =
            let first_vert = List.hd lst in
            match lst with
            | [] -> ()
            | e::[] -> () (*
                let verts = [| 
                  cpv_of_polar e; 
                  cpv_of_polar first_vert;
                  cpv_zero |] in
                add_chassis_triangle verts body space;*)
            | h1::h2::t -> 
                let verts = [|
                  cpv_of_polar h2;
                  cpv_of_polar h1;
                  cpv_zero |] in
                add_chassis_triangle verts;
                chassis_triangles (h2::t);
          in

          body#set_pos (cpv 200.0 500.0);
          space#add_body body;
          chassis_triangles car.chassis;
          (* TODO: Add wheels *)
          (*List.iter (add_wheel car body space) car.wheels; *)
          let wheel1 = new cp_body 1.0 1.0 in
          let wheel2 = new cp_body 1.0 1.0 in 
          space#add_body wheel1;
          space#add_body wheel2;
          [{ chassis = body; wheel1 = wheel1; wheel2 = wheel2 }]
    | Empty n -> failwith "make_cars with Empty not implemented"
  ;;

  let make pop =
    let space = new cp_space in
    space#set_gravity (cpv 0.0 (-980.0)); 
    let terr = make_terrain 100 space in
    let cars = make_cars space pop in
    { cars = cars; space = space; terrain = terr }

  let rec step_cars = function
  | [] -> [] 
  | x::xs' -> 
    let chassis = x.chassis
    and wheel1 = x.wheel1
    and wheel2 = x.wheel2 in
    chassis#reset_forces;
    wheel1#reset_forces;
    wheel2#reset_forces;
    let max_w = -100.0 in
    let torque = 60000.0 *. (min 1.0 ((wheel1#get_a_vel -. 0.1 *. max_w) /. max_w)) in 
    (* wheel1#set_torque (wheel1#get_torque +. torque); *)
    (* wheel2#set_torque (wheel1#get_torque); *)
    (* chassis#set_torque (chassis#get_torque -. torque); *)
    wheel1#set_a_vel 10.0;
    chassis#set_a_vel 1.0;
    {wheel1 = wheel1; wheel2 = wheel2; chassis = chassis}::step_cars xs'

  let step world = 
    let substeps = 100 in
    let dt = (1.0 /. 60.0) /. (float substeps) in
    for i=0 to pred substeps do
      let cars = step_cars world.cars in
      print_float ((List.nth cars 0).wheel1#get_a_vel); print_newline ();
      let space = world.space in 
      space#step dt;
    done;
    world

  let get_terrain t = t.terrain.points
  
  let vect_of_cpv v = Vect.make v.cp_x v.cp_y 

  let get_car_state t = 
    match t.cars with
    | [c] -> 
        let angle = c.chassis#get_angle in
        let pos = vect_of_cpv (c.chassis#get_pos) in
        let wheel_angles = (c.wheel1#get_angle, c.wheel2#get_angle) in
        (* TODO: Hardcoded velocity to 0 *)
        let velocity = 0.0 in
        [{velocity = velocity; pos = pos; angle = angle; wheel_angles =
          wheel_angles}]
    | _ -> failwith "get_car_state with more than 1 car not implemented"

  (* TODO: Dummy implementation *)
  let with_terrain terr pop = make pop
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

module World = RealWorld

