open Company
open Printf

type path = string

(* Format of text files:
   % This is a comment

   % A city with its supply and demand numbers.
   Toulouse 50 10
   Paris 100 200
   Bordeaux 30 50
   Lyon 0 50
   Nantes 60 0
*)

(* Reads a line with a city. *)
let read_factory company line =
  try Scanf.sscanf line "%s %d %d" (fun name supply demand -> new_factory company name (supply, demand))
  with e ->
    Printf.printf "Cannot read factory in line - %s:\n%s\n%!" (Printexc.to_string e) line ;
    failwith "from_file"

(* Reads a comment or fail. *)
let read_comment company line =
  try Scanf.sscanf line " %%" company
  with _ ->
    Printf.printf "Unknown line:\n%s\n%!" line ;
    failwith "from_file"

(* Read company file. *)
let from_cfile path =
  let infile = open_in path in

  (* Read all lines until end of file. *)
  let rec loop company =
    try
      let line = input_line infile in

      (* Remove leading and trailing spaces. *)
      let line = String.trim line in

      let company2 =
        (* Ignore empty lines *)
        if line = "" then company

        (* The first character of a line determines its content : n or e. *)
        else match line.[0] with
          | '%' -> read_comment company line

          (* It should be a factory *)
          | _ -> read_factory company line
      in
      loop company2

    with End_of_file -> company (* Done *)
  in

  let final_company = loop empty_company in

  close_in infile ;
  final_company
