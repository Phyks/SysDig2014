open String
open Format
open Printf

let rec bin_of_int i =
  let high_byte = i lsr 1 in
  let low_byte = ( i mod 2) in

  if high_byte > 0 then
    low_byte+10*(bin_of_int high_byte)
  else
    low_byte

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

let ins2 = [("cp", 0); ("ld", 1); ("or", 2); ("st", 3)]

let ins3 = [("adc", 0); ("add", 1); ("and", 2); ("asr", 3); ("bld", 4); ("bst", 5); ("cbi", 6); ("cbr", 7); ("clc", 8); ("clh", 9); ("cli", 10); ("cln", 11); ("clr", 12); ("cls", 13); ("clt", 14); ("clv", 15); ("clz", 16); ("com", 17); ("cpc", 18); ("cpi", 19); ("dec", 20); ("des", 21); ("eor", 22); ("inc", 23); ("jmp", 24); ("lac", 25); ("las", 26); ("lat", 27); ("ldi", 28); ("lds", 29); ("lpm", 30); ("lsl", 31); ("lsr", 32); ("mov", 33); ("mul", 34); ("neg", 35); ("nop", 36); ("ori", 37); ("out", 38); ("pop", 39); ("ret", 40); ("rol", 41); ("ror", 42); ("sbc", 43); ("sbi", 44); ("sbr", 45); ("sec",46); ("seh", 47); ("sei", 48); ("sen", 49); ("ser", 50); ("ses", 51); ("set", 52); ("sev", 53); ("sez", 54); ("spm", 55); ("sts", 56); ("sub", 57); ("tst", 58); ("wdr", 59); ("xch", 60)]

let ins4 = [("andi", 1); ("bclr", 2); ("brbc", 3); ("brbs", 4);
("brcc", 5); ("brcs", 6); ("breq", 8); ("brge", 9); ("brhc", 10);
("brhs", 11); ("brid", 12); ("brie", 13); ("brlo", 14); ("brlt", 15); ("brmi",
16); ("brne", 17); ("brpl", 18); ("brsh", 19); ("brtc", 20); ("brts", 21);
("brvc", 22); ("brvs", 23); ("bset", 24); ("cpse", 26); ("ijmp", 28); ("push", 29); ("sbrc", 30); ("sbrs", 31); ("swap", 32)]

let xyz = [("X ", ("1001000", "1100")); ("X+", ("1001000", "1101")); ("-X",("1001000", "1110")); ("Y ", ("1000000","1000")); ("Y+", ("1001000", "1001")); ("-Y", ("1001000","1010")); ("Z ", ("1000000","0000")); ("Z+", ("1001000","0001")); ("-Z", ("1001000","0010"))]

let xyzst = [("X ", ("1001001", "1100")); ("X+", ("1001001", "1101")); ("-X",("1001001", "1110")); ("Y ", ("1000001","1000")); ("Y+", ("1001001", "1001")); ("-Y", ("1001001","1010")); ("Z ", ("1000001","0000")); ("Z+", ("1001001","0001")); ("-Z", ("1001001","0010"))]
  
