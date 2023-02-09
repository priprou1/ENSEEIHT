(*Gonthier Priscilia L2*)

(*  Tri par insertion **)

(*Exercice 1*)
(*CONTRAT
Fonction qui ajoute un élément dans une liste triée, selon un ordre donné
Type : ('a->'a->bool)->'a->'a list -> 'a list
Paramètre : ordre  ('a->'a->bool), un ordre sur les éléments de la liste
Paramètre : elt, l'élement à ajouter
Paramètre : l, la liste triée dans laquelle ajouter elt
Résultat : une liste triée avec les éléments de l, plus elt
*)

let rec insert ordre elt l = 
  match l with
  | [] -> [elt]
  | h::t -> if ordre elt h then elt::l
            else h::(insert ordre elt t)

(* TESTS *)
let%test _ = insert (fun x y -> x<y) 3 []=[3]
let%test _ = insert (fun x y -> x<y) 3 [2;4;5]=[2;3;4;5]
let%test _ = insert (fun x y -> x > y) 6 [3;2;1]=[6;3;2;1]

(*Exercice 2*)
(*CONTRAT
Fonction qui trie une liste, selon un ordre donné
Type : ('a->'a->bool)->'a list -> 'a list
Paramètre : ordre  ('a->'a->bool), un ordre sur les éléments de la liste
Paramètre : l, la liste à trier
Résultat : une liste triée avec les éléments de l
*)

let tri_insertion ordre l = List.fold_right (fun elt l -> insert ordre elt l) l []  

(* TESTS *)
let%test _ = tri_insertion (fun x y -> x<y) [] =[]
let%test _ = tri_insertion (fun x y -> x<y) [4;2;4;3;1] =[1;2;3;4;4]
let%test _ = tri_insertion (fun x y -> x > y) [4;7;2;4;1;2;2;7]=[7;7;4;4;2;2;2;1]