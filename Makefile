main:
	ocaml main.ml

#	ocamlbuild -cflags -I,+glMLite,-I,+chipmunk,-color,always -lflags -I,+glMLite,GL.cma,Glu.cma,Glut.cma,-color,always main.byte
#	ocamlbuild -cflags -custom,-verbose,-I,+glMLite,GL.cma,Glu.cma,Glut.cma,-I,+chipmunk,chipmunk.cma,unix.cma,-color,always -lflags -I,/glMLite,GL.cma,Glu.cma,Glut.cma,/glMLite/GL.o,/glMLite/Glu.o,/glMLite/Glut.o,/glMLite/GL.a,/glMLite/Glu.a,/glMLite/Glut.a,dllgl_stubs.so,dllGlu.so,dllGlut.so,unix.cma,-dllpath,/glMLite,-dllib,dllgl_stubs.so,-dllib,dllGlu.so,-dllib,dllGlut.so,-I,/home/john/gcars/chipmunk,chipmunk.cma main.byte
#	ocamlbuild -cflags -verbose,-I,+glMLite,GL.cmxa,Glu.cmxa,Glut.cmxa,-I,+chipmunk,chipmunk.cmxa,-color,always -lflags -I,/glMLite,GL.cmxa,Glu.cmxa,Glut.cmxa,/glMLite/GL.o,/glMLite/Glu.o,/glMLite/Glut.o,/glMLite/GL.a,/glMLite/Glu.a,/glMLite/Glut.a,dllgl_stubs.so,dllGlu.so,dllGlut.so,-dllpath,/glMLite,-dllib,dllgl_stubs.so,-dllib,dllGlu.so,-dllib,dllGlut.so,-I,/home/john/gcars/chipmunk,chipmunk.cma main.native

# run: main
#	./main.byte

# clean:
# ocamlbuild -clean
