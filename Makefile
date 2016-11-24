main:
	ocamlbuild -cflags '-I +glMLite GL.cma Glu.cma Glut.cma -I +chipmunk chipmunk.cma' main.byte

test_graphics:
	ocamlbuild -cflags '-I +glMLite GL.cma Glu.cma Glut.cma -I +chipmunk chipmunk.cma' graphics_test.byte

clean:
	ocamlbuild -clean
