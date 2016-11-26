open Genetic
open Vect

type car_state = {
  velocity : float;
  pos : Vect.t;
  angle : float; (* in radians *)
  wheel_angles : float * float;
} 

module type World = sig
  (* Abstract type to represent the world *)
  type t

  (* Creates a new world with the specified terrain and cars *)
  val make : population -> t

  (* Steps the physics simulation forward one timestep *)
  val step : t -> t

  (* Get state info about all the cars *)
  val get_car_state : t -> car_state list

  (* Get the terrain to be drawn *)
  val get_terrain : t -> Vect.t list
end

module World : World
module FakeWorld : World
