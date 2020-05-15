open Exp
open Format

let program_of_string s = Parser.parse_program Lexer.lex (Lexing.from_string s)

let x = (App (Fun ("x", Typ ,Var "x"), Var "y"))

(* let _ = print_endline (pp_exp (program_of_string (read_line ()))) *)

let main =
let ps = program_of_string (read_line ()) in
let c : context = [ ] in
let rec exec s =
    match s with
    | Check t -> printf "%s\n" (pp_exp t); pp_exp t
    | _ -> ""
in match ps with
   | [] -> ""
   | p :: ps' -> exec p
