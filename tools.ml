open Graph

let clone_nodes (graph:'a graph) = n_fold graph (fun acc id -> new_node acc id) empty_graph

let gmap (graph:'a graph) f = e_fold graph (fun acc id1 id2 label -> new_arc acc id1 id2 (f label)) (clone_nodes graph)

(* let add_arc = assert false; *)
