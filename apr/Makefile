###############################################
## Makefile for SONA APR
##
## Author: Yejoong Kim (yejoong@umich.edu)
## Edit: Pierre Abillama
## Last Updated: Feb 16 2022
###############################################

############################
## Layer Name
############################
layer_name  = PE_prowess
top_level   = $(layer_name)
top_level_file = PE_prowess

############################
## Directories
############################
cdl_dir = /afs/eecs.umich.edu/vlsida/projects/SONA/cdl

############################
## File Names
############################
cdl_file     = output/$(top_level_file).cdl
ckt_file     = output/$(top_level_file).ckt
apr_v        = output/$(top_level_file).apr.v
apr_pg_v     = output/$(top_level_file).apr.pg.v
apr_sim_v    = output/$(top_level_file).apr.sim.v
apr_sdf      = output/$(top_level_file).apr.sdf

############################
## v2lvs Settings
############################

v2lvs_lsr =	\
			-lsr $(cdl_dir)/source.added \
			-lsr $(cdl_dir)/sc7mcpp140z_cln22ul_base_svt_c30.cdl \
			-lsr $(cdl_dir)/sc7mcpp140z_cln22ul_pmk_svt_c30.cdl \
			-lsr $(cdl_dir)/sc7mcpp140z_cln22ul_pmk_hvt_c30.cdl \
			-lsr ${cdl_dir}/tphn22ullgv2od3_c171206.spi \
			-lsr $(cdl_dir)/sc9_cln22ul_pmk_g3p3.cdl \
			-lsr $(cdl_dir)/mrn22ull128kx145m32b4i8lp_dw33_svt_010h_\<\>.spb \
			-lsr ${cdl_dir}/SRAM_512x128_\<\>.cdl \
			-lsr ${cdl_dir}/SRAM_512x32_\<\>.cdl \
			-lsr ${cdl_dir}/SRAM_512x80_\<\>.cdl \
			-lsr ${cdl_dir}/SRAM_512x96_\<\>.cdl \
			-lsr ${cdl_dir}/SRAM_1024x110_\<\>.cdl \
			-lsr ${cdl_dir}/RF_16x128_\<\>.cdl \
			-lsr ${cdl_dir}/RF_32x128_\<\>.cdl \
			-lsr ${cdl_dir}/RF_32x32_\<\>.cdl \
			-lsr ${cdl_dir}/RF_32x96_\<\>.cdl \
			-lsr ${cdl_dir}/custom/CLK_GEN_CORE.sp \
			-lsr ${cdl_dir}/custom/HEADER_0P8V_MRAMVDD.cdl \
			-lsr ${cdl_dir}/custom/HEADER_0P8V_SMALL_MRAMVDD.cdl \
			-lsr ${cdl_dir}/custom/HEADER_0P8V_MRAMVDDS.cdl \
			-lsr ${cdl_dir}/custom/HEADER_3P3V_MRAMVDIO.cdl \
			-lsr ${cdl_dir}/custom/HEADER_3P3V_SMALL_MRAMVDIO.cdl \
			-lsr ${cdl_dir}/custom/LC_L2H_3P3.cdl \

v2lvs_s =	\
			-s $(cdl_dir)/source.added \
			-s $(cdl_dir)/sc7mcpp140z_cln22ul_base_svt_c30.cdl \
			-s $(cdl_dir)/sc7mcpp140z_cln22ul_pmk_svt_c30.cdl \
			-s $(cdl_dir)/sc7mcpp140z_cln22ul_pmk_hvt_c30.cdl \
			-s $(cdl_dir)/sc9_cln22ul_pmk_g3p3.cdl \
			-s ${cdl_dir}/tphn22ullgv2od3_c171206.spi \
			-s $(cdl_dir)/mrn22ull128kx145m32b4i8lp_dw33_svt_010h_\<\>.spb \
		    -s ${cdl_dir}/SRAM_512x128_\<\>.cdl \
			-s ${cdl_dir}/SRAM_512x32_\<\>.cdl \
			-s ${cdl_dir}/SRAM_512x80_\<\>.cdl \
			-s ${cdl_dir}/SRAM_512x96_\<\>.cdl \
			-s ${cdl_dir}/SRAM_1024x110_\<\>.cdl \
			-s ${cdl_dir}/RF_16x128_\<\>.cdl \
			-s ${cdl_dir}/RF_32x128_\<\>.cdl \
			-s ${cdl_dir}/RF_32x32_\<\>.cdl \
			-s ${cdl_dir}/RF_32x96_\<\>.cdl \
			-s ${cdl_dir}/custom/CLK_GEN_CORE.sp \
			-s ${cdl_dir}/custom/HEADER_0P8V_MRAMVDD.cdl \
			-s ${cdl_dir}/custom/HEADER_0P8V_SMALL_MRAMVDD.cdl \
			-s ${cdl_dir}/custom/HEADER_0P8V_MRAMVDDS.cdl \
			-s ${cdl_dir}/custom/HEADER_3P3V_MRAMVDIO.cdl \
			-s ${cdl_dir}/custom/HEADER_3P3V_SMALL_MRAMVDIO.cdl \
			-s ${cdl_dir}/custom/LC_L2H_3P3.cdl \

