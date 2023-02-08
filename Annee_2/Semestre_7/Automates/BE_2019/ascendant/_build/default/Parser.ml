
module MenhirBasics = struct
  
  exception Error
  
  let _eRR =
    fun _s ->
      raise Error
  
  type token = 
    | UL_VIRG
    | UL_VARIABLE of (
# 18 "Parser.mly"
       (string)
# 16 "Parser.ml"
  )
    | UL_SYMBOLE of (
# 17 "Parser.mly"
       (string)
# 21 "Parser.ml"
  )
    | UL_PT
    | UL_PAROUV
    | UL_PARFER
    | UL_FIN
    | NEG
    | ECHEC
    | DEDUC
    | COUPURE
  
end

include MenhirBasics

# 1 "Parser.mly"
  

(* Partie recopiee dans le fichier CaML genere. *)
(* Ouverture de modules exploites dans les actions *)
(* Declarations de types, de constantes, de fonctions, d'exceptions exploites dans les actions *)


# 44 "Parser.ml"

type ('s, 'r) _menhir_state = 
  | MenhirState00 : ('s, _menhir_box_programme) _menhir_state
    (** State 00.
        Stack shape : .
        Start symbol: programme. *)

  | MenhirState02 : (('s, _menhir_box_programme) _menhir_cell1_UL_SYMBOLE, _menhir_box_programme) _menhir_state
    (** State 02.
        Stack shape : UL_SYMBOLE.
        Start symbol: programme. *)

  | MenhirState05 : (('s, _menhir_box_programme) _menhir_cell1_UL_SYMBOLE, _menhir_box_programme) _menhir_state
    (** State 05.
        Stack shape : UL_SYMBOLE.
        Start symbol: programme. *)

  | MenhirState06 : ((('s, _menhir_box_programme) _menhir_cell1_UL_SYMBOLE, _menhir_box_programme) _menhir_cell1_terme, _menhir_box_programme) _menhir_state
    (** State 06.
        Stack shape : UL_SYMBOLE terme.
        Start symbol: programme. *)

  | MenhirState07 : ((('s, _menhir_box_programme) _menhir_cell1_terme, _menhir_box_programme) _menhir_cell1_UL_VIRG, _menhir_box_programme) _menhir_state
    (** State 07.
        Stack shape : terme UL_VIRG.
        Start symbol: programme. *)

  | MenhirState08 : (((('s, _menhir_box_programme) _menhir_cell1_terme, _menhir_box_programme) _menhir_cell1_UL_VIRG, _menhir_box_programme) _menhir_cell1_terme, _menhir_box_programme) _menhir_state
    (** State 08.
        Stack shape : terme UL_VIRG terme.
        Start symbol: programme. *)

  | MenhirState13 : ((('s, _menhir_box_programme) _menhir_cell1_UL_SYMBOLE, _menhir_box_programme) _menhir_cell1_terme, _menhir_box_programme) _menhir_state
    (** State 13.
        Stack shape : UL_SYMBOLE terme.
        Start symbol: programme. *)

  | MenhirState16 : (('s, _menhir_box_programme) _menhir_cell1_regle, _menhir_box_programme) _menhir_state
    (** State 16.
        Stack shape : regle.
        Start symbol: programme. *)

  | MenhirState19 : ((('s, _menhir_box_programme) _menhir_cell1_regle, _menhir_box_programme) _menhir_cell1_regle, _menhir_box_programme) _menhir_state
    (** State 19.
        Stack shape : regle regle.
        Start symbol: programme. *)

  | MenhirState22 : (('s, _menhir_box_programme) _menhir_cell1_predicat, _menhir_box_programme) _menhir_state
    (** State 22.
        Stack shape : predicat.
        Start symbol: programme. *)

  | MenhirState23 : (('s, _menhir_box_programme) _menhir_cell1_NEG, _menhir_box_programme) _menhir_state
    (** State 23.
        Stack shape : NEG.
        Start symbol: programme. *)

  | MenhirState28 : ((('s, _menhir_box_programme) _menhir_cell1_predicat, _menhir_box_programme) _menhir_cell1_expression, _menhir_box_programme) _menhir_state
    (** State 28.
        Stack shape : predicat expression.
        Start symbol: programme. *)

  | MenhirState29 : ((('s, _menhir_box_programme) _menhir_cell1_expression, _menhir_box_programme) _menhir_cell1_UL_VIRG, _menhir_box_programme) _menhir_state
    (** State 29.
        Stack shape : expression UL_VIRG.
        Start symbol: programme. *)

  | MenhirState30 : (((('s, _menhir_box_programme) _menhir_cell1_expression, _menhir_box_programme) _menhir_cell1_UL_VIRG, _menhir_box_programme) _menhir_cell1_expression, _menhir_box_programme) _menhir_state
    (** State 30.
        Stack shape : expression UL_VIRG expression.
        Start symbol: programme. *)


and ('s, 'r) _menhir_cell1_expression = 
  | MenhirCell1_expression of 's * ('s, 'r) _menhir_state * (unit)

and ('s, 'r) _menhir_cell1_predicat = 
  | MenhirCell1_predicat of 's * ('s, 'r) _menhir_state * (unit)

and ('s, 'r) _menhir_cell1_regle = 
  | MenhirCell1_regle of 's * ('s, 'r) _menhir_state * (unit)

and ('s, 'r) _menhir_cell1_terme = 
  | MenhirCell1_terme of 's * ('s, 'r) _menhir_state * (unit)

and ('s, 'r) _menhir_cell1_NEG = 
  | MenhirCell1_NEG of 's * ('s, 'r) _menhir_state

and ('s, 'r) _menhir_cell1_UL_SYMBOLE = 
  | MenhirCell1_UL_SYMBOLE of 's * ('s, 'r) _menhir_state * (
# 17 "Parser.mly"
       (string)
# 137 "Parser.ml"
)

and ('s, 'r) _menhir_cell1_UL_VIRG = 
  | MenhirCell1_UL_VIRG of 's * ('s, 'r) _menhir_state

and _menhir_box_programme = 
  | MenhirBox_programme of (unit) [@@unboxed]

let _menhir_action_01 =
  fun () ->
    (
# 44 "Parser.mly"
                   ((print_endline "expression : fail") )
# 151 "Parser.ml"
     : (unit))

let _menhir_action_02 =
  fun () ->
    (
# 45 "Parser.mly"
                      ((print_endline "expression : !") )
# 159 "Parser.ml"
     : (unit))

let _menhir_action_03 =
  fun () ->
    (
# 46 "Parser.mly"
                           ((print_endline "expression : - predicat") )
# 167 "Parser.ml"
     : (unit))

let _menhir_action_04 =
  fun () ->
    (
# 47 "Parser.mly"
                       ((print_endline "expression : predicat") )
# 175 "Parser.ml"
     : (unit))

let _menhir_action_05 =
  fun () ->
    (
# 58 "Parser.mly"
                        ((print_endline "o : /* lambda mot vide*/") )
# 183 "Parser.ml"
     : (unit))

let _menhir_action_06 =
  fun () ->
    (
# 59 "Parser.mly"
                                                        ((print_endline "o : (terme suite_terme)") )
# 191 "Parser.ml"
     : (unit))

let _menhir_action_07 =
  fun () ->
    (
# 39 "Parser.mly"
                                                            (( print_endline ("predicat : symbole ( terme suite_terme)")) )
# 199 "Parser.ml"
     : (unit))

let _menhir_action_08 =
  fun () ->
    (
# 32 "Parser.mly"
                                     ( (print_endline "programme : regle suite_regle FIN ") )
# 207 "Parser.ml"
     : (unit))

let _menhir_action_09 =
  fun () ->
    (
# 34 "Parser.mly"
                                      ( (print_endline "regle : predicat suite_predicat .") )
# 215 "Parser.ml"
     : (unit))

let _menhir_action_10 =
  fun () ->
    (
# 49 "Parser.mly"
                                       ((print_endline "suite_expression : /* lambda mot vide*/") )
# 223 "Parser.ml"
     : (unit))

let _menhir_action_11 =
  fun () ->
    (
# 50 "Parser.mly"
                                                      ((print_endline "suite_expression : , expression suite_expression") )
# 231 "Parser.ml"
     : (unit))

let _menhir_action_12 =
  fun () ->
    (
# 41 "Parser.mly"
                                                   ( (print_endline "suite_predicat : :- expression suite_expression") )
# 239 "Parser.ml"
     : (unit))

let _menhir_action_13 =
  fun () ->
    (
# 42 "Parser.mly"
                                      ((print_endline "suite_predicat : /* lambda mot vide*/") )
# 247 "Parser.ml"
     : (unit))

let _menhir_action_14 =
  fun () ->
    (
# 36 "Parser.mly"
                                ( (print_endline "suite_regle : regle suite_regle") )
# 255 "Parser.ml"
     : (unit))

let _menhir_action_15 =
  fun () ->
    (
# 37 "Parser.mly"
                                  ((print_endline "suite_regle : /* lambda mot vide*/") )
# 263 "Parser.ml"
     : (unit))

let _menhir_action_16 =
  fun () ->
    (
# 55 "Parser.mly"
                                  ((print_endline "suite_terme : /* lambda mot vide*/") )
# 271 "Parser.ml"
     : (unit))

let _menhir_action_17 =
  fun () ->
    (
# 56 "Parser.mly"
                                            ((print_endline "suite_terme : , terme suite_terme") )
# 279 "Parser.ml"
     : (unit))

let _menhir_action_18 =
  fun () ->
    (
# 52 "Parser.mly"
                    ((print_endline ("terme : variable ")) )
# 287 "Parser.ml"
     : (unit))

let _menhir_action_19 =
  fun () ->
    (
# 53 "Parser.mly"
                       ((print_endline ("terme : symbole o")) )
# 295 "Parser.ml"
     : (unit))

let _menhir_print_token : token -> string =
  fun _tok ->
    match _tok with
    | COUPURE ->
        "COUPURE"
    | DEDUC ->
        "DEDUC"
    | ECHEC ->
        "ECHEC"
    | NEG ->
        "NEG"
    | UL_FIN ->
        "UL_FIN"
    | UL_PARFER ->
        "UL_PARFER"
    | UL_PAROUV ->
        "UL_PAROUV"
    | UL_PT ->
        "UL_PT"
    | UL_SYMBOLE _ ->
        "UL_SYMBOLE"
    | UL_VARIABLE _ ->
        "UL_VARIABLE"
    | UL_VIRG ->
        "UL_VIRG"

let _menhir_fail : unit -> 'a =
  fun () ->
    Printf.eprintf "Internal failure -- please contact the parser generator's developers.\n%!";
    assert false

include struct
  
  [@@@ocaml.warning "-4-37-39"]
  
  let rec _menhir_run_17 : type  ttv_stack. (ttv_stack, _menhir_box_programme) _menhir_cell1_regle -> _menhir_box_programme =
    fun _menhir_stack ->
      let MenhirCell1_regle (_menhir_stack, _, _) = _menhir_stack in
      let _v = _menhir_action_08 () in
      MenhirBox_programme _v
  
  let rec _menhir_run_20 : type  ttv_stack. ((ttv_stack, _menhir_box_programme) _menhir_cell1_regle, _menhir_box_programme) _menhir_cell1_regle -> _menhir_box_programme =
    fun _menhir_stack ->
      let MenhirCell1_regle (_menhir_stack, _menhir_s, _) = _menhir_stack in
      let _ = _menhir_action_14 () in
      _menhir_goto_suite_regle _menhir_stack _menhir_s
  
  and _menhir_goto_suite_regle : type  ttv_stack. ((ttv_stack, _menhir_box_programme) _menhir_cell1_regle as 'stack) -> ('stack, _menhir_box_programme) _menhir_state -> _menhir_box_programme =
    fun _menhir_stack _menhir_s ->
      match _menhir_s with
      | MenhirState19 ->
          _menhir_run_20 _menhir_stack
      | MenhirState16 ->
          _menhir_run_17 _menhir_stack
      | _ ->
          _menhir_fail ()
  
  let rec _menhir_run_01 : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_programme) _menhir_state -> _menhir_box_programme =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s ->
      let _menhir_stack = MenhirCell1_UL_SYMBOLE (_menhir_stack, _menhir_s, _v) in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | UL_PAROUV ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | UL_VARIABLE _ ->
              let _tok = _menhir_lexer _menhir_lexbuf in
              let _v = _menhir_action_18 () in
              _menhir_run_13 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState02 _tok
          | UL_SYMBOLE _v_2 ->
              _menhir_run_04 _menhir_stack _menhir_lexbuf _menhir_lexer _v_2 MenhirState02
          | _ ->
              _eRR ())
      | _ ->
          _eRR ()
  
  and _menhir_run_13 : type  ttv_stack. ((ttv_stack, _menhir_box_programme) _menhir_cell1_UL_SYMBOLE as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_programme) _menhir_state -> _ -> _menhir_box_programme =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      let _menhir_stack = MenhirCell1_terme (_menhir_stack, _menhir_s, _v) in
      match (_tok : MenhirBasics.token) with
      | UL_VIRG ->
          _menhir_run_07 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState13
      | UL_PARFER ->
          let _ = _menhir_action_16 () in
          _menhir_run_14 _menhir_stack _menhir_lexbuf _menhir_lexer
      | _ ->
          _eRR ()
  
  and _menhir_run_07 : type  ttv_stack. ((ttv_stack, _menhir_box_programme) _menhir_cell1_terme as 'stack) -> _ -> _ -> ('stack, _menhir_box_programme) _menhir_state -> _menhir_box_programme =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _menhir_stack = MenhirCell1_UL_VIRG (_menhir_stack, _menhir_s) in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | UL_VARIABLE _ ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          let _v = _menhir_action_18 () in
          _menhir_run_08 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState07 _tok
      | UL_SYMBOLE _v ->
          _menhir_run_04 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState07
      | _ ->
          _eRR ()
  
  and _menhir_run_08 : type  ttv_stack. (((ttv_stack, _menhir_box_programme) _menhir_cell1_terme, _menhir_box_programme) _menhir_cell1_UL_VIRG as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_programme) _menhir_state -> _ -> _menhir_box_programme =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      let _menhir_stack = MenhirCell1_terme (_menhir_stack, _menhir_s, _v) in
      match (_tok : MenhirBasics.token) with
      | UL_VIRG ->
          _menhir_run_07 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState08
      | UL_PARFER ->
          let _ = _menhir_action_16 () in
          _menhir_run_09 _menhir_stack _menhir_lexbuf _menhir_lexer
      | _ ->
          _eRR ()
  
  and _menhir_run_09 : type  ttv_stack. (((ttv_stack, _menhir_box_programme) _menhir_cell1_terme, _menhir_box_programme) _menhir_cell1_UL_VIRG, _menhir_box_programme) _menhir_cell1_terme -> _ -> _ -> _menhir_box_programme =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer ->
      let MenhirCell1_terme (_menhir_stack, _, _) = _menhir_stack in
      let MenhirCell1_UL_VIRG (_menhir_stack, _menhir_s) = _menhir_stack in
      let _ = _menhir_action_17 () in
      _menhir_goto_suite_terme _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
  
  and _menhir_goto_suite_terme : type  ttv_stack. ((ttv_stack, _menhir_box_programme) _menhir_cell1_terme as 'stack) -> _ -> _ -> ('stack, _menhir_box_programme) _menhir_state -> _menhir_box_programme =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      match _menhir_s with
      | MenhirState13 ->
          _menhir_run_14 _menhir_stack _menhir_lexbuf _menhir_lexer
      | MenhirState06 ->
          _menhir_run_10 _menhir_stack _menhir_lexbuf _menhir_lexer
      | MenhirState08 ->
          _menhir_run_09 _menhir_stack _menhir_lexbuf _menhir_lexer
      | _ ->
          _menhir_fail ()
  
  and _menhir_run_14 : type  ttv_stack. ((ttv_stack, _menhir_box_programme) _menhir_cell1_UL_SYMBOLE, _menhir_box_programme) _menhir_cell1_terme -> _ -> _ -> _menhir_box_programme =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer ->
      let _tok = _menhir_lexer _menhir_lexbuf in
      let MenhirCell1_terme (_menhir_stack, _, _) = _menhir_stack in
      let MenhirCell1_UL_SYMBOLE (_menhir_stack, _menhir_s, _) = _menhir_stack in
      let _v = _menhir_action_07 () in
      _menhir_goto_predicat _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_goto_predicat : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_programme) _menhir_state -> _ -> _menhir_box_programme =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match _menhir_s with
      | MenhirState29 ->
          _menhir_run_27_spec_29 _menhir_stack _menhir_lexbuf _menhir_lexer _tok
      | MenhirState22 ->
          _menhir_run_27_spec_22 _menhir_stack _menhir_lexbuf _menhir_lexer _tok
      | MenhirState23 ->
          _menhir_run_24 _menhir_stack _menhir_lexbuf _menhir_lexer _tok
      | MenhirState00 ->
          _menhir_run_21 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState16 ->
          _menhir_run_21 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState19 ->
          _menhir_run_21 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          _menhir_fail ()
  
  and _menhir_run_27_spec_29 : type  ttv_stack. ((ttv_stack, _menhir_box_programme) _menhir_cell1_expression, _menhir_box_programme) _menhir_cell1_UL_VIRG -> _ -> _ -> _ -> _menhir_box_programme =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _tok ->
      let _v = _menhir_action_04 () in
      _menhir_run_30 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState29 _tok
  
  and _menhir_run_30 : type  ttv_stack. (((ttv_stack, _menhir_box_programme) _menhir_cell1_expression, _menhir_box_programme) _menhir_cell1_UL_VIRG as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_programme) _menhir_state -> _ -> _menhir_box_programme =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      let _menhir_stack = MenhirCell1_expression (_menhir_stack, _menhir_s, _v) in
      match (_tok : MenhirBasics.token) with
      | UL_VIRG ->
          _menhir_run_29 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState30
      | UL_PT ->
          let _ = _menhir_action_10 () in
          _menhir_run_31 _menhir_stack _menhir_lexbuf _menhir_lexer
      | _ ->
          _eRR ()
  
  and _menhir_run_29 : type  ttv_stack. ((ttv_stack, _menhir_box_programme) _menhir_cell1_expression as 'stack) -> _ -> _ -> ('stack, _menhir_box_programme) _menhir_state -> _menhir_box_programme =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _menhir_stack = MenhirCell1_UL_VIRG (_menhir_stack, _menhir_s) in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | UL_SYMBOLE _v ->
          _menhir_run_01 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState29
      | NEG ->
          _menhir_run_23 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState29
      | ECHEC ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          let _v = _menhir_action_01 () in
          _menhir_run_30 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState29 _tok
      | COUPURE ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          let _v = _menhir_action_02 () in
          _menhir_run_30 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState29 _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_23 : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_programme) _menhir_state -> _menhir_box_programme =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _menhir_stack = MenhirCell1_NEG (_menhir_stack, _menhir_s) in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | UL_SYMBOLE _v ->
          _menhir_run_01 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState23
      | _ ->
          _eRR ()
  
  and _menhir_run_31 : type  ttv_stack. (((ttv_stack, _menhir_box_programme) _menhir_cell1_expression, _menhir_box_programme) _menhir_cell1_UL_VIRG, _menhir_box_programme) _menhir_cell1_expression -> _ -> _ -> _menhir_box_programme =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer ->
      let MenhirCell1_expression (_menhir_stack, _, _) = _menhir_stack in
      let MenhirCell1_UL_VIRG (_menhir_stack, _menhir_s) = _menhir_stack in
      let _ = _menhir_action_11 () in
      _menhir_goto_suite_expression _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
  
  and _menhir_goto_suite_expression : type  ttv_stack. ((ttv_stack, _menhir_box_programme) _menhir_cell1_expression as 'stack) -> _ -> _ -> ('stack, _menhir_box_programme) _menhir_state -> _menhir_box_programme =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      match _menhir_s with
      | MenhirState28 ->
          _menhir_run_32 _menhir_stack _menhir_lexbuf _menhir_lexer
      | MenhirState30 ->
          _menhir_run_31 _menhir_stack _menhir_lexbuf _menhir_lexer
      | _ ->
          _menhir_fail ()
  
  and _menhir_run_32 : type  ttv_stack. ((ttv_stack, _menhir_box_programme) _menhir_cell1_predicat, _menhir_box_programme) _menhir_cell1_expression -> _ -> _ -> _menhir_box_programme =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer ->
      let MenhirCell1_expression (_menhir_stack, _, _) = _menhir_stack in
      let _ = _menhir_action_12 () in
      _menhir_goto_suite_predicat _menhir_stack _menhir_lexbuf _menhir_lexer
  
  and _menhir_goto_suite_predicat : type  ttv_stack. (ttv_stack, _menhir_box_programme) _menhir_cell1_predicat -> _ -> _ -> _menhir_box_programme =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer ->
      let _tok = _menhir_lexer _menhir_lexbuf in
      let MenhirCell1_predicat (_menhir_stack, _menhir_s, _) = _menhir_stack in
      let _v = _menhir_action_09 () in
      _menhir_goto_regle _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_goto_regle : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_programme) _menhir_state -> _ -> _menhir_box_programme =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match _menhir_s with
      | MenhirState19 ->
          _menhir_run_19 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState16 ->
          _menhir_run_19 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState00 ->
          _menhir_run_16 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          _menhir_fail ()
  
  and _menhir_run_19 : type  ttv_stack. ((ttv_stack, _menhir_box_programme) _menhir_cell1_regle as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_programme) _menhir_state -> _ -> _menhir_box_programme =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      let _menhir_stack = MenhirCell1_regle (_menhir_stack, _menhir_s, _v) in
      match (_tok : MenhirBasics.token) with
      | UL_SYMBOLE _v_0 ->
          _menhir_run_01 _menhir_stack _menhir_lexbuf _menhir_lexer _v_0 MenhirState19
      | UL_FIN ->
          let _ = _menhir_action_15 () in
          _menhir_run_20 _menhir_stack
      | _ ->
          _eRR ()
  
  and _menhir_run_16 : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_programme) _menhir_state -> _ -> _menhir_box_programme =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      let _menhir_stack = MenhirCell1_regle (_menhir_stack, _menhir_s, _v) in
      match (_tok : MenhirBasics.token) with
      | UL_SYMBOLE _v_0 ->
          _menhir_run_01 _menhir_stack _menhir_lexbuf _menhir_lexer _v_0 MenhirState16
      | UL_FIN ->
          let _ = _menhir_action_15 () in
          _menhir_run_17 _menhir_stack
      | _ ->
          _eRR ()
  
  and _menhir_run_27_spec_22 : type  ttv_stack. (ttv_stack, _menhir_box_programme) _menhir_cell1_predicat -> _ -> _ -> _ -> _menhir_box_programme =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _tok ->
      let _v = _menhir_action_04 () in
      _menhir_run_28 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState22 _tok
  
  and _menhir_run_28 : type  ttv_stack. ((ttv_stack, _menhir_box_programme) _menhir_cell1_predicat as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_programme) _menhir_state -> _ -> _menhir_box_programme =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      let _menhir_stack = MenhirCell1_expression (_menhir_stack, _menhir_s, _v) in
      match (_tok : MenhirBasics.token) with
      | UL_VIRG ->
          _menhir_run_29 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState28
      | UL_PT ->
          let _ = _menhir_action_10 () in
          _menhir_run_32 _menhir_stack _menhir_lexbuf _menhir_lexer
      | _ ->
          _eRR ()
  
  and _menhir_run_24 : type  ttv_stack. (ttv_stack, _menhir_box_programme) _menhir_cell1_NEG -> _ -> _ -> _ -> _menhir_box_programme =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _tok ->
      let MenhirCell1_NEG (_menhir_stack, _menhir_s) = _menhir_stack in
      let _v = _menhir_action_03 () in
      _menhir_goto_expression _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_goto_expression : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_programme) _menhir_state -> _ -> _menhir_box_programme =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match _menhir_s with
      | MenhirState29 ->
          _menhir_run_30 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState22 ->
          _menhir_run_28 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          _menhir_fail ()
  
  and _menhir_run_21 : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_programme) _menhir_state -> _ -> _menhir_box_programme =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      let _menhir_stack = MenhirCell1_predicat (_menhir_stack, _menhir_s, _v) in
      match (_tok : MenhirBasics.token) with
      | DEDUC ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | UL_SYMBOLE _v_0 ->
              _menhir_run_01 _menhir_stack _menhir_lexbuf _menhir_lexer _v_0 MenhirState22
          | NEG ->
              _menhir_run_23 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState22
          | ECHEC ->
              let _tok = _menhir_lexer _menhir_lexbuf in
              let _v = _menhir_action_01 () in
              _menhir_run_28 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState22 _tok
          | COUPURE ->
              let _tok = _menhir_lexer _menhir_lexbuf in
              let _v = _menhir_action_02 () in
              _menhir_run_28 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState22 _tok
          | _ ->
              _eRR ())
      | UL_PT ->
          let _ = _menhir_action_13 () in
          _menhir_goto_suite_predicat _menhir_stack _menhir_lexbuf _menhir_lexer
      | _ ->
          _eRR ()
  
  and _menhir_run_10 : type  ttv_stack. ((ttv_stack, _menhir_box_programme) _menhir_cell1_UL_SYMBOLE, _menhir_box_programme) _menhir_cell1_terme -> _ -> _ -> _menhir_box_programme =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer ->
      let _tok = _menhir_lexer _menhir_lexbuf in
      let MenhirCell1_terme (_menhir_stack, _, _) = _menhir_stack in
      let _ = _menhir_action_06 () in
      _menhir_goto_o _menhir_stack _menhir_lexbuf _menhir_lexer _tok
  
  and _menhir_goto_o : type  ttv_stack. (ttv_stack, _menhir_box_programme) _menhir_cell1_UL_SYMBOLE -> _ -> _ -> _ -> _menhir_box_programme =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _tok ->
      let MenhirCell1_UL_SYMBOLE (_menhir_stack, _menhir_s, _) = _menhir_stack in
      let _v = _menhir_action_19 () in
      _menhir_goto_terme _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_goto_terme : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_programme) _menhir_state -> _ -> _menhir_box_programme =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match _menhir_s with
      | MenhirState02 ->
          _menhir_run_13 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState07 ->
          _menhir_run_08 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState05 ->
          _menhir_run_06 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          _menhir_fail ()
  
  and _menhir_run_06 : type  ttv_stack. ((ttv_stack, _menhir_box_programme) _menhir_cell1_UL_SYMBOLE as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_programme) _menhir_state -> _ -> _menhir_box_programme =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      let _menhir_stack = MenhirCell1_terme (_menhir_stack, _menhir_s, _v) in
      match (_tok : MenhirBasics.token) with
      | UL_VIRG ->
          _menhir_run_07 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState06
      | UL_PARFER ->
          let _ = _menhir_action_16 () in
          _menhir_run_10 _menhir_stack _menhir_lexbuf _menhir_lexer
      | _ ->
          _eRR ()
  
  and _menhir_run_04 : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_programme) _menhir_state -> _menhir_box_programme =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s ->
      let _menhir_stack = MenhirCell1_UL_SYMBOLE (_menhir_stack, _menhir_s, _v) in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | UL_PAROUV ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | UL_VARIABLE _ ->
              let _tok = _menhir_lexer _menhir_lexbuf in
              let _v = _menhir_action_18 () in
              _menhir_run_06 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState05 _tok
          | UL_SYMBOLE _v_2 ->
              _menhir_run_04 _menhir_stack _menhir_lexbuf _menhir_lexer _v_2 MenhirState05
          | _ ->
              _eRR ())
      | UL_PARFER | UL_VIRG ->
          let _ = _menhir_action_05 () in
          _menhir_goto_o _menhir_stack _menhir_lexbuf _menhir_lexer _tok
      | _ ->
          _eRR ()
  
  let rec _menhir_run_00 : type  ttv_stack. ttv_stack -> _ -> _ -> _menhir_box_programme =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer ->
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | UL_SYMBOLE _v ->
          _menhir_run_01 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState00
      | _ ->
          _eRR ()
  
end

let programme =
  fun _menhir_lexer _menhir_lexbuf ->
    let _menhir_stack = () in
    let MenhirBox_programme v = _menhir_run_00 _menhir_stack _menhir_lexbuf _menhir_lexer in
    v

# 61 "Parser.mly"
  

# 709 "Parser.ml"
