############################################################################
# TCL script for Innovus 15.21 (MEMv1)
# Power Routing
#---------------------------------------------------------------------------
# Author: Yejoong Kim
# Edit: Pierre Abillama
# Last Updated: Jan 10 2022
############################################################################


clearGlobalNets

############################################################################
# GLOBAL NET CONNECTIONS
############################################################################
# Connect Global Nets
proc myConnectGlobalNets {} \
{
    # SRAMs
    globalNetConnect VDD                -type pgpin -pin VDDPE      -inst *mem*      -override -verbose
    globalNetConnect VSS                -type pgpin -pin VSSE       -inst *mem*      -override -verbose

}
myConnectGlobalNets

# # Connect Pads
# proc myConnectPads {} \
# {
#     # Signal Pads
#     globalNetConnect VSS                -type pgpin -pin VSS        -inst *u_PAD*                       -verbose -override
#     globalNetConnect VSS                -type pgpin -pin VSSPST     -inst *u_PAD*                       -verbose -override

#     globalNetConnect VDD0P8_NE          -type pgpin -pin VDD        -inst *u_PAD*                       -verbose -override
#     globalNetConnect VDD0P8_CLK         -type pgpin -pin VDD        -inst *CLK_GEN_L*                   -verbose -override
#     globalNetConnect VDD0P8_CLK         -type pgpin -pin VDD        -inst *_clk_gen_en                  -verbose -override
#     globalNetConnect VDD0P8_CLK         -type pgpin -pin VDD        -inst VDDCLK_L*                     -verbose -override
#     globalNetConnect VDD0P8_CLK         -type pgpin -pin VDD        -inst DVDDCLK_L*                    -verbose -override
#     globalNetConnect VDD0P8_CLK         -type pgpin -pin VDD        -inst CVSSCLK_L*                    -verbose -override
#     globalNetConnect VDD0P8_CLK         -type pgpin -pin VDD        -inst CVDDCLK_L*                    -verbose -override
#     globalNetConnect VDD0P8_CLK         -type pgpin -pin VDD        -inst RN_CVDDCLK_L*                    -verbose -override

#     globalNetConnect DVDD0P8_NE         -type pgpin -pin VDDPST     -inst *u_PAD*                       -verbose -override
#     globalNetConnect DVDD0P8_CLK        -type pgpin -pin VDDPST     -inst *CLK_GEN_L*                   -verbose -override
#     globalNetConnect DVDD0P8_CLK        -type pgpin -pin VDDPST     -inst *_clk_gen_en                  -verbose -override
#     globalNetConnect DVDD0P8_CLK        -type pgpin -pin VDDPST     -inst CVDDCLK_L*                    -verbose -override
#     globalNetConnect DVDD0P8_CLK        -type pgpin -pin VDDPST     -inst RN_CVDDCLK_L*                    -verbose -override
#     globalNetConnect DVDD0P8_CLK        -type pgpin -pin VDDPST     -inst DVDDCLK_L*                    -verbose -override
#     globalNetConnect DVDD0P8_CLK        -type pgpin -pin VDDPST     -inst RN_DVDDCLK_L*                    -verbose -override
#     globalNetConnect DVDD0P8_CLK        -type pgpin -pin VDDPST     -inst CVSSCLK_L*                    -verbose -override
#     globalNetConnect DVDD0P8_CLK        -type pgpin -pin VDDPST     -inst VDDCLK_L*                     -verbose -override

#     globalNetConnect VDDPOC0P8_NE       -type pgpin -pin POC        -inst *u_PAD*                       -verbose -override
#     globalNetConnect VDDPOC0P8_CLK      -type pgpin -pin POC        -inst *CLK_GEN_L*                   -verbose -override
#     globalNetConnect VDDPOC0P8_CLK      -type pgpin -pin POC        -inst *_clk_gen_en                  -verbose -override
#     globalNetConnect VDDPOC0P8_CLK      -type pgpin -pin POC        -inst CVDDCLK_L*                    -verbose -override
#     globalNetConnect VDDPOC0P8_CLK      -type pgpin -pin POC        -inst RN_CVDDCLK_L*                    -verbose -override
#     globalNetConnect VDDPOC0P8_CLK      -type pgpin -pin POC        -inst DVDDCLK_L*                    -verbose -override
#     globalNetConnect VDDPOC0P8_CLK      -type pgpin -pin POC        -inst RN_DVDDCLK_L*                    -verbose -override
#     globalNetConnect VDDPOC0P8_CLK      -type pgpin -pin POC        -inst CVSSCLK_L*                    -verbose -override
#     globalNetConnect VDDPOC0P8_CLK      -type pgpin -pin POC        -inst VDDCLK_L*                     -verbose -override

