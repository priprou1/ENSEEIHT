(* ouverture de la "library" definie dans lib/dune *)
open Miniml

(* ouverture de modules de la library Miniml *)
open Miniml_parser
open Miniml_typer
open Miniml_printer

(*** Fichier miniml_principal.ml ***)
(* Auteur :  CAMPAN Mathieu        *)
(*           GIRARD Antoine        *)
(*           GONTHIER Priscilia    *)
(*           HAUTESSERRES Simon    *)
(* Date : 20/01/2023               *)
       
(* Fonction qui parse un fichier, définis les équations si le fichier est parsé et résoud les équations   *)
let print_type filename =
  (* Ouvrir et parser le fichier *)
  let flux = parse_miniml_file filename in
  (* Définir les équations liées au type du fichier si il a pu être parsé *)
  match Solution.uncons flux with
  | None -> Format.printf ">>>> Parsing failed ! @.\n"
  | Some (expr, _) -> 
    (* Résoudre les équations afin de trouver le type s'il existe *)
    try let type_sol = type_expr expr in
    (* Afficher le type si le typage a réussi *)
    begin
       print_typ TypeVariable.fprintf Format.std_formatter type_sol;
       Format.printf "\n";
    end with Failure _ -> Format.printf ">>>> Typing failed !\n" 

(* Fonction principale *)
let main () =
  if ((Array.length Sys.argv) != 2) then 
    Format.printf "Usage :\n./miniml_principal.exe filename\n"
  else
    (* Récupérer le nom du fichier à typer *)
    let filename = Sys.argv.(1) in
    (* Afficher le type du fichier *)
    print_type filename

(* Lancement du programme *)
let () = main ()
