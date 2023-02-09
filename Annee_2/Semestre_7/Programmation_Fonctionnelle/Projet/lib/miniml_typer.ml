open Miniml_types

(*** Fichier miniml_typer.ml  ***)
(* Auteur :  CAMPAN Mathieu     *)
(*           GIRARD Antoine     *)
(*           GONTHIER Priscilia *)
(*           HAUTESSERRES Simon *)
(* Date : 20/01/2023            *)

(* signature minimale pour définir des variables *)
module type VariableSpec =
  sig
    (* type abstrait des variables      *)
    type t

    (* création d'une variable fraîche  *)
    val fraiche : unit -> t

    (* fonctions de comparaison         *)
    (* permet de définir des conteneurs *)
    (* (hash-table, etc) de variables   *)
    val compare : t -> t -> int
    val equal : t -> t -> bool
    val hash : t -> int

    (* fonction d'affichage             *)
    (* on utilise Format.std_formatter  *)
    (* comme premier paramètre          *)
    (* pour la sortie standard          *) 
    val fprintf : Format.formatter -> t -> unit
  end

(* implantation de la spécification     *)
module TypeVariable : VariableSpec =
  struct
    type t = int

    let fraiche =
      let cpt = ref 0 in
      (fun () -> incr cpt; !cpt)

    let compare a b = a - b
    let equal a b = a = b
    let hash a = Hashtbl.hash a

    let fprintf fmt a = Format.fprintf fmt "t{%d}" a
  end


(* Définition de l'environnement env0 de départ commun à toutes les expressions *)
(* Contient tous les types et les opérations standard prédéfénies *)
let env_0 =
  let type_Concat = TVar(TypeVariable.fraiche())
  and type_Cons = TVar(TypeVariable.fraiche())
  and type_Virg1 = TVar(TypeVariable.fraiche())
  and type_Virg2= TVar(TypeVariable.fraiche())
  and type_Equal = TVar(TypeVariable.fraiche())
  and type_Notequal = TVar(TypeVariable.fraiche())
  and type_Infeq = TVar(TypeVariable.fraiche())
  and type_Inf = TVar(TypeVariable.fraiche())
  and type_Supeq = TVar(TypeVariable.fraiche())
  and type_Sup = TVar(TypeVariable.fraiche())
  and type_Fst1 = TVar(TypeVariable.fraiche())
  and type_Fst2 = TVar(TypeVariable.fraiche())
  and type_Snd1 = TVar(TypeVariable.fraiche())
  and type_Snd2 = TVar(TypeVariable.fraiche())
  and type_Hd = TVar(TypeVariable.fraiche())
  and type_Tl = TVar(TypeVariable.fraiche())

in [
  (* @ : ’a list −> ’a list −> ’a list *)
  (CONCAT , TFun(TList(type_Concat),TFun(TList(type_Concat),TList(type_Concat))))
  (* :: : ’a −> ’a list −> ’a list *)
  ;(CONS, TFun(type_Cons ,TFun(TList(type_Cons),TList(type_Cons))))
  (* , : ’a −> ’b −> ’a * ’b *)
  ;(VIRG, TFun(type_Virg1, TFun(type_Virg2, TProd(type_Virg1,type_Virg2))))
  (* Arithop : int −> int −> int *)
  ;(PLUS, TFun(TInt, TFun(TInt, TInt)))
  ;(MOINS, TFun(TInt, TFun(TInt, TInt)))
  ;(MULT, TFun(TInt, TFun(TInt, TInt)))
  ;(DIV, TFun(TInt, TFun(TInt, TInt)))
  (* Relop : ’a −> ’a −> bool *)
  ;(EQU, TFun(type_Equal,TFun(type_Equal, TBool)))
  ;(NOTEQ, TFun(type_Notequal,TFun(type_Notequal, TBool)))
  ;(INFEQ, TFun(type_Infeq,TFun(type_Infeq, TBool)))
  ;(INF, TFun(type_Inf,TFun(type_Inf, TBool)))
  ;(SUPEQ, TFun(type_Supeq,TFun(type_Supeq, TBool)))
  ;(SUP, TFun(type_Sup,TFun(type_Sup, TBool)))
  (* Boolop : bool −> bool −> bool *)
  ;(AND, TFun(TBool, TFun(TBool, TBool)))
  ;(OR, TFun(TBool, TFun(TBool, TBool)))
  (* Pas dans le lexer, mais indiqué à mettre dans l'environement initial dans le sujet : *)
  (* not : bool −> bool *)
  ;(IDENT "not", TFun(TBool, TBool))
  (* fst : ’a * ’b −> ’a *)
  ;(IDENT "fst", TFun(TProd(type_Fst1,type_Fst2), type_Fst1))
  (* snd : ’a * ’b −> ’b *)
  ;(IDENT "snd", TFun(TProd(type_Snd1,type_Snd2), type_Snd2))
  (* hd : ’a list −> ’a *)
  ;(IDENT "hd", TFun(TList(type_Hd), type_Hd))
  (* tl : ’a list −> ’a list  *)
  ;(IDENT "tl", TFun(TList(type_Tl), TList(type_Tl)))
  ]

(* ******** Inférence de Type ********* *)

(* ******** Fonctions auxiliaires ********* *)
(* ident_in_event : ident -> (token*TypeVariable.t typ) list -> TypeVariable.t typ *)
(* Recherche d'un ident dans l'environnement                                       *)
(* Paramètres                                                                      *)
(*    ident - ident : ident à rechercher                                           *)
(*    env - (token*TypeVariable.t typ) list : environnement                        *)
(* Résultat - TypeVariable.t typ : type de l'ident si présent dans l'environnement *)

  let rec ident_in_event ident env = 
    match env with
    | [] -> failwith "ident_in_event : ident non trouvé"
    | (t,qt)::q -> if (IDENT ident) = t then 
      (match ident with (* Pour les fonctions prédéfinies, on fait une copie avec un nouveau type libre pour que les appels se fassent sur différents types*)
        | "not" -> TFun(TBool, TBool)
        | "fst" -> let type_1 = TVar(TypeVariable.fraiche ()) in 
                   let type_2 = TVar(TypeVariable.fraiche ()) in 
                   TFun(TProd(type_1,type_2), type_1)
        | "snd" -> let type_1 = TVar(TypeVariable.fraiche ()) in 
                   let type_2 = TVar(TypeVariable.fraiche ()) in 
                   TFun(TProd(type_1,type_2), type_2)
        | "hd" ->  let type_1 = TVar(TypeVariable.fraiche ()) in 
                   TFun(TList(type_1), type_1)
        | "tl" ->  let type_1 = TVar(TypeVariable.fraiche ()) in 
                   TFun(TList(type_1), TList(type_1))
        | _ -> qt
      )
    else ident_in_event ident q


(* ******** Fonction principale ********* *)
(* search_type : (token*TypeVariable.t typ) list -> expr -> TypeVariable.t typ*(TypeVariable.t typ*TypeVariable.t typ) list                    *)
(* Fonction de recherche de type                                                                                                               *)
(* Paramètres                                                                                                                                  *)
(*    env - (token*TypeVariable.t typ) list : environnement                                                                                    *)
(*    expr - expr : expression à analyser                                                                                                      *)
(* Résultat - TypeVariable.t typ*(TypeVariable.t typ*TypeVariable.t typ) list : type de l'expression et les équations de définition de ce type *)
let rec search_type env expr =
  match expr with
  (* constante                   *)
  | EConstant(constant) -> (match constant with
      (* constante booléenne         *)
      | CBooleen(_) -> (TBool, [])
      (* constante entière           *)
      | CEntier(_) -> (TInt, [])
      (* constante []                *)
      | CNil -> (TList(TVar(TypeVariable.fraiche())),[])
      (* constante ()                *)
      | CUnit -> (TUnit, [])
  )
  (* variable                    *)
  | EIdent(ident) -> ((ident_in_event ident env) , [])
  (* paire (e1, e2)              *)
  | EProd(expr1,expr2) -> let (type_expr1, equ1) = search_type env expr1 
                          and (type_expr2, equ2) = search_type env expr2 
                          in (TProd(type_expr1,type_expr2),(equ1@equ2))
  (* liste (e1::e2)              *)
  | ECons(expr1,expr2) -> let (type_expr1, equ1) = search_type env expr1
                          and (type_expr2, equ2) = search_type env expr2
                          in (TList(type_expr1), (type_expr2, TList(type_expr1))::equ1@equ2) 
  (* fonction anonyme            *)
  | EFun(ident,expr) -> let type_libre = TVar(TypeVariable.fraiche()) in
                        let (type_expr, equ1) = search_type ((IDENT ident, type_libre)::env) expr
                        in  (TFun(type_libre, type_expr), equ1)
  (* bloc conditionnelle              *)
  | EIf(expr1,expr2,expr3) -> let (type_expr1, equ1) = search_type env expr1
                              and (type_expr2, equ2) = search_type env expr2 
                              and (type_expr3, equ3) = search_type env expr3
                              in (type_expr2, (type_expr1, TBool)::(type_expr2, type_expr3)::(equ1@equ2@equ3))
  (* application (e1 e2)         *)
  | EApply(expr1,expr2) -> let (type_expr1, equ1) = search_type env expr1  (* func : 'a connu -> 'b libre *)
                           and (type_expr2, equ2) = search_type env expr2 (* arg : 'a connu *)
                           and type_libre = TVar(TypeVariable.fraiche())
                           in (type_libre, (type_expr1, TFun(type_expr2, type_libre))::(equ1@equ2))
  (* opérateur binaire prédéfini *)
  | EBinop(token) -> (match token with
      (* Opérateur de concaténation de liste*)
      | CONCAT -> let type_libre = TVar(TypeVariable.fraiche())
                  in (TFun(TList(type_libre), TFun(TList(type_libre), TList(type_libre))), [])
      (* Opérateur de construction de liste *)
      | CONS -> let type_libre = TVar(TypeVariable.fraiche())
                 in (TFun(type_libre,TFun(TList(type_libre),TList(type_libre))), [])
      (* Opérateur arithmétique *)
      | PLUS | MOINS | MULT | DIV -> (TFun(TInt, TFun(TInt, TInt)), [])
      (* Opérateur de comparaison *)
      | EQU | NOTEQ | INFEQ | INF | SUPEQ | SUP -> let type_libre = TVar(TypeVariable.fraiche())
                            in (TFun(type_libre,TFun(type_libre, TBool)), [])
      (* Opérateur booléen *)
      | AND | OR -> (TFun(TBool, TFun(TBool, TBool)), [])
      (* Cas d'erreur *)
      | _ -> failwith "Erreur : opérateur binaire non prédéfini"
      )
  (* définition fonction let *)
  | ELet(ident,expr1,expr2) ->  let (type_expr1, eq1) = search_type env expr1 in
                                let (type_expr2, eq2) = search_type ((IDENT ident, type_expr1)::env) expr2 
                                in (type_expr2, eq1@eq2)

  (* définition fonction let récursive *)
  | ELetrec(ident,expr1,expr2) -> let type_libre = TVar(TypeVariable.fraiche()) in
                                  let (type_expr1, equ1) = search_type ((IDENT ident, type_libre)::env) expr1 in
                                  let (type_expr2, equ2) = search_type ((IDENT ident, type_libre)::env) expr2
                                  in (type_expr2, (type_libre, type_expr1)::(equ1@equ2))



(* ******** Résolution des équations ********* *)

(* ******** Fonctions auxiliaires ********* *)

(* substitute_type : TypeVariable.t typ -> TypeVariable.t typ -> TypeVariable.t typ -> TypeVariable.t typ
 * Substituer la variable alpha par rho dans le type type_eq
 * Paramètres : 
 *    alpha - TypeVariable.t typ : Variable à substituer
 *    rho - TypeVariable.t typ : Variable de substitution
 *    type_eq - TypeVariable.t typ : Type dans lequel substituer
 * Résultat - TypeVariable.t typ : Type avec tous les alphas remplacés par rho *)
let rec substitute_type (TVar alpha) rho type_eq =
  match type_eq with
  | TList t1 -> TList (substitute_type (TVar alpha) rho t1)
  | TFun(t1,t2) -> TFun(substitute_type (TVar alpha) rho t1,substitute_type (TVar alpha) rho t2)
  | TProd(t1,t2) -> TProd(substitute_type (TVar alpha) rho t1,substitute_type (TVar alpha) rho t2)
  | TVar alpha1 -> if (TypeVariable.equal alpha1 alpha) then rho else type_eq
  | _ -> type_eq

(* substitute : TypeVariable.t typ -> TypeVariable.t typ -> (TypeVariable.t typ * TypeVariable.t typ) list -> (TypeVariable.t typ * TypeVariable.t typ) list
 * Substituer le type de la variable alpha par le type rho dans la liste d'équations donné en paramètre
 * Paramètres : 
 *    alpha - TypeVariable.t typ : Variable à substituer
 *    rho - TypeVariable.t typ : Variable de substitution
 *    list_eq - (TypeVariable.t typ * TypeVariable.t typ) list : Liste d'équations dans laquelle substituer
 * Résultat - (TypeVariable.t typ * TypeVariable.t typ) list : Liste d'équations avec tous les alphas remplacés par rho *)
let substitute (TVar alpha) rho list_eq =
  (* substitute_eq : Substituer le type de la variable alpha par rho dans l'équation eq *)
  let substitute_eq (TVar alpha) rho eq = (substitute_type (TVar alpha) rho (fst eq), substitute_type (TVar alpha) rho (snd eq))
  in List.map (fun eq -> substitute_eq (TVar alpha) rho eq) list_eq



(* ******** Fonction principale ********* *)

(* get_type : TypeVariable.t typ*(TypeVariable.t typ * TypeVariable.t typ) list -> TypeVariable.t typ
 * Donne le type défini par les équations données en arguments
 * Paramètres : 
 *    type_list_eqs - TypeVariable.t typ*(TypeVariable.t typ * TypeVariable.t typ) list : Paire qui a comme premier élément le type à déterminer et comme second la liste des équations le définissant
 * Résultat - TypeVariable.t typ : Le type trouvé *)
let get_type type_list_eqs =
  (* Applique les règles de normalisation sur la liste d'équations et le type à trouver afin de déterminer le type *)
  let rec resolve_type type_list_eqs =
    let (type_f,list_eqs) = type_list_eqs in
        match list_eqs with
      (* Ø |- tau => sigma *)
      | [] -> (type_f,list_eqs)
      | t::q -> (match t with
                (* Eqs |- tau => sigma             *)
                (* {int ≡ int}UEqs |- tau => sigma *)
                | (TInt, TInt) -> resolve_type (type_f,q)
                (* Eqs |- tau => sigma               *)
                (* {bool ≡ bool}UEqs |- tau => sigma *)
                | (TBool, TBool) -> resolve_type (type_f,q)
                (* Eqs |- tau => sigma               *)
                (* {unit ≡ unit}UEqs |- tau => sigma *)
                | (TUnit, TUnit) -> resolve_type (type_f,q)
                (* {t1 ≡ t2}UEqs |- tau => sigma           *)
                (* {t1 list ≡ t2 list}UEqs |- tau => sigma *)
                | (TList t1, TList t2) -> resolve_type (type_f,((t1,t2)::q))
                (* {t1 ≡ s1,t2 ≡ s2}UEqs |- tau => sigma     *)
                (* {t1 -> t2 ≡ s1 -> s2}UEqs |- tau => sigma *)
                | (TFun(t1,t2), TFun(s1,s2)) -> resolve_type (type_f,((t1,s1)::(t2,s2)::q))
                (* {t1 ≡ s1,t2 ≡ s2}UEqs |- tau => sigma *)
                (* {t1*t2 ≡ s1*s2}UEqs |- tau => sigma   *)
                | (TProd(t1,t2), TProd(s1,s2)) -> resolve_type (type_f,((t1,s1)::(t2,s2)::q))
                | (TVar alpha1, TVar alpha2) -> 
                  (* Eqs |- tau => sigma                 *)
                  (* {alpha ≡ alpha}UEqs |- tau => sigma *)
                  if (TypeVariable.equal alpha1 alpha2) then resolve_type (type_f, q)
                  (* [alpha -> rho]Eqs |- tau => sigma               *)
                  (* {alpha ≡ rho}UEqs |- tau => [alpha -> rho]sigma *)
                  else resolve_type (substitute_type (TVar alpha1) (TVar alpha2) type_f,(substitute (TVar alpha1) (TVar alpha2) q)) (* alpha non libre dans rho != alpha, car cela a été traité dessus *)
                (* [alpha -> rho]Eqs |- tau => sigma               *)
                (* {alpha ≡ rho}UEqs |- tau => [alpha -> rho]sigma *)
                | (TVar alpha, rho) -> resolve_type (substitute_type (TVar alpha) rho type_f,(substitute (TVar alpha) rho q))  (* alpha non libre dans rho != alpha, car cela a été traité dessus *)
                (* {alpha ≡ rho}UEqs |- tau => sigma               *)
                (* {rho ≡ alpha}UEqs |- tau => [alpha -> rho]sigma *)
                | (rho, TVar alpha) -> resolve_type (substitute_type (TVar alpha) rho type_f,((TVar alpha, rho)::q)) (* rho n'est pas une variable ici car cela a été traité dessus *)
                (* Cas non normalisables, déclenche une erreur de type *)
                | _ -> failwith "type incorrect"
                )
in fst (resolve_type type_list_eqs)

(* ******** Fonction de typage principale ********* *)
(* type_expr : expr -> TypeVariable.t typ
 * Donne le type de l'expression donné en argument
 * Paramètres : 
 *    expr - expr : Expression à typer
 * Résultat - TypeVariable.t typ : Le type trouvé *)
let type_expr expr =
  let type_list_eqs = search_type env_0 expr in
    get_type type_list_eqs