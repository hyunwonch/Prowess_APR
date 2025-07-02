
#---------- Dont Change ----------

export CURRENT_PATH = $(shell pwd)
export DESIGN_PATH = $(CURRENT_PATH)/../verilog
#---------------------------------

export DESIGN_NAME = PE

syn:
	dc_shell -64bit -f syn.tcl | tee syn.log
	mv -f *.{pvl,syn,mr,svf} files/

check:
	@ echo ""
	@ echo "########################"
	@ echo "##   ERROR MESSAGES   ##"
	@ echo "########################"
	@ echo ""
	@ grep -i "error" syn.log || (echo "     NO ERROR DETECTED! :)")
	@ echo ""
	@ echo "########################"
	@ echo "## UNRESOLVED MODULES ##"
	@ echo "########################"
	@ echo ""
	@ grep "\(resolved\|three\|tri-\)" syn.log || (echo "     LOOKS GOOD! :)")
	@ echo ""
	@ echo "########################"
	@ echo "##      LATCHES       ##"
	@ echo "########################"
	@ echo ""
	@ grep "Latch" syn.log || (echo "     NO LATCH DETECTED! :)")
	@ echo ""

synth: syn check

bleach_synth:
	rm -rf *.out
	rm -rf *.txt
	rm -rf *.syn
	rm -rf ./data/*.ddc
	rm -rf ./data/*.dc.sdf
	rm -rf ./data/*.nl.v
	rm -rf ./data/*.sdc
	rm -rf ./data/*.sv
	rm -rf *.pvl
	rm -rf *.mr
	rm -rf alib-52
	rm -rf *.svf
	rm -rf *.log
	rm -rf ./files/*

.PHONY: syn synth clean check