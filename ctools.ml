open Graph
open Company

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

    let create_factories_nodes g = 
        let rec loop cnt g = match cnt with
        | (-1) -> g
        | _ -> 
            let g = (new_node g cnt) in
            loop (cnt-1) (new_node g (cnt + length))
        in 

        loop (length-1) g
    in

    let connect_factories_with_source_and_sink g =
        let rec loop cnt g = match cnt with
        | (-1) -> g
        | _ -> 
        (
            let (_, (supply, demand)) = (List.nth company cnt) in
            let g = (new_arc g source cnt supply) in
            loop (cnt-1) (new_arc g (cnt+length) sink demand)
        )
        in 
        loop (length-1) g
    in


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

    let process graph = 
        let graph = create_source_node graph in
        let graph = create_sink_node graph in
        let graph = create_factories_nodes graph in
        let graph = connect_factories_with_source_and_sink graph in
        let graph = connect_factories graph in
        graph
    in

    process graph