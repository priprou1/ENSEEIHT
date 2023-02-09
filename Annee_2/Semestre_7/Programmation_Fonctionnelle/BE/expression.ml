(* Exercice 3 *)
module type Expression = 
sig
  (* Type pour représenter les expressions *)
  type exp


  (* eval : exp -> int 
   * Evaluer la valeur d'une expression donnée en paramètre
   * Paramètre : exp - Expression à évaluer
   * Retour : int - Valeur de l'expression *)
  val eval : exp -> int
end

(* Exercice 4 *)

module ExpAvecArbreBinaire : Expression =
struct
  type op = Moins | Plus | Mult | Div
  type exp = Binaire of exp * op * exp | Entier of int
  let rec eval expr = 
    match expr with
    | Entier e -> e
    | Binaire (a, o, b) -> 
      (match o with
        | Moins -> (eval a) - (eval b)
        | Plus -> (eval a) + (eval b)
        | Mult -> (eval a) * (eval b)
        | Div -> (eval a) / (eval b)
      )

  (* Tests d'eval *)
  (* (3+4)-12=-5 *)
  let arbre = Binaire(Binaire (Entier 3, Plus, Entier 4), Moins, Entier 12)
  let%test _ = eval arbre = -5
  (* (3+4)-(4/2)=5 *)
  let arbre2 = Binaire(Binaire (Entier 3, Plus, Entier 4), Moins, Binaire (Entier 4, Div, Entier 2))
  let%test _ = eval arbre2 = 5
  (* ((4/4)*(5-3))/(1+0)=2 *)
  let arbre3 = Binaire(Binaire (Binaire (Entier 4, Div, Entier 4), Mult, Binaire (Entier 5, Moins, Entier 3)), Div, Binaire (Entier 1, Plus, Entier 0))
  let%test _ = eval arbre3 = 2
  (* 2=2 *)
  let arbre4 = Entier 2
  let%test _ = eval arbre4 = 2
end

(* Exercice 5 *)

module ExpAvecArbreNaire : Expression =
struct
  (* Linéarisation des opérateurs binaire associatif gauche et droit *)
  type op = Moins | Plus | Mult | Div
  type exp = Naire of op * exp list | Valeur of int
    
  (* bienformee : exp -> bool *)
  (* Vérifie qu'un arbre n-aire représente bien une expression n-aire *)
  (* c'est-à-dire que les opérateurs d'addition et multiplication ont au moins deux opérandes *)
  (* et que les opérateurs de division et soustraction ont exactement deux opérandes.*)
  (* Paramètre : l'arbre n-aire dont ont veut vérifier si il correspond à une expression *)
  let rec bienformee arbre = 
    match arbre with
    | Valeur _ -> true
    | Naire(o, l) ->
      (match o, l with
        | _, [] -> false 
        | _, _::[] -> false
        | Moins, h::s::t -> if t=[] then (bienformee h) && (bienformee s) else false
        | Div, h::s::t -> if t=[] then (bienformee h) && (bienformee s) else false
        | Plus, _::_::_ -> List.fold_left (fun b e -> b && (bienformee e)) true l
        | Mult, _::_::_ -> List.fold_left (fun b e -> b && (bienformee e)) true l
      )

  let en1 = Naire (Plus, [ Valeur 3; Valeur 4; Valeur 12 ])
  let en2 = Naire (Moins, [ en1; Valeur 5 ])
  let en3 = Naire (Mult, [ en1; en2; en1 ])
  let en4 = Naire (Div, [ en3; Valeur 2 ])
  let en1err = Naire (Plus, [ Valeur 3 ])
  let en2err = Naire (Moins, [ en1; Valeur 5; Valeur 4 ])
  let en3err = Naire (Mult, [ en1 ])
  let en4err = Naire (Div, [ en3; Valeur 2; Valeur 3 ])

  let%test _ = bienformee en1
  let%test _ = bienformee en2
  let%test _ = bienformee en3
  let%test _ = bienformee en4
  let%test _ = not (bienformee en1err)
  let%test _ = not (bienformee en2err)
  let%test _ = not (bienformee en3err)
  let%test _ = not (bienformee en4err)
      
  (* eval : exp-> int *)
  (* Calcule la valeur d'une expression n-aire *)
  (* Paramètre : l'expression dont on veut calculer la valeur *)
  (* Précondition : l'expression est bien formée *)
  (* Résultat : la valeur de l'expression *)
  let rec eval_bienformee expr = 
  match expr with
    | Valeur e -> e
    | Naire (o, l) -> 
      (match o, l with
        | _ , [] -> 0
        | _ , _::[] -> 0
        | Moins, h::s::_ -> (eval_bienformee h) - (eval_bienformee s)
        | Plus, _ -> List.fold_left (fun a ex -> a + eval_bienformee ex) 0 l
        | Mult, _ -> List.fold_left (fun a ex -> a * eval_bienformee ex) 1 l
        | Div, h::s::_ -> (eval_bienformee h) / (eval_bienformee s)
      )

  let%test _ = eval_bienformee en1 = 19
  let%test _ = eval_bienformee en2 = 14
  let%test _ = eval_bienformee en3 = 5054
  let%test _ = eval_bienformee en4 = 2527

  (* Définition de l'exception Malformee *)
  exception Malformee

  (* eval : exp-> int *)
  (* Calcule la valeur d'une expression n-aire *)
  (* Paramètre : l'expression dont on veut calculer la valeur *)
  (* Résultat : la valeur de l'expression *)
  (* Exception  Malformee si le paramètre est mal formé *)
  let eval arbre = 
    if bienformee arbre then eval_bienformee arbre else raise Malformee
      
  let%test _ = eval en1 = 19
  let%test _ = eval en2 = 14
  let%test _ = eval en3 = 5054
  let%test _ = eval en4 = 2527

  let%test _ =
    try
      let _ = eval en1err in
      false
    with Malformee -> true

  let%test _ =
    try
      let _ = eval en2err in
      false
    with Malformee -> true

  let%test _ =
    try
      let _ = eval en3err in
      false
    with Malformee -> true

  let%test _ =
    try
      let _ = eval en4err in
      false
    with Malformee -> true
    
end
