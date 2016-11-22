open Physics

module Graphics = sig
  (* Initalize the graphics module *)
  val init_graphics : world ref -> ()

  (* Draw the current state of the simulation. The car which is furthest from
   * the start should always be in view. *)
  val draw : () -> ()
end

module Graphics : Graphics
