open Graph
open Company

(* Create weights list of a company *)
val create_weights_list: int graph -> company -> (id * id * int) list

(* Create a graph from a company *)
val create_graph_by_company: company -> int graph -> int graph
