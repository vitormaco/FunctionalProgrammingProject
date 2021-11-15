open Gfile
open Tools

let () =

  (* Check the number of command-line arguments *)
  if Array.length Sys.argv <> 5 then
    begin
      Printf.printf "\nUsage: %s infile source sink outfile\n\n%!" Sys.argv.(0) ;
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

  let graph = gmap graph (fun x -> (int_of_string x)) in 

  let custom_graph = add_arc graph 0 2 5 in

  let custom_graph = gmap custom_graph (fun x -> string_of_int (x)) in 

  (* Rewrite the graph that has been read. *)
  (* let () = write_file outfile graph in *)
  let () = write_file outfile custom_graph in

  ()
