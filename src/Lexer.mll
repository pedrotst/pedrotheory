{

type token =
| ID of string
| VAR
| FUN
| PROD
| TYPE
| ARROW
| COLON
| COMMA
| OPEN_PAREN
| CLOSE_PAREN
| EOF

}

let white = [' ' '\t']+

rule lex = parse
| white    { lex lexbuf }
| "forall" { PROD }
| "fun"    { FUN }
| "=>"     { ARROW }
| ":"      { COLON }
| ","      { COMMA }
| "("      { OPEN_PAREN }
| ")"      { CLOSE_PAREN }
| "Type"   { TYPE }
| [ 'a'-'z' 'A'-'X' '_']['0'-'9' 'A'-'Z' 'a'-'z' '_']* as s
           { ID (s) }
| eof      { EOF }