let tobin = function
	| s ->  (try let a = List.assoc (sub s 0 3) ins3 in
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
		| 6 -> let aa = read_reg (sub s 4 3) and b = bit (sub s 8 1) in
		"10011000"^aa^b
		| 7 -> failwith "cbr not Implemented"
		| 8 -> "1001010010001000"
		| 9 -> "1001010011011000"
		| 10 ->"1001010011111000"
		| 11 ->"1001010010101000"
		| 12-> let rd = read_reg (sub s 4 3) in
		"001001"^(sub rd 0 1)^rd^(sub rd 1 4)
		| 13-> "1001010011001000"
		| 14 ->"1001010011101000"
		| 15 ->"1001010010111000"
		| 16-> "1001010010011000"
		| 17 ->let rd = read_reg (sub s 4 3) in
		"1001010"^rd^"0000"
		|18 -> let rd = read_reg (sub s 4 3) and rr = read_reg (sub s 8 3) in
		"000001"^(sub rr 0 1)^rd^(sub rr 1 4)
		|19 -> let rd = read_reg (sub s 4 3) in
		"0011"^(sub s 8 4)^(sub rd 1 4)^(sub s 12 4)
		|20 -> let rd = read_reg (sub s 4 3) in
		"1001010"^rd^"1010"
		|21 -> "10010100"^(sub s 4 4)^"1011"
		|22 -> let rd = read_reg (sub s 4 3) and rr = read_reg (sub s 8 3) in
		"001001"^(sub rr 0 1)^rd^(sub rr 1 4)
		| 23 -> let rd = read_reg (sub s 4 3) in
		"1001010"^rd^"0011"
		| 24 -> failwith "jmp not Implemented"
		| 25 -> let rr = read_reg (sub s 6 3) in
		"1001001"^rr^"0110"
		| 26 -> let rr = read_reg (sub s 6 3) in
		"1001001"^rr^"0101"
		| 27 -> let rr = read_reg (sub s 6 3) in
		"1001001"^rr^"0111"
		|28 -> let rd = read_reg (sub s 4 3) in
		"1110"^(sub s 8 4)^(sub rd 1 4)^(sub s 12 4)
		|29 -> failwith "lds not implemented"
		|30 -> failwith "lpm not implemented"
		|31 -> let rd = read_reg (sub s 4 3) in
		"000011"^(sub rd 0 1)^rd^(sub rd 1 4)
		|32 -> let rd = read_reg (sub s 4 3) in
		"1001010"^rd^"0110"
		|33 -> let rd = read_reg (sub s 4 3) and rr = read_reg (sub s 8 3) in
		"001011"^(sub rr 0 1)^rd^(sub rr 1 4)
		| 34 -> failwith "mul not implemented"
		|35 -> let rd = read_reg (sub s 4 3) in
		"1001010"^rd^"0001"
		|36 -> "0000000000000000"
		|37 -> let rd = read_reg (sub s 4 3) in
		"0110"^(sub s 8 4)^(sub rd 1 4)^(sub s 12 4)
		|38 -> failwith "out not implemented"
		|39 -> let rd = read_reg (sub s 4 3) in
		"1001000"^rd^"1111"
		|40 -> "1001010100001000"
		|41 -> let rd = read_reg (sub s 4 3) in
		"000111"^(sub rd 0 1)^rd^(sub rd 1 4)
		| 42 -> let rd = read_reg (sub s 4 3) in
		"1001010"^rd^"0111"
		|43 -> let rd = read_reg (sub s 4 3) and rr = read_reg (sub s 8 3) in
		"000010"^(sub rr 0 1)^rd^(sub rr 1 4)
		|44 -> failwith "sbi not implemented"
		|45 -> let rd = read_reg (sub s 4 3) in
		"0110"^(sub s 8 4)^(sub rd 1 4)^(sub s 12 4)
		|46 -> "1001010000001000"
		|47 -> "1001010001011000"
		|48 -> "1001010001111000"
		|49 -> "1001010000101000"
		|50 -> let rd = read_reg (sub s 4 3) in
		"11101111"^(sub rd 1 4)^"1111"
		|51 ->"1001010001001000"
		|52 ->"1001010001101000"
		|53 ->"1001010000111000"
		|54 ->"1001010000011000"
		|55 ->failwith "spm not implemented"
		|56 -> failwith "sts not implemented"
		|57 -> let rd = read_reg (sub s 4 3) and rr = read_reg (sub s 8 3) in
		"000110"^(sub rr 0 1)^rd^(sub rr 1 4)
		|58 -> let rd = read_reg (sub s 4 3) in
		"001000"^(sub rd 0 1)^rd^(sub rd 1 4)
		|59 -> "1001010110101000"
		|60 -> failwith "xch not implemented"
		| n -> failwith "Cette instruction n'existe pas"
		) 
		with Not_found -> (try let a = List.assoc (sub s 0 4) ins4 in
		(match a with
	| 0 -> failwith "adiw not implemented"
        |1-> let rd = read_reg (sub s 5 3) in
		"0111"^(sub s 9 4)^(sub rd 1 4)^(sub s 13 4)
	|2-> "100101001"^(bit (sub s 5 1))^"1000"
        |3-> "111101"^(sub s 5 7)^(bit (sub s 13 1))
        |4-> "111100"^(sub s 5 7)^(bit (sub s 13 1))
        |5-> "111101"^(sub s 5 7)^"000"
        |6-> "111100"^(sub s 5 7)^"000"
        |8-> "111100"^(sub s 5 7)^"001"
        |9-> "111101"^(sub s 5 7)^"100"
        |10->"111101"^(sub s 5 7)^"101"
        |11->"111100"^(sub s 5 7)^"101"
        |12->"111101"^(sub s 5 7)^"111"
        |13->"111100"^(sub s 5 7)^"111"
        |14->"111100"^(sub s 5 7)^"000"
        |15->"111100"^(sub s 5 7)^"100"
        |16->"111100"^(sub s 5 7)^"010"
        |17->"111101"^(sub s 5 7)^"001"
        |18->"111101"^(sub s 5 7)^"010"
        |19->"111101"^(sub s 5 7)^"000"
        |20->"111101"^(sub s 5 7)^"110"
        |21->"111100"^(sub s 5 7)^"110"
        |22->"111101"^(sub s 5 7)^"011"
        |23->"111100"^(sub s 5 7)^"011"
        |24->let s = bit (sub s 5 1) in "100101000"^s^"1000"
        |26->let rd = read_reg (sub s 5 3) and rr = read_reg (sub s 9 3) in
	"000100"^(sub rr 0 1)^rd^(sub rr 1 4)
        |28->"1001010000001001"
        |29->let rd = read_reg (sub s 5 3) in
	"1001001"^rd^"1111"
        |30->let rr = read_reg (sub s 5 3) and b = bit (sub s 9 1) in
	"1111110"^rr^"0"^b
        |31->let rr = read_reg (sub s 5 3) and b = bit (sub s 9 1) in
	"1111111"^rr^"0"^b
        |32->let rd = read_reg (sub s 5 3) in "1001010"^rd^"0010"
    | n -> failwith "cette instruction n'existe pas")
 		with Not_found -> try let a = List.assoc (sub s 0 2) ins2 in
		(match a with
		|0 -> let rd = read_reg (sub s 3 3) and rr = read_reg (sub s 7 3) in
		"000101"^(sub rr 0 1)^rd^(sub rr 1 4)
		|1 -> let rd = read_reg (sub s 3 3) and (fs, sn) = List.assoc (sub s 7 2) xyz in
		fs^rd^sn
		|2 -> let rd = read_reg (sub s 3 3) and rr = read_reg (sub s 7 3) in
		"001010"^(sub rr 0 1)^rd^(sub rr 1 4)
		|3 -> (try let (fs, sn) = List.assoc (sub s 3 2) xyzst and rr = read_reg (sub s 5 3) in
		fs^rr^sn with |Not_found -> failwith "Syntaxe de st : st X R31 par exemple")
		|n -> failwith "Cette instruction n'existe pas"
		)
		with Not_found -> "Instruction de 2 char inconnue. Pas d'espaces devant les instructions, pas de ligne vide")) 

