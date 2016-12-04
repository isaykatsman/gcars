(* {{{ COPYING *(

  This file belongs to glMLite, an OCaml binding to the OpenGL API.

  Copyright (C) 2006 - 2011  Florent Monnier, Some rights reserved
  Contact:  <fmonnier@linux-nantes.org>

  Permission is hereby granted, free of charge, to any person obtaining a
  copy of this software and associated documentation files (the "Software"),
  to deal in the Software without restriction, including without limitation the
  rights to use, copy, modify, merge, publish, distribute, sublicense, and/or
  sell copies of the Software, and to permit persons to whom the Software is
  furnished to do so, subject to the following conditions:

  The above copyright notice and this permission notice shall be included in
  all copies or substantial portions of the Software.

  The Software is provided "as is", without warranty of any kind, express or
  implied, including but not limited to the warranties of merchantability,
  fitness for a particular purpose and noninfringement. In no event shall
  the authors or copyright holders be liable for any claim, damages or other
  liability, whether in an action of contract, tort or otherwise, arising
  from, out of or in connection with the software or the use or other dealings
  in the Software.

)* }}} *)

(** {3 VBO : Vertex Buffer Object} *)

(** {{:http://en.wikipedia.org/wiki/Vertex_Buffer_Object}Wikipedia article about
    Vertex Buffer Object} *)


(* http://camltastic.blogspot.com/2008/08/tip-calling-c-functions-directly-with.html
 *)

type vbo_id

external glGenBuffer: unit -> vbo_id = "ml_glgenbuffer" "noalloc"
external glGenBuffers: n:int -> vbo_id array = "ml_glgenbuffers" (* DOES ALLOC *)
(** {{:http://www.opengl.org/sdk/docs/man/xhtml/glGenBuffers.xml}
    manual page} *)

external glDeleteBuffer: vbo:vbo_id -> unit = "ml_gldeletebuffer" "noalloc"
(** {{:http://www.opengl.org/sdk/docs/man/xhtml/glDeleteBuffers.xml}
    manual page} *)

# 49 "VBO.ml.pp"
val glDeleteBuffers: vbos:vbo_id array -> unit
# 53 "VBO.ml.pp"


# 1 "enums/buffer_object_target.inc.ml" 1
type buffer_object_target =
  | GL_ARRAY_BUFFER
  | GL_ELEMENT_ARRAY_BUFFER
  | GL_PIXEL_PACK_BUFFER
  | GL_PIXEL_UNPACK_BUFFER
# 56 "VBO.ml.pp" 2

external glBindBuffer: target:buffer_object_target -> vbo:vbo_id -> unit = "ml_glbindbuffer" "noalloc"
(** {{:http://www.opengl.org/sdk/docs/man/xhtml/glBindBuffer.xml}
    manual page} *)

external glUnbindBuffer: target:buffer_object_target -> unit = "ml_glunbindbuffer" "noalloc"
(** Equivalent to the function [glBindBuffer] with 0 as vbo_id, as tells
    {{:http://www.opengl.org/sdk/docs/man/xhtml/glBindBuffer.xml}
    the manual} to unbind buffer objects. *)


# 1 "enums/vbo_usage_pattern.inc.ml" 1
type vbo_usage_pattern =
  | GL_STREAM_DRAW
  | GL_STREAM_READ
  | GL_STREAM_COPY
  | GL_STATIC_DRAW
  | GL_STATIC_READ
  | GL_STATIC_COPY
  | GL_DYNAMIC_DRAW
  | GL_DYNAMIC_READ
  | GL_DYNAMIC_COPY
# 68 "VBO.ml.pp" 2

external glBufferData:
    target:buffer_object_target ->
    size:int ->
    data:('a, 'b, Bigarray.c_layout) Bigarray.Array1.t ->
    usage:vbo_usage_pattern ->
    unit
    = "ml_glbufferdata"
(** {{:http://www.opengl.org/sdk/docs/man/xhtml/glBufferData.xml}
    manual page} *)

external glBufferDataNull:
    target:buffer_object_target ->
    size:int ->
    usage:vbo_usage_pattern ->
    unit
    = "ml_glbufferdata_null"
(** same than [glBufferData] but passes a NULL pointer to the data parameter of the C function *)

external glBufferSubData:
    target:buffer_object_target ->
    offset:int ->
    size:int ->
    data:('a, 'b, Bigarray.c_layout) Bigarray.Array1.t ->
    unit
    = "ml_glbuffersubdata"
(** {{:http://www.opengl.org/sdk/docs/man/xhtml/glBufferSubData.xml}
    manual page} *)

external elem_size: ba:('a, 'b, Bigarray.c_layout) Bigarray.Array1.t -> int = "ml_ba_elem_size"
(** this function returns the size in octets of the elements of a bigarray *)

# 101 "VBO.ml.pp"
val ba_sizeof: ba:('a, 'b, Bigarray.c_layout) Bigarray.Array1.t -> int
(** you can use this function to provide the [size] argument of the function [glBufferData] *)
# 107 "VBO.ml.pp"

type access_policy =
  | GL_READ_ONLY
  | GL_WRITE_ONLY
  | GL_READ_WRITE

type mapped_buffer

(*
  (* wrapping the mapped buffer as a big-array does a segfault
     (but curiously not immediatly, after a while) *)
external glMapBuffer: target:buffer_object_target -> access:access_policy ->
                      ('a, 'b, Bigarray.c_layout) Bigarray.Array1.t = "ml_glmapbuffer"
*)
external glMapBufferAbs: target:buffer_object_target -> access:access_policy -> mapped_buffer = "ml_glmapbuffer_abs"

(** {{:http://www.opengl.org/sdk/docs/man/xhtml/glMapBuffer.xml}
    manual page} *)

external glUnmapBuffer: target:buffer_object_target -> unit = "ml_glunmapbuffer"


external mapped_buffer_blit: mapped_buffer ->
    (float, Bigarray.float32_elt, Bigarray.c_layout) Bigarray.Array1.t ->
    len:int -> unit = "mapped_buffer_blit"

external mapped_buffer_blit_ofs: mapped_buffer ->
    (float, Bigarray.float32_elt, Bigarray.c_layout) Bigarray.Array1.t ->
    ofs:int -> len:int -> unit = "mapped_buffer_blit_ofs"


(** params for [glGetBufferParameter], but not used *)
type bo_param =
  | GL_BUFFER_ACCESS
  | GL_BUFFER_MAPPED
  | GL_BUFFER_SIZE
  | GL_BUFFER_USAGE

(** in the C API [glGetBufferParameteriv] can be called with
    [GL_BUFFER_ACCESS], [GL_BUFFER_MAPPED], [GL_BUFFER_SIZE], or [GL_BUFFER_USAGE],
    each of these parameters return a different type, so glGetBufferParameter
    have been wrapped as follow:
     
{ul
    {- glGetBufferParameter [GL_BUFFER_ACCESS] => glGetBufferAccess}
    {- glGetBufferParameter [GL_BUFFER_MAPPED] => glGetBufferMapped}
    {- glGetBufferParameter [GL_BUFFER_SIZE]   => glGetBufferSize}
    {- glGetBufferParameter [GL_BUFFER_USAGE]  => glGetBufferUsage}
}
*)

external glGetBufferAccess: target:buffer_object_target -> access_policy     = "ml_glGetBufferParameter_ACCESS"
external glGetBufferMapped: target:buffer_object_target -> bool              = "ml_glGetBufferParameter_MAPPED"
external glGetBufferSize  : target:buffer_object_target -> int               = "ml_glGetBufferParameter_SIZE"
external glGetBufferUsage : target:buffer_object_target -> vbo_usage_pattern = "ml_glGetBufferParameter_USAGE"

(** {{:http://www.opengl.org/sdk/docs/man/xhtml/glGetBufferParameteriv.xml}
    manual page} *)

(* vim: sw=2 sts=2 ts=2 et fdm=marker filetype=ocaml
 *)
