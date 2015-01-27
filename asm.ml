open String
open Format
open Printf

let read_reg = function
	|"R16" -> "10000"
	|"R17" -> "10001"
	|"R18" -> "10010"
	|"R19" -> "10011"
	|"R20" -> "10100"
	|"R21" -> "10101"
	|"R22" -> "10110"
	|"R23" -> "10111"
	|"R24" -> "11000"
	|"R25" -> "11001"
	|"R26" -> "11010"
	|"R27" -> "11011"
	|"R28" -> "11100"
	|"R29" -> "11101"
	|"R30" -> "11110"
	|"R31" -> "11111"
	| a -> failwith "Les registres doivent être de la forme R16"

let bit = function
	|"0" -> "000"
	|"1" -> "001"
	|"2" -> "010"
	|"3" -> "011"
	|"4" -> "100"
	|"5" -> "101"
	|"6" -> "110"
	|"7" -> "111"
	| _ -> failwith "Les bits sont de 0 à 7"

let ins3 = [("adc", 0); ("add", 1); ("and", 2); ("asr", 3); ("bld", 4); ("bst", 5); ("cbi", 6); ("cbr", 7); ("clc", 8); ("clh", 9); ("cli", 10); ("cln", 11); ("clr", 12); ("cls", 13); ("clt", 14); ("clv", 15); ("clz", 16); ("com", 17); ("cpc", 18); ("cpi", 19); ("dec", 20); ("des", 21); ("eor", 22); ("inc", 23); ("jmp", 24); ("lac", 25); ("las", 26); ("lat", 27); ("ldi", 28); ("lds", 29); ("lpm", 30); ("lsl", 31); ("lsr", 32); ("mov", 33); ("mul", 34); ("neg", 35); ("nop", 36); ("ori", 37); ("out", 38); ("pop", 39); ("ret", 40); ("rol", 41); ("ror", 42); ("sbc", 43); ("sbi", 44); ("sbr", 45); ("sec",46); ("seh", 47); ("sei", 48); ("sen", 49); ("ser", 50); ("ses", 51); ("set", 52); ("sev", 53); ("sez", 54); ("spm", 55); ("sts", 56); ("sub", 57); ("tst", 58); ("wdr", 59); ("xch", 60)]

let ins4 = [("bclr", 0)]

let tobin = function
	| s ->  try let a = List.assoc (sub s 0 3) ins3 in 
		(match a with
		| 0 -> let rd = read_reg (sub s 4 3) and rr = read_reg (sub s 8 3) in
		"000111"^(sub rd 0 1)^rr^(sub rd 1 4)
		| 1 -> let rd = read_reg (sub s 4 3) and rr = read_reg (sub s 8 3) in
		"000011"^(sub rd 0 1)^rr^(sub rd 1 4)
		| 2 -> let rd = read_reg (sub s 4 3) and rr = read_reg (sub s 8 3) in
		"001000"^(sub rd 0 1)^rr^(sub rd 1 4)
		| 3 -> let rd = read_reg (sub s 4 3) in
		"1001010"^rd^"0101"
		| 4 -> let rd = read_reg (sub s 4 3) and b = bit (sub s 8 1) in
		"1111100"^rd^"0"^b
		| 5 -> let rd = read_reg (sub s 4 3) and b = bit (sub s 8 1) in
		"1111101"^rd^"0"^b
		| 6 -> 
		| n -> failwith "Not Implemented"
		) 
		with Not_found -> (try let a = List.assoc (sub s 0 4) ins4 in
		(match a with
		|0 -> "100101001"^(bit (sub s 5 1))^"1000"
		| n -> failwith "Not Implemented")
 		with Not_found -> failwith "asshole")
	|_ -> failwith "Instruction inconnue. Pas d'espaces devant les instructions, pas de ligne vide."

let filename = ref ""

let set_var v s = v:=s

let options = []

let usage = "usage: asm [options] file"

let isneof = ref true

let () =
  Arg.parse options (set_var filename) usage;

  if !filename = "" then
    (eprintf "Pas de fichier d'entrée\n@?";
     exit 2);

  let f = open_in !filename in
  let c = open_out (!filename^".rom") in
  while !isneof do 
  try 
  let line = input_line f in
  let rep = tobin line in
  printf "%s\n" rep;
  fprintf c "%s\n" rep
  with 
  End_of_file -> isneof := false
  done;
  close_in f;
  close_out c	
