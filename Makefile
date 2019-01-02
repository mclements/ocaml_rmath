.SUFFIXES: .m4

M4       = m4
M4FLAGS  =
M4SCRIPT =

# --- you shouldn't need to edit below this line ---

ifeq ($(OS),Windows_NT)
    DLLEXT := .dll
else
    DLLEXT := .so
endif

LIBRMATH = $(shell pkg-config --variable=libdir libRmath)/libRmath$(DLLEXT)

dynamic: clean rmath-dynamic.ml.m4 rmath.mli.m4 test.ml
	${M4} ${M4FLAGS} ${M4SCRIPT} -D LIBRMATH=${LIBRMATH} rmath-dynamic.ml.m4 > rmath.ml
	ocamlfind ocamlc -linkpkg -package ctypes.foreign rmath.ml test.ml \
		-cclib "`pkg-config --libs libRmath`"
	@./a.out
	@rm a.out

static: clean rmath-static.ml.m4 rmath.mli.m4 test.ml
	${M4} ${M4FLAGS} ${M4SCRIPT} rmath-static.ml.m4 > rmath.ml
	${M4} ${M4FLAGS} ${M4SCRIPT} rmath.mli.m4 > rmath.mli
	ocamlopt -c rmath.mli
	ocamlfind ocamlopt -linkpkg -package ctypes.foreign rmath.ml test.ml \
		-cclib "`pkg-config --libs libRmath`"
	@./a.out
	@rm a.out

clean:
	rm -f rmath.ml rmath.mli
	rm -f rmath.cm* rmath.o
	rm -f test.o test.cm*