#     # TIEHI, TIELO in Pads
#     globalNetConnect VDD0P8_NE          -type tiehi                 -inst *u_PAD*                       -verbose -override
#     globalNetConnect VDD0P8_CLK         -type tiehi                 -inst *CLK_GEN_L*                   -verbose -override
#     globalNetConnect VDD0P8_CLK         -type tiehi                 -inst *_clk_gen_en                  -verbose -override
#     globalNetConnect VDD0P8_CLK         -type tiehi                 -inst CVDDCLK_L*                    -verbose -override
#     globalNetConnect VDD0P8_CLK         -type tiehi                 -inst RN_CVDDCLK_L*                    -verbose -override
#     globalNetConnect VDD0P8_CLK         -type tiehi                 -inst DVDDCLK_L*                    -verbose -override
#     globalNetConnect VDD0P8_CLK         -type tiehi                 -inst RN_DVDDCLK_L*                    -verbose -override
#     globalNetConnect VDD0P8_CLK         -type tiehi                 -inst CVSSCLK_L*                    -verbose -override
#     globalNetConnect VDD0P8_CLK         -type tiehi                 -inst VDDCLK_L*                     -verbose -override
#     globalNetConnect VSS                -type tielo                 -inst *u_PAD*                       -verbose -override

#     # Power Supply Pads
#     globalNetConnect VSS                -type pgpin -pin AVSS       -inst VSS_L*                        -verbose -override
#     globalNetConnect VSS                -type pgpin -pin AVSS       -inst VSS_EXTRA_L*                  -verbose -override
#     globalNetConnect VDD0P8_NE          -type pgpin -pin AVDD       -inst VDDNE_L*                      -verbose -override
#     globalNetConnect VDD0P8_SRAM        -type pgpin -pin AVDD       -inst VDDSRAM_L*                    -verbose -override
#     globalNetConnect VDD0P8_NE          -type pgpin -pin AVDD       -inst VDDNE_EXTRA_L*                -verbose -override
#     globalNetConnect VDD0P8_SRAM        -type pgpin -pin AVDD       -inst VDDSRAM_EXTRA_L*              -verbose -override
#     globalNetConnect VDD0P8_CLK         -type pgpin -pin AVDD       -inst VDDCLK_L*                     -verbose -override
#     globalNetConnect VDD3P3_MRAMVDIO    -type pgpin -pin AVDD       -inst VDDIO_V_L*                    -verbose -override
#     globalNetConnect VDD3P3_MRAMVDIO    -type pgpin -pin AVDD       -inst VDDIO_H_L*                    -verbose -override

#     # Analog Pads
#     globalNetConnect AVDD               -type pgpin -pin TACVDD     -inst *u_PAD*                       -verbose -override
#     globalNetConnect AVSS               -type pgpin -pin TACVSS     -inst *u_PAD*                       -verbose -override
#     globalNetConnect AVDD               -type pgpin -pin TACVDD     -inst u_PAD_MRAM_TMANA*             -verbose -override
#     globalNetConnect AVSS               -type pgpin -pin TACVSS     -inst u_PAD_MRAM_TMANA*             -verbose -override
#     globalNetConnect AVDD               -type pgpin -pin TACVDD     -inst u_PAD_CAV*                    -verbose -override
#     globalNetConnect AVSS               -type pgpin -pin TACVSS     -inst u_PAD_CAV*                    -verbose -override
# }
# myConnectPads

applyGlobalNets

# # Rings

# setAddRingMode -ring_target stripe -avoid_short 1
# setSrouteMode -blockPinRouteWithPinWidth true

# proc myAddCoreRing {ringWidth ringSpacing met1 met2} \
# {
#     global VSS_NETS
#     global VDD_NETS

#     set coreSupplies "VDD0P8_MRAMVDD_PG VDD0P8_MRAMVDDS_PG VDD3P3_MRAMVDIO_PG VDD0P8_SRAM VDD3P3_MRAMVDIO VDD0P8_CLK VDD0P8_NE VSS"
#     addRing \
#         -type core_rings \
#         -around default_power_domain \
#         -nets ${coreSupplies} \
#         -center 1 \
#         -width $ringWidth \
#         -spacing $ringSpacing \
#         -layer "top $met2 bottom $met2 left $met1 right $met1" \
#         -rectangle 1
# }

