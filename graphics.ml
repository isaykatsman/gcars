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
  let cars_cache = ref []

  let polar_to_vect (r, theta) =
    let x = r *. cos(theta) in
    let y = r *. sin(theta) in
    Vect.make x y

  let rec get_chassis_verts chassis acc =
    match chassis with
    | [] -> acc
    | h::t -> get_chassis_verts t ((polar_to_vect h)::acc)
  
  let rec init_cars_cache cars =
    match cars with
    | [] -> ()
    | curr::next ->
        let verts = get_chassis_verts curr.chassis [] in
        let first_vert = polar_to_vect (List.hd curr.chassis) in
        cars_cache := (!cars_cache)@(first_vert::verts);
        init_cars_cache next

  let draw_line v1 v2 = 
    let v1_str = Vect.to_string v1 in
    let v2_str = Vect.to_string v2 in
    print_endline ("drawing line from "^v1_str^" to "^v2_str);
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
    float) = 
    match verts with
    | [] -> ()
    | curr_vert::next_verts ->
        let curr_rot = 
          if angle = 0.0 then curr_vert 
          else Vect.rot curr_vert angle in
        draw_line prev_vert curr_rot;
        draw_polyline next_verts curr_rot angle
  ;;
    
  let draw_car car = ()

  (* Actually draw the world. Requires that get_car_info world is not [] *)
  let draw_gl world = 
    print_endline "In draw_gl";
    let cars = World.get_car_state !world in

    (* Move the furthest along car into view *)
    let furthest = get_furthest_car cars (List.hd cars) in

    glClear [GL_COLOR_BUFFER_BIT];
    glLoadIdentity();
    let furthest_x = (Vect.x furthest.pos) in
    let furthest_y = (Vect.y furthest.pos) in 
    glTranslate (-. furthest_x) (-. furthest_y) 0.0;
    
    (* Draw the cars and terrain *)
    glColor3 0.0 0.0 0.0;
    List.iter draw_car cars;
    let terrain = World.get_terrain !world in
    print_endline ("length of terrain is "^(string_of_int (List.length
    terrain)));
    draw_polyline terrain Vect.origin 0.0;
    glutSwapBuffers();
    print_endline "Exiting draw_gl";
  ;;

  let init_gl world = 
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

    (* Register the display callback *)
    glutDisplayFunc ~display:(fun () -> draw_gl world);
  ;;
  
  let sleep_ticks = 16
  let rec timer ~value =
    glutTimerFunc ~msecs:sleep_ticks ~timer ~value:0;
    glutPostRedisplay();
  ;;

  (* Initalize the graphics module *)
  let init_graphics world cars =
    (* Initialize Open GL *)
    init_gl world; 

    (* Cache the verticies we will have to draw for the cars *)
    init_cars_cache cars;
    
    print_endline "Entering main loop";

    glutTimerFunc ~msecs:sleep_ticks ~timer ~value:0;

    glutMainLoop ();
  ;;

  (* Request that OpenGL re-draw the world*)
  let draw () = 
    print_endline "draw called";
    glutPostRedisplay ();
  ;;

end

