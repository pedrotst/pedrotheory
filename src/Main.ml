open Exp

(* let formula_of_string s = Parser.parse_formula Lexer.lex (Lexing.from_string s) *)

let _ = print_endline (str (App (Fun ("x", Typ,Var "x"), Var "y")))