# # Core M2 stripes for core
# myAddCoreRing $ring_width $ring_space M3 M4
# myAddCoreRing $ring_width $ring_space M5 M4
# myAddCoreRing $ring_width $ring_space M5 M6
# myAddCoreRing $ring_width $ring_space M5 M8
# myAddCoreRing $ring_width $ring_space M7 M8
# myAddCoreRing $ring_width $ring_space M9 M8

# myConnectGlobalNets
# myConnectPads
############################################################################
# PAD SROUTE
############################################################################
# sroute -connect padPin -padPinPortConnect allGeom -allowJogging 0 -padPinLayerRange {2 2} \
#     -nets {VDD0P8_NE VDD0P8_SRAM VDD0P8_CLK VDD3P3_MRAMVDIO VSS}

############################################################################
# PAD Filler
############################################################################

# # Left
# addIoFiller -cell PFILLER20     -prefix u_PAD_FILLER -side w
# addIoFiller -cell PFILLER10     -prefix u_PAD_FILLER -side w
# addIoFiller -cell PFILLER5      -prefix u_PAD_FILLER -side w
# addIoFiller -cell PFILLER1      -prefix u_PAD_FILLER -side w
# addIoFiller -cell PFILLER05     -prefix u_PAD_FILLER -side w
# addIoFiller -cell PFILLER0005    -prefix u_PAD_FILLER -side w -fillAnyGap

# # Right
# addIoFiller -cell PFILLER20     -prefix u_PAD_FILLER -side e
# addIoFiller -cell PFILLER10     -prefix u_PAD_FILLER -side e
# addIoFiller -cell PFILLER5      -prefix u_PAD_FILLER -side e
# addIoFiller -cell PFILLER1      -prefix u_PAD_FILLER -side e
# addIoFiller -cell PFILLER05     -prefix u_PAD_FILLER -side e
# addIoFiller -cell PFILLER0005    -prefix u_PAD_FILLER -side e -fillAnyGap

# # Top
# addIoFiller -cell PFILLER20     -prefix u_PAD_FILLER -side n
# addIoFiller -cell PFILLER10     -prefix u_PAD_FILLER -side n
# addIoFiller -cell PFILLER5      -prefix u_PAD_FILLER -side n
# addIoFiller -cell PFILLER1      -prefix u_PAD_FILLER -side n
# addIoFiller -cell PFILLER05     -prefix u_PAD_FILLER -side n
# addIoFiller -cell PFILLER0005    -prefix u_PAD_FILLER -side n -fillAnyGap

# set ana_cut_start 732
# set ana_cut_end 1102

# # Bottom
# # Digital
# addIoFiller -to $ana_cut_start -cell PFILLER20     -prefix u_PAD_FILLER -side s
# addIoFiller -to $ana_cut_start -cell PFILLER10     -prefix u_PAD_FILLER -side s
# addIoFiller -to $ana_cut_start -cell PFILLER5      -prefix u_PAD_FILLER -side s
# addIoFiller -to $ana_cut_start -cell PFILLER1      -prefix u_PAD_FILLER -side s
# addIoFiller -to $ana_cut_start -cell PFILLER05     -prefix u_PAD_FILLER -side s
# addIoFiller -to $ana_cut_start -cell PFILLER0005    -prefix u_PAD_FILLER -side s -fillAnyGap
# # Analog
# addIoFiller -from $ana_cut_start -to $ana_cut_end -cell PFILLER20A     -prefix u_PAD_FILLER -side s
# addIoFiller -from $ana_cut_start -to $ana_cut_end -cell PFILLER10A     -prefix u_PAD_FILLER -side s
# addIoFiller -from $ana_cut_start -to $ana_cut_end -cell PFILLER5A      -prefix u_PAD_FILLER -side s
# addIoFiller -from $ana_cut_start -to $ana_cut_end -cell PFILLER1A      -prefix u_PAD_FILLER -side s
# addIoFiller -from $ana_cut_start -to $ana_cut_end -cell PFILLER05A     -prefix u_PAD_FILLER -side s
# addIoFiller -from $ana_cut_start -to $ana_cut_end -cell PFILLER0005A    -prefix u_PAD_FILLER -side s -fillAnyGap
# # Digital
# addIoFiller -from $ana_cut_start -cell PFILLER20     -prefix u_PAD_FILLER -side s
# addIoFiller -from $ana_cut_start -cell PFILLER10     -prefix u_PAD_FILLER -side s
# addIoFiller -from $ana_cut_start -cell PFILLER5      -prefix u_PAD_FILLER -side s
# addIoFiller -from $ana_cut_start -cell PFILLER1      -prefix u_PAD_FILLER -side s
# addIoFiller -from $ana_cut_start -cell PFILLER05     -prefix u_PAD_FILLER -side s
# addIoFiller -from $ana_cut_start -cell PFILLER0005    -prefix u_PAD_FILLER -side s -fillAnyGap

