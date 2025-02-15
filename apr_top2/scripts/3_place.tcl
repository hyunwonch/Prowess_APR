############################################################################
# TCL script for Innovus 15.21 (MEMv1)
# Placement
#---------------------------------------------------------------------------
# Author: Yejoong Kim
# Edit: Pierre Abillama
# Last Updated: Jan 12 2022
############################################################################
# Place Options
setPlaceMode -congEffort high
setPlaceMode -timingDriven true -maxDensity 0.5
# Trial Route Options
setTrialRouteMode -maxRouteLayer 10
setTrialRouteMode -minRouteLayer 2
set_dont_use [get_lib_cells {GPG*}]

# Add well tap
addEndCap -prefix ENDCAP -preCap BOUNDARY_LEFTBWP30P140 -postCap BOUNDARY_RIGHTBWP30P140
# addEndCap -prefix ENDCAP_PD0P8_CLK -preCap ENDCAPTIE3_A7PP140ZTS_C30 -postCap ENDCAPTIE3_A7PP140ZTS_C30 -powerDomain PD_0P8_CLK
addWellTap -cell TAPCELLBWP30P140 -prefix WELLTAP -cellInterval 25 -checkerBoard
# addWellTap -cell FILLTIE5_A7PP140ZTS_C30 -prefix WELLTAP_PD0P8_CLK -cellInterval 25 -checkerBoard -powerDomain PD_0P8_CLK


# Optimization Options
setOptMode -verbose true
setOptMode -restruct false
setOptMode -addPortAsNeeded false
setOptMode -honorFence true
setOptMode -fixFanoutLoad true
setOptMode -enableDataToDataChecks true

setOptMode -setupTargetSlack 0.1
setOptMode -holdTargetSlack 0.1


# Timing Analysis Options
#--- Note: (IMPOPT-6080) AAE-SI Optimization can only be turned on when the timing analysis mode is set to OCV.
setDelayCalMode -engine aae -SIAware true -reportOutBound true
setAnalysisMode -analysisType onChipVariation -cppr both
setExtractRCMode -engine preRoute

# Place the Standard Cells
timeDesign -prePlace -prefix PREPLACE_SETUP0_ -outDir ${report_dir}
place_opt_design -prefix PLACE_SETUP0_ -out_dir ${report_dir}
congRepair

timeDesign -preCTS -numPaths 200
timeDesign -preCTS -hold -numPaths 200

# Add TIEHI / TIELO Cells
# setTieHiLoMode -cell "TIEHI_X1M_A7PP140ZTS_C30 TIELO_X1M_A7PP140ZTS_C30" -createHierPort false -prefix tiehilo_svt_ -maxDistance 500 -maxFanout 32
# addTieHiLo -cell "TIEHI_X1M_A7PP140ZTS_C30 TIELO_X1M_A7PP140ZTS_C30" -powerDomain PD_0P8_NE
# addTieHiLo -cell "TIEHI_X1M_A7PP140ZTS_C30 TIELO_X1M_A7PP140ZTS_C30" -powerDomain PD_0P8_CLK
