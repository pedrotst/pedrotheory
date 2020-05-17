%token <string> ID
%token FUN PROD COLON TYPE OPEN_PAREN CLOSE_PAREN ARROW COMMA ASGN DOT EOF

%token CTX PARAM DEF EVAL CHECK

%{
    open Lexer
    open Term
    open Vernacular
         %}

%start parse_program
/* %type <Term.exp> parse_exp */
%type <Vernacular.statement> parse_statement
%type <Vernacular.program> parse_program rev_parse_program

%%

(* I'll leave this expression out for now, so I can extend it later *)
parse_args:
/* | OPEN_PAREN x=ID CLOSE_PAREN { x } */
  | OPEN_PAREN x=ID COLON t=parse_term CLOSE_PAREN { (String x, t) }
/* | ID { $1 } */

parse_term:
  | FUN xt= parse_args ARROW e = parse_app
    { let (x, t) = xt in Lambda (x, t, e) }
  | PROD xt= parse_args COMMA e = parse_app
    { let (x, t) = xt in Pi (x, t, e) }
/* | e = parse_app COLON t = parse_app */
/* { Ascr (e, t) } */
  | parse_app { $1 }

parse_app:
  | e = parse_simple_term { e }
  | e1 = parse_simple_term e2 = parse_simple_term
    { App (e1, e2) }

parse_simple_term:
  | OPEN_PAREN e = parse_term CLOSE_PAREN { e }
  | TYPE { Universe 0 }
  | ID { Var (String $1) }

%public parse_statement:
  | CTX { Context }
  | PARAM x=ID COLON t=parse_term { Parameter (x, t) }
  | DEF x=ID ASGN t=parse_term  { Definition (x, t) }
  | CHECK t=parse_term { Check t }
  | EVAL t=parse_term  { Eval t }

%public parse_program:
  | ps = rev_parse_program; EOF { List.rev ps }

rev_parse_program:
  | ps = rev_parse_program; s = parse_statement; DOT { s :: ps }
  | (* empty *) { [] }
