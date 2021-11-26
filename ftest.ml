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
  let graph_int = gmap graph (fun x -> (int_of_string x)) in
  let graph = add_arc graph_int 0 2 5 in
  let graph = gmap graph (fun x -> string_of_int (x)) in
  let path = find_path graph_int [] 0 5 in

  (* Rewrite the graph that has been read. *)
  let () = export_file_graphviz outfile graph _source _sink in

  let rec print_list = function
      [] -> ()
      | e::[] -> print_int e ;
      | e::rest -> print_int e ; print_string "->" ; print_list rest
  in

  (match path with
    | None -> Printf.printf "None" ;
    | Some x -> print_list x
  )
