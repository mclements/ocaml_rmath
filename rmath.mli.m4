divert(`-1')
define(`CAML_TYPE',`ifelse($1,int,int,$1,double,float,$1,void,unit,$1)')
define(`tolower', `translit(`$*', `A-Z', `a-z')')dnl
define(`CONSTANT',`val tolower($2) : float')
define(`FUNCTION0',`val tolower($2) : unit -> CAML_TYPE(double)')
define(`FUNCTION1',`val tolower($2) : CAML_TYPE($3)-> CAML_TYPE(double)')
define(`FUNCTION2',`val tolower($2) : CAML_TYPE($3) -> CAML_TYPE($5)-> CAML_TYPE(double)')
define(`FUNCTION3',`val tolower($2) : CAML_TYPE($3) -> CAML_TYPE($5) -> CAML_TYPE($7) -> CAML_TYPE(double)')
define(`FUNCTION4',`val tolower($2) : CAML_TYPE($3) -> CAML_TYPE($5) -> CAML_TYPE($7) -> CAML_TYPE($9) -> CAML_TYPE(double)')
define(`FUNCTION5',`val tolower($2) : CAML_TYPE($3) -> CAML_TYPE($5) -> CAML_TYPE($7) -> CAML_TYPE($9) -> CAML_TYPE($11) -> CAML_TYPE(double)')
define(`FUNCTION6',`val tolower($2) : CAML_TYPE($3) -> CAML_TYPE($5) -> CAML_TYPE($7) -> CAML_TYPE($9) -> CAML_TYPE($11) -> CAML_TYPE($13) -> CAML_TYPE(double)')
divert(`1')dnl
type test_alternative = TwoSided | Less | Greater
include(`rmath-template.m4')dnl
val imin2 : int -> int -> int
val imax2 : int -> int -> int
val set_seed : int -> int -> unit
val log1pexp : float -> float
val get_seed : unit -> int * int
val lgammafn_sign : float -> float * int
val rmultinom : int -> float array -> int array
val rf_log1pexp : float -> float
val qgamma : float -> float -> float -> int -> int -> float
val pgamma : float -> float -> float -> int -> int -> float
val dgamma : float -> float -> float -> int -> float
val poisson_ci : float -> float -> test_alternative -> float * float
val poisson_test: float -> float -> float -> test_alternative -> float
val for_loop : (int * 'a -> 'a) -> 'a -> int * int -> 'a
val count : (int -> bool) -> int * int -> int
