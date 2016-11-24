main:
	ocamlbuild -cflags '-I +glMLite GL.cma Glu.cma Glut.cma -I +chipmunk chipmunk.cma -custom' main.byte

test_graphics:
	ocamlbuild -cflags '-I +glMLite GL.cma Glu.cma Glut.cma -I +chipmunk chipmunk.cma -custom' graphics_test.byte

clean:
	ocamlbuild -clean
