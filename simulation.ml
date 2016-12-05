(*
open Genetic
open World
open Graphics
open Vect

open GL
open Glu
open Glut
*)
open Printf

type eval_function =
  | LongestDistance
  | ShortestTime

type sim_options = {
  mutation_rate : float;
  num_cars : int;
  eval_func : eval_function;
}

module type Simulation = sig
  type t
  val make : sim_options -> t
  val run : t -> unit
end

module FakeSimulation = struct
  type car_progress = {
    greatest_x : float; (* The greatest x position the car has attained so far *)
    timer : int; (* The number of steps since the greastest x increased *)
    dead : bool; (* Whether the car is dead *)
  }

  type t = {
    pop : population;
    world : World.t;
    graphics : Graphics.t;
    opts : sim_options;
    prev_max_scores : float list; 
    progress : car_progress list;
    course_end : float;
  }

  let init_progress num_cars =
    let rec init_progress_inner num_cars acc =
      if num_cars > 0 then
        let new_acc = {greatest_x = 0.0; timer = 0; dead = false}::acc in
        init_progress_inner (num_cars - 1) new_acc
      else
        acc in
    init_progress_inner num_cars []

  let terr_max_x terr = 
    let f acc x = if (Vect.x x) > acc then (Vect.x x) else acc in
    List.fold_left f 0.0 terr

  let sleep_ticks = 16
  let rec timer ~value =
    glutTimerFunc ~msecs:sleep_ticks ~timer ~value:0;
    glutPostRedisplay();
  ;;

  let make opts = 
    let pop = Genetic.new_population (Empty opts.num_cars) [] opts.mutation_rate in 
    let world = World.make pop in
    let course_end = terr_max_x (World.get_terrain world) in
    { pop = pop; world = world; 
      graphics = Graphics.make pop;
      opts = opts; 
      prev_max_scores = [0.0];
      progress = init_progress opts.num_cars;
      course_end = course_end }

  (* 1 second of non-progress will kill a car *) 
  let max_timer = 63 * 5

  let update_progress sim progress = 
    let states = World.get_car_state sim.world in
    print_endline ("=== Len of states list "^(string_of_int (List.length
    states)^" ==="));
    print_endline ("=== Len of progress list "^(string_of_int (List.length
    progress)^" ==="));
      let rec update_prog_inner sim states progress acc = 
        match (progress, states) with
        | ([], []) -> acc
        | (progress::progresses, state::states) ->
            let (new_greatest_x, new_timer, new_dead) = 
              let curr_x = Vect.x state.pos in
              if progress.dead then 
                let () = print_endline "Car is dead" in
                (progress.greatest_x, progress.timer, true)
              else if curr_x > sim.course_end then
                let () = print_endline "Car finished course" in
                (progress.greatest_x, 0, true)
              else if (curr_x > progress.greatest_x) && (abs_float (curr_x -.
              progress.greatest_x)) > 2.0  then
                let () = print_endline ("Car is making progress, greatest: \
                  "^(string_of_float progress.greatest_x)^", curr: \
                    "^(string_of_float curr_x)^", y: \
                      "^(string_of_float (Vect.y state.pos))) in
                (curr_x, 0, false)
              else
                let new_timer = progress.timer + 1 in
                let dead = new_timer > max_timer in
                print_endline ("New timer: "^(string_of_int new_timer)^", \
                Dead: "^(string_of_bool dead));
                (progress.greatest_x, new_timer, dead) in
            let new_progress = 
              {greatest_x = new_greatest_x; timer = new_timer;
               dead = new_dead } in
            update_prog_inner sim states progresses (acc@[new_progress]) 
        | (_, _) -> failwith "Simulation.generation_done: Car state and \
                              progress lists are not the same length" in
    update_prog_inner sim states progress []
 
  (* This function will check if the evaluation of a generation is done (all
   * cars not making progress *)
  let generation_done progress =
    let num_cars_alive = ref 0 in
    let f acc x =
      if not x.dead then num_cars_alive := !num_cars_alive + 1;
      not x.dead || acc in
    let result = List.fold_left f false progress in
    print_endline ("Num cars alive: "^(string_of_int !num_cars_alive));
    not result

  let score_max_dist car_state = (Vect.x car_state.pos)
  
  (* Score the generation *)
  let score_gen sim eval_f =
    match eval_f with
    | ShortestTime -> []
    | LongestDistance -> List.map score_max_dist (World.get_car_state sim.world)

  let max lst = List.fold_left max 0.0 lst

  (* This function will be called by OpenGL on every update. *)
  let step sim_ref =
    let sim = !(sim_ref) in

    let new_progress = update_progress sim sim.progress in
    let new_sim = 
      if generation_done new_progress then
        let scores = score_gen sim sim.opts.eval_func in
        let new_prev_scores = (max scores)::sim.prev_max_scores in
        let new_pop = Genetic.new_population sim.pop scores
          sim.opts.mutation_rate in
        let new_graphics = Graphics.make new_pop in
        let new_world = World.with_terrain sim.world new_pop in
        { sim with pop = new_pop; graphics = new_graphics; world = new_world;
          prev_max_scores = new_prev_scores; 
          progress = init_progress sim.opts.num_cars }
      else
        let new_world = World.step sim.world in
        Graphics.draw sim.graphics sim.prev_max_scores new_world
        sim.opts.num_cars sim.opts.mutation_rate;
        { sim with world = new_world; 
          progress = new_progress } in

      sim_ref := new_sim;
  ;;

  let run sim = 
    (* Must be called for graphics to work *)
    Graphics.init ();

    (* Register the display callback *)
    let sim_ref = ref sim in
    glutDisplayFunc ~display:(fun x -> step sim_ref);
    glutTimerFunc ~msecs:sleep_ticks ~timer ~value:0;
    glutMainLoop ();
  ;;
end

module Simulation = FakeSimulation
