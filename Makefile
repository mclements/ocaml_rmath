.SUFFIXES: .ml .mli .m4

M4       = m4
M4FLAGS  =
M4SCRIPT =

# --- you shouldn't need to edit below this line ---

CFLAGS  += $(shell pkg-config --cflags libRmath) -fPIC
LDFLAGS += $(shell pkg-config --libs libRmath)

ifeq ($(OS),Windows_NT)
    DLLEXT := .dll
else
    DLLEXT := .so
endif

%.ml: %.ml.m4
	${M4} ${M4FLAGS} ${M4SCRIPT} $< > $*.ml

%.mli: %.mli.m4
	${M4} ${M4FLAGS} ${M4SCRIPT} $< > $*.mli

dynamic: clean rmath.ml rmath.mli
	${M4} ${M4FLAGS} ${M4SCRIPT} rmath.ml.m4 > rmath.ml
	ocamlfind ocamlc -linkpkg -package ctypes.foreign rmath.ml test_1.ml \
		-cclib "`pkg-config --libs libRmath`"
	@./a.out
	@rm a.out

static: clean rmath.ml.m4 rmath.mli.m4
	${M4} ${M4FLAGS} ${M4SCRIPT} rmath-static.ml.m4 > rmath.ml
	${M4} ${M4FLAGS} ${M4SCRIPT} rmath.mli.m4 > rmath.mli
	ocamlopt -c rmath.mli
	ocamlfind ocamlopt -linkpkg -package ctypes.foreign rmath.ml test_1.ml \
		-cclib "`pkg-config --libs libRmath`"
	@./a.out
	@rm a.out

swig: rmath-swig.i swig.cmo swig.cmi
	swig -ocaml `pkg-config --cflags libRmath` rmath-swig.i
	sed -i '1i#include<stdint.h>\n#define int64 int64_t\n' rmath-swig_wrap.c
	ocamlc -a -o rmath_swig.cma -ccopt "`pkg-config --cflags libRmath`" rmath-swig_wrap.c
	# ocamlc -c rmath.mli
	ocamlc -c rmath.ml
	# ocamlc -pp "camlp4o ./swigp4.cmo" -c test_swig.ml
	ocamlc -o test_swig -custom swig.cmo rmath_swig.cma rmath.ml test_swig.ml -cclib "-lRmath -lm"

swig-init:
	swig -ocaml -co swig.mli
	swig -ocaml -co swig.ml
	swig -ocaml -co swigp4.ml
	ocamlc -c swig.mli
	ocamlc -c swig.ml
	ocamlc -I `camlp4 -where` -pp "camlp4o pa_extend.cmo q_MLast.cmo" -c swigp4.ml


clean:
	rm -f rmath.ml rmath.mli
	rm -f rmath_wrap.c rmath.mli rmath.ml
