open Exp

let formula_of_string s = Parser.parse_program Lexer.lex (Lexing.from_string s)

let x = (App (Fun ("x", Typ ,Var "x"), Var "y"))

let _ = print_endline (str (formula_of_string (read_line ())))
