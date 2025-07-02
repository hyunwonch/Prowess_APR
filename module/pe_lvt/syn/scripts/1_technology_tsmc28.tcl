# Technology setup file for synopsys products
# This file should be sourced after sourcing "common.tcl"

#------------- Dont Change ---------------

set SVT_TECH_DIR /afs/eecs.umich.edu/kits/TSMC/N28HPC+/2018.10/tcbn28hpcplusbwp30p140lvt/digital/Front_End/timing_power_noise/CCS/tcbn28hpcplusbwp30p140lvt_180a
set DB_DIR /n/badwater/z/hyunwon/Documents/TSMC_Prowess/tsmc28/db
set SRAM_DIR /n/badwater/z/hyunwon/Documents/TSMC_Prowess/tsmc28/mem/active/db

set target_library "tcbn28hpcplusbwp30p140lvttt0p9v25c_ccs.db"
set synthetic_library "standard.sldb dw_foundation.sldb"

#-----------------------------------------

set sram_library "ts1n28hpcpuhdhvtb32x64m1sso_tt0p9v25c.db      \
					ts1n28hpcpuhdlvtb32x84m1sso_tt0p9v25c.db    \
					ts1n28hpcpuhdlvtb512x32m4sso_tt0p9v25c.db   \
                    ts1n28hpcpuhdlvtb128x32m1sso_tt0p9v25c.db   \
    "

#-----------------------------------------

set link_library [concat "* "  $target_library $synthetic_library $sram_library ]

# Pathes for logic libraries
set search_path ". \
                $SVT_TECH_DIR
                $DB_DIR
                $SRAM_DIR
                "

#-----------------------------------------