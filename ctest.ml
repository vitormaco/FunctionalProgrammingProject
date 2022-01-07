open Company
open Cfile
open Printf
open Ctools
open Graph
open Tools
open Gfile

let () =

  (* Check the number of command-line arguments *)
  if Array.length Sys.argv <> 3 then
    begin
      Printf.printf
        "\n ✻  Usage: %s infile outfile\n\n%s%!" Sys.argv.(0)
        ("    🟄  infile  : input file containing a graph\n" ^
         "    🟄  outfile : output file in which the result should be written.\n\n") ;
      exit 0
    end ;

  (* Arguments are : infile(1) outfile(2) *)
  let _infile = Sys.argv.(1) in
  let _outfile = Sys.argv.(2) in

  (* Open file *)
  let company = from_cfile _infile in

  (* Determine the source and sink index *)
  let length = (List.length company) in
  let _source = (length*2) in
  let _sink = (length*2+1) in

  (* Convert the company class into a graph class, with the problem translation *)
  let original_graph_int = create_graph_by_company company empty_graph in

  (* Get weights of a company *)
  let weights = create_weights_list original_graph_int company in

  (* run the algorithm and get the residual graph *)
  let residual_graph = ford_fulkerson original_graph_int weights _source _sink in

  (* parse the residual graph to get the parsed string flow graph *)
  let flow_graph = create_flow_graph original_graph_int residual_graph in

  (* Rewrite the graph that has been read. *)
  let () = export_file_graphviz_company _outfile flow_graph company _source _sink in

  ()
