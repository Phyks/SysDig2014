all: netlist

netlist: mjc
	@echo "## Generating netlist ##"
	cd mj; make

simulateur:
	@echo "## Building simulateur ##"
	cd simulateur; make

mjc:
	@echo "## Building minijazz to netlist converter ##"
	cd minijazz/minijazz; ocamlbuild mjc.native
