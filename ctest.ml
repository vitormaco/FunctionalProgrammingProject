open Company
open Cfile
open Printf
open Ctools
open Graph
open Tools
open Gfile

let () =

  (* Check the number of command-line arguments *)


  (* Arguments are : infile(1) outfile(2) *)
  let _infile = Sys.argv.(1) in
  let _outfile = Sys.argv.(2) in

  (* Open file *)
  let company = from_cfile _infile in

  let original_graph_int = create_graph_by_company company empty_graph in

  let _source = 0 in
  let _sink = 1 in

  (* run the algorithm and get the residual graph *)
  let residual_graph = ford_fulkerson original_graph_int _source _sink in

  (* parse the residual graph to get the parsed string flow graph *)
  let flow_graph = create_flow_graph original_graph_int residual_graph in


(*
  let flow_graph = create_flow_graph original_graph_int original_graph_int in
*)
  (* Rewrite the graph that has been read. *)
  let () = export_file_graphviz _outfile flow_graph _source _sink in

  ()
