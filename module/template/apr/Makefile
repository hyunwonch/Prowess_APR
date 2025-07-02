###############################################
## Makefile for PROWESS APR
##
## Author: Hyunwon Chung
## Last Updated: Jun 26 2025
###############################################

#---------- Dont Change ----------

export CURRENT_PATH = $(shell pwd)

#---------------------------------

export DESIGN_NAME = template_module
export FOLDER_NAME = top_base

############################
## Layer Name
############################
TOP_LEVEL   	= $(DESIGN_NAME)
TOP_LEVEL_FILE 	= $(DESIGN_NAME)

############################
## Directories
############################
cdl_dir = /net/badwater/z/hyunwon/Documents/TSMC_Prowess/tsmc28/cdl
mem_dir = /net/badwater/z/hyunwon/Documents/TSMC_Prowess/tsmc28/mem/active/cdl

############################
## File Names
############################
cdl_file     = output/$(TOP_LEVEL_FILE).cdl
ckt_file     = output/$(TOP_LEVEL_FILE).ckt
apr_v        = output/$(TOP_LEVEL_FILE).apr.v
apr_pg_v     = output/$(TOP_LEVEL_FILE).apr.pg.v
apr_sim_v    = output/$(TOP_LEVEL_FILE).apr.sim.v
apr_sdf      = output/$(TOP_LEVEL_FILE).apr.sdf

############################
## v2lvs Settings
############################

v2lvs_lsr =	\
			-lsr $(cdl_dir)/tcbn28hpcplusbwp30p140_110a.spi \
			-lsr ${mem_dir}/ts1n28hpcpuhdlvtb32x84m1sso_170a.spi  \
			-lsr ${mem_dir}/ts1n28hpcpuhdlvtb128x32m1sso_170a.spi  \

v2lvs_s =	\
			-s $(cdl_dir)/tcbn28hpcplusbwp30p140_110a.spi \
			-s ${mem_dir}/ts1n28hpcpuhdlvtb32x84m1sso_170a.spi  \
			-s ${mem_dir}/ts1n28hpcpuhdlvtb128x32m1sso_170a.spi  \

############################
## Makefile Recipes
############################

apr:
	@ echo "**** [Makefile] Deleting previous log files... "
	@ rm -rf innovus.* anaMsvClk.* ./logs/$(TOP_LEVEL).log* $(TOP_LEVEL).cmd* *.rcdb.d *.old .*_diode.list* .*.fp .*.fp.spr *Analysis.txt *Analysis_early_*.rpt *Analysis_late_*.rpt
	@ echo "**** [Makefile] Starting Innovus... "
	@ innovus -init all.tcl -log ./logs/$(TOP_LEVEL).log
init:
	@ echo "**** [Makefile] Deleting previous log files... "
	@ rm -rf innovus.* anaMsvClk.* ./logs/$(TOP_LEVEL).log* $(TOP_LEVEL).cmd* *.rcdb.d *.old .*_diode.list* .*.fp .*.fp.spr *Analysis.txt *Analysis_early_*.rpt *Analysis_late_*.rpt
	@ echo "**** [Makefile] Starting Innovus... "
	@ innovus -init ./scripts/0_init.tcl -log ./logs/init.log

check:
	@ echo " "
	@ echo "**** [Makefile] Checking $(TOP_LEVEL) Setup Time Report... "
	@ echo " "
	@ grep "VIOLATED" timingReports/$(TOP_LEVEL)_postRoute_all.tarpt || (echo "      PASS!";)
	@ echo " "
	@ echo "**** [Makefile] Checking $(TOP_LEVEL) Hold Time Report... "
	@ echo " "
	@ grep "VIOLATED" timingReports/$(TOP_LEVEL)_postRoute_all_hold.tarpt || (echo "      PASS!";)
	@ echo " "
	@ echo "**** [Makefile] Timing Check Done... "
	@ echo " "

cdl: v2lvs

v2lvs:
	@ echo " "
	@ echo "**** [Makefile] Starting v2lvs... "
	@ echo " "
	v2lvs -c /_ -a \<\> -v ./$(apr_pg_v)  \
	$(v2lvs_lsr) \
	$(v2lvs_s) \
	-o $(cdl_file) \
	-sn

# To run LVS without using Virtuoso, you need to run v2lvs2
v2lvs2:
	@ echo " "
	@ echo "**** [Makefile] Starting v2lvs2... "
	@ echo " "
	v2lvs -i -v ./$(apr_pg_v) $(v2lvs_lsr) $(v2lvs_s) -o $(cdl_file) -sn

db_gen:
	cd output;make lc

latest:
	@ echo "## move latest output ## "
	@ mv ./$(TOP_LEVEL).gds        ./latest_output/
	@ mv ./$(TOP_LEVEL).spf        ./latest_output/
	@ mv ./$(TOP_LEVEL).cdl        ./latest_output/
	@ mv ./$(TOP_LEVEL).logv       ./latest_output/
	@ mv ./$(TOP_LEVEL).apr.sim.v  ./latest_output/
	@ mv ./$(TOP_LEVEL).apr.v      ./latest_output/
	@ mv ./$(TOP_LEVEL).def        ./latest_output/
	@ mv ./$(TOP_LEVEL).apr.v      ./latest_output/

debug:
	innovus -init ./scripts/debug.tcl -log ./logs/$(TOP_LEVEL)_debug.log

clean:
	rm -rf .cadence .t* timingReports *.rcdb.d *.v innovus.* *.sdf *.bk CTS_*.txt cts.rguide *.rpt *.trace *.def *.old *.lef *.gds *.spf *.spef *.dc.outbound.* clkNetList.* implicitIsoShifterRules.cpf orig*.route origScaleFactor.tcl *_diode.list* *.apr.sdf.orig *.mac.ckt *.cdl.orig $(TOP_LEVEL).log* $(TOP_LEVEL).cmd* v2lvs.log db .nano_eco_diode*
	rm -rf scheduling_file.*
	rm -rf .PE*
	rm -rf ./logs/*
	rm -rf ./reports/*
	rm -rf rc_model.bin
	rm -rf *.mtarpt

bleach_synth: clean

all: apr v2lvs2 db_gen

.PHONY: apr check cdl v2lvs v2lvs2 clean
