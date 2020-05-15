open Term
open Format

type statement =
| Context
| Parameter of ident * exp
| Definition of ident * exp
| Check of exp
| Eval of exp

type context = (ident, exp) Hashtbl.t

type program = statement list

let ctx : context = Hashtbl.create 20

let rec eval_statement s =
match s with
| Check e -> printf "%s\n" (pp_exp e); ()
| Eval e -> printf "%s\n" (pp_exp e); ()
| Definition (i, e) ->
    Hashtbl.add ctx i e;
    printf "%s is Defined!\n" i;
    printf "There are %d definition(s) in the context\n" (Hashtbl.length ctx)
| _ -> ()

let eval (ps: program) = List.fold_right (fun s _ -> eval_statement s) ps ()
