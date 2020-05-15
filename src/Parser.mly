%token <string> ID
%token FUN PROD COLON TYPE OPEN_PAREN CLOSE_PAREN ARROW COMMA ASGN DOT EOF

%token CTX PARAM DEF EVAL CHECK

%{
    open Lexer
    open Exp
%}

%start parse_program
/* %type <Exp.exp> parse_exp */
%type <Exp.statement> parse_statement
%type <Exp.program> parse_program rev_parse_program

%%

%public parse_id:
  | ID { $1 }

parse_term:
  | FUN OPEN_PAREN x = parse_id COLON t = parse_app CLOSE_PAREN ARROW e = parse_app
    { Fun (x, t, e) }
  | PROD OPEN_PAREN x = parse_id COLON t = parse_app CLOSE_PAREN COMMA e = parse_app
    { Prod (x, t, e) }
  | e = parse_app COLON t = parse_app
    { Ascr (e, t) }
  | parse_app { $1 }

parse_app:
  | e = parse_simple_term { e }
  | e1 = parse_simple_term e2 = parse_simple_term
    { App (e1, e2) }

parse_simple_term:
  | OPEN_PAREN e = parse_simple_term CLOSE_PAREN { e }
  | TYPE { Typ }
  | ID { Var $1 }

%public parse_statement:
  | CTX { Context }
  | PARAM x=parse_id COLON t=parse_term { Parameter (x, t) }
  | DEF x=parse_id ASGN t=parse_term  { Definition (x, t) }
  | CHECK t=parse_term { Check t }
  | EVAL t=parse_term  { Eval t }

%public parse_program:
  | ps = rev_parse_program; EOF { List.rev ps }

rev_parse_program:
  | ps = rev_parse_program; s = parse_statement; DOT { s :: ps }
  | (* empty *) { [] }
