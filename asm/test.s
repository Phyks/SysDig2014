ldi R25 00000000     # R25 = $00
ld0 R16
ld1 0000000000000010 # seconds
ld0 R17	
ld1 0000000000000011 # min
ld0 R18
ld1 0000000000000100 # hour	
ld0 R19 	     # START POINT
ld1 0000000000000101 # tic
add R16 R19          # R20 is current seconds
cpi R16 00111100     # R20 - 60 <? 0
brmi 00000100        # goto RESET (+4)
inc R17              # increase minutes
cpi R17 00111100     # R17 - 60 <? 0
brmi 00000001        # goto RESET 
inc R18              # increase hours
st0 R25              # RESET ($0x0005 ← R25 = $00), reset the tick
st1 0000000000000101
rjmp 11110100        # go back to START POINT
