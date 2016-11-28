main:
	ocamlbuild -cflags -custom,-I,+glMLite,GL.cma,Glu.cma,Glut.cma,-I,+chipmunk,chipmunk.cma,unix.cma -lflags -I,/glMLite,GL.cma,Glu.cma,Glut.cma,GL.o,Glu.o,Glut.o,GL.a,Glu.a,Glut.a,dllgl_stubs.so,dllGlu.so,dllGlut.so,unix.cma -verbose 0 main.byte
	LD_LIBRARY_PATH=/glMLite ./main.byte

clean:
	ocamlbuild -clean
