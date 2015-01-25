ldi R18 00000000
ldi R19 00000000
ldi R20 00000000
ldi R29 00000000
ldi R28 00000101
ldi R31 00000000
ldi R30 00000110
ld R17 Y # tic
add R18 R17 # add a second if tic
mov R16 R18 # Test if 60 seconds have elapsed
subi R16 00111100
tst R16
breq 00001101
addi R19 00000001
ldi R18 00000000
mov R16 R19 # Test if 60 minutes have elapsed
subi R19 00111100
tst R19
breq 00000111
addi R20 00000001
ldi R19 00000000
mov R16 R19 # Test if 24 hours have elapsed
subi R16 00011000
tst R16
breq 00000001
ldi R16 00000000
breq 11100100 # go back to start (-27)
