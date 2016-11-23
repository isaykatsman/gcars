module Vect = struct
  type t = { x : float; y : float }

  let add v1 v2 =
    { x = v1.x + v2.x; y = v1.y + v2.y }

  let rot v angle =
    let c = cos(v) in
    let s = sin(v) in
    { x = c - s; y = c + s }
  
  let make x y = { x = x; y = y}
end

