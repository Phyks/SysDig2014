Première étape : Spec du Microprocesseur
Architecture choisie : AVR

Doc :
http://www.atmel.com/images/atmel-8127-avr-8-bit-microcontroller-attiny4-attiny5-attiny9-attiny10_datasheet.pdf
http://www.atmel.com/images/doc0856.pdf chap 4, Description du CPU core, page 150, instruction set

Description de l'AVR :
54 instructions. S'exécutent majoritairement en un clock tick.
16 registres de 8 bits. (numérotés de 16 à 31 pour des histoires de compatibilité)
6 registres peuvent être utilisés comme des indirect address registers pointers 16 bits, les R26 -> R31. (=> 3 pointeurs, notés X, Y et Z)
ALU : Entre deux registres ou une constante et un registre. (Classique) Séparation opérations arithmétiques, logiques et bit à bit.
Registres : Accès direct, Register file supporte comme entrée/sortie :
	-Un opérande 8-bit/Un opérande 8-bit
	-Deux opérandes 8-bit/un opérande 8-bit
	-Un opérande 16-bit/un opérande 16-bit
Pile : - Pour stocker des données temporaires, des variables locales, des adresses de retour après interruptions. (as usual)
	- Pointeur qui décroît au fur et à mesure des allocations
	- Pointeur représenté par deux registres 8-bit dans l'I/O space.
Exécution d'une action : En un clock tick, on lit les opérandes dans le registre, on exécute l'opération et on écrit le résultat.
Instructions : de 4 (5 ?) types :
	-Arithmétiques et Logiques (ALU)
	-Branchement (JUMP)
	-Opérations sur des bits (BITS)
	-Opérations sur les données (DATA)
	-MCU Control Instructions ? (Break, No operation, Sleep, Watchdog Reset) -> En a-t-on vraiment besoin ?

-> Utiliser des multiplexeurs pour choisir un bloc. Séparer en sous-groupes pour plus de clarté (i.e., ensemble d'instructions dans le bloc ALU, si on en veut une, on choisit ALU à l'aide d'un multiplexeur, puis l'instruction en question à l'aide d'un autre multiplexeur.)
-> Deux ou trois premiers bits pour décider quel bloc utiliser ?
-> Choisir quelles instructions garder. Simplifier un peu le set ? Beaucoup d'instructions redondantes, ou inutiles dans notre cas.




