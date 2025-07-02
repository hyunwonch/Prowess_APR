############################################################################
# TCL script for Innovus 21.10
# Power Routing
#---------------------------------------------------------------------------
# Author: Hyunwon Chung
# Last Updated: Apr 10 2025
############################################################################


clearGlobalNets

############################################################################
# GLOBAL NET CONNECTIONS
############################################################################
# Connect Global Nets
proc myConnectGlobalNets {} \
{
    globalNetConnect VSS 		-type pgpin -pin VSS 	-inst *         -verbose -override
    globalNetConnect VDD 	    -type pgpin -pin VDD 	-inst *         -verbose -override

    # SRAMs
    globalNetConnect VDD_SRAM 	-type pgpin -pin VDD 	-inst {mem*}  	-verbose -override

}
myConnectGlobalNets


applyGlobalNets

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
