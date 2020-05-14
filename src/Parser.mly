%token <string> ID
%token FUN PROD COLON TYPE OPEN_PAREN CLOSE_PAREN ARROW COMMA EOF

%{
    open Lexer
    open Exp
%}

%start parse_program
%type <Exp.exp> parse_program parse_exp

%%

%public parse_id:
  | ID { $1 }

%public parse_exp:
  | TYPE { Typ }
  | ID { Var ($1) }
  | FUN x = parse_id COLON t = parse_exp ARROW e = parse_exp
    { Fun (x, t, e) }
  | PROD x = parse_id COLON t = parse_exp COMMA e = parse_exp
    { Prod (x, t, e) }
  | OPEN_PAREN e1 = parse_exp CLOSE_PAREN e2 = parse_exp
    { App (e1, e2) }
  | e = parse_exp COLON t = parse_exp
    { Ascr (e, t) }

parse_program:
  | parse_exp EOF { $1 }
