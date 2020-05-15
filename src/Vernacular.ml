open Term
open Format

type statement =
| Context
| Parameter of ident * exp
| Definition of ident * exp
| Check of exp
| Eval of exp

type context = (ident * exp) array

type program = statement list

let ctx : context = [| |]

let rec eval_statement s =
match s with
| Check e -> printf "%s\n" (pp_exp e); ()
| _ -> ()

let eval (ps: program) = List.fold_right (fun s _ -> eval_statement s) ps ()
