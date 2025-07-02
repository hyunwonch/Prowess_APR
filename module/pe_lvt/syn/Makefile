
#---------- Dont Change ----------

export CURRENT_PATH = $(shell pwd)
export VERILOG_PATH = $(CURRENT_PATH)/verilog
#---------------------------------

export DESIGN_NAME = PE

SYN_LOG = syn.log
ERROR_LOG = error.log
WARNING_LOG = warning.log
SYN_SCRIPT = syn.tcl

synth:
	dc_shell -64bit -f syn.tcl | tee syn.log
	mv -f *.{pvl,syn,mr,svf} files/

all:
	@rm -f $(SYN_LOG) $(ERROR_LOG)
	@(dc_shell -64bit -f $(SYN_SCRIPT) | tee $(SYN_LOG) &)
	@sleep 1  # Ensure syn.log is created before grepping
	@(tail -f $(SYN_LOG) | grep -i "error" > $(ERROR_LOG) &)
	@(tail -f $(SYN_LOG) | grep -i "warning" > $(WARNING_LOG) &)
	@wait

check:
	@ echo ""
	@ echo "########################"
	@ echo "##   ERROR MESSAGES   ##"
	@ echo "########################"
	@ echo ""
	@ grep "\(^err\|(LIBSETUP\)" syn.log || (echo "     NO ERROR DETECTED! :)")
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
	rm -rf reports/*
