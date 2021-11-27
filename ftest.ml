open Gfile
open Tools
open Printf

let () =

  (* Check the number of command-line arguments *)
  if Array.length Sys.argv <> 5 then
    begin
      Printf.printf
        "\n ✻  Usage: %s infile source sink outfile\n\n%s%!" Sys.argv.(0)
        ("    🟄  infile  : input file containing a graph\n" ^
         "    🟄  source  : identifier of the source vertex (used by the ford-fulkerson algorithm)\n" ^
         "    🟄  sink    : identifier of the sink vertex (ditto)\n" ^
         "    🟄  outfile : output file in which the result should be written.\n\n") ;
      exit 0
    end ;


  (* Arguments are : infile(1) source-id(2) sink-id(3) outfile(4) *)

  let infile = Sys.argv.(1)
  and outfile = Sys.argv.(4)

  (* These command-line arguments are not used for the moment. *)
  and _source = int_of_string Sys.argv.(2)
  and _sink = int_of_string Sys.argv.(3)
  in

  (* Open file *)
  let graph = from_file infile in

  (* Our code *)
  (* converts string graph to int graph *)
  let graph_int = gmap graph (fun x -> (int_of_string x)) in

  let ford_fulkerson input_graph =
  (
    let path = find_path input_graph [] 0 5 in
    match path with
    | None -> input_graph
    | Some x ->
      let path_id1_id2_label = (get_path_info input_graph x) in
      let max_flow = (List.fold_left (fun acc (id1,id2,label) -> if label < acc then label else acc) Int.max_int path_id1_id2_label) in
      let graphs_with_new_arcs = List.fold_left (fun g (a,b,c) -> add_arc (add_arc g b a max_flow) a b (-max_flow)) graph_int path_id1_id2_label in
      clone_without_empty_arcs graphs_with_new_arcs
    )
  in

  (* the algorithm may enter cycles, this avoids infinite loops *)
  let rec call_function_n_times func input count =
    if count > 0 then
      call_function_n_times func (func input) (count-1)
    else
      input
  in

  let result = call_function_n_times ford_fulkerson graph_int 1000 in

  (* converts int graph to string graph *)
  let printable_graph = gmap result (fun x -> string_of_int (x)) in

  (* Rewrite the graph that has been read. *)
  let () = export_file_graphviz outfile printable_graph _source _sink in

  ()
