%{

(* Partie recopiee dans le fichier CaML genere. *)
(* Ouverture de modules exploites dans les actions *)
(* Declarations de types, de constantes, de fonctions, d'exceptions exploites dans les actions *)

%}

/* Declaration des unites lexicales et de leur type si une valeur particuliere leur est associee */

%token UL_PAROUV UL_PARFER
%token UL_PT UL_VIRG
%token NEG DEDUC ECHEC COUPURE

/* Defini le type des donnees associees a l'unite lexicale */

%token <string> UL_SYMBOLE
%token <string> UL_VARIABLE

/* Unite lexicale particuliere qui represente la fin du fichier */

%token UL_FIN

/* Type renvoye pour le nom terminal document */
%type <unit> programme

/* Le non terminal document est l'axiome */
%start programme

%% /* Regles de productions */

programme : regle suite_regle UL_FIN { (print_endline "programme : regle suite_regle FIN ") }

regle : predicat suite_predicat UL_PT { (print_endline "regle : predicat suite_predicat .") }

suite_regle : regle suite_regle { (print_endline "suite_regle : regle suite_regle") }
            | /* lambda mot vie*/ {(print_endline "suite_regle : /* lambda mot vide*/") }

predicat : UL_SYMBOLE UL_PAROUV terme suite_terme UL_PARFER {( print_endline ("predicat : symbole ( terme suite_terme)")) }

suite_predicat : DEDUC expression suite_expression { (print_endline "suite_predicat : :- expression suite_expression") }
                | /* lambda mot vie*/ {(print_endline "suite_predicat : /* lambda mot vide*/") }

expression : ECHEC {(print_endline "expression : fail") }
            | COUPURE {(print_endline "expression : !") }
            | NEG predicat {(print_endline "expression : - predicat") }
            | predicat {(print_endline "expression : predicat") }

suite_expression : /* lambda mot vie*/ {(print_endline "suite_expression : /* lambda mot vide*/") }
                | UL_VIRG expression suite_expression {(print_endline "suite_expression : , expression suite_expression") }

terme : UL_VARIABLE {(print_endline ("terme : variable ")) }
        | UL_SYMBOLE o {(print_endline ("terme : symbole o")) }

suite_terme : /* lambda mot vie*/ {(print_endline "suite_terme : /* lambda mot vide*/") }
                | UL_VIRG terme suite_terme {(print_endline "suite_terme : , terme suite_terme") }

o : /* lambda mot vie*/ {(print_endline "o : /* lambda mot vide*/") }
                | UL_PAROUV terme suite_terme UL_PARFER {(print_endline "o : (terme suite_terme)") }

%%
