%{

(* Partie recopiee dans le fichier CaML genere. *)
(* Ouverture de modules exploites dans les actions *)
(* Declarations de types, de constantes, de fonctions, d'exceptions exploites dans les actions *)

%}

/* Declaration des unites lexicales et de leur type si une valeur particuliere leur est associee */

%token UL_PAROUV UL_PARFER UL_PT

/* Defini le type des donnees associees a l'unite lexicale */

%token <string> UL_IDENT
%token <int> UL_ENTIER

/* Unite lexicale particuliere qui represente la fin du fichier */

%token UL_FIN 


/* Type renvoye pour le nom terminal document */
%type <unit> scheme

/* Le non terminal document est l'axiome */
%start scheme

%% /* Regles de productions */

scheme : expression UL_FIN { (print_endline "scheme : expression UL_FIN ") }

expression : UL_IDENT { (print_endline "expression : UL_IDENT ") }
 | UL_ENTIER { (print_endline "expression : UL_ENTIER ") }
 | UL_PAROUV s_expression UL_PARFER { (print_endline "expression : ( s_expression ) ") }

s_expression : expression UL_PT expression { (print_endline "s_expression : expression . expression ") }
    | suite_s { (print_endline "s_expression : suite_s ") }

suite_s : /* lambda mot vide*/ {(print_endline "suite_s: /* lambda mot vide*/") }
    | expression suite_s {(print_endline "suite_s: expression suite_s") }

%%
