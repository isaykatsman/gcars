(* Copyright (c) Mark J. Kilgard, 1994. *)

(* (c) Copyright 1993, Silicon Graphics, Inc.
 * ALL RIGHTS RESERVED
 * Permission to use, copy, modify, and distribute this software for
 * any purpose and without fee is hereby granted, provided that the above
 * copyright notice appear in all copies and that both the copyright notice
 * and this permission notice appear in supporting documentation, and that
 * the name of Silicon Graphics, Inc. not be used in advertising
 * or publicity pertaining to distribution of the software without specific,
 * written prior permission.
 *
 * THE MATERIAL EMBODIED ON THIS SOFTWARE IS PROVIDED TO YOU "AS-IS"
 * AND WITHOUT WARRANTY OF ANY KIND, EXPRESS, IMPLIED OR OTHERWISE,
 * INCLUDING WITHOUT LIMITATION, ANY WARRANTY OF MERCHANTABILITY OR
 * FITNESS FOR A PARTICULAR PURPOSE.  IN NO EVENT SHALL SILICON
 * GRAPHICS, INC.  BE LIABLE TO YOU OR ANYONE ELSE FOR ANY DIRECT,
 * SPECIAL, INCIDENTAL, INDIRECT OR CONSEQUENTIAL DAMAGES OF ANY
 * KIND, OR ANY DAMAGES WHATSOEVER, INCLUDING WITHOUT LIMITATION,
 * LOSS OF PROFIT, LOSS OF USE, SAVINGS OR REVENUE, OR THE CLAIMS OF
 * THIRD PARTIES, WHETHER OR NOT SILICON GRAPHICS, INC.  HAS BEEN
 * ADVISED OF THE POSSIBILITY OF SUCH LOSS, HOWEVER CAUSED AND ON
 * ANY THEORY OF LIABILITY, ARISING OUT OF OR IN CONNECTION WITH THE
 * POSSESSION, USE OR PERFORMANCE OF THIS SOFTWARE.
 *
 * US Government Users Restricted Rights
 * Use, duplication, or disclosure by the Government is subject to
 * restrictions set forth in FAR 52.227.19(c)(2) or subparagraph
 * (c)(1)(ii) of the Rights in Technical Data and Computer Software
 * clause at DFARS 252.227-7013 and/or in similar or successor
 * clauses in the FAR or the DOD or NASA FAR Supplement.
 * Unpublished-- rights reserved under the copyright laws of the
 * United States.  Contractor/manufacturer is Silicon Graphics,
 * Inc., 2011 N.  Shoreline Blvd., Mountain View, CA 94039-7311.
 *
 * OpenGL(TM) is a trademark of Silicon Graphics, Inc.
 *)

(*  anti.ml
 *  This program draws antialiased lines in RGBA mode.
 *)

(* OCaml version by Florent Monnier *)

open GL
open Glu
open Glut

(*  Initialize antialiasing for RGBA mode, including alpha
 *  blending, hint, and line width.  Print out implementation
 *  specific info on line width granularity and width.
 *)
let myinit() =
  let value = glGetFloat1 Get.GL_LINE_WIDTH_GRANULARITY in
  Printf.printf "GL_LINE_WIDTH_GRANULARITY value is %3.1f\n" value;

  let v1, v2 = glGetFloat2 Get.GL_LINE_WIDTH_RANGE in
  Printf.printf "GL_LINE_WIDTH_RANGE values are %3.1f %3.1f\n" v1 v2;
  Printf.printf "%!";

  glEnable GL_LINE_SMOOTH;
  glEnable GL_BLEND;
  glBlendFunc Sfactor.GL_SRC_ALPHA  Dfactor.GL_ONE_MINUS_SRC_ALPHA;
  glHint GL_LINE_SMOOTH_HINT  GL_DONT_CARE;
  glLineWidth 1.5;

  glShadeModel GL_FLAT;
  glClearColor 0.0 0.0 0.0 0.0;
  glDepthFunc GL_LESS;
  glEnable GL_DEPTH_TEST;
;;


(*  display() draws an icosahedron with a large alpha value, 1.0.  *)
let display() =
  glClear [GL_COLOR_BUFFER_BIT; GL_DEPTH_BUFFER_BIT];
  glColor4 1.0 1.0 1.0 1.0;
  glutWireIcosahedron();
  glFlush();
;;


let reshape ~width:w ~height:h =
  glViewport 0 0 w h;
  glMatrixMode GL_PROJECTION;
  glLoadIdentity();
  gluPerspective 45.0 ((float w) /. (float h)) 3.0 5.0;

  glMatrixMode GL_MODELVIEW;
  glLoadIdentity();
  glTranslate 0.0 0.0 (-4.0);  (*  move object into view   *)
;;


let keyboard ~key ~x ~y =
  begin match key with
  | '\027' ->  (* Escape *)
      exit 0;
  | _ -> ()
  end;
  glutPostRedisplay();
;;


(*  Main Loop
 *  Open window with initial window size, title bar,
 *  RGBA display mode, and handle input events.
 *)
let () =
  ignore(glutInit Sys.argv);
  glutInitDisplayMode [GLUT_SINGLE; GLUT_RGB; GLUT_DEPTH];
  ignore(glutCreateWindow Sys.argv.(0));
  myinit();
  glutReshapeFunc ~reshape;
  glutDisplayFunc ~display;
  glutKeyboardFunc ~keyboard;
  glutMainLoop();
;;

