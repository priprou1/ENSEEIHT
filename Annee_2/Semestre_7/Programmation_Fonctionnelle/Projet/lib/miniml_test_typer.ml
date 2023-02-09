open Miniml_typer
open Miniml_parser
open Miniml_printer

(*** Fichier miniml_test_typer.ml  ***)
(* Auteur :  CAMPAN Mathieu          *)
(*           GIRARD Antoine          *)
(*           GONTHIER Priscilia      *)
(*           HAUTESSERRES Simon      *)
(* Date : 20/01/2023                 *)

(* Fonction qui affiche la liste des équations *)
(* Paramètres *)
(* l: liste d'équations *)
let rec print_eq l =
  match l with
    | [] -> Format.printf "\n"
    | (t1, t2)::s -> 
    Format.printf "{ ";
    print_typ TypeVariable.fprintf Format.std_formatter t1;
    Format.printf " = ";
    print_typ TypeVariable.fprintf Format.std_formatter t2;
    Format.printf " } ";
    print_eq s

(* Fonction qui affiche le fichier parsé, le type retourné après search_and_type et affiche l'ensemble des équations *)
let type_and_print filename = 
  let flux = parse_miniml_file filename in
  match Solution.uncons flux with
  | None -> Format.printf ">>>> Parsing failed ! @.\n"
  | Some (t, _) -> try let (sol,l) = search_type env_0 t
    in 
    begin
      Format.printf "- Expression à typer : @.";
      print_expr Format.std_formatter t;
      Format.printf "\n- Type renvoyé par le typer :\n";
      print_typ TypeVariable.fprintf Format.std_formatter sol;
      Format.printf "\n- Equations renvoyés par le typer :\n";
      print_eq l;
    end with Failure _ -> Format.printf ">>>> Typing failed !\n" 

(* Fonction qui teste search_type sur tous les fichiers présents dans ./tests_typer*)
let test_typer () =
  let rec test list =
    match list with
    | [] -> (Format.printf "** End of test **@.";)
    | (result, filename)::q -> 
      begin
        Format.printf "\n** Test %s must be a %s **@." filename result;
        type_and_print ("lib/tests_typer/"^filename);
        test q;
      end
      and listeoftest = [("success", "test_int");("success", "test_bool");
      ("success", "test_nil");("success", "test_unit");("success", "test_binop");
      ("success", "test_if");("success", "test_let");("success", "test_fun");("success", "test_letrec");
      ("success", "test_fst");("success", "test_snd");("success", "test_tl");("success", "test_hd");
      ("success", "test_fun_rec");("success", "test_not");("failure", "kotest_1");
      ("success", "kotest_2");("success", "kotest_3");("success", "kotest_4");("success", "kotest_5");("success", "kotest_6")
      ]
    in test listeoftest

(* Fonction qui applique les règles de type d'une expression dans filename afin d'obtenir son type et l'affiche *)
(* Paramètres *)
(* filename : le fichier contenant l'expression à typer *)
let type_print_and_resolve filename = 
  let flux = parse_miniml_file filename in
  match Solution.uncons flux with
  | None -> Format.printf ">>>> Parsing failed ! @.\n"
  | Some (t, _) -> try let (sol,l) =  search_type env_0 t
    in 
    let t = get_type (sol,l) 
  in 
        print_typ TypeVariable.fprintf Format.std_formatter t with Failure _ -> Format.printf ">>>> Typing failed !\n" 

(* Fonction de test du typer et resolve sur tous les fichiers présents dans ./tests_typer *)
let test_resolve () =
  let rec test list =
    match list with
    | [] -> (Format.printf "** End of test **@.";)
    | (result, filename)::q -> 
      begin
        Format.printf "\n** Test %s must be a %s **@." filename result;
        type_print_and_resolve ("lib/tests_typer/"^filename);
        test q;
      end
      and listeoftest = [("success", "test_int");("success", "test_bool");
      ("success", "test_nil");("success", "test_unit");("success", "test_binop");
      ("success", "test_if");("success", "test_let");("success", "test_fun");("success", "test_letrec");
      ("success", "test_fst");("success", "test_snd");("success", "test_tl");("success", "test_hd");
      ("success", "test_fun_rec");("success", "test_not");("failure", "kotest_1");
      ("failure", "kotest_2");("failure", "kotest_3");("failure", "kotest_4");("failure", "kotest_5");("failure", "kotest_6")]
    in test listeoftest
  