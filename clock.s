# X : Timer
# Y : Tick
# Z : Output
ldi R27 0
ldi R26 60
ldi R29 0
ldi R28 2
ldi R31 0
ldi R30 5
ld R16 X # Load current timer
ld R17 Y # Load current tick
add R17 R16 # Add them
st R17 X # Update timer
ldi R16 0
st R16 Y # Reset tick
st R17 Z # Output
breq -8

============

# R18 : S
# R19 : M
# R20 : H
# Y : Tick
# Z : Output
ldi R18 0
ldi R19 0
ldi R20 0
ldi R29 0
ldi R28 2
ldi R31 0
ldi R30 5

ld R17 Y
add R18 R17

mov R16 R18 # Test if 60 seconds have elapsed
subi R16 60
tst R16
breq 13
addi R19 1
ldi R18 0
mov R16 R19 # Test if 60 minutes have elapsed
subi R19 60
tst R19
breq 7
addi R20 1
ldi R19 0
mov R16 R19 # Test if 24 hours have elapsed
subi R16 24
tst R16
breq 1
ldi R16 0

# Output
mov R16 R18
add R16 R16 # Multiply by 4
add R16 R16
ldi R25 1 # Seconds
add R16 R25
st R16 Z

mov R16 R19
add R16 R16 # Multiply by 4
add R16 R16
ldi R25 2 # Minutes
add R16 R25
st R16 Z

mov R16 R20
add R16 R16 # Multiply by 4
add R16 R16
ldi R25 3 # Hours
add R16 R25
st R16 Z

breq -38
