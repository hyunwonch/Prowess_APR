############################################################################
# TCL script for Innovus 15.21 (MEMv1)
# Floorplan
#---------------------------------------------------------------------------
# Author: Hyunwon CHung
# Last Updated: Feb 15 2022
############################################################################

############################################################################
# Get Cell Sizes
############################################################################
set cell_list   [list \
                SRAM_32x84              TS1N28HPCPUHDLVTB32X84M1SSO  \
                SRAM_128x32             TS1N28HPCPUHDLVTB128X32M1SSO \
                ]

foreach {my_name my_cell} $cell_list {
    set ${my_name}_w [expr [dbGet [dbGetCellByName ${my_cell}].size_x]]
    set ${my_name}_h [expr [dbGet [dbGetCellByName ${my_cell}].size_y]]
}

############################################################################
# Set Some Variables
############################################################################

# Set before in 0_init.tcl but redefined here
set init_pwr_net "VDD VDD_SRAM"
set init_gnd_net "VSS"

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

set core_width   260 ;   # Core Area Width
set core_height  260  ;   # Core Area Height


floorPlan -s $core_width \
            $core_height \
            $core_margin_l \
            $core_margin_b \
            $core_margin_r \
            $core_margin_t

source -verbose scripts/2_1_pin.tcl
source -verbose scripts/2_2_macro.tcl
source -verbose scripts/2_3_stripes.tcl