open Term
open Vernacular
open Format

let program_of_string s = Parser.parse_program Lexer.lex (Lexing.from_string s)

let main =
  let s = ref "" in
  s := read_line ();
  while not (!s = "Quit.") do
    eval (program_of_string !s);
    printf "@?" ;
    flush_all ();
    s := read_line ()
  done
