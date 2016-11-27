open Simulation
open Genetic

(* Entry point into the program. Recives command line options and parses them
 * parse_opts *)
val main : unit -> unit

(* [parse_opts argv] parses the command line input and returns an opts record
 * to represent the options set *)
val parse_opts : string array -> options
