(*Rendu TP3*)
(*Priscilia Gonthier*)
(*Exercice 2*)

(*** Combinaisons d'une liste ***)

(* CONTRAT 
Fonction qui renvoie toutes les combinaisons de k éléments d'une liste passé en paramètre
Paramètre k : nombre d'éléments par combinaison
Paramètre l : liste dans laquelle les éléments sont choisis
Résutat : liste des combinaisons de k éléments parmis la liste l
Préconditions : k >= 0
*)
let rec combinaison k l = match k,l with
  | 0,_ -> [[]]
  | _,[] -> []
  | _,h::t -> (List.map (fun l -> h::l) (combinaison (k-1) t))@(combinaison k t)

(* TESTS *)
let%test _ = combinaison 0 [1;2;3;4] = [[]]
let%test _ = combinaison 2 [] = []
let%test _ = combinaison 3 [1;2;3;4] = [[1;2;3];[1;2;4];[1;3;4];[2;3;4]]
let%test _ = combinaison 2 [1;2;3;4] = [[1;2];[1;3];[1;4];[2;3];[2;4];[3;4]]