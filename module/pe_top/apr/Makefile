###############################################
## Makefile for SONA APR
##
## Author: Hyunwon Chung (yejoong@umich.edu)
## Edit: Pierre Abillama
## Last Updated: Feb 16 2022
###############################################

#---------- Dont Change ----------

export CURRENT_PATH = $(shell pwd)

#---------------------------------

export DESIGN_NAME = pe_top
export FOLDER_NAME = pe_top

############################
## Layer Name
############################
TOP_LEVEL   = $(DESIGN_NAME)
TOP_LEVEL_FILE = $(DESIGN_NAME)

############################
## Directories
############################
cdl_dir = $(CURRENT_PATH)/cdl

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
			-lsr $(cdl_dir)/source.added \

v2lvs_s =	\
			-s $(cdl_dir)/source.added \

############################
## Makefile Recipes
############################
FINAL_MSG =	"**** [Makefile]: End of Makefile ****"

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
floorplan:
	@ echo "**** [Makefile] Deleting previous log files... "
	@ rm -rf innovus.* anaMsvClk.* ./logs/$(TOP_LEVEL).log* $(TOP_LEVEL).cmd* *.rcdb.d *.old .*_diode.list* .*.fp .*.fp.spr *Analysis.txt *Analysis_early_*.rpt *Analysis_late_*.rpt
	@ echo "**** [Makefile] Starting Innovus... "
	@ innovus -init $(TOP_LEVEL)_floorplan.tcl -log ./logs/$(TOP_LEVEL).log
power:
	@ echo "**** [Makefile] Deleting previous log files... "
	@ rm -rf innovus.* anaMsvClk.* ./logs/$(TOP_LEVEL).log* $(TOP_LEVEL).cmd* *.rcdb.d *.old .*_diode.list* .*.fp .*.fp.spr *Analysis.txt *Analysis_early_*.rpt *Analysis_late_*.rpt
	@ echo "**** [Makefile] Starting Innovus... "
	@ innovus -init $(TOP_LEVEL)_power.tcl -log ./logs/$(TOP_LEVEL).log
cts:
	@ echo "**** [Makefile] Deleting previous log files... "
	@ rm -rf innovus.* anaMsvClk.* ./logs/$(TOP_LEVEL).log* $(TOP_LEVEL).cmd* *.rcdb.d *.old .*_diode.list* .*.fp .*.fp.spr *Analysis.txt *Analysis_early_*.rpt *Analysis_late_*.rpt
	@ echo "**** [Makefile] Starting Innovus... "
	@ innovus -init $(TOP_LEVEL)_cts.tcl -log ./logs/$(TOP_LEVEL).log
optimize:
	@ echo "**** [Makefile] Deleting previous log files... "
	@ rm -rf innovus.* anaMsvClk.* ./logs/$(TOP_LEVEL).log* $(TOP_LEVEL).cmd* *.rcdb.d *.old .*_diode.list* .*.fp .*.fp.spr *Analysis.txt *Analysis_early_*.rpt *Analysis_late_*.rpt
	@ echo "**** [Makefile] Starting Innovus... "
	@ innovus -init $(TOP_LEVEL)_optimize.tcl -log ./logs/$(TOP_LEVEL).log
route:
	@ echo "**** [Makefile] Deleting previous log files... "
	@ rm -rf innovus.* anaMsvClk.* ./logs/$(TOP_LEVEL).log* $(TOP_LEVEL).cmd* *.rcdb.d *.old .*_diode.list* .*.fp .*.fp.spr *Analysis.txt *Analysis_early_*.rpt *Analysis_late_*.rpt
	@ echo "**** [Makefile] Starting Innovus... "
	@ innovus -init $(TOP_LEVEL)_route.tcl -log ./logs/$(TOP_LEVEL).log
place:
	@ echo "**** [Makefile] Deleting previous log files... "
	@ rm -rf innovus.* anaMsvClk.* ./logs/$(TOP_LEVEL).log* $(TOP_LEVEL).cmd* *.rcdb.d *.old .*_diode.list* .*.fp .*.fp.spr *Analysis.txt *Analysis_early_*.rpt *Analysis_late_*.rpt
	@ echo "**** [Makefile] Starting Innovus... "
	@ innovus -init $(TOP_LEVEL)_place.tcl -log ./logs/$(TOP_LEVEL).log
final:
	@ echo "**** [Makefile] Deleting previous log files... "
	@ rm -rf innovus.* anaMsvClk.* ./logs/$(TOP_LEVEL).log* $(TOP_LEVEL).cmd* *.rcdb.d *.old .*_diode.list* .*.fp .*.fp.spr *Analysis.txt *Analysis_early_*.rpt *Analysis_late_*.rpt
	@ echo "**** [Makefile] Starting Innovus... "
	@ innovus -init $(TOP_LEVEL)_final.tcl -log ./logs/$(TOP_LEVEL).log

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

clean:
	rm -rf .cadence .t* timingReports *.rcdb.d *.v innovus.* *.sdf *.bk CTS_*.txt cts.rguide *.rpt *.trace *.def *.old *.lef *.gds *.spf *.spef *.dc.outbound.* clkNetList.* implicitIsoShifterRules.cpf orig*.route origScaleFactor.tcl *_diode.list* *.apr.sdf.orig *.mac.ckt *.cdl.orig $(TOP_LEVEL).log* $(TOP_LEVEL).cmd* v2lvs.log db .nano_eco_diode*
	rm -rf scheduling_file.*
	rm -rf .PE_prowess_*
	rm -rf ./logs/*
	rm -rf ./reports/*
	rm -rf rc_model.bin
	rm -rf *.mtarpt

.PHONY: apr check cdl v2lvs post_v2lvs final_msg clean post_cdl_mod v2lvs_customsim
