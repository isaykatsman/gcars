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

type sim_options = {
  mutation_rate : float;
  num_cars : int;
  eval_func : [`LongestDistance | `ShortestTime | `JumpDistance];
  car_vel : float;
  scale : float;
}

module type Simulation = sig
  type t
  val make : sim_options -> t
  val run : t -> unit
end

module Simulation = struct
  type car_progress = {
    greatest_x : float; (* The greatest x position the car has attained so far *)
    life : float; (* The number of steps since the greastest x increased *)
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
        let new_acc = {greatest_x = 0.0; life = 50.0; dead = false}::acc in
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
    let world = World.make pop opts.eval_func opts.car_vel in
    let course_end = terr_max_x (World.get_terrain world) in
    { pop = pop; world = world; 
      graphics = Graphics.make pop;
      opts = opts; 
      prev_max_scores = [0.0];
      progress = init_progress opts.num_cars;
      course_end = course_end }

  (* 1 second of non-progress will kill a car *) 
  let max_timer = 63 * 5
  let sim_time = ref 1

  let update_progress sim progress = 
    let states = World.get_car_state sim.world in
      let rec update_prog_inner sim states progress acc = 
        match (progress, states) with
        | ([], []) -> acc
        | (progress::progresses, state::states) ->
            let (new_greatest_x, new_life, new_dead) = 
              let curr_x = Vect.x state.pos in
              if progress.dead then 
                let () = print_endline "Car is dead" in 
                (progress.greatest_x, 0.0, true)
              else if curr_x > sim.course_end then
                let () = print_endline "Car finished course" in
                (progress.greatest_x, 0.0, true)
              else if curr_x > progress.greatest_x then
                let () =  print_endline ("Life: "^(string_of_float progress.life)^", \
                Dead: false") in
                let dead = progress.life < 0.0 in 
                (curr_x, min 50.0 (progress.life +. (curr_x -. progress.greatest_x) -. 0.2), dead)
              else
                let new_life = progress.life -. 0.2 in
                let dead = new_life < 0.0 in
                print_endline ("Life: "^(string_of_float new_life)^", \
                Dead: "^(string_of_bool dead));
                (progress.greatest_x, new_life, dead) in
            let new_progress = 
              {greatest_x = new_greatest_x; life = new_life;
               dead = new_dead } in
            update_prog_inner sim states progresses (acc@[new_progress]) 
        | (_, _) -> failwith "Simulation.generation_done: Car state and \
                              progress lists are not the same length" 
    in
    match sim.opts.eval_func with
    |`JumpDistance | `LongestDistance -> update_prog_inner sim states progress []
    | `ShortestTime -> if !sim_time mod 500 = 0 then (sim_time := 1; List.map (fun x -> {x with dead = true}) progress) else (sim_time := !sim_time + 1; progress)
    

 
  (* This function will check if the evaluation of a generation is done (all
   * cars not making progress *)
  let generation_done progress =
    let num_cars_alive = ref 0 in
    let f acc x =
      if not x.dead then num_cars_alive := !num_cars_alive + 1;
      not x.dead || acc in
    let result = List.fold_left f false progress in
    (* print_endline ("Num cars alive: "^(string_of_int !num_cars_alive)); *)
    not result

  let score_max_dist car_state = (Vect.x car_state.pos)
  
  (* Score the generation *)
  let score_gen sim eval_f =
    match eval_f with
    `JumpDistance | `ShortestTime -> List.map (fun x -> Vect.x (x.pos)) (World.get_car_state sim.world)
    | `LongestDistance -> 
      List.map (fun x -> x.greatest_x) sim.progress

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
    Graphics.init (sim.opts.scale);

    (* Register the display callback *)
    let sim_ref = ref sim in
    glutDisplayFunc ~display:(fun x -> step sim_ref);
    glutTimerFunc ~msecs:sleep_ticks ~timer ~value:0;
    glutMainLoop ();
  ;;
end
