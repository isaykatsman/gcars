open Graphics
open Genetic
open Unix
open World

let pi = 3.14159265359

let world = World.make (Empty 0)
let car1 = {
  chassis = [
    (50.0, 7.0 *. (pi /. 4.0)); 
    (50.0, 5.0 *. (pi /. 4.0)); 
    (50.0, 3.0 *. (pi /. 4.0)); 
    (50.0, 1.0 *. (pi /. 4.0))
  ];
  wheels = (
    {radius=20.0; vert = 1 },
    {radius=20.0; vert = 2 }
  )
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

