type ident = string

type exp =
| Typ
| Var of ident
| Fun of ident * exp * exp
| Prod of ident * exp * exp
| App of exp * exp
| Ascr of exp * exp


let rec pp_exp = function
| Typ -> "Type"
| Var s -> s
| Fun (x, t, e) -> "fun " ^ x ^ " : " ^ (pp_exp t) ^ " => " ^ (pp_exp e)
| Prod (x, t, e) -> "forall " ^ x ^ ":" ^ (pp_exp t) ^ ", " ^ (pp_exp e)
| App (e1, e2) -> "(" ^ (pp_exp e1) ^ ") " ^ (pp_exp e2)
| Ascr (e, t) -> (pp_exp e) ^ " : " ^ (pp_exp t)
