###############################################
## Makefile for PROWESS APR
##
## Author: Hyunwon Chung
## Last Updated: Jun 26 2025
###############################################

############################
## Layer Name
############################
layer_name  	= PE
top_level   	= $(layer_name)
top_level_file 	= PE

############################
## Directories
############################
cdl_dir = /net/badwater/z/hyunwon/Documents/TSMC_Prowess/tsmc28/cdl
mem_dir = /net/badwater/z/hyunwon/Documents/TSMC_Prowess/tsmc28/mem/active/cdl

############################
## File Names
############################
cdl_file     = output/$(top_level_file).cdl
ckt_file     = output/$(top_level_file).ckt
apr_v        = output/$(top_level_file).apr.v
apr_pg_v     = output/$(top_level_file).apr.pg.v
apr_pg_v2     = output/$(top_level_file).apr.pg2.v
apr_sim_v    = output/$(top_level_file).apr.sim.v
apr_sdf      = output/$(top_level_file).apr.sdf

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
	@ rm -rf innovus.* anaMsvClk.* ./logs/$(top_level).log* $(top_level).cmd* *.rcdb.d *.old .*_diode.list* .*.fp .*.fp.spr *Analysis.txt *Analysis_early_*.rpt *Analysis_late_*.rpt
	@ echo "**** [Makefile] Starting Innovus... "
	@ innovus -init all.tcl -log ./logs/$(top_level).log
init:
	@ echo "**** [Makefile] Deleting previous log files... "
	@ rm -rf innovus.* anaMsvClk.* ./logs/$(top_level).log* $(top_level).cmd* *.rcdb.d *.old .*_diode.list* .*.fp .*.fp.spr *Analysis.txt *Analysis_early_*.rpt *Analysis_late_*.rpt
	@ echo "**** [Makefile] Starting Innovus... "
	@ innovus -init ./scripts/0_init.tcl -log ./logs/init.log

check:
	@ echo " "
	@ echo "**** [Makefile] Checking $(top_level) Setup Time Report... "
	@ echo " "
	@ grep "VIOLATED" reports/signoff_all.tarpt || (echo "      PASS!";)
	@ echo " "
	@ echo "**** [Makefile] Checking $(top_level) Hold Time Report... "
	@ echo " "
	@ grep "VIOLATED" reports/signoff_all_hold.tarpt || (echo "      PASS!";)
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
	v2lvs -i -v ./$(apr_pg_v2) $(v2lvs_lsr) $(v2lvs_s) -o $(cdl_file) -sn

db_gen:
	cd output;make lc

latest:
	@ echo "## move latest output ## "
	@ mv ./$(top_level).gds        ./latest_output/
	@ mv ./$(top_level).spf        ./latest_output/
	@ mv ./$(top_level).cdl        ./latest_output/
	@ mv ./$(top_level).logv       ./latest_output/
	@ mv ./$(top_level).apr.sim.v  ./latest_output/
	@ mv ./$(top_level).apr.v      ./latest_output/
	@ mv ./$(top_level).def        ./latest_output/
	@ mv ./$(top_level).apr.v      ./latest_output/

debug:
	innovus -init ./scripts/debug.tcl -log ./logs/$(TOP_LEVEL)_debug.log

clean:
	rm -rf .cadence .t* timingReports *.rcdb.d *.v innovus.* *.sdf *.bk CTS_*.txt cts.rguide *.rpt *.trace *.def *.old *.lef *.gds *.spf *.spef *.dc.outbound.* clkNetList.* implicitIsoShifterRules.cpf orig*.route origScaleFactor.tcl *_diode.list* *.apr.sdf.orig *.mac.ckt *.cdl.orig $(layer_name).log* $(layer_name).cmd* v2lvs.log db .nano_eco_diode*
	rm -rf scheduling_file.*
	rm -rf .PE*
	rm -rf ./logs/*
	rm -rf ./reports/*
	rm -rf rc_model.bin
	rm -rf *.mtarpt

bleach_synth: clean

all: apr v2lvs2 db_gen

.PHONY: apr check cdl v2lvs v2lvs2 clean
