type name = string
type numbers = (int * int)

(* A company is just a list of tuples: a name & its numbers at the factory. *)
type company = (name * numbers) list

exception Company_error of string

let empty_company = []

let factory_exists cmp name = List.mem_assoc name cmp

let new_factory cmp name (supply, demand) =
  if factory_exists cmp name then raise (Company_error ("Factory " ^ name ^ " already exists in the company."))
  else (name, (supply, demand)) :: cmp

let c_iter cmp f = List.iter (fun (name, numbers) -> f name numbers) cmp
