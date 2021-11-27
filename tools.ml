open Graph

let clone_nodes (graph:'a graph) = n_fold graph new_node empty_graph

let gmap (graph:'a graph) f = e_fold graph (fun acc id1 id2 label -> new_arc acc id1 id2 (f label)) (clone_nodes graph)

let add_arc (graph: int graph) id1 id2 n = match (find_arc graph id1 id2) with
    | None -> new_arc graph id1 id2 n
    | Some x-> new_arc graph id1 id2 (n+x)

let rec find_path (graph: int graph) vis id1 id2 =
    let visited = (List.append vis [id1]) in
    match (find_arc graph id1 id2) with
        | Some x -> Some (List.append visited [id2])
        | None ->
            let arcs = out_arcs graph id1 in
            let rec loop = (function
                | [] -> []
                | (a, b) :: rest ->
                    if (List.mem a visited) then
                        loop rest else
                        (let next_it = (find_path graph visited a id2) in
                            match next_it with
                            | None -> (loop rest)
                            | Some y -> y
                        )
            ) in
            match (loop arcs) with
            | [] -> None
            | node -> Some node
