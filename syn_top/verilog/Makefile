################################################################################
## CONFIGURATION
################################################################################

DESIGN_NAME     = top
PROJECT_PATH    = .
VERILOG_PATH    = $(PROJECT_PATH)
HEADER_PATH     = $(PROJECT_PATH)
TESTBENCH_PATH  = $(PROJECT_PATH)
MEMORY_PATH 	= /net/badwater/z/hyunwon/Documents/TSMC_Prowess/tsmc28/mem/verilog
HIER_PATH 		= /net/badwater/z/hyunwon/Documents/TSMC_Prowess/tsmc28/syn/verilog
DW_PATH			= /usr/caen/synopsys-synth-2022.03-SP3/dw/sim_ver

SYN_PATH        = ../../runs/$(DESIGN_NAME)/results/dc

################################################################################
## LIBRARY
################################################################################

VCS = SW_VCS=2020.12-SP2-1 vcs -sverilog +vc +v2k -Mupdate -line -full64 -timescale=1ns/1ps +define+DUMP_VCD=1 -debug_access +sdfverbose +define+no_warning -o $@
SYNOPSYS = /afs/umich.edu/group/engin/caen2/software/academic-res/synopsys-synth-2013.03-sp1/
LIB = /n/badwater/z/hyunwon/Documents/TSMC_Prowess/library/arm_2020q4/verilog/sc7mcpp140z_cln22ul_base_svt_c30.v

SIMDEFS             = +define+NOTEST=1 +define+DUMP_VCD=1 +define+COM=1 +define+GF12MEM=1 +define+ARM_UD_MODEL +define+NO_SDTC +define+GF12 +define+TSMC_INITIALIZE_MEM +define+TSMC_INITIALIZE_FORMAT_BINARY +define+TSMC_NO_WARNING

DBGDEFS             = +define+DEBUG +define+FULL -debug_access+all -debug_region+cell+lib +memcbk

SYNDEFS             = +define+SYN +define+SYNTH +define+ASIC +sdfverbose +neg_tchk +multisource_int_delays +plusarg_save +overlap

SDFCPL              = +csdf+precomp+file+/n/badwater/z/hyunwon/Documents/template_project/runs/$(DESIGN_NAME)/results/innovus/$(DESIGN_NAME).sdf +csdf+precomp+dir+./

SDFDEFS             = -timescale=1ns/1fs +define+SYN +define+ASIC +define+APR_SDF +define+SDF +sdfverbose +neg_tchk +multisource_int_delays +plusarg_save +overlap

SDFANT              = -sdf typ:tb.dut:PE_prowess.sdf_c

################################################################################
## VERILOG FILES
################################################################################

HEADERS             = $(wildcard    $(HEADER_PATH)/*.svh)
MEMORYS             = $(wildcard    $(MEMORY_PATH)/*.v)
HIER             	= $(wildcard    $(HIER_PATH)/*.sv	\
									$(HIER_PATH)/*.svh	\
						)
DW_VERILOG_FILE     = 				$(DW_PATH)/DW_fp_mult.v   \
                                    $(DW_PATH)/DW_fp_add.v     \
                                    $(DW_PATH)/DW_fp_addsub.v
VERILOG_FILE        = $(wildcard    $(VERILOG_PATH)/*.sv    \
                                    $(VERILOG_PATH)/*.v     \
                        )
TESTBENCH           = $(wildcard    $(TESTBENCH_PATH)/*.sv  \
                                    $(TESTBENCH_PATH)/*.v   \
                        )
VERILOG_SYN_FILE    = $(SYN_PATH)/$(DESIGN_NAME).mapped.v

################################################################################
## RULES
################################################################################

.PHONY: all com sim syn full power clean memory

# Default target:
all:    sim

memory:
	ln -srf ../../memory/*.v ./memory/

com:	$(HEADERS) $(DW_VERILOG_FILE) $(HIER) $(VERILOG_FILE) $(MEMORYS) $(TESTBENCH)
	$(VCS) $(SIMDEFS) $^ -timescale=1ns/1ps;rm -rf com*;rm -rf csrc

sim:	$(HEADERS) $(VERILOG_FILE) $(TESTBENCH)
	$(VCS) $(SIMDEFS) $^ -timescale=1ns/1ps; ./sim | tee sim.log;rm -rf sim;rm -rf sim.daidir;rm -rf csrc;rm -rf ucli.key

full:	$(HEADERS) $(VERILOG_FILE) $(TESTBENCH)
	$(VCS) $(SIMDEFS) $(DBGDEFS) $^ -kdb -R -timescale=1ns/1ps;full;verdi -ssf novas.fsdb

syn: $(LIB) $(HEADERS) $(VERILOG_SYN_FILE) $(TESTBENCH)
	$(VCS) $(SIMDEFS) $(SYNDEFS) $^ -timescale=1ns/1ps; ./syn | tee syn.log



current_date = $(shell date '+%Y-%m-%d_%H-%M-%S')

bleach_synth:
	cd ../../runs/$(DESIGN_NAME); make bleach_synth

synth:
	cd ../../runs/$(DESIGN_NAME); make synth
	cat ../../runs/$(DESIGN_NAME)/reports/dc/$(DESIGN_NAME).qor_snapshot.rpt

power:	clean_power syn
	mkdir -p reports
	mkdir -p reports/$(current_date)
	cd power/mem_db; ln -srf ../../../../memory/*{sigcmin,sigcmax,nominal}*.db ./
	cd power; pt_shell -f pp_syn.tcl | tee pt_shell.log
	cp -f power/*.rpt reports/
	-mv power/*.{rpt,log} reports/$(current_date)

clean:
	rm -rf csrc
	rm -rf com sim full syn
	rm -rf com.log sim.log full.log syn.log
	rm -f *.fsdb
	rm -rf *.daidir

clean_verdi:
	rm -rf Verdi*
	rm -rf ucli.key

clean_power:
	rm -rf power/primetime_px.fsdb
	rm -rf power/vcd_syn/*.vcd
	rm -rf syn
	rm -rf syn*
	rm -rf sdfAnnotateInfo

clean_all: clean clean_verdi
	rm -rf ./verdiLog
	rm -rf verdi_config_file
	rm -f *.rc
	rm -f sdfAnnotateInfo
