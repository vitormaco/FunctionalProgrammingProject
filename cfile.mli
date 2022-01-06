(* Read a city from a file *)
open Company

type path = string

(* Values are read as strings. *)
val from_cfile: path -> company

