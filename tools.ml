open Graph

let clone_nodes (graph:'a graph) = n_fold graph (fun acc id -> new_node acc id) empty_graph

(* let gmap gr f = assert false; *)
(* let add_arc = assert false; *)
