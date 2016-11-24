let pi = 3.14159265358979312

module Vect = struct
  type t = { x : float; y : float }

  let add v1 v2 =
    { x = v1.x +. v2.x; y = v1.y +. v2.y }

  let rot v angle =
    let c = cos(angle) in
    let s = sin(angle) in
    { 
      x = (v.x *. c) -. (v.y *. s); 
      y = (v.x *. s) +. (v.y *. c)
    }

  let make x y = { x = x; y = y}

  let origin = { x = 0.0; y = 0.0 }
  
  let x v = v.x
  let y v = v.y

  let to_string v = 
    let x = string_of_float v.x in
    let y = string_of_float v.y in
    ("("^x^", "^y^")")
end

