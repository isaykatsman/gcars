open Genetic
open Chipmunk
open OO

(* Abstract type to represent the world *)
type world

type car_info = {
  velocity : float;
  dist_from_start : float;
} 

(* Creates a new world with the specified terrain and cars *)
val create_world : population -> world

(* Steps the physics simulation forward one timestep *)
val step : world -> ()

(* Get info about all the cars *)
val get_car_info : world -> car_info list
