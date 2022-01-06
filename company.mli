
(* Each node has a unique identifier (a number). *)
type name = string

type numbers = (int * int)

(* Type of a company in which factories numbers have labels of type 'a. *)
type company = (name * numbers) list



exception Company_error of string


(**************  CONSTRUCTORS  **************)

(* The empty company. *)
val empty_company: company

(* Add a new node with the given identifier.
 * @raise company_error if the id already exists. *)
val new_factory: company -> name -> numbers -> company


(**************  GETTERS  *****************)

(* company_exists cmp name  indicates if the factory with identifier name exists in company cmp. *)
val factory_exists: company -> name -> bool

(**************  COMBINATORS, ITERATORS  **************)

(* Iterate on all nodes, in no special order. *)
val c_iter: company -> (name -> numbers -> unit) -> unit
