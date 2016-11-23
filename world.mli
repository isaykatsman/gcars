open Genetic
open Vect

module World = sig
  (* Abstract type to represent the world *)
  type world

  type car_state = {
    velocity : float;
    pos : Vect.t;
    angle : float; (* in radians *)
  } 

  (* Creates a new world with the specified terrain and cars *)
  val create_world : population -> world

  (* Steps the physics simulation forward one timestep *)
  val step : world -> world

  (* Get state info about all the cars *)
  val get_car_state : world -> car_state list

  (* Get the terrain to be drawn *)
  val get_terrain : world -> Vect.t list
end

module World : World
module FakeWorld : World
