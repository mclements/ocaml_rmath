open Rmath;;
let printLn x = Printf.printf "%f\n" x;;
let y = qnorm5 0.975 0.0 1.0 1 0 in 
    printLn y;;
let (y,s) = lgammafn_sign 3.0 in
    printLn y;;
let r = rmultinom 1000 [|0.1;0.2;0.7|] in
    Printf.printf "(%i,%i,%i)\n" r.(0) r.(1) r.(2);;
let p = poisson_test 10.0 12.0 1.0 TwoSided in
    printLn p;;
let p = poisson_test 10.0 8.0 1.0 TwoSided in
    printLn p;;
