open Miniml_parser
open Miniml_printer

(*** Fichier miniml_test_parser.ml  ***)
(* Auteur :  CAMPAN Mathieu          *)
(*           GIRARD Antoine          *)
(*           GONTHIER Priscilia      *)
(*           HAUTESSERRES Simon      *)
(* Date : 20/01/2023                 *)

(* Fonction de lancement, parse puis affiche le résultat de filename *)
(* Paramètres *)
(* filename : string, nom du fichier à parser *)
let parse_and_print filename =
  let flux = parse_miniml_file filename in
  match Solution.uncons flux with
  | None        -> (Format.printf ">>>> parsing failed ! @.\n";)
  | Some (expr, _) -> 
    begin
      print_expr Format.std_formatter expr;
      Format.printf "\n>>>> parsing successfull ! @.\n";
    end

(* Fonction de test de parser sur tous les fichiers présents dans ./tests_parseur *)
let test_parser () =
  let rec test list =
  match list with
  | [] -> (Format.printf "** End of test **@.";)
  | (result, filename)::q -> 
    begin
      Format.printf "** Test %s must be a %s **@." filename result;
      parse_and_print ("lib/tests_parseur/"^filename);
      test q;
    end
    and listeoftest = [("failure", "kotest_1");("failure", "kotest_2");("failure", "kotest_3");
    ("failure", "kotest_4");("failure", "kotest_5");("success", "oktest_1");("success", "oktest_2");
    ("success", "oktest_3");("success", "oktest_4");("success", "oktest_5");("success", "oktest_6");
    ("success", "oktest_7");("success", "oktest_8");("success", "oktest_9");("success", "oktest_10")]
  in test listeoftest;