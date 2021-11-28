open Graph

let clone_nodes (graph:'a graph) = n_fold graph new_node empty_graph

let gmap (graph:'a graph) f = e_fold graph (fun acc id1 id2 label -> new_arc acc id1 id2 (f label)) (clone_nodes graph)

let clone_without_empty_arcs (graph:'a graph) = e_fold graph (fun acc id1 id2 label -> if label = 0 then acc else new_arc acc id1 id2 label) (clone_nodes graph)

let create_flow_graph original_graph residual_graph =
    let flow_graph = e_fold
        original_graph
        (
            fun acc id1 id2 label -> new_arc acc id1 id2
            (
                match find_arc residual_graph id1 id2 with
                | None -> label
                | Some x -> (label-x)
            )
        )
        (clone_nodes original_graph)
    in

    e_fold
        flow_graph
        (
            fun acc id1 id2 label -> new_arc acc id1 id2
            (
                match find_arc original_graph id1 id2 with
                | None -> string_of_int label
                | Some x -> Printf.sprintf "%d/%d" label x
            )
        )
        (clone_nodes flow_graph)

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

let get_arc graph id1 id2 = match (find_arc graph id1 id2) with
| Some x -> x
| None -> 0

let rec get_path_info graph list = match list with
    | id1::id2::t -> (id1, id2, (get_arc graph id1 id2)) :: (get_path_info graph (id2::t))
    | id1::[] -> []
    | [] -> []
