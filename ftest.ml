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
  let original_graph = from_file infile in

  (* Our code *)

  (* converts string graph to int graph *)
  let original_graph_int = gmap original_graph (fun x -> (int_of_string x)) in

  let rec ford_fulkerson input_graph =
  (
    let path = find_path input_graph [] _source _sink in
    match path with
    | None -> input_graph
    | Some x ->
      let path_id1_id2_label = (get_path_info input_graph x) in
      let max_flow = (List.fold_left (fun acc (id1,id2,label) -> if label < acc then label else acc) Int.max_int path_id1_id2_label) in
      let graphs_with_new_arcs = List.fold_left (fun g (a,b,c) -> add_arc (add_arc g b a max_flow) a b (-max_flow)) input_graph path_id1_id2_label in
      let residual_graph = clone_without_empty_arcs graphs_with_new_arcs in
      ford_fulkerson residual_graph
    )
  in

  let result_residual_graph = ford_fulkerson original_graph_int in
  let flow_graph = create_flow_graph original_graph_int result_residual_graph in

  (* Rewrite the graph that has been read. *)
  let () = export_file_graphviz outfile flow_graph _source _sink in

  ()
