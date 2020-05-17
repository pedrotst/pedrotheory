{

exception SyntaxError of string

type token =
  | ID of string
  | VAR
  | FUN
  | PROD
  | CTX
  | PARAM
  | DEF
  | CHECK
  | EVAL
  | ASGN
  | TYPE
  | ARROW
  | COLON
  | COMMA
  | DOT
  | OPEN_PAREN
  | CLOSE_PAREN
  | EOF

}

let white = [' ' '\t']+

rule lex = parse
  | white        { lex lexbuf }
  | "Context"    { CTX }
  | "Parameter"  { PARAM }
  | "Definition" { DEF }
  | "Check"      { CHECK }
  | "Eval"       { EVAL }
  | "forall"     { PROD }
  | "fun"        { FUN }
  | ":="         { ASGN }
  | "=>"         { ARROW }
  | ":"          { COLON }
  | ","          { COMMA }
  | "("          { OPEN_PAREN }
  | ")"          { CLOSE_PAREN }
  | "."          { DOT }
  | "Type"       { TYPE }
  | [ 'a'-'z' 'A'-'X' '_']['0'-'9' 'A'-'Z' 'a'-'z' '_']* as s
    { ID (s) }
  | _ { raise (SyntaxError ("Unexpected char: " ^ Lexing.lexeme lexbuf)) }
  | eof      { EOF }
