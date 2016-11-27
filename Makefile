main:
	ocamlbuild -cflags -custom,-I,+glMLite,GL.cma,Glu.cma,Glut.cma,-I,+chipmunk,chipmunk.cma,unix.cma -lflags -I,/glMLite,GL.cma,Glu.cma,Glut.cma,GL.o,Glu.o,Glut.o,GL.a,Glu.a,Glut.a,dllgl_stubs.so,dllGlu.so,dllGlut.so,unix.cma -verbose 0 main.byte
	LD_LIBRARY_PATH=/glMLite ./main.byte

graphics_test:
	ocamlbuild -cflags -custom,-I,+glMLite,GL.cma,Glu.cma,Glut.cma,-I,+chipmunk,chipmunk.cma,unix.cma -lflags -I,/glMLite,GL.cma,Glu.cma,Glut.cma,GL.o,Glu.o,Glut.o,GL.a,Glu.a,Glut.a,dllgl_stubs.so,dllGlu.so,dllGlut.so,unix.cma -verbose 0 graphics_test.byte
	LD_LIBRARY_PATH=/glMLite ./graphics_test.byte

clean:
	ocamlbuild -clean
