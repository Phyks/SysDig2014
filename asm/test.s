ldi R27 00000000
ldi R26 00111100
ldi R29 00000000
ldi R28 00000010
ldi R31 00000000
ldi R30 00000101
ld R16 X # Load current timer
ld R17 Y # Load current tick
add R17 R16 # Add them
st R17 X # Update timer
ldi R16 00000000
st R16 Y # Reset tick
st R17 Z # Output
breq 1110111
