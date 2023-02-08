open Tokens

(* Type du résultat d'une analyse syntaxique *)
type parseResult =
  | Success of inputStream
  | Failure
;;

(* accept : token -> inputStream -> parseResult *)
(* Vérifie que le premier token du flux d'entrée est bien le token attendu *)
(* et avance dans l'analyse si c'est le cas *)
let accept expected stream =
  match (peekAtFirstToken stream) with
    | token when (token = expected) ->
      (Success (advanceInStream stream))
    | _ -> Failure
;;

(* Définition de la monade  qui est composée de : *)
(* - le type de donnée monadique : parseResult  *)
(* - la fonction : inject qui construit ce type à partir d'une liste de terminaux *)
(* - la fonction : bind (opérateur >>=) qui combine les fonctions d'analyse. *)

(* inject inputStream -> parseResult *)
(* Construit le type de la monade à partir d'une liste de terminaux *)
let inject s = Success s;;

(* bind : 'a m -> ('a -> 'b m) -> 'b m *)
(* bind (opérateur >>=) qui combine les fonctions d'analyse. *)
(* ici on utilise une version spécialisée de bind :
   'b  ->  inputStream
   'a  ->  inputStream
    m  ->  parseResult
*)
(* >>= : parseResult -> (inputStream -> parseResult) -> parseResult *)
let (>>=) result f =
  match result with
    | Success next -> f next
    | Failure -> Failure
;;

let acceptSymbole stream =
  match (peekAtFirstToken stream) with
    | (UL_SYMBOLE s) -> (print_endline (("accept : ") ^ s));(Success (advanceInStream stream))
    | _ -> Failure
;;

let acceptVariable stream =
  match (peekAtFirstToken stream) with
    | (UL_VARIABLE v) -> (print_endline (("accept : ") ^ v));(Success (advanceInStream stream))
    | _ -> Failure
;;

(* parseProgramme : inputStream -> parseResult *)
(* Analyse du non terminal Programme *)
let rec parseProgramme stream =
  (print_string "Programme -> ");
  (match (peekAtFirstToken stream) with
    | (UL_SYMBOLE _) -> 
      (print_endline "Règle Suite de règle");
      (inject stream >>=
      parseR >>=
      parseSr)
    | _ -> Failure)

and parseR stream =
  (print_string "Règle -> ");
  (match (peekAtFirstToken stream) with
  | (UL_SYMBOLE _) -> 
    (print_endline "Prédicat Suite de prédicat .");
    (inject stream >>=
    parseP >>=
    parseSp >>=
    accept UL_PT)
  | _ -> Failure)

and parseSr stream =
  (print_string "Règle -> ");
  (match (peekAtFirstToken stream) with
  | (UL_SYMBOLE _) -> 
    (print_endline "Règle Suite de règle");
    (inject stream >>=
    parseR >>=
    parseSr)
  | UL_FIN -> 
    (print_endline "");
    (Success stream)
  | _ -> Failure)

and parseP stream =
  (print_string "Prédicat -> ");
  (match (peekAtFirstToken stream) with
  | (UL_SYMBOLE _) -> 
    (print_endline "symbole ( Terme Suite de terme )");
    (inject stream >>=
    acceptSymbole >>=
    accept UL_PAROUV >>=
    parseT >>=
    parseSt >>=
    accept UL_PARFER)
  | _ -> Failure)

  and parseSp stream =
    (print_string "Suite de Prédicat -> ");
    (match (peekAtFirstToken stream) with
    | UL_DEDUC -> 
      (print_endline " :- Expression Suite d'expression");
      (inject stream >>=
      accept UL_DEDUC >>=
      parseE >>=
      parseSe)
    | UL_PT -> 
      (print_endline "");
      (Success stream)
    | _ -> Failure)

and parseE stream =
  (print_string "Expression -> ");
  (match (peekAtFirstToken stream) with
  | UL_ECHEC -> 
    (print_endline "!");
    (inject stream >>=
    accept UL_ECHEC)
  | UL_COUPURE -> 
    (print_endline "!");
    (inject stream >>=
    accept UL_COUPURE)
  | UL_NEG -> 
    (print_endline "- Prédicat");
    (inject stream >>=
    accept UL_NEG >>=
    parseP)
  | (UL_SYMBOLE _) -> 
    (print_endline "Prédicat");
    (inject stream >>=
    parseP)
  | _ -> Failure)

and parseSe stream =
  (print_string "Suite d'expression -> ");
  (match (peekAtFirstToken stream) with
  | UL_VIRG -> 
    (print_endline ", Expression Suite d'expression");
    (inject stream >>=
    accept UL_VIRG >>=
    parseE >>=
    parseSe)
  | UL_PT -> 
    (print_endline "");
    (Success stream)
  | _ -> Failure)

and parseT stream =
  (print_string "Terme -> ");
  (match (peekAtFirstToken stream) with
  | (UL_VARIABLE _) -> 
    (print_endline "variable");
    (inject stream >>=
    acceptVariable)
  | (UL_SYMBOLE _) -> 
    (print_endline "symbole O");
    (inject stream >>=
    acceptSymbole >>=
    parseO)
  | _ -> Failure)

and parseSt stream =
  (print_string "Suite de terme -> ");
  (match (peekAtFirstToken stream) with
  | UL_VIRG -> 
    (print_endline ", Terme Suite de terme");
    (inject stream >>=
    accept UL_VIRG >>=
    parseT >>=
    parseSt)
  | UL_PARFER -> 
    (print_endline "");
    (Success stream)
  | _ -> Failure)

  and parseO stream =
  (print_string "O -> ");
  (match (peekAtFirstToken stream) with
  | UL_PAROUV -> 
    (print_endline "( Terme Suite de terme )");
    (inject stream >>=
    accept UL_PAROUV >>=
    parseT >>=
    parseSt >>=
    accept UL_PARFER)
  | UL_VIRG | UL_PT | UL_PARFER-> 
    (print_endline "");
    (Success stream)
  | _ -> Failure)
;;