############################################################################
# STRIPES & RINGS
############################################################################

source ./scripts/2_stripes.tcl

############################################################################
# CUSTOM BLOCK SROUTE
############################################################################

# setSrouteMode -blockPinRouteWithPinWidth true

############################################################################
# CPF
############################################################################
myConnectGlobalNets

verifyPowerDomain
# read_power_intent -cpf ${cpf_file}

# set ::CPF::useHierScript 1
# #-- Max Delay Corner (Setup Analysis)
# update_delay_corner -name maxDelay \
#     -power_domain PD_0P8_NE -library_set {svtMaxLib sramMaxLib}

# update_delay_corner -name maxDelay \
#     -power_domain PD_0P8_CLK -library_set {svtMaxLib}

# #-- Min Delay Corner (Hold Analysis)
# update_delay_corner -name minDelay \
#     -power_domain PD_0P8_NE -library_set {svtMinLib sramMinLib}

# update_delay_corner -name minDelay \
#     -power_domain PD_0P8_CLK -library_set {svtMinLib}

commit_power_intent -verbose

myConnectGlobalNets
############################################################################
# POWER DOMAIN LOCATION
############################################################################
# set CLK_GEN_NE_x [expr $transform_mem_x_end]
# # LEFT
# set PD0P8_xl0 [expr $left_offset + ($pad_height - $pad_offsets)]
# set PD0P8_xr0 [expr $CLK_GEN_NE_x - $custom_halo_l]
# set PD0P8_yb0 [expr $bottom_offset + ($pad_height - $pad_offsets)]
# set PD0P8_yt0 [expr $y_dim - ($top_offset + $pad_height + $pad_offsets)]

# # RIGHT
# set PD0P8_xl1 [expr $CLK_GEN_NE_x + $CLK_GEN_CORE_w + $custom_halo_r + 30.2 + 5 - 1.3]
# set PD0P8_xr1 [expr $x_dim - ($right_offset + $pad_height + $pad_offsets)]
# set PD0P8_yb1 [expr $bottom_offset + ($pad_height - $pad_offsets)]
# set PD0P8_yt1 [expr $y_dim - ($top_offset + $pad_height + $pad_offsets)]

# # MIDDLE
# set PD0P8_xl2 [expr $CLK_GEN_NE_x - $custom_halo_l]
# set PD0P8_xr2 [expr $CLK_GEN_NE_x + $CLK_GEN_CORE_w + $custom_halo_r + 30.2 + 5]
# set PD0P8_yb2 [expr $bottom_offset + ($pad_height - $pad_offsets) + 20 + 5]
# set PD0P8_yt2 [expr $y_dim - ($top_offset + $pad_height + $pad_offsets)]

# set PD0P8_CLK_xl0 [expr $CLK_GEN_NE_x - $custom_halo_l + 5]
# set PD0P8_CLK_xr0 [expr $CLK_GEN_NE_x + $CLK_GEN_CORE_w + $custom_halo_r + 30.2 - 1.3]
# set PD0P8_CLK_yb0 [expr $bottom_offset + ($pad_height - $pad_offsets)]
# set PD0P8_CLK_yt0 [expr $bottom_offset + ($pad_height - $pad_offsets) + 20]

# setObjFPlanBoxList     Group PD_0P8_CLK        $PD0P8_CLK_xl0 $PD0P8_CLK_yb0 $PD0P8_CLK_xr0 $PD0P8_CLK_yt0

# setObjFPlanBoxList     Group PD_0P8_NE         $PD0P8_xl0 $PD0P8_yb0 $PD0P8_xr0 $PD0P8_yt0 \
#                                                $PD0P8_xl1 $PD0P8_yb1 $PD0P8_xr1 $PD0P8_yt1 \
#                                                $PD0P8_xl2 $PD0P8_yb2 $PD0P8_xr2 $PD0P8_yt2
# verifyPowerDomain
# reportPowerDomain -file ${report_dir}/${top_level}_power_domain.rpt

