open Graphics
open Genetic
open Unix
open World

let pi = 3.14159265359

let world = World.make (Empty 0)
let rec make_chassis n acc = 
  if n > 0 then
    let angle = Random.float (2.0 *. pi) in
    let radius = (Random.float 100.0) +. 100.0 in 
    make_chassis (n-1) ((radius, angle)::acc)
  else
    let chassis = List.sort (fun x y -> compare (snd x) (snd y)) acc in 
    chassis
  
let car1 = {
  chassis = make_chassis 8 [];
  wheels = (
    {radius=50.0; vert = 1 },
    {radius=50.0; vert = 2 }
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

