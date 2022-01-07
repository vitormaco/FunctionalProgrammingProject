open Graph
open Company

(* Main function that converts the company into a graph *)
let create_graph_by_company company graph =
    let length = (List.length company) in
    let source = (length*2) in
    let sink = (length*2+1) in

    let create_source_node g =
        new_node g source
    in

    let create_sink_node g =
        new_node g sink
    in

    (* All the factories in the company. 2 nodes by factory *)
    let create_factories_nodes graph =
        let rec loop graph count =
            if count = length then
                graph
            else
                let graph = new_node graph count in
                let graph = new_node graph (count+length) in
                loop graph (count+1)
        in
        loop graph 0
    in

    (* Source -> Supply node of factory // Demand node of factory -> Sink *)
    let connect_factories_with_source_and_sink graph =
        let rec loop graph count =
            if count = length then
                graph
            else
                let (_, (supply, demand)) = (List.nth company count) in
                let graph = (new_arc graph source count supply) in
                let graph = (new_arc graph (count+length) sink demand) in
                loop graph (count+1)
        in
        loop graph 0
    in

    (* Each Supply node with all Demand nodes *)
    let connect_factories g =
        let length = (List.length company) in

        let rec loop_arcs id cnt g = match cnt with
            | (-1) -> g
            | _ -> let (_, (_, demand)) = (List.nth company (cnt)) in
            loop_arcs id (cnt-1) (new_arc g id (cnt+length) demand)
        in

        let rec loop cnt g = match cnt with
        | (-1) -> g
        | _ -> let g = loop_arcs cnt (length-1) g in loop (cnt-1) g
        in
        loop (length-1) g
    in

    (* We make the process *)
    let process graph =
        let graph = create_source_node graph in
        let graph = create_sink_node graph in
        let graph = create_factories_nodes graph in
        let graph = connect_factories_with_source_and_sink graph in
        let graph = connect_factories graph in
        graph
    in

    process graph
