open Graphics
open Genetic
open Unix
open World

let world = World.make (Empty 0)
let () = Graphics.init_graphics (ref world) []

let rec run () = 
  sleepf 0.03333;
  Graphics.draw ();
  run ()

let () = run ()
