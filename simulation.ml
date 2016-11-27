open Genetic
open World
open Graphics

open GL
open Glu
open Glut

type eval_function =
  | LongestDistance
  | LongestTime

type options = {
  mutation_rate : float;
  num_cars : int;
  eval_func : eval_function;
}

module type Simulation = sig
  type t
  val make : options -> t
  val run : t -> unit
end


module Simulation = struct
  type t = {
    pop : population;
    world : World.t;
    graphics : Graphics.t;
    opts : options;
  }

  let sleep_ticks = 16
  let rec timer ~value =
    glutTimerFunc ~msecs:sleep_ticks ~timer ~value:0;
    glutPostRedisplay();
  ;;

  let make opts = 
    let pop = Genetic.new_population (Empty opts.num_cars) [] opts.mutation_rate in 
    { pop = pop; world = World.make pop; 
      graphics = Graphics.make pop;
      opts = opts }


  (* This function will check if the evaluation of a generation is done (all
   * cars not making progress *)
  let generation_done sim = false
  
  (* Score the generation *)
  let score_gen sim = []

  (* This function will be called by OpenGL on every update. *)
  let step sim_ref =
    let sim = !(sim_ref) in

    let new_sim = 
      if generation_done sim then
        let scores = score_gen sim in
        let new_pop = Genetic.new_population sim.pop scores
          sim.opts.mutation_rate in
        let new_graphics = Graphics.make new_pop in
        let new_world = World.make new_pop in
        { sim with pop = new_pop; graphics = new_graphics; world = new_world }
      else
        let new_world = World.step sim.world in
        Graphics.draw sim.graphics new_world;
        { sim with world = new_world } in

      sim_ref := new_sim;
  ;;

  let run sim = 
    (* Must be called for graphics to work *)
    Graphics.init ();

    (* Register the display callback *)
    glutDisplayFunc ~display:(fun x -> step (ref sim) );
    glutTimerFunc ~msecs:sleep_ticks ~timer ~value:0;
    glutMainLoop ();
  ;;
end
