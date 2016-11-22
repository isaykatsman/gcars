#directory "+glMLite"
#load "GL.cma"
#load "Glu.cma"
#load "Glut.cma"

open GL
open Glu
open Glut

open Physics
(* Potions of this code were adapted from the OCaml Chipmunk Moon Buggy Demo by
 * Scott Lembcke *)

module Graphics = struct
  let get_furthest_car cars furthest =
    match cars with
    | [] -> furthest
    | h::t -> 
        let new_furthest = 
          if h.x > furthest.x then h
          else furthest in
        get_furthest_car t new_furthest
    
  let draw_car car = ()

  let draw_terrain terr = ()

  (* Actually draw the world. Requires that get_car_info world is not [] *)
  let draw_gl world = 
    let cars = get_car_info !world in

    (* Move the furthest along car into view *)
    let furthest = get_furthest_car cars cars.hd in

    glClear [GL_COLOR_BUFFER_BIT];
    glLoadIdentity();
    glTranslate (-. furthest.x) (-. furthest.y) 0.0;
    
    (* Draw the cars and terrain *)
    glColor3 0.0 0.0 0.0;
    List.iter draw_car cars;
    let terrain = get_terrain !world in
    draw_terrain terr;

  (* Initalize the graphics module *)
  let init_graphics world =
    (* @JohnM Not sure if Sys.argv is needed *)
    ignore(glutInit Sys.argv);

    glutInitDisplayMode [GLUT_DOUBLE; GLUT_RGBA];

    (* @JohnM probably shouldn't hardcode window size *)
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

    glMatrixMode GL_PROJECTION;
    glLoadIdentity ();
    glOrtho (-1000.0) (1000.0) (-750.0) (750.0) (-1.0) (1.0);
    glScale 2.0 2.0 1.0;
    glMatrixMode GL_MODELVIEW;

    glutDisplayFunc ~display:(fun () -> draw_gl world);

    glutMainLoop ();

  (* Request that OpenGL re-draw the world*)
  let draw () =
    glutPostRedisplay ();

end

module Graphics : Graphics