# selectObject Group PD_0P8_CLK
# globalNetConnect VSS -type pgpin -pin VSS  -inst * -powerDomain PD_0P8_CLK -override
# globalNetConnect VDD0P8_CLK -type pgpin -pin VDD -inst * -powerDomain PD_0P8_CLK -override
# globalNetConnect VDD0P8_CLK -type pgpin -pin BIASNW -inst * -powerDomain PD_0P8_CLK -override
# globalNetConnect VDD0P8_CLK -type pgpin -pin VNW -inst * -powerDomain PD_0P8_CLK -override
# globalNetConnect VSS -type pgpin -pin VPW -inst * -powerDomain PD_0P8_CLK -override
# myConnectGlobalNets
# myConnectPads
# deselectAll

# selectObject Group PD_0P8_NE
# globalNetConnect VSS -type pgpin -pin VSS  -inst * -powerDomain PD_0P8_NE -override
# globalNetConnect VDD0P8_NE -type pgpin -pin VDD -inst * -powerDomain PD_0P8_NE -override
# globalNetConnect VDD0P8_NE -type pgpin -pin BIASNW -inst * -powerDomain PD_0P8_NE -override
# globalNetConnect VDD0P8_NE -type pgpin -pin VNW -inst * -powerDomain PD_0P8_NE -override
# globalNetConnect VSS -type pgpin -pin VPW -inst * -powerDomain PD_0P8_NE -override
# myConnectGlobalNets
# myConnectPads
# deselectAll

# myConnectGlobalNets
# myConnectPads

# cutRow -area [expr $PD0P8_CLK_xl0 - 4.72 - 0.14] [expr 156.6 + 16] [expr $PD0P8_CLK_xr0 + 4.82] [expr 161 + 16]
# createPlaceBlockage -box [expr $PD0P8_CLK_xl0 - 4.72 - 0.14] [expr 156.6 + 16] [expr $PD0P8_CLK_xr0 + 4.82] [expr 161 + 16]
# createRouteBlk -box [expr $PD0P8_CLK_xl0 - 4.72 - 0.14] [expr 156.6 + 16] [expr $PD0P8_CLK_xr0 + 4.82] [expr 161 + 16] -layer {M1 M2 M3 M4 M5 M6}

# cutRow -area [expr $PD0P8_CLK_xl0 - 4.72 - 0.14] [expr ${PD0P8_yb0}] [expr $PD0P8_CLK_xl0 - 0.22] [expr 161 + 16]
# createPlaceBlockage -box [expr $PD0P8_CLK_xl0 - 4.72 - 0.14] [expr ${PD0P8_yb0}] [expr $PD0P8_CLK_xl0 - 0.22] [expr 161 + 16]
# createRouteBlk -box [expr $PD0P8_CLK_xl0 - 4.72 - 0.14] [expr ${PD0P8_yb0}] [expr $PD0P8_CLK_xl0 - 0.22] [expr 161 + 16] -layer {M1 M2 M3 M4 M5 M6}

# cutRow -area [expr $PD0P8_CLK_xr0 + 0.12] [expr ${PD0P8_yb0}] [expr $PD0P8_CLK_xr0 + 4.82] [expr 161 + 16]
# createPlaceBlockage -box [expr $PD0P8_CLK_xr0 + 0.12] [expr ${PD0P8_yb0}] [expr $PD0P8_CLK_xr0 + 4.82] [expr 161 + 16]
# createRouteBlk -box [expr $PD0P8_CLK_xr0 + 0.12] [expr ${PD0P8_yb0}] [expr $PD0P8_CLK_xr0 + 4.82] [expr 161 + 16] -layer {M1 M2 M3 M4 M5 M6}

############################################################################
# POWER DOMAIN VDD SROUTE
############################################################################
# sroute -nets {VDD0P8_NE}   -connect corePin -powerDomains PD_0P8_NE -allowLayerChange 0 -allowJogging 0 -crossoverViaLayerRange {M1 M7} -targetViaLayerRange {M1 M7} -corePinTarget none
# sroute -nets {VSS}         -connect corePin -powerDomains PD_0P8_NE -allowLayerChange 0 -allowJogging 0 -crossoverViaLayerRange {M1 M7} -targetViaLayerRange {M1 M7} -corePinTarget none

# sroute -nets {VDD0P8_CLK}  -connect corePin -powerDomains PD_0P8_CLK -allowLayerChange 0 -allowJogging 0 -crossoverViaLayerRange {M1 M7} -targetViaLayerRange {M1 M7} -corePinTarget none
# sroute -nets {VSS}         -connect corePin -powerDomains PD_0P8_CLK -allowLayerChange 0 -allowJogging 0 -crossoverViaLayerRange {M1 M7} -targetViaLayerRange {M1 M7} -corePinTarget none

# setSrouteMode -reset
# setMultiCpuUsage -localCpu $num_cpu

# myConnectGlobalNets
# myConnectPads
