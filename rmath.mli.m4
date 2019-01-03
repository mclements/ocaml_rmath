divert(`-1')
define(`CAML_TYPE',`ifelse($1,int,int,$1,double,float,$1,void,unit,$1)')
define(`tolower', `translit(`$*', `A-Z', `a-z')')dnl
define(`CONSTANT',`(* $1 *)
val tolower($2) : float')
define(`FUNCTION0',`(* $1. $2() *)
val tolower($2) : unit -> CAML_TYPE(double)')
define(`FUNCTION1',`(* $1. $2 $4 *)
val tolower($2) : CAML_TYPE($3)-> CAML_TYPE(double)')
define(`FUNCTION2',`(* $1. $2 $4 $6 *)
val tolower($2) : CAML_TYPE($3) -> CAML_TYPE($5)-> CAML_TYPE(double)')
define(`FUNCTION3',`(* $1. $2 $4 $6 $8) *)
val tolower($2) : CAML_TYPE($3) -> CAML_TYPE($5) -> CAML_TYPE($7) -> CAML_TYPE(double)')
define(`FUNCTION4',`(* $1. $2 $4 $6 $8 $10 *)
val tolower($2) : CAML_TYPE($3) -> CAML_TYPE($5) -> CAML_TYPE($7) -> CAML_TYPE($9) -> CAML_TYPE(double)')
define(`FUNCTION5',`(* $1. $2 $4 $6 $8 $10 $12 *)
val tolower($2) : CAML_TYPE($3) -> CAML_TYPE($5) -> CAML_TYPE($7) -> CAML_TYPE($9) -> CAML_TYPE($11) -> CAML_TYPE(double)')
define(`FUNCTION6',`(* $1. $2 $4 $6 $8 $10 $12 $14 *)
val tolower($2) : CAML_TYPE($3) -> CAML_TYPE($5) -> CAML_TYPE($7) -> CAML_TYPE($9) -> CAML_TYPE($11) -> CAML_TYPE($13) -> CAML_TYPE(double)')
divert(`1')dnl
type test_alternative = TwoSided | Less | Greater
include(`rmath-template.m4')dnl
(* imin2. imin2 a b *)
val imin2 : int -> int -> int
(* imax2. imax2 a b *)
val imax2 : int -> int -> int
(* Normal cumulative density function. pnorm q mean sd lower log *)
val pnorm : float -> float -> float -> int -> int -> float
(* Normal quantile function. qnorm p mean sd lower log *)
val qnorm : float -> float -> float -> int -> int -> float
(* Normal probability density function. dnorm p mean sd log *)
val dnorm : float -> float -> float -> int -> float
(* Set random seed. set_seed a b *)
val set_seed : int -> int -> unit
(* log(1 + exp(x)). log1pexp x *)
val log1pexp : float -> float
(* Get random seed. get_seed a b *)
val get_seed : unit -> int * int
(* log(gamma) with sign. lgammafn_sign x *)
val lgammafn_sign : float -> float * int
(* Sample from a multinomial distribution. rmultinom n prob *)
val rmultinom : int -> float array -> int array
(* log(1 + exp(x)). rf_log1pexp x *)
val rf_log1pexp : float -> float
(* some additional functions *)
(* Poisson confidence interval. poisson_ci x t alternative confLevel *)
val poisson_ci : float -> float -> test_alternative -> float * float
(* Poisson test. poisson_test x t r alternative *)
val poisson_test: float -> float -> float -> test_alternative -> float
(* utility for loop. for_loop f init (left,right) *)
val for_loop : (int * 'a -> 'a) -> 'a -> int * int -> 'a
(* utility to count. count predicate (left,right) *)
val count : (int -> bool) -> int * int -> int
