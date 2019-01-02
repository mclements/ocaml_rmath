#use "topfind";;
#require "ctypes.foreign";;
#require "ctypes.top";;

#use "rmath.ml";;

open Rmath;;
     
qnorm5 0.975 0.0 1.0 1 0;;

lgammafn_sign 3.0;;

rmultinom 1000 [|0.1;0.2;0.7|];;
poisson_test 10.0 12.0 1.0 Rmath.TwoSided)
poisson_test 10.0 8.0 1.0 Rmath.TwoSided)

(* poisson_ci 10.0 0.95 Rmath.TwoSided;; *)
