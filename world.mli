open Genetic
open Vect

type car_state = {
  velocity : float;
  pos : Vect.t;
  angle : float; (* in radians *)
  wheel_angles : float * float;
  wheel_positions : Vect.t list;
} 

module type World = sig
  (* Abstract type to represent the world *)
  type t

  (* Creates a new world with new terrain and the specified cars *)
  val make : population -> t

  (* Creates a new world with the specified terrain and cars *)
  val with_terrain : t -> population -> t

  (* Steps the physics simulation forward one timestep *)
  val step : t -> t

  (* Get state info about all the cars *)
  val get_car_state : t -> car_state list

  (* Get the terrain to be drawn *)
  val get_terrain : t -> Vect.t list
end

module World : World
(* module FakeWorld : World *)
