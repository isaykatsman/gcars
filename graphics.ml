(* Small portions of this program were adapted from the OCaml Chipmunk Moon
 * Buggy Demo. See legal.txt for more information *)

open GL
open Glu
open Glut

open World
open Vect
open Genetic

module type Graphics = sig
  val init_graphics : World.t ref -> car_genome list -> unit
  val draw : unit -> unit
end

module Graphics = struct
  type cached_car = { verts : Vect.t list; genome : car_genome }

  let polar_to_vect (r, theta) =
    let x = r *. cos(theta) in
    let y = r *. sin(theta) in
    Vect.make x y

  let rec get_chassis_verts chassis acc =
    match chassis with
    | [] -> acc
    | h::t -> get_chassis_verts t ((polar_to_vect h)::acc)
  
  let rec init_cars_cache cars acc : cached_car list =
    match cars with
    | [] -> acc
    | curr::next ->
        let verts = get_chassis_verts curr.chassis [] in
        let first_vert = polar_to_vect (List.hd curr.chassis) in
        let verts = (first_vert::verts) in
        let car_genome = curr in
        let new_acc = acc@[{genome = car_genome; verts = verts}] in 
        init_cars_cache next new_acc

  let draw_line v1 v2 = 
    let v1_str = Vect.to_string v1 in
    let v2_str = Vect.to_string v2 in
    (* print_endline ("drawing line from "^v1_str^" to "^v2_str); *)
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

  let rec draw_polyline (verts : Vect.t list) (prev_vert : Vect.t) (angle :
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
        draw_polyline next_verts curr_disp angle pos
  ;;
    
  let draw_cars cars car_states = ()

  (* Actually draw the world. Requires that get_car_info world is not [] *)
  let draw_gl world cars_cache = 
    let car_states = World.get_car_state !world in

    (* Move the furthest along car into view *)
    let furthest = get_furthest_car car_states (List.hd car_states) in

    glClear [GL_COLOR_BUFFER_BIT];
    glLoadIdentity();
    let furthest_x = (Vect.x furthest.pos) in
    let furthest_y = (Vect.y furthest.pos) in 
    glTranslate (-. furthest_x) (-. furthest_y) 0.0;
    
    (* Draw the cars and terrain *)
    glColor3 0.0 0.0 0.0;
    draw_cars cars_cache;
    let terrain = World.get_terrain !world in
    draw_polyline (List.tl terrain) (List.hd terrain) 0.0 (Vect.origin);

    glutSwapBuffers();
  ;;

  let init_gl world cars = 
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
    glLineWidth 3.0;
    
    (* Magic *)
    glMatrixMode GL_PROJECTION;
    glLoadIdentity ();
    glOrtho (-1000.0) (1000.0) (-750.0) (750.0) (-1.0) (1.0);
    glScale 2.0 2.0 1.0;
    glMatrixMode GL_MODELVIEW;

    let cache = init_cars_cache cars [] in 

    (* Register the display callback *)
    glutDisplayFunc ~display:(fun () -> draw_gl world cache);
  ;;
  
  let sleep_ticks = 16
  let rec timer ~value =
    glutTimerFunc ~msecs:sleep_ticks ~timer ~value:0;
    glutPostRedisplay();
  ;;

  (* Initalize the graphics module *)
  let init_graphics world cars =
    (* Initialize Open GL *)
    init_gl world cars; 

    (* Cache the verticies we will have to draw for the cars *)
    
    glutTimerFunc ~msecs:sleep_ticks ~timer ~value:0;

    glutMainLoop ();
  ;;

  (* Request that OpenGL re-draw the world*)
  let draw () = 
    glutPostRedisplay ();
  ;;

end

