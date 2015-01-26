ldi R31 00000000
ldi R30 00000100
ld0 R16              # Read from 3 first bytes of RAM initial s, min, h
ld1 0000000000000010 # seconds
ld0 R17	
ld1 0000000000000011 # min
ld0 R18
ld1 0000000000000100 # hour	
ldi R25 00000000     # masks
ldi R26 01000000     
ldi R27 10000000
ldi R28 00000001
ld0 R19 	     # read tic
ld1 0000000000000101
st0 R25
st1 0000000000000101
add R16 R19          # add tic to current seconds
cpi R16 00111100     # if not more than 60, output seconds
brmi 0010001 # +17  
ldi R16 00000000     # else, increase minutes, reset seconds # TODO, check not more than 1 tic
add R17 R28
cpi R17 00111100     # if not more than 60, output min, sec
brmi 0001001 # +9  
ldi R17 00000000     # else, increase hours, reset minutes
add R18 R28
cpi R18 00011000     # if not more than 24, output h, min, sec
brmi 0000001 # +1    
ldi R18 00000000     # else reset hours 	
mov R20 R18 # HOUR OUTPUT
or R20 R27
st0 R20              
st1 0000000000000110
mov R20 R17 # MIN OUTPUT
or R20 R26 # apply mask
st0 R20              
st1 0000000000000110
st0 R16  # SEC OUTPUT              
st1 0000000000000110
rjmp 111111100101 # go back and read tic -27 # TODO
