open GL
open Glu
open Glut
(*
open World
open Vect
open Genetic
*)
module type Graphics = sig
  type t
  val init : unit -> unit
  val make : population -> t
  val draw : t -> float list -> World.t -> int -> float -> unit
end

module Graphics = struct
  type precomputed_car = { 
    verts : Vect.t list; 
    genome : car_genome; 
    color : (float * float * float) 
  }

  type t = { precomputed_cars : precomputed_car list } 

  let window_width = 640
  let window_height = 700
  let world_height = 480
  let hud_height = window_height - world_height
  let graph_width = (window_width / 2) - 10

  let polar_to_vect (r, theta) =
    let x = r *. cos(theta) in
    let y = r *. sin(theta) in
    Vect.make x y

  let rec get_chassis_verts chassis acc =
    match chassis with
    | [] -> acc
    | h::t -> get_chassis_verts t ((polar_to_vect h)::acc)
 
  let rec init_precomputed_cars cars acc : precomputed_car list =
    match cars with
    | [] -> acc
    | curr::next ->
        (* let chassis = List.sort (fun x y -> compare (snd x) (snd y))
        curr.chassis in *)
        let chassis = curr.chassis in
        let verts = get_chassis_verts chassis [] in
        let first_vert = polar_to_vect (List.hd chassis) in
        let verts_new = (first_vert::verts) in 
        let car_genome = curr in 
        let color = (Random.float 1.0, Random.float 1.0, Random.float 1.0) in
        let new_acc = acc@[{genome = car_genome; verts = verts_new; color =
          color}] in 
        init_precomputed_cars next new_acc

  let draw_line v1 v2 = 
    glBegin(GL_LINES);
      glVertex2 (Vect.x v1) (Vect.y v1);
      glVertex2 (Vect.x v2) (Vect.y v2);
    glEnd();
  ;;

  let draw_triangle v1 v2 v3 = 
    glBegin(GL_TRIANGLES);
      glVertex2 (Vect.x v1) (Vect.y v1);
      glVertex2 (Vect.x v2) (Vect.y v2);
      glVertex2 (Vect.x v3) (Vect.y v3);
    glEnd();
  ;;
    
  let rec get_furthest_car cars furthest =
    match cars with
   | [] -> furthest
    | h::t -> 
        let new_furthest = 
          if (Vect.x h.pos) > (Vect.x furthest.pos) then h
          else furthest in
        get_furthest_car t new_furthest

  let rec draw_polyline_aux (verts : Vect.t list) (prev_vert : Vect.t) (angle :
    float) (pos : Vect.t) closed = 
    match verts with
    | [] -> ()
    | curr_vert::next_verts ->
        let curr_rot = Vect.rot curr_vert angle in
        let curr_disp = Vect.add curr_rot pos in
        let () = if closed then draw_triangle prev_vert curr_disp pos
                 else draw_line prev_vert curr_disp in
        draw_polyline_aux next_verts curr_disp angle pos closed
  ;;

  let draw_polyline ?closed:(close=false) verts angle pos = 
    match verts with
    | [] -> print_endline "Call to draw_polyline with verts list of length 0";
    | [v] -> print_endline "Call to draw_polyline with verts list of length 1";
    | h::t -> 
        let first_vert = Vect.add (Vect.rot h angle) pos in
        draw_polyline_aux t first_vert angle pos close


  (* This function was adapted from code in the OCaml Chipmunk Moon Buggy Demo 
   * https://github.com/fccm/ocaml-chipmunk-trunk/blob/master/demos/moon_buggy.ml
   *)
  let draw_wheel pos r a (col00, col01, col02) (col10, col11, col12) = 
    let x = (Vect.x pos) in
    let y = (Vect.y pos) in 
    let segs = 30 in
    let coef = 2.0 *. pi /. (float segs) in

    glColor3 col00 col01 col02;
    glBegin GL_TRIANGLES;
      for n=0 to pred segs do
        let rads0 = (float n) *. coef in
        let rads1 = ((float_of_int n) +. 1.0) *. coef in
        glVertex2 (r *. cos(rads0 +. a) +. x)
                  (r *. sin(rads0 +. a) +. y);
        glVertex2 (r *. cos(rads1 +. a) +. x)
                  (r *. sin(rads1 +. a) +. y);
        glVertex2 x y;
      done;
    glEnd ();

    glColor3 col10 col11 col12;
    glBegin GL_LINE_LOOP;
      for n=0 to pred segs do
        let rads = (float n) *. coef in
        glVertex2 (r *. cos(rads +. a) +. x)
                  (r *. sin(rads +. a) +. y);
      done;
      glVertex2 (r *. cos(a) +. x)
                (r *. sin(a) +. y);
      glVertex2 x y;
    glEnd();
  ;;

  let draw_wheels car state = 
    let wheel_pos w =
      let pair = List.nth car.genome.chassis w.vert in
      let vect = polar_to_vect pair in
      Vect.add (Vect.rot vect state.angle) state.pos 
    in
    match (car.genome.wheels, state.wheel_angles) with
    | ((w1, w2), (w1_angle, w2_angle)) -> 
        let in_color = (0.7, 0.7, 0.7) in
        let out_color = (0.4, 0.4, 0.4) in
        let w1_pos = List.nth state.wheel_positions 0 in
        let w2_pos = List.nth state.wheel_positions 1 in
        draw_wheel w1_pos  w1.radius w1_angle in_color out_color;
        draw_wheel w2_pos w2.radius w2_angle in_color out_color;
  ;;

  let darken (c1, c2, c3) =
    let darken_channel c =
      let new_c = c -. 0.5 in
      if new_c < 0.0 then 0.0 else c in
    (darken_channel c1, darken_channel c2, darken_channel c3)
    
  let draw_car car state =
    let (c1, c2, c3) = car.color in
    glColor3 c1 c2 c3;
    draw_polyline car.verts state.angle state.pos ~closed:true;
    let (c1d, c2d, c3d) = darken car.color in
    glColor3 c1d c2d c3d;
    draw_polyline car.verts state.angle state.pos ~closed:false;
    draw_wheels car state;
  ;;

  let explode s =
    let rec exp i l =
     if i < 0 then l else exp (i - 1) (s.[i] :: l) in
    exp (String.length s - 1) [];;

  let draw_string s x y = 
    let chars = explode s in
    glColor3 0.0 0.0 0.0;
    glLineWidth 1.5;
    glPointSize 0.1;
    glPushMatrix ();
    glTranslate x y 0.0;
    glScale 0.1 0.1 0.1;
    List.iter (fun c -> glutStrokeCharacter GLUT_STROKE_ROMAN c) chars;
    glPopMatrix ();

  exception Cars_precomputed_length
  let rec draw_cars precomp states =
    match (precomp, states) with
    | ([], []) -> ()
    | (precomp_entry::precomp_tl, state::states_tl) -> 
        draw_car precomp_entry state;
        draw_cars precomp_tl states_tl
    | (_, _) -> raise Cars_precomputed_length

  (* Actually draw the world. Requires that get_car_info world is not [] *)
  let draw graphics prev_max_scores world num_cars mutation_rate = 
    let car_states = World.get_car_state world in

    (* Move the furthest along car into view *)
    let furthest = get_furthest_car car_states (List.hd car_states) in

    glClear [GL_COLOR_BUFFER_BIT];
    glLoadIdentity();
    let furthest_x = (Vect.x furthest.pos) in
    let furthest_y = (Vect.y furthest.pos) in 
    let camera_y = furthest_y -. ((float_of_int hud_height) /. 2.0) in
    glTranslate (-. furthest_x) (-. camera_y) 0.0;
    
    (* Draw the cars and terrain *)
    glColor3 0.0 0.0 0.0;
    let terrain = World.get_terrain world in
    draw_polyline terrain 0.0 (Vect.origin);
    draw_cars graphics.precomputed_cars car_states;

    (* Draw the HUD background. Coords relative to center of frame. *)
    let hud_x = furthest_x -. ((float_of_int window_width) /. 2.0) in
    let hud_y = furthest_y -. ((float_of_int window_height) /. 2.0) 
                -. ((float_of_int hud_height) /. 2.0)  in
    glColor3 0.9 0.9 0.9;
    glRect ~x1:hud_x ~y1:hud_y
           ~x2:(hud_x +. (float_of_int window_width))
           ~y2:(hud_y +. (float_of_int hud_height));

    let x_inc = (float_of_int graph_width) /. 
                (float_of_int ((List.length prev_max_scores) - 1)) in
    
    let max_y = List.fold_left max 0.0 prev_max_scores in
    let min_y = List.fold_left min max_float prev_max_scores in

    let rec get_graph_points idx lst acc =
      match lst with
      | [] -> acc
      | h::t -> 
          let x = (x_inc *. (float_of_int idx)) in
          let y = (((h -. min_y) /. (max_y -. min_y)) *. (float_of_int
          (hud_height - 40))) +. 10.0 in
          let p = Vect.make (hud_x +. ((float_of_int window_width) /. 2.0) +. x) 
                            (hud_y +. y) in
          get_graph_points (idx - 1) t (p::acc) in

    let graph_x = (hud_x +. ((float_of_int window_width) /. 2.0)) in
    glColor3 0.8 0.8 0.8;
    glRect ~x1:graph_x
           ~y1:(hud_y +. 10.0)
           ~x2:(hud_x +. (float_of_int window_width) -. 10.0)
           ~y2:(hud_y +. (float_of_int hud_height) -. 30.0);
     
    let start_idx = (List.length prev_max_scores) - 1 in
    let graph_line = get_graph_points start_idx prev_max_scores
                                      [] in
    glColor3 1.0 0.0 0.0;
    let () = 
      if (List.length prev_max_scores) >= 2 then 
        draw_polyline graph_line 0.0 Vect.origin; in
  
    let curr_gen = string_of_int ((List.length prev_max_scores) + 1) in
    let num_cars_str = string_of_int num_cars in
    let mut_rate_str = string_of_float mutation_rate in

    let str = ("Best Score Versus Generation") in
    let hud_top = (hud_y +. (float_of_int hud_height) -. 20.0) in

    draw_string str (hud_x +. (float_of_int graph_width) +. 10.0) hud_top;
    draw_string ("Current Generation: "^curr_gen) (hud_x +. 10.0) 
                (hud_top);
    draw_string ("Cars Per Generation: "^num_cars_str) (hud_x +. 10.0) 
                (hud_top -. 20.0);
    draw_string ("Mutation Rate: "^mut_rate_str) (hud_x +. 10.0)
                (hud_top -. 40.0);
     
    let min_y_str = try 
      String.sub (string_of_float min_y) 0 6
    with | Invalid_argument s -> "" in
    let max_y_str = try
      String.sub (string_of_float max_y) 0 6
    with | Invalid_argument s -> "" in
    draw_string min_y_str (graph_x -. 50.0) (hud_y +. 12.0);
    draw_string max_y_str (graph_x -. 50.0) 
                (hud_y +. (float_of_int hud_height) -. 47.0);


    glutSwapBuffers();
  ;;

  (* This function was adapted from code in the OCaml Chipmunk Moon Buggy Demo 
   * https://github.com/fccm/ocaml-chipmunk-trunk/blob/master/demos/moon_buggy.ml
   *)
  let init () = 
    (* Initialize with no arguments to Glut *)
    let args = Array.make 0 "" in
    ignore(glutInit args);

    glutInitDisplayMode [GLUT_DOUBLE; GLUT_RGBA];

    glutInitWindowSize window_width window_height;
    ignore(glutCreateWindow "Genetic Cars");
    
    (* Set white as the "clear" color *)
    glClearColor 1.0 1.0 1.0 0.0;

    glPointSize 3.0;

    (* Pretty smoothing effects *)
    glEnable GL_LINE_SMOOTH;
    glEnable GL_POINT_SMOOTH;
    glEnable GL_BLEND; 
    glBlendFunc GL_SRC_ALPHA  GL_ONE_MINUS_SRC_ALPHA; 
    glHint GL_LINE_SMOOTH_HINT  GL_DONT_CARE;
    glHint GL_POINT_SMOOTH_HINT  GL_DONT_CARE;
    glLineWidth 2.5;
    
    (* Set the projection matrix *)
    glMatrixMode GL_PROJECTION;
    glLoadIdentity ();
    glOrtho ((float_of_int window_width) /. -2.0) 
            ((float_of_int window_width) /. 2.0) 
            ((float_of_int window_height) /. -2.0) 
            ((float_of_int window_height) /. 2.0) 
            (-1.0) (1.0);
    glMatrixMode GL_MODELVIEW;
  ;;
     
  let sleep_ticks = 16
  let rec timer ~value =
    glutTimerFunc ~msecs:sleep_ticks ~timer ~value:0;
    glutPostRedisplay();
  ;;
     
  let make pop : t = 
    match pop with
    | Empty n -> { precomputed_cars = [] }
    | Population lst -> { precomputed_cars = (init_precomputed_cars lst []) }
end
