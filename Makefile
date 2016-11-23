main:
	ocamlbuild -cflags '-I +glMLite GL.cma Glu.cma Glut.cma -I +chipmunk chipmunk.cma' main.byte

clean:
	ocamlbuild -clean
