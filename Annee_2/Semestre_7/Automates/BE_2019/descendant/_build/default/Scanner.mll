{

(* Partie recopiée dans le fichier CaML généré. *)
(* Ouverture de modules exploités dans les actions *)
(* Déclarations de types, de constantes, de fonctions, d'exceptions exploités dans les actions *)

  open Tokens 
  exception Printf

}

(* Déclaration d'expressions régulières exploitées par la suite *)
let chiffre = ['0' - '9']
let minuscule = ['a' - 'z']
let majuscule = ['A' - 'Z']
let alphabet = minuscule | majuscule
let alphanum = alphabet | chiffre | '_'
let commentaire =
  (* Commentaire fin de ligne *)
  "#" [^'\n']*

rule scanner = parse
  | ['\n' '\t' ' ']+					{ (scanner lexbuf) }
  | commentaire						{ (scanner lexbuf) }
  | "fail"						{ UL_ECHEC::(scanner lexbuf) }
  | eof							{ [UL_FIN] }

  | "(" 						{ UL_PAROUV::(scanner lexbuf) }
  | ")" 						{ UL_PARFER::(scanner lexbuf) }
  | "!" 						{ UL_COUPURE::(scanner lexbuf) }
  | "-" 						{ UL_NEG::(scanner lexbuf) }
  | "." 						{ UL_PT::(scanner lexbuf) }
  | "," 						{ UL_VIRG::(scanner lexbuf) }
  | ":-" 						{ UL_DEDUC::(scanner lexbuf) }
  | minuscule alphabet* as s {UL_SYMBOLE(s)::(scanner lexbuf)}
  | majuscule alphabet* as v {UL_VARIABLE(v)::(scanner lexbuf)}

  | _ as texte				 		{ (print_string "Erreur lexicale : ");(print_char texte);(print_newline ()); (UL_ERREUR::(scanner lexbuf)) }

{

}
