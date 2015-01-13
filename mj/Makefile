MJS=arithmetics.mj bitwise.mj branching.mj constants.mj flags.mj gates.mj main.mj others.mj transfer.mj utils.mj
MJC=../minijazz/minijazz/mjc.native

all: compile

core.mj: $(MJS)
	./generate.py main.mj > core.mj

compile: core
	$(MJC) core.mj
