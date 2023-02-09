open Miniml_types
open Miniml_lexer
open Lazyflux

(*** Fichier miniml_parser.ml ***)
(* Auteur :  CAMPAN Mathieu     *)
(*           GIRARD Antoine     *)
(*           GONTHIER Priscilia *)
(*           HAUTESSERRES Simon *)
(* Date : 20/01/2023            *)

(* Ce fichier contient les fonctions de lecture et de parsing de MiniML *)

(* Fonction de lecture d'un fichier.      *)
(* string -> token Flux.t                 *)
(* Paramètres *)
(* filename : nom du fichier en entrée    *)
(* Résultat : flux de lexèmes reconnus    *)
(* Exception : ErreurLecture si le fichier n'existe pas             *)
(*             ErreurLex si le fichier contient une erreur lexicale *)
let read_miniml_tokens_from_file filename : token Flux.t =
  try
    let chan = open_in filename in
    let buf = Lexing.from_channel chan in
    line_g := 1;
    let next_token () =
      try
        let next = token buf in
        if next = EOF
        then
          begin
            close_in chan;
            None
          end
        else
          Some (next, ())
   with
   | ErreurLex msg ->
      begin
        close_in chan;
        raise (ErreurLecture (Format.sprintf "ERREUR : ligne %d, lexème '%s' : %s" !line_g (Lexing.lexeme buf) msg))
      end in
    Flux.unfold next_token ()
 with
    | Sys_error _ -> raise (ErreurLecture (Format.sprintf "ERREUR : Impossible d'ouvrir le fichier '%s' !" filename))
;;

(* Fonction de lecture d'un buffer.    *)
(* Lexing.lexbuf -> token Flux.t       *)
(* Paramètres *)
(* buf : buffer en entrée              *)
(* Résultat : flux de lexèmes reconnus *)
(* Exception : ErreurLex si le buffer contient une erreur lexicale *)
(* Similaire à la fonction précédente *)
let read_miniml_tokens_from_lexbuf buf : token Flux.t =
  line_g := 1;
  let next_token () =
    try
      let next = token buf in
      if next = EOF
      then
        begin
          None
        end
      else
        Some (next, ())
    with
    | ErreurLex msg ->
       begin
         raise (ErreurLecture (Format.sprintf "ERREUR : ligne %d, lexème '%s' : %s" !line_g (Lexing.lexeme buf) msg))
       end in
  Flux.unfold next_token ()
;;

(* Fonction de lecture d'une chaîne.  *)
(* string -> token Flux.t             *)
(* Paramètres *)
(* chaine : chaîne en entrée          *)
(* Résultat : flux de lexèmes reconnus   *)
(* Exception : ErreurLex si la chaîne contient une erreur lexicale *)
(* Similaire à la fonction précédente *)
let read_miniml_tokens_from_string chaine : token Flux.t =
  read_miniml_tokens_from_lexbuf (Lexing.from_string chaine)
;;

(* Fonctions auxiliaires de traitement des lexèmes *)
(* contenant une information: IDENT, BOOL et INT   *)
let isident =
  function IDENT _     -> true
         | _           -> false
let isbool =
  function BOOL _      -> true
         | _           -> false
let isint =
  function INT _       -> true
         | _           -> false

let unident =
  function
  | IDENT id    -> id
  | _           -> assert false
let unbool =
  function
  | BOOL b      -> b
  | _           -> assert false   
let unint =
  function
  | INT i       -> i
  | _           -> assert false


(* Fonctions de parsing de MiniML *)


module Solution = Flux;;

(* Types des parsers généraux *)
type ('a, 'b) result = ('b * 'a Flux.t) Solution.t;;
type ('a, 'b) parser = 'a Flux.t -> ('a, 'b) result;;

(* Interface des parsers: combinateurs de parsers et parsers simples *)
module type Parsing =
  sig
    val map : ('b -> 'c) -> ('a, 'b) parser -> ('a, 'c) parser

    val return : 'b -> ('a, 'b) parser

    val ( >>= ) : ('a, 'b) parser -> ('b -> ('a, 'c) parser) -> ('a, 'c) parser

    val zero : ('a, 'b) parser

    val ( ++ ) : ('a, 'b) parser -> ('a, 'b) parser -> ('a, 'b) parser

    val run : ('a, 'b) parser -> 'a Flux.t -> 'b Solution.t

    val pvide : ('a, unit) parser

    val ptest : ('a -> bool) -> ('a, 'a) parser

    val ( *> ) : ('a, 'b) parser -> ('a, 'c) parser -> ('a, 'b * 'c) parser
  end

(* Implantation des parsers, comme vu en TD. On utilise les opérations
   du module Flux et du module Solution                                *)
module Parser : Parsing =
  struct
    let map fmap parse f = Solution.map (fun (b, f') -> (fmap b, f')) (parse f);; 

    let return b f = Solution.return (b, f);;

    let (>>=) parse dep_parse = fun f -> Solution.(parse f >>= fun (b, f') -> dep_parse b f');;

    let zero _ = Solution.zero;;

    let (++) parse1 parse2 = fun f -> Solution.(parse1 f ++ parse2 f);;

    let run parse f = Solution.(map fst (filter (fun (_, f') -> Flux.uncons f' = None) (parse f)));;

    let pvide f =
      match Flux.uncons f with
      | None   -> Solution.return ((), f)
      | Some _ -> Solution.zero;;

    let ptest p f =
      match Flux.uncons f with
      | None        -> Solution.zero
      | Some (t, q) -> if p t then Solution.return (t, q) else Solution.zero;;

    let ( *> ) parse1 parse2 = fun f ->
      Solution.(parse1 f >>= fun (b, f') -> parse2 f' >>= fun (c, f'') -> return ((b, c), f''));;
  end

  open Parser

(* 'droppe' le resultat d'un parser et le remplace par () *)
let drop p = map (fun _ -> ()) p;;

(* Parser qui reconnaît le token t *)
let p_token t = drop (ptest ((=) t));;

(* Parser pour les identificateurs *)
let p_ident = ptest isident >>= fun id -> return (unident id);;

(* Parser pour les booléens *)
let p_bool = ptest isbool >>= fun b -> return (unbool b);;

(* Parser pour les entiers *)
let p_int = ptest isint >>= fun i -> return (unint i);;

(* Parser pour la fin de fichier *)
let p_eof = pvide;;

(* Les parsers mutuellement récursifs pour la grammaire miniml *)
(* (token, expr) parser *)

(* Parser associe a Expr *)
let rec parse_Expr : (token, expr) parser = fun flux ->
  (
  (* let Liaison in Expr *)
  (p_token LET >>= fun () -> parse_Liaison >>= fun (id, exprL) -> p_token IN >>= fun () -> parse_Expr >>= fun exprF -> return(ELet (id, exprL, exprF)))
  (* let rec Liaison in Expr *)
  ++ (p_token LET >>= fun () -> p_token REC >>= fun () -> parse_Liaison >>= fun (id, exprL) -> p_token IN >>= fun () -> parse_Expr >>= fun exprF -> return (ELetrec (id, exprL, exprF)))
  (* (Expr Binop Expr) *)
  ++ (p_token PARO >>= fun () -> parse_Expr >>= fun exprG -> parse_Binop >>= fun binop -> parse_Expr >>= fun exprD -> p_token PARF >>= fun () -> return (EApply (EApply (binop, exprG), exprD))) (* EApply(EApply(binop, exprG), exprD) <==> exprG binop exprD <==> (binop) exprG exprD *)
  (* (Expr) *)
  ++ (p_token PARO >>= fun () -> parse_Expr >>= fun expr -> p_token PARF >>= fun () -> return expr)
  (* (Expr Expr) *)
  ++ (p_token PARO >>= fun () -> parse_Expr >>= fun expr1 -> parse_Expr >>= fun expr2 -> p_token PARF >>= fun () -> return (EApply (expr1, expr2)))
  (* if Expr then Expr else Expr *)
  ++ (p_token IF >>= fun () -> parse_Expr >>= fun exprCond -> p_token THEN >>= fun () -> parse_Expr >>= fun exprSi -> p_token ELSE >>= fun () -> parse_Expr >>= fun exprSinon -> return (EIf (exprCond, exprSi, exprSinon)))
  (* (fun ident −> Expr) *)
  ++ (p_token FUN >>= fun () -> p_ident >>= fun id -> p_token TO >>= fun () -> parse_Expr >>= fun expr -> return (EFun (id, expr)))
  (* ident *)
  ++ (p_ident >>= fun id -> return (EIdent id))
  (* Constant *)
  ++ (parse_Constant >>= fun const -> return (EConstant const))
  (* (Expr , Expr) *)
  ++ (p_token PARO >>= fun () -> parse_Expr >>= fun exprG -> p_token VIRG >>= fun () -> parse_Expr >>= fun exprD -> p_token PARF >>= fun () -> return (EProd (exprG, exprD)))
  ) flux

(* Parser associe a Liaison *)
and parse_Liaison : (token, ident * expr) parser = fun flux ->
  (* ident = Expr *)
  (p_ident >>= fun id -> p_token EQU >>= fun () -> parse_Expr >>= fun expr -> return (id, expr)) flux

(* Parser associe a Binop *)
and parse_Binop : (token, expr) parser = fun flux ->
  (
  (* Arithop  *)
  (parse_Arithop >>= fun arithop -> return (EBinop arithop))
  (* Boolop *)
  ++ (parse_Boolop >>= fun boolop -> return (EBinop boolop))
  (* Relop *)
  ++ (parse_Relop >>= fun relop -> return (EBinop relop))
  (* @ *)
  ++ (p_token CONCAT >>= fun () -> return (EBinop CONCAT))
  (* :: *)
  ++ (p_token CONS >>= fun () -> return (EBinop CONS))
  ) flux

(* Parser associe a Arithop *)
and parse_Arithop : (token, token) parser = fun flux ->
  (
  (* + *)
  (p_token PLUS >>= fun () -> return PLUS)
  (* - *)
  ++ (p_token MOINS >>= fun () -> return MOINS)
  (* * *)
  ++ (p_token MULT >>= fun () -> return MULT)
  (* / *)
  ++ (p_token DIV >>= fun () -> return DIV)
  ) flux

(* Parser associe a Boolop *)
and parse_Boolop : (token, token) parser = fun flux ->
  (
  (* && *)
  (p_token AND >>= fun () -> return AND)
  (* || *)
  ++ (p_token OR >>= fun () -> return OR)
  ) flux

(* Parser associe a Relop *)
and parse_Relop : (token, token) parser = fun flux ->
  (
  (* = *)
  (p_token EQU >>= fun () -> return EQU)
  (* <> *)
  ++ (p_token NOTEQ >>= fun () -> return NOTEQ)
  (* <= *)
  ++ (p_token INFEQ >>= fun () -> return INFEQ)
  (* < *)
  ++ (p_token INF >>= fun () -> return INF)
  (* >= *)
  ++ (p_token SUPEQ >>= fun () -> return SUPEQ)
  (* > *)
  ++ (p_token SUP >>= fun () -> return SUP)
  ) flux

(* Parser associe a Constant *)
and parse_Constant : (token, constant) parser = fun flux ->
  (
  (* entier *)
  (p_int >>= fun i -> return (CEntier i))
  (* booleen *)
  ++ (p_bool >>= fun b -> return (CBooleen b))
  (* [] *)
  ++ (p_token CROO >>= fun () -> p_token CROF >>= fun () -> return CNil)
  (* () *)
  ++ (p_token PARO >>= fun () -> p_token PARF >>= fun () -> return CUnit)
  ) flux

(* Fonction principale de parsing des programmes miniml *)
let parse_miniml flux = run (map fst (parse_Expr *> p_eof)) flux;;

(* Fonction de parsing d'un fichier *)
let parse_miniml_file filename =
  let flux = read_miniml_tokens_from_file filename
in parse_miniml flux;;

(* Fonction de parsing d'un buffer *)
let parse_miniml_buffer buf =
  let flux = read_miniml_tokens_from_lexbuf buf
in parse_miniml flux;;

(* Fonction de parsing d'une chaine de caractère *)
let parse_miniml_string chaine =
  let flux = read_miniml_tokens_from_string chaine
in parse_miniml flux;;
