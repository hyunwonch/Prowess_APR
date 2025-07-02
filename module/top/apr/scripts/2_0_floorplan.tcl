############################################################################
# TCL script for Innovus 21.10
# Floorplan
#---------------------------------------------------------------------------
# Author: Hyunwon Chung
# Last Updated: Feb 15 2025
############################################################################

############################################################################
# Get Cell Sizes
############################################################################
set cell_list   [list \
                SRAM_512x64             TS1N28HPCPUHDHVTB512X64M4S \
                SRAM_512x32             TS1N28HPCPUHDHVTB512X32M4S \
                SRAM_2048x64            TS1N28HPCPUHDHVTB2048X64M4S \
                CLK_GEN_CORE            CLK_GEN_CORE \
                INST_MEM                TS1N28HPCPUHDHVTB128X64M2SSO \
                CMD_MEM                 TS1N28HPCPUHDHVTB128X256M1SSO \
                PDIGITAL_V              PDDWUW0408SDGH_V \
                PDIGITAL_H              PDDWUW0408SDGH_H \
                PANA_V                  PDB3A_V \
                PANA_H                  PDB3A_H \
                PVDD_V                  PVDD2ANA_V \
                PVDD_H                  PVDD2ANA_H \
                ]

foreach {my_name my_cell} $cell_list {
    set ${my_name}_w [expr [dbGet [dbGetCellByName ${my_cell}].size_x]]
    set ${my_name}_h [expr [dbGet [dbGetCellByName ${my_cell}].size_y]]
}

############################################################################
# Set Some Variables
############################################################################

# Set before in 0_init.tcl but redefined here
set init_pwr_net "VDD DVDD"
set init_gnd_net "VSS VSSE"

set t_pitch [dbGet top.fPlan.coreSite.size_y]     ; # Pitch between power rails (standard cell height)
set f_pitch [dbGet head.finGridPitch]             ; # Pitch between fins

# Variables used by Power Planning scripts
set pwr_net_list {VDD VSS}              ;   # List of Power nets

set p_rng_w      0.960                  ;   # Power ring metal width
set p_rng_s      0.480                  ;   # Power ring metal space
set p_str_w      0.720                  ;   # Power stripe metal width
set p_str_s      0.360                  ;   # Power stripe metal space
set p_str_p      8.000                  ;   # Power stripe metal space


# Floorplan Variables
set p_str_margin  [expr ([llength $pwr_net_list] * ($p_str_w + $p_str_s)) + $p_str_s]
set core_margin_t [expr ([llength $pwr_net_list] * ($p_rng_w + $p_rng_s)) + $p_rng_s]
set core_margin_b [expr ([llength $pwr_net_list] * ($p_rng_w + $p_rng_s)) + $p_rng_s]
set core_margin_r [expr ([llength $pwr_net_list] * ($p_rng_w + $p_rng_s)) + $p_rng_s]
set core_margin_l [expr ([llength $pwr_net_list] * ($p_rng_w + $p_rng_s)) + $p_rng_s]

set core_width   2800 ;   # Core Area Width
set core_height  2000 ;   # Core Area Height


floorPlan -s $core_width \
            $core_height \
            $core_margin_l \
            $core_margin_b \
            $core_margin_r \
            $core_margin_t

source -verbose scripts/2_1_pin.tcl
source -verbose scripts/2_2_macro.tcl
source -verbose scripts/2_3_stripes.tcl