open Graph

let clone_nodes (graph:'a graph) = n_fold graph (fun acc id -> new_node acc id) empty_graph

let gmap (graph:'a graph) f = e_fold graph (fun acc id1 id2 label -> new_arc acc id1 id2 (f label)) (clone_nodes graph)

let add_arc (graph: int graph) id1 id2 n = match (find_arc graph id1 id2) with 
    | None -> new_arc graph id1 id2 n
    | Some x-> new_arc graph id1 id2 (n+x)
