%token <string> ID
%token FUN PROD COLON TYPE OPEN_PAREN CLOSE_PAREN ARROW EOF

%{
    open Lexer
    open Exp
%}

%start parse_exp
%type <Exp.exp> parse_exp

%%

%public parse_exp
