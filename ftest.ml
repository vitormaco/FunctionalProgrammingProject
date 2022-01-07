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
  let _infile = Sys.argv.(1) in
  let _source = int_of_string Sys.argv.(2) in
  let _sink = int_of_string Sys.argv.(3) in
  let _outfile = Sys.argv.(4) in

  (* Open file *)
  let original_graph = from_file _infile in

  (* converts string graph to int graph *)
  let original_graph_int = gmap original_graph (fun x -> (int_of_string x)) in

  (* run the algorithm and get the residual graph *)
  let residual_graph = ford_fulkerson original_graph_int [] _source _sink in

  (* parse the residual graph to get the parsed string flow graph *)
  let flow_graph = create_flow_graph original_graph_int residual_graph in

  (* Rewrite the graph that has been read. *)
  let () = export_file_graphviz _outfile flow_graph _source _sink in

  ()
