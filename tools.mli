open Graph

(* returns a new graph having the same nodes than gr, but no arc. (code : one line)
In order to find your errors more quickly, you may add an annotation : let clone_nodes (gr:'a graph) = ... *)
val clone_nodes: 'a graph -> 'b graph

(* maps all arcs of gr by function f. (⩽3 lines) *)
val gmap: 'a graph -> ('a -> 'b) -> 'b graph

(* adds n to the value of the arc between id1 and id2. If the arc does not exist, it is created. *)
val add_arc: int graph -> id -> id -> int -> int graph

(* A path is a list of nodes. *)
type path = id list

(* find_path gr forbidden id1 id2 
 *   returns None if no path can be found.
 *   returns Some p if a path p from id1 to id2 has been found. 
 *
 *  forbidden is a list of forbidden nodes (they have already been visited)
 *)
val find_path: int graph -> id list -> id -> id -> path option