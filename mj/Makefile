MJS=arithmetics.mj bitwise.mj branching.mj constants.mj flags.mj gates.mj main.mj others.mj transfer.mj utils.mj

all: compile

mjc.native:
	cd ../simulateur/minijazz
	ocamlbuild mjc.native
	cd -
	ln -s ln -s ../simulateur/minijazz/_build/main/mjc.native mjc.native

_tmp: $(MJS)
	./generate.py main.mj > _tmp

compile: _tmp mjc.native
	./mjc.native _tmp