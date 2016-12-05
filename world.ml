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
  wheel_positions : Vect.t list;
}

module type World = sig
  type t
  val make : population -> t
  val with_terrain : (Vect.t list) -> population -> t
  val step : t -> t
  val get_car_state : t -> car_state list
  val get_terrain : t -> Vect.t list
end

let mask_offset v car_n = 
  int_of_float ((float_of_int v)*.2.0**(float_of_int (car_n*3)))

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
        let angle = (Random.float pi /. 2.0) -. (pi /. 4.0) in
        let v = Vect.rot (Vect.make 50.0 0.0) angle in
        let new_v = Vect.add v prev_v in
        let new_points = new_v::prev_v::t in

        let cp_prev_v = cpv_of_vect prev_v in
        let cp_new_v = cpv_of_vect new_v in
        
        (* Attach the shape to the body and put it in the space *)
        let shape = new cp_shape terr.body (SEGMENT_SHAPE(cp_prev_v, cp_new_v, 0.0)) in
        shape#set_friction 1.0;
        shape#set_elasticity 0.0;
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

  (* TODO: Support more than 1 car *)
  let make_cars (space : cp_space) pop = 
    match pop with
    | Population lst ->
        let car_list = ref [] in 
        for i = 0 to (List.length lst)-1 do 
          let car = List.nth lst i in
          (* TODO: Cacluate moment of interia and mass for body *)
          let body = new cp_body 10.0 100.0 in 
          let sort a b = 
            int_of_float (b.cp_y *. a.cp_x -. a.cp_y *. b.cp_x)
          in
          let add_chassis_triangle verts : unit =
            print_string "[|";
            Array.iter (fun x -> print_string ("("^(string_of_float x.cp_x)^", \
            "^(string_of_float x.cp_y)^"); "))
                       verts;
            print_string "|]";
            print_newline ();
            Array.sort sort verts;
            let shape = new cp_shape body (POLY_SHAPE(verts, cpv_zero)) in
            shape#set_friction 0.5;
            shape#set_elasticity 0.0;
            shape#set_layers (mask_offset 1 i);
            space#add_shape shape;
          in
          let rec get_chassis_shape lst = 
            let first_vert = List.hd lst in
            let rec chassis_triangles lst =
              
              print_string "first: "; print_float (fst first_vert); 
              match lst with
              | [] -> ()
              | e::[] -> 
                  let verts = [| 
                    cpv_of_polar e; 
                    cpv_of_polar first_vert;
                    cpv_zero |] in
                  Array.sort sort verts;
                  add_chassis_triangle verts;
                  ()
              | h1::h2::t -> 
                  let verts = [|
                    cpv_of_polar h2;
                    cpv_of_polar h1;
                    cpv_zero |] in
                  add_chassis_triangle verts;
                  chassis_triangles (h2::t);
            in
            chassis_triangles lst
          in

          body#set_pos (cpv 100.0 ((float_of_int i) *. 100.0 +. 200.0));
          space#add_body body;
          get_chassis_shape car.chassis;
          (* TODO: Add wheels *)
          (*List.iter (add_wheel car body space) car.wheels; *)
          let (whinfo1, whinfo2) = car.wheels in 
          let wheel1 = new cp_body 1.0 100.0 in
          let wheel2 = new cp_body 1.0 100.0 in 
          wheel1#set_pos (cpvadd body#get_pos (cpv_of_polar ((List.nth car.chassis whinfo1.vert))));
          wheel2#set_pos (cpvadd body#get_pos (cpv_of_polar (List.nth car.chassis whinfo2.vert)));
          space#add_body wheel1;
          space#add_body wheel2; 

          let j1 = new cp_joint body wheel1 (PIN_JOINT(cpvzero(), cpvzero()))
          and j2 = new cp_joint body wheel2 (PIN_JOINT(cpvzero(), cpvzero())) 
          and j3 = new cp_joint body wheel1 (PIN_JOINT(cpv 100.0 0.0, cpvzero())) 
          and j4 = new cp_joint body wheel2 (PIN_JOINT(cpv 100.0 0.0, cpvzero())) 
          and j5 = new cp_joint body wheel1 (PIN_JOINT(cpv 0.0 100.0, cpvzero())) 
          and j6 = new cp_joint body wheel2 (PIN_JOINT(cpv 0.0 100.0, cpvzero()))
          and j7 = new cp_joint wheel1 wheel2 (PIN_JOINT(cpvzero(), cpvzero())) in 
          space#add_constraint (j1#get_constraint);
          space#add_constraint (j2#get_constraint);
          space#add_constraint (j3#get_constraint);
          space#add_constraint (j4#get_constraint);
          space#add_constraint (j5#get_constraint);
          space#add_constraint (j6#get_constraint);
          space#add_constraint (j7#get_constraint);

          let wheelshape1 = new cp_shape wheel1 (CIRCLE_SHAPE(whinfo1.radius, cpvzero()))
          and wheelshape2 = new cp_shape wheel2 (CIRCLE_SHAPE(whinfo2.radius, cpvzero())) in 
          wheelshape1#set_friction 1.0;
          wheelshape2#set_friction 1.0;
          wheelshape1#set_layers (mask_offset 2 i);
          wheelshape2#set_layers (mask_offset 4 i);
          space#add_shape wheelshape1; 
          space#add_shape wheelshape2;
          car_list := { chassis = body; wheel1 = wheel1; wheel2 = wheel2 }::(!car_list)
        done;
        !car_list
    | Empty n -> failwith "make_cars with Empty not implemented"
  ;;

  let make pop =
    let space = new cp_space in
    init_chipmunk ();
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
    let torque = 60000.0 *. (min 1.0 ((wheel1#get_a_vel -. 1.0 *. max_w) /. max_w)) in 
    (* print_float torque; print_endline (" intended torque"); *)
    (* wheel1#set_torque (wheel1#get_torque +. torque); *)
    (* wheel2#set_torque (wheel1#get_torque); *)
    (* print_float (wheel1#get_torque); print_endline (" torque "); *)
    (* chassis#set_torque (chassis#get_torque -. torque); *)
    wheel1#set_a_vel (~-.20.0);
    wheel2#set_a_vel (~-.20.0);
    (* chassis#set_a_vel (~-. 10.0); *)
    (* chassis#set_force (cpv 50.0 (0.0)); *)
    {wheel1 = wheel1; wheel2 = wheel2; chassis = chassis}::step_cars xs'

  let step world = 
    let substeps = 100 in
    let dt = (1.0 /. 60.0) /. (float substeps) in
    for i=0 to pred substeps do
      let cars = step_cars world.cars in
      
 (*      print_float ((List.nth cars 0).wheel1#get_a_vel); print_string " ";
      print_float ((List.nth cars 0).chassis#get_pos).cp_y; print_newline (); *)
      
      (* print_float (((List.nth cars 0).wheel1#get_pos).cp_y -. ((List.nth cars 0).chassis#get_pos).cp_y); print_newline (); *)
      let space = world.space in 
      space#step dt;
    done;
    world

  let get_terrain t = t.terrain.points
  
  let vect_of_cpv v = Vect.make v.cp_x v.cp_y 

  let get_car_state t = 
    let rec get_cars lst = 
      match lst with
      | c::cs' -> 
          let angle = c.chassis#get_angle in
          let pos = vect_of_cpv (c.chassis#get_pos) in
          let wheel_angles = (c.wheel1#get_angle, c.wheel2#get_angle) in
          (* TODO: Hardcoded velocity to 0 *)
          let wheel_positions = [vect_of_cpv c.wheel1#get_pos; 
                                 vect_of_cpv c.wheel2#get_pos] in
          let velocity = 0.0 in
          {velocity = velocity; pos = pos; angle = angle; wheel_angles =
            wheel_angles; wheel_positions = wheel_positions }::(get_cars cs')
      | [] -> []
    in
    List.rev (get_cars t.cars)

  (* TODO: Dummy implementation *)
  let with_terrain terr pop = 
    let new_pop = make pop in 
    {new_pop with terrain = {new_pop.terrain with points = terr}}
end
module World = RealWorld

