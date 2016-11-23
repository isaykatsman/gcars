(* Small portions of this program were adapted from the OCaml Chipmunk Moon
 * Buggy Demo. See legal.txt for more information *)

#directory "+glMLite"
#load "GL.cma"
#load "Glu.cma"
#load "Glut.cma"

open GL
open Glu
open Glut

open Physics

module Graphics = struct
  let cars_cache = ref []

  let polar_to_vect (r, theta) =
    let x = r *. cos(theta) in
    let y = y *. sin(theta) in
    (Vect.make x y)

  let rec get_chassis_verts chassis acc =
    match chassis with
    | [] -> ()
    | h::t -> get_chassis_verts t (polar_to_vect h)::acc
  
  let rec init_cars_cache cars =
    match cars with
    | [] -> ()
    | curr::next ->
        let verts = get_chassis_verts curr.chassis [] in
        let first_vert = polar_to_vec (List.hd curr.chassis) in
        cars_cache := (!cars_cache)@(first_vert::verts);
        init_cars_cache next

  let draw_line v1 v2 = 
    glBegin GL_LINES;
      glVertex2 v1.x v1.y;
      glVertex2 v2.x v2.y;
    glEnd();
    
  let get_furthest_car cars furthest =
    match cars with
    | [] -> furthest
    | h::t -> 
        let new_furthest = 
          if h.x > furthest.x then h
          else furthest in
        get_furthest_car t new_furthest

  let rec draw_polyline verts prev_vert angle = 
    match verts with
    | [] -> ()
    | curr_vert::next_verts ->
        let curr_rot = 
          if angle = 0 then curr_vert 
          else Vect.rot curr_vert angle in
        draw_line prev_vert curr_rot;
        draw_polyline next_verts curr_rot angle
    
  let draw_car car = ()

  (* Actually draw the world. Requires that get_car_info world is not [] *)
  let draw_gl world = 
    let cars = get_car_state !world in

    (* Move the furthest along car into view *)
    let furthest = get_furthest_car cars cars.hd in

    glClear [GL_COLOR_BUFFER_BIT];
    glLoadIdentity();
    glTranslate (-. furthest.x) (-. furthest.y) 0.0;
    
    (* Draw the cars and terrain *)
    glColor3 0.0 0.0 0.0;
    List.iter draw_car cars;
    let terrain = get_terrain !world in
    draw_polyline terr (0.0, 0.0) 0.0;

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
    glLineWidth 1.5;
    
    (* Magic *)
    glMatrixMode GL_PROJECTION;
    glLoadIdentity ();
    glOrtho (-1000.0) (1000.0) (-750.0) (750.0) (-1.0) (1.0);
    glScale 2.0 2.0 1.0;
    glMatrixMode GL_MODELVIEW;

    (* Register the display callback *)
    glutDisplayFunc ~display:(fun () -> draw_gl world);

  (* Initalize the graphics module *)
  let init_graphics world =
    (* Initialize Open GL *)
    init_gl world; 

    (* Cache the verticies we will have to draw for the cars *)
    init_cars_cache cars;

    glutMainLoop ();

  (* Request that OpenGL re-draw the world*)
  let draw () =
    glutPostRedisplay ();

end

module Graphics : Graphics