|_ -> failwith "Instruction inconnue. Pas d'espaces devant les instructions, pas de ligne vide."

let filename = ref ""

let set_var v s = v:=s

let options = []

let usage = "usage: asm [options] file"

let isneof = ref true

let basename = ref ""

let comp = ref 0

let addrofstring s =
    let st = ref (string_of_int s) in
    let n = ref (length (!st)) in
    while ((!n) < 16) do
    st:="0"^(!st);
    n:= (!n) +1
    done;
    !st

let () =
  Arg.parse options (set_var filename) usage;

  if !filename = "" then
    (eprintf "Pas de fichier d'entrée\n@?";
     exit 2);

  basename:= !filename;

  if (Filename.check_suffix !filename ".s") then
  (basename:= Filename.chop_suffix (!filename) ".s");
   

  let f = open_in !filename in
  let c = open_out (!basename^".rom") in
  fprintf c "WORD SIZE\t10000\n";
  fprintf c "ADDRESS SIZE\t10000\n\n";

  while !isneof do
  try
  let line = input_line f in
  let rep = tobin line in
  let rebis = (addrofstring (bin_of_int !comp))^"\t"^rep in
  printf "%s\n" rebis;
  fprintf c "%s\n" rebis;
  comp:= (!comp) +1
  with
  End_of_file -> isneof := false
  done;
  close_in f;
  close_out c
