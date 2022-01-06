open Graph
open Company

let create_graph_by_company company graph = 
    let create_source_node g = 
        g
    in

    let create_sink_node g = 
        g
    in

    let create_factories_nodes g = 
        g
    in

    let connect_factories_with_source_and_sink g =
        g
    in

    let connect_factories g = 
        g
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