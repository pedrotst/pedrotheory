open Term
open Vernacular
open Format

let program_of_string s = Parser.parse_program Lexer.lex (Lexing.from_string s)

let main = eval (program_of_string (read_line ()))
