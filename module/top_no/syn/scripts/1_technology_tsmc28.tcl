# Technology setup file for synopsys products
# This file should be sourced after sourcing "common.tcl"

#------------- Dont Change ---------------

set SVT_TECH_DIR /afs/eecs.umich.edu/kits/TSMC/N28HPC+/2018.10/tcbn28hpcplusbwp30p140/digital/Front_End/timing_power_noise/CCS/tcbn28hpcplusbwp30p140_180a
set DB_DIR /n/badwater/z/hyunwon/Documents/TSMC_Prowess/tsmc28/db
set CUSTOM_DIR /n/badwater/z/hyunwon/Documents/TSMC_Prowess/tsmc28/db/custom
set SRAM_DIR /n/badwater/z/hyunwon/Documents/TSMC_Prowess/tsmc28/mem/active/db

set target_library "tcbn28hpcplusbwp30p140tt0p9v25c_ccs.db"
set synthetic_library "standard.sldb dw_foundation.sldb"
set pad_library "tphn28hpcpgv2od3tt0p9v2p5v25c.db"

#-----------------------------------------

set sram_library "ts1n28hpcpuhdhvtb32x64m1sso_tt0p9v25c.db \
					ts1n28hpcpuhdlvtb32x84m1sso_tt0p9v25c.db \
					ts1n28hpcpuhdlvtb512x32m4sso_tt0p9v25c.db \
					ts1n28hpcpuhdhvtb128x256m1sso_170a_tt0p9v25c.db	\
					ts1n28hpcpuhdhvtb128x64m2sso_170a_tt0p9v25c.db	\
					ts1n28hpcpuhdhvtb512x32m4sso_170a_tt0p9v25c.db	\
    "

set custom_library "CLK_GEN_CORE.db \
					PE.db			\
                    "

set HIER_DIR /n/badwater/z/hyunwon/Documents/TSMC_Prowess/tsmc28/module/pe_no/apr/output

#-----------------------------------------

set link_library [concat "* "  $target_library $synthetic_library $pad_library $sram_library $custom_library ]

# Pathes for logic libraries
set search_path ". \
                $SVT_TECH_DIR
                $DB_DIR
                $SRAM_DIR
                $CUSTOM_DIR
				$HIER_DIR
                "

#-----------------------------------------