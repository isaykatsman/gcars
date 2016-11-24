open Graphics
open Genetic
open Unix
open World

let pi = 3.14159265359

let world = World.make (Empty 0)
let car1 = {
  chassis = [(10.0, 0.0); (10.0, (pi /. 2.0)); (10.0, pi); (10.0, 3.0 *. (pi /. 2.0))];
  w1_radius = 10.0;
  w2_radius = 10.0;
  w1_vert = 0;
  w2_vert = 1;
}
   
let () = print_endline "going to init"
let () = Graphics.init_graphics (ref world) [car1; car1]
let () = print_endline "Init done"

let rec run () = 
  print_endline "running";
  (* sleepf 0.03333; *)
  run ()

let () = run ()
let () = print_endline "done"

