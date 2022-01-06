open Graph
open Company

let create_graph_by_company company graph = 
    let create_source_node g = 
        new_node g 0
    in

    let create_sink_node g = 
        new_node g 1
    in

    let create_factories_nodes g = 
        let length = (List.length company) in

        let rec loop cnt g = match cnt with
        | 1 -> g
        | _ -> loop (cnt-1) (new_node g cnt)
        in 

        loop (length+1) g
    in

    let connect_factories_with_source_and_sink g =
        let length = (List.length company) in

        let rec loop cnt g = match cnt with
        | (-1) -> g
        | _ -> 
        (
            let (_, (supply, demand)) = (List.nth company cnt) in
            let g = loop (cnt-1) (new_arc g 0 (cnt+2) supply) in
            loop (cnt-1) (new_arc g (cnt+2) 1 demand)
        )
        in 
        loop (length-1) g
    in


    let connect_factories g = 
        let length = (List.length company) in

        let rec loop cnt g = match cnt with
        | 2 -> new_arc g 2 (length+1) Int.max_int
        | _ -> loop (cnt-1) (new_arc g cnt (cnt-1) Int.max_int)
        in 
        loop (length+1) g
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