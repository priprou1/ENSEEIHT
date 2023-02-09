(* Exercice 1*)

(* max : int list -> int  *)
(* Paramètre : liste dont on cherche le maximum *)
(* Précondition : la liste n'est pas vide *)
(* Résultat :  l'élément le plus grand de la liste *)
let max liste = 
  List.fold_left (fun a b -> if a>=b then a else b) 0 liste

(************ tests de max ************)
let%test _ = max [ 1 ] = 1
let%test _ = max [ 1; 2 ] = 2
let%test _ = max [ 2; 1 ] = 2
let%test _ = max [ 1; 2; 3; 4; 3; 2; 1 ] = 4

(* max_max : int list list -> int  *)
(* Paramètre : la liste de listes dont on cherche le maximum *)
(* Précondition : il y a au moins un élement dans une des listes *)
(* Résultat :  l'élément le plus grand de la liste *)
let max_max liste = 
  List.fold_left (fun a b -> if a >= max b then a else max b) 0 liste

(************ tests de max_max ************)
let%test _ = max_max [ [ 1 ] ] = 1
let%test _ = max_max [ [ 1 ]; [ 2 ] ] = 2
let%test _ = max_max [ [ 2 ]; [ 2 ]; [ 1; 1; 2; 1; 2 ] ] = 2
let%test _ = max_max [ [ 2 ]; [ 1 ] ] = 2
let%test _ = max_max [ [ 1; 1; 2; 1 ]; [ 1; 2; 2 ] ] = 2
let%test _ =
  max_max [ [ 1; 1; 1 ]; [ 2; 1; 2 ]; [ 3; 2; 1; 4; 2 ]; [ 1; 3; 2 ] ] = 4


(* Exercice 2*)

(* suivant : int list -> int list *)
(* Calcule le terme suivant dans une suite de Conway *)
(* Paramètre : le terme dont on cherche le suivant *)
(* Précondition : paramètre différent de la liste vide *)
(* Retour : le terme suivant *)

let suivant liste = 
  let rec suivant_aux liste nliste ncour nb = 
    match liste, nb with
    | [], 0 -> nliste
    | [], _ -> nliste@[nb; ncour]
    | h::t, 0 -> suivant_aux t nliste h 1
    | h::t, _ -> if h=ncour then suivant_aux t nliste h (nb+1)
                 else suivant_aux t (nliste@[nb; ncour]) h 1
  in suivant_aux liste [] 0 0

(************ tests de suivant ************)
let%test _ = suivant [ 1 ] = [ 1; 1 ]
let%test _ = suivant [ 2 ] = [ 1; 2 ]
let%test _ = suivant [ 3 ] = [ 1; 3 ]
let%test _ = suivant [ 1; 1 ] = [ 2; 1 ]
let%test _ = suivant [ 1; 2 ] = [ 1; 1; 1; 2 ]
let%test _ = suivant [ 1; 1; 1; 1; 3; 3; 4 ] = [ 4; 1; 2; 3; 1; 4 ]
let%test _ = suivant [ 1; 1; 1; 3; 3; 4 ] = [ 3; 1; 2; 3; 1; 4 ]
let%test _ = suivant [ 1; 3; 3; 4 ] = [ 1; 1; 2; 3; 1; 4 ]
let%test _ = suivant [3;3] = [2;3]

(* suite : int -> int list -> int list list *)
(* Calcule la suite de Conway *)
(* Paramètre taille : le nombre de termes de la suite que l'on veut calculer *)
(* Paramètre depart : le terme de départ de la suite de Conway *)
(* Résultat : la suite de Conway *)
let suite taille depart = 
  let rec suite_aux taille liste =
    if taille <= 0 then
      liste 
    else
      suite_aux (taille-1) (liste@[suivant (List.hd (List.rev liste))])
  in suite_aux (taille-1) [depart]

(************ tests de suite ************)
let%test _ = suite 1 [ 1 ] = [ [ 1 ] ]
let%test _ = suite 2 [ 1 ] = [ [ 1 ]; [ 1; 1 ] ]
let%test _ = suite 3 [ 1 ] = [ [ 1 ]; [ 1; 1 ]; [ 2; 1 ] ]
let%test _ = suite 4 [ 1 ] = [ [ 1 ]; [ 1; 1 ]; [ 2; 1 ]; [ 1; 2; 1; 1 ] ]

let%test _ =
  suite 5 [ 1 ]
  = [ [ 1 ]; [ 1; 1 ]; [ 2; 1 ]; [ 1; 2; 1; 1 ]; [ 1; 1; 1; 2; 2; 1 ] ]

let%test _ =
  suite 10 [ 1 ]
  = [
      [ 1 ];
      [ 1; 1 ];
      [ 2; 1 ];
      [ 1; 2; 1; 1 ];
      [ 1; 1; 1; 2; 2; 1 ];
      [ 3; 1; 2; 2; 1; 1 ];
      [ 1; 3; 1; 1; 2; 2; 2; 1 ];
      [ 1; 1; 1; 3; 2; 1; 3; 2; 1; 1 ];
      [ 3; 1; 1; 3; 1; 2; 1; 1; 1; 3; 1; 2; 2; 1 ];
      [ 1; 3; 2; 1; 1; 3; 1; 1; 1; 2; 3; 1; 1; 3; 1; 1; 2; 2; 1; 1 ];
    ]

let%test _ =
  suite 10 [ 3; 3 ]
  = [
      [ 3; 3 ];
      [ 2; 3 ];
      [ 1; 2; 1; 3 ];
      [ 1; 1; 1; 2; 1; 1; 1; 3 ];
      [ 3; 1; 1; 2; 3; 1; 1; 3 ];
      [ 1; 3; 2; 1; 1; 2; 1; 3; 2; 1; 1; 3 ];
      [ 1; 1; 1; 3; 1; 2; 2; 1; 1; 2; 1; 1; 1; 3; 1; 2; 2; 1; 1; 3 ];
      [ 3; 1; 1; 3; 1; 1; 2; 2; 2; 1; 1; 2; 3; 1; 1; 3; 1; 1; 2; 2; 2; 1; 1; 3 ];
      [ 1; 3; 2; 1; 1; 3; 2; 1; 3; 2; 2; 1; 1; 2; 1; 3; 2; 1; 1; 3; 2; 1; 3; 2; 2; 1; 1; 3; ];
      [ 1; 1; 1; 3; 1; 2; 2; 1; 1; 3; 1; 2; 1; 1; 1; 3; 2; 2; 2; 1; 1; 2; 1; 1; 1; 3; 1; 2; 2; 1; 1; 3; 1; 2; 1; 1; 1; 3; 2; 2; 2; 1; 1; 3; ];
    ]

(* Tests de la conjecture *)
(* "Aucun terme de la suite, démarant à 1, ne comporte un chiffre supérieur à 3" *)

(* test_prop : int -> bool
 * Renvoyer si tous les termes comporte des chiffre inférieur à 3 pour la suite de taille donnée en paramètre dont le premier terme est 1
 * Paramètre : int - Taille de la suite de Conway à évaluer
 * Retour : bool - Vrai si tous les chiffres inférieur à 3 faux sinon*)
let test_prop taille = 
  let rec inf3 l = 
    (match l with
    | [] -> true
    | h::t -> if h > 3 then false else inf3 t)
  in List.fold_left (fun b l -> b && (inf3 l) ) true (suite taille [ 1 ])
 

let%test _ = test_prop 1 = true
let%test _ = test_prop 5 = true
let%test _ = test_prop 20 = true
let%test _ = test_prop 30 = true
let%test _ = test_prop 35 = true
(*let%test _ = test_prop 40 = true*)

(* Remarque : Cette technique fonctionne pour les suites de petites tailles,
   et elle va mettre beaucoup trop de temps pour les grandes suites (par exemple
   une taille de 40, est bien long).
   Cette technique ne permet pas de tester toutes les suites possible, seulement
   celles qui ont une taille finie.
   La complexité est importante du fait que l'on parcours chaque sous-liste et
   que pour chaque élément de cette sous-liste on effectue une comparaison.*)