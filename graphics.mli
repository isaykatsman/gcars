open World
open Genetic

module type Graphics = sig
  (* Type of graphics data *)
  type t

  (* Initalize the graphics module *)
  val init : unit -> unit

  (* Initalizes a new population *)
  val make : population -> t

  (* Draw the current state of the simulation. The car which is furthest from
   * the start should always be in view. *)
  val draw : t -> float list -> World.t -> unit
end

module Graphics : Graphics
