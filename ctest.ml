open Company
open Cfile
open Printf

let () =

  (* Check the number of command-line arguments *)


  (* Arguments are : infile(1) *)
  let _infile = Sys.argv.(1) in

  (* Open file *)
  let original_company = from_cfile _infile in

  let show_company = (fun name (supply, demand) -> 
    Printf.printf "Company: %s %d %d\n" name supply demand
  ) in

  c_iter original_company show_company

  (*
  (* converts string graph to int graph *)
  let original_graph_int = gmap original_graph (fun x -> (int_of_string x)) in

  (* run the algorithm and get the residual graph *)
  let residual_graph = ford_fulkerson original_graph_int _source _sink in

  (* parse the residual graph to get the parsed string flow graph *)
  let flow_graph = create_flow_graph original_graph_int residual_graph in

  (* Rewrite the graph that has been read. *)
  let () = export_file_graphviz _outfile flow_graph _source _sink in
  *)
