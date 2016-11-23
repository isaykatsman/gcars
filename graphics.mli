open World
open Genetic

module type Graphics = sig
  (* Initalize the graphics module *)
  val init_graphics : World.t ref -> car_genome list -> unit

  (* Draw the current state of the simulation. The car which is furthest from
   * the start should always be in view. *)
  val draw : unit -> unit
end

module Graphics : Graphics
