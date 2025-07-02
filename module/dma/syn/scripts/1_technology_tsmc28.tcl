# Technology setup file for synopsys products
# This file should be sourced after sourcing "common.tcl"

#------------- Dont Change ---------------

set SVT_TECH_DIR /afs/eecs.umich.edu/kits/TSMC/N28HPC+/2018.10/tcbn28hpcplusbwp30p140/digital/Front_End/timing_power_noise/CCS/tcbn28hpcplusbwp30p140_180a
set DB_DIR /n/badwater/z/hyunwon/Documents/TSMC_Prowess/tsmc28/db
set CUSTOM_DIR /n/badwater/z/hyunwon/Documents/TSMC_Prowess/tsmc28/db/custom
set SRAM_DIR /n/badwater/z/hyunwon/Documents/TSMC_Prowess/tsmc28/mem/db

set target_library "tcbn28hpcplusbwp30p140tt0p9v25c_ccs.db"
# set target_library "tcbn28hpcplusbwp30p140tt0p9v25c.db"
set synthetic_library "standard.sldb dw_foundation.sldb"
set pad_library "tphn28hpcpgv2od3tt0p9v2p5v25c.db"

#-----------------------------------------

set sram_library "ts1n28hpcpuhdhvtb512x64m4s_170a_tt0p9v25c.db \
                  ts1n28hpcpuhdhvtb1024x64m4s_170a_tt0p9v25c.db \
                  ts1n28hpcpuhdhvtb2048x64m4s_170a_tt0p9v25c.db \
                  ts1n28hpcpuhdhvtb512x32m4s_170a_tt0p9v25c.db \
                    ts1n28hpcpuhdlvtb16x32m1sso_170a_tt0p9v25c.db \
					ts1n28hpcpuhdlvtb32x64m1sso_170a_tt0p9v25c.db \
					ts1n28hpcpuhdlvtb64x128m1sso_170a_tt0p9v25c.db \
					ts1n28hpcpuhdlvtb128x256m1sso_170a_tt0p9v25c.db \
					ts1n28hpcpuhdlvtb32x16m2sso_170a_tt0p9v25c.db \
					ts1n28hpcpuhdlvtb64x32m2sso_170a_tt0p9v25c.db \
					ts1n28hpcpuhdlvtb128x64m2sso_170a_tt0p9v25c.db \
					ts1n28hpcpuhdlvtb256x128m2sso_170a_tt0p9v25c.db \
					ts1n28hpcpuhdlvtb256x16m4sso_170a_tt0p9v25c.db \
					ts1n28hpcpuhdlvtb512x32m4sso_170a_tt0p9v25c.db \
					ts1n28hpcpuhdlvtb1024x64m4sso_170a_tt0p9v25c.db \
					ts1n28hpcpuhdlvtb2048x128m4sso_170a_tt0p9v25c.db \
					\
					ts1n28hpcpuhdsvtb16x32m1sso_170a_tt0p9v25c.db \
					ts1n28hpcpuhdsvtb32x64m1sso_170a_tt0p9v25c.db \
					ts1n28hpcpuhdsvtb64x128m1sso_170a_tt0p9v25c.db \
					ts1n28hpcpuhdsvtb128x256m1sso_170a_tt0p9v25c.db \
					ts1n28hpcpuhdsvtb32x16m2sso_170a_tt0p9v25c.db \
					ts1n28hpcpuhdsvtb64x32m2sso_170a_tt0p9v25c.db \
					ts1n28hpcpuhdsvtb128x64m2sso_170a_tt0p9v25c.db \
					ts1n28hpcpuhdsvtb256x128m2sso_170a_tt0p9v25c.db \
					ts1n28hpcpuhdsvtb256x16m4sso_170a_tt0p9v25c.db \
					ts1n28hpcpuhdsvtb512x32m4sso_170a_tt0p9v25c.db \
					ts1n28hpcpuhdsvtb1024x64m4sso_170a_tt0p9v25c.db \
					ts1n28hpcpuhdsvtb2048x128m4sso_170a_tt0p9v25c.db \
					\
					ts1n28hpcpuhdhvtb16x32m1sso_170a_tt0p9v25c.db \
					ts1n28hpcpuhdhvtb32x64m1sso_170a_tt0p9v25c.db \
					ts1n28hpcpuhdhvtb64x128m1sso_170a_tt0p9v25c.db \
					ts1n28hpcpuhdhvtb128x256m1sso_170a_tt0p9v25c.db \
					ts1n28hpcpuhdhvtb32x16m2sso_170a_tt0p9v25c.db \
					ts1n28hpcpuhdhvtb64x32m2sso_170a_tt0p9v25c.db \
					ts1n28hpcpuhdhvtb128x64m2sso_170a_tt0p9v25c.db \
					ts1n28hpcpuhdhvtb256x128m2sso_170a_tt0p9v25c.db \
					ts1n28hpcpuhdhvtb256x16m4sso_170a_tt0p9v25c.db \
					ts1n28hpcpuhdhvtb512x32m4sso_170a_tt0p9v25c.db \
					ts1n28hpcpuhdhvtb1024x64m4sso_170a_tt0p9v25c.db \
					ts1n28hpcpuhdhvtb2048x128m4sso_170a_tt0p9v25c.db \
    "

set custom_library "CLK_GEN_CORE.db \
                    "

#-----------------------------------------

set link_library [concat "* "  $target_library $synthetic_library $pad_library $sram_library $custom_library ]

# Pathes for logic libraries
set search_path ". \
                $SVT_TECH_DIR
                $DB_DIR
                $SRAM_DIR
                $CUSTOM_DIR
                "

#-----------------------------------------