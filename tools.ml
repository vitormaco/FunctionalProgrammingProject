open Graph

type path = id list

let clone_nodes (graph:'a graph) = n_fold graph new_node empty_graph

let gmap (graph:'a graph) f = e_fold graph (fun acc id1 id2 label -> new_arc acc id1 id2 (f label)) (clone_nodes graph)

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


let rec find_path (graph: int graph) initial target =
    let node_cost_parent =
        (n_fold graph
        (fun acc id -> let value = if id=initial then (id, 0, -1) else (id, max_int, -1) in List.append [value] acc)
        [])
    in

    let update_node nodes node cost parent =
        List.map (fun (x,y,z) -> if (x = node) then (x,cost,parent) else (x,y,z)) nodes
    in

    let rec get_node_cost nodes node = match nodes with
        | [] -> -1
        | (x,y,z)::rest -> if x=node then y else (get_node_cost rest node)
    in

    let rec get_node_parent nodes node = match nodes with
        | [] -> -1
        | (x,y,z)::rest -> if x=node then z else (get_node_parent rest node)
    in

    let get_w id1 id2 = match (id1,id2) with
    | (0,3) -> 10
    | (0,2) -> 10
    | (0,1) -> 10
    | (1,4) -> 10
    | (1,5) -> 10
    | (2,4) -> 10
    | (3,2) -> 10
    | (3,4) -> 10
    | (3,1) -> 10
    | (4,5) -> 10
    | x -> -1

    in

    let all_edges = e_fold graph (fun acc id1 id2 lbl ->
        if lbl != 0 then
            List.append acc [(id1,id2,(get_w id1 id2))]
        else
            acc
        ) [] in

    let bellman_ford_iteraction nodes =
        List.fold_left
        (
            fun acc (source, dest, cost) ->
            let source_cost = get_node_cost nodes source in
            let dest_cost = get_node_cost nodes dest in
            let new_cost = source_cost + cost in
            if ((source_cost != max_int) && (new_cost < dest_cost)) then
                update_node acc dest new_cost source else acc
        )
        nodes
        all_edges
    in

    let bellman_ford_result = (n_fold graph (fun acc id -> bellman_ford_iteraction acc) node_cost_parent) in

    (* START OF DEBUG PRINTS *)
    let _ = Printf.printf "\niteration\n" in
    let _ = List.map
        (fun (a,b,c) -> Printf.printf "n %d cost %d parent %d\n" a b c)
        bellman_ford_result
    in
    (* END OF DEBUG PRINTS *)

    let rec build_path nodes source sink =
        let parent = (get_node_parent bellman_ford_result sink) in
        if (parent = -1) then
            []
        else
            if (parent = source) then
                List.append [source] [sink]
            else
                List.append (build_path nodes source parent) [sink]
    in

    (build_path bellman_ford_result initial target)

let get_arc graph id1 id2 = match (find_arc graph id1 id2) with
| Some x -> x
| None -> 0

let rec get_path_info graph list = match list with
    | id1::id2::t -> (id1, id2, (get_arc graph id1 id2)) :: (get_path_info graph (id2::t))
    | id1::[] -> []
    | [] -> []

let rec ford_fulkerson input_graph _source _sink =
(
    let path = find_path input_graph _source _sink in
    match path with
    | [] -> input_graph
    | x ->
        (* get (id1, id2, label) for every pair of nodes in the path *)
        let path_id1_id2_label = (get_path_info input_graph x) in
        (* find the max flow in this path *)
        let max_flow = (List.fold_left (fun min (id1,id2,label) -> if label < min then label else min) Int.max_int path_id1_id2_label) in
        (* update the path arcs removing the max flow and adding another arc the other way around *)
        let residual_graph = List.fold_left (fun g (a,b,c) -> add_arc (add_arc g b a max_flow) a b (-max_flow)) input_graph path_id1_id2_label in
        ford_fulkerson residual_graph _source _sink
)
