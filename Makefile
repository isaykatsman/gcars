main:
	ocamlbuild -cflags -custom,-I,+glMLite,GL.cma,Glu.cma,Glut.cma,-I,+chipmunk,chipmunk.cma,unix.cma -lflags -I,/glMLite,GL.cma,Glu.cma,Glut.cma,GL.o,Glu.o,Glut.o,GL.a,Glu.a,Glut.a,dllgl_stubs.so,dllGlu.so,dllGlut.so,unix.cma,-dllpath,/glMLite,-dllib,dllgl_stubs.so,-dllib,dllGlu.so,-dllib,dllGlut.so -verbose 0 main.byte

run: main
	./main.byte

clean:
	ocamlbuild -clean
