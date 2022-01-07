
(* Each factory in the company has a unique identifier (a name). *)
type name = string

(* Each factory has stats*)
type stats = (int * int * int)

(* Type of a company in which factories stats have labels of type 'a. *)
type company = (name * stats) list


exception Company_error of string


(**************  CONSTRUCTORS  **************)

(* The empty company. *)
val empty_company: company

(* Add a new factory with the given name.
 * @raise company_error if the name already exists. *)
val new_factory: company -> name -> stats -> company


(**************  GETTERS  *****************)

(* company_exists cmp name  indicates if the factory with identifier name exists in company cmp. *)
val factory_exists: company -> name -> bool
