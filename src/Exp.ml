type ident = string

type exp =
| Typ
| Var of ident
| Fun of ident * exp * exp
| Prod of ident * exp * exp
| App of exp * exp
| Ascr of exp * exp

let rec str = function
| Typ -> "Type"
| Var s -> s
| Fun (x, t, e) -> "fun " ^ x ^ " : " ^ (str t) ^ " => " ^ (str e)
| Prod (x, t, e) -> "forall " ^ x ^ ":" ^ (str t) ^ ", " ^ (str e)
| App (e1, e2) -> "(" ^ (str e1) ^ ") " ^ (str e2)
| Ascr (e, t) -> (str e) ^ " : " ^ (str t)