############################
## Makefile Recipes
############################
FINAL_MSG =	"**** [Makefile]: End of Makefile ****"

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
floorplan:
	@ echo "**** [Makefile] Deleting previous log files... "
	@ rm -rf innovus.* anaMsvClk.* ./logs/$(top_level).log* $(top_level).cmd* *.rcdb.d *.old .*_diode.list* .*.fp .*.fp.spr *Analysis.txt *Analysis_early_*.rpt *Analysis_late_*.rpt
	@ echo "**** [Makefile] Starting Innovus... "
	@ innovus -init $(top_level)_floorplan.tcl -log ./logs/$(top_level).log
power:
	@ echo "**** [Makefile] Deleting previous log files... "
	@ rm -rf innovus.* anaMsvClk.* ./logs/$(top_level).log* $(top_level).cmd* *.rcdb.d *.old .*_diode.list* .*.fp .*.fp.spr *Analysis.txt *Analysis_early_*.rpt *Analysis_late_*.rpt
	@ echo "**** [Makefile] Starting Innovus... "
	@ innovus -init $(top_level)_power.tcl -log ./logs/$(top_level).log
cts:
	@ echo "**** [Makefile] Deleting previous log files... "
	@ rm -rf innovus.* anaMsvClk.* ./logs/$(top_level).log* $(top_level).cmd* *.rcdb.d *.old .*_diode.list* .*.fp .*.fp.spr *Analysis.txt *Analysis_early_*.rpt *Analysis_late_*.rpt
	@ echo "**** [Makefile] Starting Innovus... "
	@ innovus -init $(top_level)_cts.tcl -log ./logs/$(top_level).log
optimize:
	@ echo "**** [Makefile] Deleting previous log files... "
	@ rm -rf innovus.* anaMsvClk.* ./logs/$(top_level).log* $(top_level).cmd* *.rcdb.d *.old .*_diode.list* .*.fp .*.fp.spr *Analysis.txt *Analysis_early_*.rpt *Analysis_late_*.rpt
	@ echo "**** [Makefile] Starting Innovus... "
	@ innovus -init $(top_level)_optimize.tcl -log ./logs/$(top_level).log
route:
	@ echo "**** [Makefile] Deleting previous log files... "
	@ rm -rf innovus.* anaMsvClk.* ./logs/$(top_level).log* $(top_level).cmd* *.rcdb.d *.old .*_diode.list* .*.fp .*.fp.spr *Analysis.txt *Analysis_early_*.rpt *Analysis_late_*.rpt
	@ echo "**** [Makefile] Starting Innovus... "
	@ innovus -init $(top_level)_route.tcl -log ./logs/$(top_level).log
place:
	@ echo "**** [Makefile] Deleting previous log files... "
	@ rm -rf innovus.* anaMsvClk.* ./logs/$(top_level).log* $(top_level).cmd* *.rcdb.d *.old .*_diode.list* .*.fp .*.fp.spr *Analysis.txt *Analysis_early_*.rpt *Analysis_late_*.rpt
	@ echo "**** [Makefile] Starting Innovus... "
	@ innovus -init $(top_level)_place.tcl -log ./logs/$(top_level).log
final:
	@ echo "**** [Makefile] Deleting previous log files... "
	@ rm -rf innovus.* anaMsvClk.* ./logs/$(top_level).log* $(top_level).cmd* *.rcdb.d *.old .*_diode.list* .*.fp .*.fp.spr *Analysis.txt *Analysis_early_*.rpt *Analysis_late_*.rpt
	@ echo "**** [Makefile] Starting Innovus... "
	@ innovus -init $(top_level)_final.tcl -log ./logs/$(top_level).log

check:
	@ echo " "
	@ echo "**** [Makefile] Checking $(top_level) Setup Time Report... "
	@ echo " "
	@ grep "VIOLATED" timingReports/$(top_level)_postRoute_all.tarpt || (echo "      PASS!";)
	@ echo " "
	@ echo "**** [Makefile] Checking $(top_level) Hold Time Report... "
	@ echo " "
	@ grep "VIOLATED" timingReports/$(top_level)_postRoute_all_hold.tarpt || (echo "      PASS!";)
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
	@ mv ./$(top_level).gds        ./latest_output/
	@ mv ./$(top_level).spf        ./latest_output/
	@ mv ./$(top_level).cdl        ./latest_output/
	@ mv ./$(top_level).logv       ./latest_output/
	@ mv ./$(top_level).apr.sim.v  ./latest_output/
	@ mv ./$(top_level).apr.v      ./latest_output/
	@ mv ./$(top_level).def        ./latest_output/
	@ mv ./$(top_level).apr.v      ./latest_output/

clean:
	rm -rf .cadence .t* timingReports *.rcdb.d *.v innovus.* *.sdf *.bk CTS_*.txt cts.rguide *.rpt *.trace *.def *.old *.lef *.gds *.spf *.spef *.dc.outbound.* clkNetList.* implicitIsoShifterRules.cpf orig*.route origScaleFactor.tcl *_diode.list* *.apr.sdf.orig *.mac.ckt *.cdl.orig $(layer_name).log* $(layer_name).cmd* v2lvs.log db .nano_eco_diode*
	rm -rf scheduling_file.*
	rm -rf .PE_prowess_*
	rm -rf ./logs/*
	rm -rf ./reports/*
	rm -rf rc_model.bin
	rm -rf *.mtarpt

.PHONY: apr check cdl v2lvs post_v2lvs final_msg clean post_cdl_mod v2lvs_customsim
