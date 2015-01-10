MJS=arithmetics.mj bitwise.mj branching.mj constants.mj flags.mj gates.mj main.mj others.mj transfer.mj utils.mj

all: compile

_tmp: $(MJS)
	./generate.py main.mj > _tmp

compile: _tmp mjc.native
	./mjc.native _tmp