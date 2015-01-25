open String
open Format

let read_reg = function
	|"R16" -> "00001"
	|"R17" -> "10001"
	|"R18" -> "01001"
	|"R19" -> "11001"
	|"R20" -> "00101"
	|"R21" -> "10101"
	|"R22" -> "01101"
	|"R23" -> "11101"
	|"R24" -> "00011"
	|"R25" -> "10011"
	|"R26" -> "01011"
	|"R27" -> "11011"
	|"R28" -> "00111"
	|"R29" -> "10111"
	|"R30" -> "01111"
	|"R31" -> "11111"
	| a -> failwith "Les registres doivent être de la forme R16"

let ins3 = [("adc", "000111")]

let tobin = function
	| s -> try let bin = List.assoc (sub s 0 3) ins3 in bin with
		|Not_found -> failwith "asshole"
	|_ -> failwith "Instruction inconnue"

let filename = ref ""

let set_var v s = v:=s

let options = []

let usage = "usage: mini-haskell [options] file.hs"

let () =
  Arg.parse options (set_var filename) usage;

  if !filename = "" then
    (eprintf "Pas de fichier d'entrée\n@?";
     exit 2);

  let f = open_in !filename in
  let c = open_out (!filename^".rom") in
  let fmt = formatter_of_out_channel c in
  let line = input_line f in
  let rep = tobin line in
  printf "%s\n@?" rep;


  close_in f;	
