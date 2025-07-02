############################################################################
# TCL script for Innovus 15.21 (MEMv1)
# Floorplan
#---------------------------------------------------------------------------
# Author: Yejoong Kim
# Edit  : Pierre Abillama
# Last Updated: Feb 15 2022
############################################################################

############################################################################
# Get Cell Sizes
############################################################################
set cell_list   [list \
                SRAM_512x64             TS1N28HPCPUHDHVTB512X64M4S \
                SRAM_512x32             TS1N28HPCPUHDHVTB512X32M4S \
                SRAM_2048x64            TS1N28HPCPUHDHVTB2048X64M4S \
                CLK_GEN_CORE            CLK_GEN_CORE \
                MIPI_HS_RX              MIPI_HS_RX \
                MIPI_LP_RX_I            MIPI_LP_RX_I \
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
set init_pwr_net "VDD"
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

set core_width   220 ;   # Core Area Width
set core_height  220  ;   # Core Area Height


floorPlan -s $core_width \
            $core_height \
            $core_margin_l \
            $core_margin_b \
            $core_margin_r \
            $core_margin_t



source -verbose scripts/2_1_pin.tcl
source -verbose scripts/2_2_macro.tcl
source -verbose scripts/2_3_stripes.tcl



############################################################################
# Get Cell Sizes
############################################################################
# set cell_list   [list \
#     SRAM_512x128           SRAM_512x128 \
#     SRAM_512x32            SRAM_512x32 \
#     SRAM_512x80            SRAM_512x80 \
#     SRAM_512x96            SRAM_512x96 \
#     SRAM_1024x110          SRAM_1024x110 \
#     RF_16x128              RF_16x128 \
#     RF_32x128              RF_32x128 \
#     RF_32x32               RF_32x32  \
#     RF_32x96               RF_32x96  \
#     MRAM                   MRN22ULL128KX145M32B4I8LP_DW33_SVT \
#     CLK_GEN_CORE           CLK_GEN_CORE \
#     HEADER_0P8V_MRAMVDD    HEADER_0P8V_MRAMVDD \
#     HEADER_0P8V_SMALL_MRAMVDD    HEADER_0P8V_SMALL_MRAMVDD \
#     HEADER_0P8V_MRAMVDDS   HEADER_0P8V_MRAMVDDS \
#     HEADER_3P3V_MRAMVDIO   HEADER_3P3V_MRAMVDIO \
#     HEADER_3P3V_SMALL_MRAMVDIO   HEADER_3P3V_SMALL_MRAMVDIO \
#     LC_L2H_3P3             LC_L2H_3P3 \
#     PDIGITAL_V             PDDWUW0408SDGH_V \
#     PDIGITAL_H             PDDWUW0408SDGH_H \
#     PVDD_V                 PVDD2ANA_V \
#     PVDD_H                 PVDD2ANA_H \
# ]

# foreach {my_name my_cell} $cell_list {
#     set ${my_name}_w [expr [dbGet [dbGetCellByName ${my_cell}].size_x]]
#     set ${my_name}_h [expr [dbGet [dbGetCellByName ${my_cell}].size_y]]
# }





# set cutRowGapL [expr 10*$t_pitch]
# set cutRowGapR [expr 10*$t_pitch]
# set cutRowGapT [expr 10*$t_pitch]
# set cutRowGapB [expr 10*$t_pitch]


# # Check for the presence of blocks
# set blocks_list [dbGet -p2 top.insts.cell.baseClass block]

# # Conditionally execute commands if blocks are found
# if {$blocks_list != 0x0} {
#     dbSelectObj $blocks_list
#     cutRow -selected -leftGap $cutRowGapL -rightGap $cutRowGapR -topGap $cutRowGapT -bottomGap $cutRowGapB
#     deselectAll
# }

############################################################################
# Set Some Variables
############################################################################
# # Chip Dimension
# set x_dim 4000
# set y_dim 3000

# # Floorplan Variables
# ##set sram_gap_x 30
# ##set sram_gap_y 20
# set sram_gap_x 15
# set sram_gap_y 10

# ## Power Ring and Straps
# # VDD0P8_NE: Always-on for logic & SRAMs
# # VDD08_CLK: Always-on for clock generator core
# # VDD3P3_MRAMVDIO: Always-on for level converters and header
# # VDD0P8_MRAMVDD_PG: Virtual MRAM VDD
# # VDD0P8_MRAMVDDS_PG: Virtual MRAM VDDS
# # VDD0P8_MRAMVDIO_PG: Virtual MRAM VDIO

# set ring_list  {VDD0P8_NE VDD0P8_SRAM VDD0P8_CLK VDD3P3_MRAMVDIO VSS}
# set ring_width   4
# set ring_space   1

# set ring_offset  0

# # set pad_height 145
# set seal_ring_offset 30
# set bond_pad_offset 35
# set pad_offsets [expr $seal_ring_offset + $bond_pad_offset]
# set pad_height [expr 110 + $pad_offsets]

# set supply_ring_width  [expr ([llength $ring_list] * ($ring_width + $ring_space)) + (2 * $ring_space)]

# # Core Offsets
# set left_offset   $supply_ring_width
# set right_offset  $supply_ring_width
# set top_offset    $supply_ring_width
# set bottom_offset $supply_ring_width
# set core_width    [expr $x_dim - $left_offset - $right_offset - 2 * $pad_height]
# set core_height    [expr $y_dim - $top_offset - $bottom_offset - 2 * $pad_height]

# # Stripe Dimension
# set stripe_w 4  ; # Wire Width
# set stripe_s 1  ; # Wire Spacing
# set stripe_p [expr $stripe_w + $stripe_s]
# # halo
# set halo_l 2
# set halo_r 2
# ##set halo_b 10
# ##set halo_t 10
# set halo_b 5
# set halo_t 5

# set mram_halo_l 15
# set mram_halo_r 15
# set mram_halo_b 15
# set mram_halo_t 15
############################################################################
# FloorPlan
############################################################################
# loadIoFile -noAdjustDieSize ${script_dir}/${top_level}.io

# floorPlan -noSnapToGrid -s $core_width $core_height $left_offset $right_offset $bottom_offset $top_offset
# uiSetTool select
# getIoFlowFlag

# # loadIoFile -noAdjustDieSize ${script_dir}/${top_level}.io
# staggerBondPad -all -pattern i

# setFlipping s
# setDrawView fplan
# fit

############################################################################
# Place Instances - PART I
#---------------------------------------------------------------------------
# NOTE: llx and lly must be enclosed by curly brackets
############################################################################
# SRAM and MRAM

#cutRow -area [expr ${mram_x_start}] [expr ${mram_y_start}] [expr ${mram_x_end}] [expr ${mram_y_end}]
#createPlaceBlockage -box [expr ${mram_x_start}] [expr ${mram_y_start}] [expr ${mram_x_end}] [expr ${mram_y_end}]
#createRouteBlk -box [expr ${mram_x_start}] [expr ${mram_y_start}] [expr ${mram_x_end}] [expr ${mram_y_end}] -layer {M1 M2 M3 M4 M5 M6 M7}

#source ${script_dir}/generate_place.tcl
############################################################################
# Place Instances - PART II
#---------------------------------------------------------------------------
# NOTE: llx and lly must be enclosed by curly brackets
############################################################################
# set custom_halo_l 5
# set custom_halo_t 5
# set custom_halo_r 5
# set custom_halo_b 5

# set custom_halo_lc 3.15

# set LC_MRAM_PDM_IO_x [expr $left_offset + ($pad_height - $pad_offsets) + $mram_halo_l + 86.4 + 22*75.595 - 62.16 - 2.4 - 15.845]
# set LC_MRAM_PDM_IO_y [expr $mram_y_end + $mram_halo_t - $custom_halo_b - $custom_halo_t + 3.5]

# set HEADER_0P8V_MRAMVDD_x [expr $left_offset + ($pad_height - $pad_offsets) + $mram_halo_l + 250 + $LC_L2H_3P3_w]
# set HEADER_0P8V_MRAMVDD_y [expr $mram_y_end + $mram_halo_t - $custom_halo_b - $custom_halo_t + 3.5]
# set HEADER_0P8V_SMALL_MRAMVDD_x [expr $left_offset + ($pad_height - $pad_offsets) + $mram_halo_l + 250 + $LC_L2H_3P3_w - 81.55 + 6]
# set HEADER_0P8V_SMALL_MRAMVDD_y [expr $mram_y_end + $mram_halo_t - $custom_halo_b - $custom_halo_t + 3.5]

# set HEADER_0P8V_MRAMVDDS_x [expr $HEADER_0P8V_MRAMVDD_x + $HEADER_0P8V_MRAMVDD_w + 120.2]
# set HEADER_0P8V_MRAMVDDS_y [expr $mram_y_end + $mram_halo_t - $custom_halo_b - $custom_halo_t + 3.5]
# set HEADER_0P8V_SMALL_MRAMVDDS_x [expr $HEADER_0P8V_MRAMVDD_x + $HEADER_0P8V_MRAMVDD_w + 120.2 - 71.1 + 1.19]
# set HEADER_0P8V_SMALL_MRAMVDDS_y [expr $mram_y_end + $mram_halo_t - $custom_halo_b - $custom_halo_t + 3.5]

# set LC_MRAM_VDIO_x [expr $HEADER_0P8V_MRAMVDDS_x + $HEADER_0P8V_MRAMVDDS_w + 101.9]
# set LC_MRAM_VDIO_y [expr $mram_y_end + $mram_halo_t - $custom_halo_b - $custom_halo_t + 3.5]
# set HEADER_3P3V_MRAMVDIO_x [expr $LC_MRAM_VDIO_x + $LC_L2H_3P3_w + $custom_halo_l + $custom_halo_r]
# set HEADER_3P3V_MRAMVDIO_y [expr $mram_y_end + $mram_halo_t - $custom_halo_b - $custom_halo_t + 3.5]

# set HEADER_3P3V_SMALL_MRAMVDIO_x [expr $LC_MRAM_VDIO_x + $LC_L2H_3P3_w + $custom_halo_l + $custom_halo_r + 515.1 + 11.1 + 8.34]
# set HEADER_3P3V_SMALL_MRAMVDIO_y [expr $mram_y_end + $mram_halo_t - $custom_halo_b - $custom_halo_t + 3.5]
# set LC_MRAM_SMALL_VDIO_x [expr $LC_MRAM_VDIO_x + $LC_L2H_3P3_w + $custom_halo_l + $custom_halo_r + 515.1 - 38.5 - 17.345]
# set LC_MRAM_SMALL_VDIO_y [expr $mram_y_end + $mram_halo_t - $custom_halo_b - $custom_halo_t + 3.5]

# set CLK_GEN_NE_x [expr $transform_mem_x_end + 5 - 7.68 - 1.705 - 66.045 - 15 + 81.04]
# set CLK_GEN_NE_y [expr $mram_y_start - $SRAM_512x128_h * 0.75 + 10 - 20.66 + 17.5]

# set CLK_GEN_MRAM_x [expr $local_act_mem_x_start + 2.5 - 1.33 - 66.045 - 15 - 0.4]
# set CLK_GEN_MRAM_y [expr $mram_y_start - $SRAM_512x128_h * 0.75 + 10 - 20.66 + 17.5]

# set inst_custom_list [list \
#     HEADER_0P8V_MRAMVDD  u_HEADER_0P8V_MRAMVDD                  R0 {$HEADER_0P8V_MRAMVDD_x}     {$HEADER_0P8V_MRAMVDD_y} $custom_halo_lc \
#     HEADER_0P8V_SMALL_MRAMVDD  u_HEADER_0P8V_SMALL_MRAMVDD      R0 {$HEADER_0P8V_SMALL_MRAMVDD_x}     {$HEADER_0P8V_SMALL_MRAMVDD_y} $custom_halo_lc \
#     HEADER_0P8V_MRAMVDDS u_HEADER_0P8V_MRAMVDDS                 R0 {$HEADER_0P8V_MRAMVDDS_x}    {$HEADER_0P8V_MRAMVDDS_y} $custom_halo_lc \
#     HEADER_0P8V_SMALL_MRAMVDDS u_HEADER_0P8V_SMALL_MRAMVDDS     R0 {$HEADER_0P8V_SMALL_MRAMVDDS_x}    {$HEADER_0P8V_SMALL_MRAMVDDS_y} $custom_halo_lc \
#     HEADER_3P3V_MRAMVDIO u_HEADER_3P3V_MRAMVDIO                 R0 {$HEADER_3P3V_MRAMVDIO_x}    {$HEADER_3P3V_MRAMVDIO_y} $custom_halo_lc \
#     HEADER_3P3V_SMALL_MRAMVDIO u_HEADER_3P3V_SMALL_MRAMVDIO     R0 {$HEADER_3P3V_SMALL_MRAMVDIO_x}    {$HEADER_3P3V_SMALL_MRAMVDIO_y} $custom_halo_lc \
#     LC_MRAM_PDM_IO       u_ne_scan/u_ne_top/u_LC_L2H_3P3_PDM_IO R0 {$LC_MRAM_PDM_IO_x}          {$LC_MRAM_PDM_IO_y} $custom_halo_lc \
#     LC_MRAM_VDIO         u_LC_L2H_3P3_MRAM_VDIO_PGEN            R0 {$LC_MRAM_VDIO_x}            {$LC_MRAM_VDIO_y} $custom_halo_lc \
#     LC_MRAM_SMALL_VDIO   u_LC_L2H_3P3_MRAM_SMALL_VDIO_PGEN      R0 {$LC_MRAM_SMALL_VDIO_x}      {$LC_MRAM_SMALL_VDIO_y} $custom_halo_lc \
#     CLK_GEN_NE           u_NE_clk_gen/u_CLK_GEN_CORE            R0 {$CLK_GEN_NE_x}              {$CLK_GEN_NE_y} $custom_halo_b \
#     CLK_GEN_MRAM         u_MRAM_clk_gen/u_CLK_GEN_CORE          R0 {$CLK_GEN_MRAM_x}            {$CLK_GEN_MRAM_y}  $custom_halo_b \
# ]
# foreach {my_name my_inst my_ro my_xl my_yb my_custom_halo} $inst_custom_list {
#     placeInstance ${my_inst} [expr ${my_xl}] [expr ${my_yb}] ${my_ro} -fixed
#     addHaloToBlock $custom_halo_l $custom_halo_t $custom_halo_r $my_custom_halo ${my_inst}
#     set ${my_name}_xl [expr [dbGet [dbGetInstByName ${my_inst}].box_llx]]
#     set ${my_name}_yb [expr [dbGet [dbGetInstByName ${my_inst}].box_lly]]
#     set ${my_name}_xr [expr [dbGet [dbGetInstByName ${my_inst}].box_urx]]
#     set ${my_name}_yt [expr [dbGet [dbGetInstByName ${my_inst}].box_ury]]
# }

# # Fix Halos for WELL TAP and END CAP alignment
# addHaloToBlock 5.3 $custom_halo_t $custom_halo_r $custom_halo_b u_MRAM_clk_gen/u_CLK_GEN_CORE
# addHaloToBlock 2.2 $halo_t $halo_r $halo_b u_ne_scan/u_ne_top/u_ne_controller/fcl_weight_memory/fcl_weight_memory_macro/banks_0__groups_1__SRAM_1024x110
# addHaloToBlock $halo_l $halo_t 2.32 $halo_b u_ne_scan/u_ne_top/u_ne_controller/fcl_bias_memory/banks_1__fcl_bias_memory_bank
# addHaloToBlock 2.32 $halo_t $halo_r $halo_b u_ne_scan/u_ne_top/u_ne_controller/fcl_weight_memory/fcl_weight_memory_macro/banks_0__groups_2__SRAM_1024x110



# placeinstance bb0 200 4 R0 -fixed
# placeinstance bd0 11889.7 7951.751 R0 -fixed
# placeinstance txtop0 12006.936 9734.435 R0 -fixed
# placeinstance mp0 12775.189 8249.441  MX -fixed
# placeinstance gf0 12685 1500  R0 -fixed