open Graph

type path = id list

(* returns a new graph having the same nodes than gr, but no arc. (code : one line)
In order to find your errors more quickly, you may add an annotation : let clone_nodes (gr:'a graph) = ... *)
val clone_nodes: 'a graph -> 'b graph

(* maps all arcs of gr by function f. (⩽3 lines) *)
val gmap: 'a graph -> ('a -> 'b) -> 'b graph

val create_flow_graph: int graph -> int graph -> string graph

(* adds n to the value of the arc between id1 and id2. If the arc does not exist, it is created. *)
val add_arc: int graph -> id -> id -> int -> int graph

(* find_path gr forbidden id1 id2
 *   returns None if no path can be found.
 *   returns Some p if a path p from id1 to id2 has been found.
 *
 *  forbidden is a list of forbidden nodes (they have already been visited)
 *)
val find_path: int graph -> (id * id * int) list -> id -> id -> id list

(* converts a path into (id1, id2, label) for each pair of nodes from the path *)
val get_path_info: int graph -> id list -> (Graph.id * Graph.id * int) list

val ford_fulkerson: int graph -> (id * id * int) list -> id -> id -> int graph
