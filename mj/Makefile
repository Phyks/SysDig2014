MJS=arithmetics.mj bitwise.mj branching.mj constants.mj flags.mj gates.mj main.mj others.mj transfer.mj utils.mj

all: compile

core: $(MJS)
	./generate.py main.mj > core

compile: core mjc.native
	./mjc.native core