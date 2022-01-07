(* Read a company from a file *)
open Company
open Graph

type path = string

(* Values are read as strings. *)
val from_cfile: path -> company

(* export graph to graph viz format *)
val export_file_graphviz_company: path -> string graph -> company -> int -> int -> unit
