{

type token =
| ID of string
| FUN
| PROD
| COLON
| TYPE
| OPEN_PAREN
| CLOSE_PAREN
| ARROW
| EOF

}

let white = [' ' '\t']+

rule lex = parse
| white    { lex lexbuf }
| "forall" { PROD }
| "fun"    { FUN }
| "=>"     { ARROW }
| "("      { OPEN_PAREN }
| ")"      { CLOSE_PAREN }
| ":"      { COLON }
| "Type"   { TYPE }
| [ 'a'-'z' 'A'-'X' '_']['0'-'9' 'A'-'Z' 'a'-'z' '_']* as s
           { ID (s) }
| eof      { EOF }
