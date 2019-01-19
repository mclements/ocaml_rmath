divert(`-1')
define(`tolower', `translit(`$*', `A-Z', `a-z')')dnl
define(`CONSTANT',`let tolower($2) = $3')
define(`FUNCTION0',`let tolower($2) = foreign ~from:library "$2" (void @-> returning double)')
define(`FUNCTION1',`let tolower($2) = foreign ~from:library "$2" ($3 @-> returning double)')
define(`FUNCTION2',`let tolower($2) = foreign ~from:library "$2" ($3 @-> $5 @-> returning double)')
define(`FUNCTION3',`let tolower($2) = foreign ~from:library "$2" ($3 @-> $5 @-> $7 @-> returning double)')
define(`FUNCTION4',`let tolower($2) = foreign ~from:library "$2" ($3 @-> $5 @-> $7 @-> $9 @-> returning double)')
define(`FUNCTION5',`let tolower($2) = foreign ~from:library "$2" ($3 @-> $5 @-> $7 @-> $9 @-> $11 @-> returning double)')
define(`FUNCTION6',`let tolower($2) = foreign ~from:library "$2" ($3 @-> $5 @-> $7 @-> $9 @-> $11 @-> $13 @-> returning double)')
divert(`1')dnl
open Ctypes
open Foreign
let library = Dl.dlopen ~filename:"LIBRMATH" ~flags:[Dl.RTLD_LAZY]
type test_alternative = TwoSided | Less | Greater
include(`rmath-template.m4')dnl
let imin2 = foreign ~from:library "imin2" (int @-> int @-> returning int)
let imax2 = foreign ~from:library "imax2" (int @-> int @-> returning int)
let set_seed = foreign ~from:library "set_seed" (int @-> int @-> returning void)
let log1pexp = rf_log1pexp
let get_seed () =
  let local = foreign ~from:library "get_seed" (ptr int @-> ptr int @-> returning void) in
  let seed1 = allocate int 0 in
  let seed2 = allocate int 0 in
  local seed1 seed2;
  (!@ seed1, !@ seed2)
let lgammafn_sign x =
  let local = foreign ~from:library "lgammafn_sign" (double @-> ptr int @-> returning double) in
  let sign = allocate int 0 in
  let y = local x sign in
  (y, !@ sign)
let rmultinom n prob =
  let local = foreign ~from:library "rmultinom" (int @-> ptr double @-> int @-> ptr int @-> returning void) in
  let k = Array.length prob in
  let cprob = CArray.of_list double (Array.to_list prob) in
  let rN = CArray.make int k in
  local n (CArray.start cprob) k (CArray.start rN);
  Array.of_list (CArray.to_list rN)
EXTRAFUNS(infinity)dnl
