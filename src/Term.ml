type ident = string

type variable =
  | String of string
  | Gensym of string * int
  | Dummy

type exp =
  (* | Typ *)
  | Universe of int
  | Var of variable
  | Pi of abstraction
  | Lambda of abstraction
  | App of exp * exp

and abstraction = variable * exp * exp

let rec pp_exp = function
  | Var s -> pp_var s
  | Lambda (x, t, e) -> "fun " ^ pp_var x ^ " : " ^ (pp_exp t) ^ " => " ^ (pp_exp e)
  | Pi (x, t, e) -> "forall " ^ pp_var x ^ ":" ^ (pp_exp t) ^ ", " ^ (pp_exp e)
  | App (e1, e2) -> "(" ^ (pp_exp e1) ^ ") " ^ (pp_exp e2)
  | Universe i -> "Type " ^ string_of_int i
(* | Typ -> "Type" *)
(* | Ascr (e, t) -> (pp_exp e) ^ " : " ^ (pp_exp t) *)

and pp_var = function
  | String s -> s
  | Gensym (s, _) -> s
  | Dummy -> "_"

let refresh =
    let k = ref 0 in
    function
    | String x | Gensym (x, _) -> incr k ; Gensym (x, !k)
    | Dummy -> (incr k; Gensym ("_", !k))

let rec subst s = function
  | Var x -> (try List.assoc x s with Not_found -> Var x)
  | Universe k -> Universe k
  | Pi a -> Pi (subst_abstraction s a)
  | Lambda a -> Lambda (subst_abstraction s a)
  | App (e1, e2) -> App (subst s e1, subst s e2)

and subst_abstraction s (x, t, e)=
  let x' = refresh x in
  (x', subst s t, subst ((x, Var x') :: s) e)
