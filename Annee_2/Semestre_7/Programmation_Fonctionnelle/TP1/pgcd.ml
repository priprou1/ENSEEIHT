(*  Exercice 5 *)
(* Girard Antoine et Gonthier Priscilia L2 *)
(*  TO DO : contrat *)
(* pgcd : int*int->int *)
(* renvoie le pgcd de deux entiers *)
(* a : premier entier *)
(* b : deuxième entier *)
(* renvoie le pgcd de a et b *)
(* précondition : a>0 && b>0 *)

let rec pgcd a b = 
  if a=b then a
  else if a>b then pgcd (a-b) b
  else pgcd a (b-a)

(*  TO DO : tests unitaires *)
let%test _ = pgcd 10 5 = 5
let%test _ = pgcd 12 10 = 2


(* pgcdv2 : int*int->int *)
(* renvoie le pgcd de deux entiers en traitant le cas négatif *)
(* a : premier entier *)
(* b : deuxième entier *)
(* renvoie le pgcd de a et b *)
(* précondition : not (a = 0) && not (b = 0)*)
let pgcdv2 a b =
  let rec pgcd_aux a b = 
    if a=b then a
    else if a>b then pgcd_aux (a-b) b
    else pgcd_aux a (b-a)
  in pgcd_aux (abs a) (abs b)

(*  TO DO : tests unitaires *)
let%test _ = pgcdv2 10 5 = 5
let%test _ = pgcdv2 10 12 = 2
let%test _ = pgcdv2 (-10) 5 = 5
let%test _ = pgcdv2 10 (-5) = 5
let%test _ = pgcdv2 (-10) (-5) = 5

