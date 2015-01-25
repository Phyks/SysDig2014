all: netlist simulateur clock

simulateur:
	@echo "## Building simulateur ##"
	cd simulateur; make main.native

netlist: mjc mj/core.mj
	@echo "## Generating netlist ##"
	cd mj; make

mj/core.mj:
	cd mj; make core.mj

mjc: minijazz/minijazz/main/mjc.ml
	@echo "## Building minijazz to netlist converter ##"
	cd minijazz/minijazz; make mjc.native

clock: simulateur netlist
	@echo "## Running the clock ##"
