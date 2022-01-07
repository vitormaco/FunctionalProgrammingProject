type name = string
type stats = (int * int * int)

(* A company is a list of a tuple : a name & its stats (supply, demand) at the factory. *)
type company = (name * stats) list

exception Company_error of string

let empty_company = []

let factory_exists cmp name = List.mem_assoc name cmp

let new_factory cmp name (supply, demand, cost) =
  if factory_exists cmp name then raise (Company_error ("Factory " ^ name ^ " already exists in the company."))
  else (name, (supply, demand, cost)) :: cmp
