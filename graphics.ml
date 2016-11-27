(* Small portions of this program were adapted from the OCaml Chipmunk Moon
 * Buggy Demo. See legal.txt for more information *)

open GL
open Glu
open Glut

open World
open Vect
open Genetic

module type Graphics = sig
  type t
  val init : unit -> unit
  val make : population -> t
  val draw : t -> World.t -> unit
end

module Graphics = struct
  type precomputed_car = { verts : Vect.t list; genome : car_genome }

  type t = { precomputed_cars : precomputed_car list } 

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
        let new_acc = acc@[{genome = car_genome; verts = verts_new}] in 
        init_precomputed_cars next new_acc

  let draw_line v1 v2 = let v1_str = Vect.to_string v1 in
    let v2_str = Vect.to_string v2 in
    glBegin GL_LINES;
      glVertex2 (Vect.x v1) (Vect.y v1);
      glVertex2 (Vect.x v2) (Vect.y v2);
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
    float) (pos : Vect.t) = 
    match verts with
    | [] -> ()
    | curr_vert::next_verts ->
        let curr_rot = 
          if angle = 0.0 then curr_vert 
          else Vect.rot curr_vert angle in
        let curr_disp = 
          if pos = Vect.origin then curr_rot
          else Vect.add curr_rot pos in
        draw_line prev_vert curr_disp;
        draw_polyline_aux next_verts curr_disp angle pos
  ;;

  let draw_polyline verts angle pos = 
    match verts with
    | [] -> print_endline "Call to draw_polyline with verts list of length 0";
    | [v] -> print_endline "Call to draw_polyline with verts list of length 1";
    | h::t -> 
        let first_vert = Vect.add (Vect.rot h angle) pos in
        draw_polyline_aux t first_vert angle pos

  let draw_wheel pos r a = 
    let x = (Vect.x pos) in
    let y = (Vect.y pos) in 
    let segs = 30 in
    let coef = 2.0 *. pi /. (float segs) in

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
      Vect.add (Vect.rot vect state.angle) state.pos in
    match (car.genome.wheels, state.wheel_angles) with
    | ((w1, w2), (w1_angle, w2_angle)) -> 
        draw_wheel (wheel_pos w1) w1.radius w1_angle;
        draw_wheel (wheel_pos w2) w2.radius w2_angle;
  ;;
    
  let draw_car car state =
    draw_polyline car.verts state.angle state.pos;
    draw_wheels car state;

  exception Cars_precomputed_length
  let rec draw_cars precomp states =
    match (precomp, states) with
    | ([], []) -> ()
    | (precomp_entry::precomp_tl, state::states_tl) -> 
        draw_car precomp_entry state;
        draw_cars precomp_tl states_tl
    | (_, _) -> raise Cars_precomputed_length

  (* Actually draw the world. Requires that get_car_info world is not [] *)
  let draw graphics world = 
    let car_states = World.get_car_state world in

    (* Move the furthest along car into view *)
    let furthest = get_furthest_car car_states (List.hd car_states) in

    glClear [GL_COLOR_BUFFER_BIT];
    glLoadIdentity();
    let furthest_x = (Vect.x furthest.pos) in
    let furthest_y = (Vect.y furthest.pos) in 
    glTranslate (-. furthest_x) (-. furthest_y) 0.0;
    
    (* Draw the cars and terrain *)
    glColor3 0.0 0.0 0.0;
    draw_cars graphics.precomputed_cars car_states;
    let terrain = World.get_terrain world in
    draw_polyline terrain 0.0 (Vect.origin);

    glutSwapBuffers();
  ;;

  let init () = 
    (* TODO: Not sure if Sys.argv is needed *)
    ignore(glutInit Sys.argv);

    glutInitDisplayMode [GLUT_DOUBLE; GLUT_RGBA];

    glutInitWindowSize 640 480;
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
    glLineWidth 1.5;
    
    (* Magic *)
    glMatrixMode GL_PROJECTION;
    glLoadIdentity ();
    glOrtho (-1000.0) (1000.0) (-750.0) (750.0) (-1.0) (1.0);
    glScale 2.0 2.0 1.0;
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

