############################################################################
# TCL script for Innovus 21.10
# Clock, Route, Optimization
#---------------------------------------------------------------------------
# Author: Hyunwon Chung
# Last Updated: Apr 08 2025
############################################################################

############################################################################
# ROUTE
############################################################################

# setAttribute -net I_PAD_TM_ANA[0] -non_default_rule CTS_1W2S
# setAttribute -net I_PAD_TM_ANA[1] -non_default_rule CTS_1W2S

# Optimization Options
setOptMode -verbose true
setOptMode -restruct false
setOptMode -addPortAsNeeded false
setOptMode -honorFence true
setOptMode -fixFanoutLoad true
setOptMode -enableDataToDataChecks true

# Timing Analysis Options
setDelayCalMode -engine aae -SIAware true -reportOutBound true
setAnalysisMode -analysisType onChipVariation -cppr both
setExtractRCMode -engine postRoute -effortLevel medium
extractRC

# Set the Routing Options
setNanoRouteMode -routeWithTimingDriven true
#setNanoRouteMode -routeConcurrentMinimizeViaCountEffort high
setNanoRouteMode -routeWithSiDriven true
setNanoRouteMode -routeSiEffort max

##via cut
setNanoRouteMode -routeConcurrentMinimizeViaCountEffort high
setNanoRouteMode -drouteUseMultiCutViaEffort low
#setNanoRouteMode -droutePostRouteSwapVia multiCut
setNanoRouteMode -routeWithViaInPin false
setNanoRouteMode -routeWithViaInPin 1:1
setNanoRouteMode -routeWithViaOnlyForStandardCellPin "1:1"
setNanoRouteMode -routeInsertAntennaDiode true
setNanoRouteMode -envNumberFailLimit 12
setNanoRouteMode -routeBottomRoutingLayer 2
setNanoRouteMode -routeTopRoutingLayer 7
setNanoRouteMode -routeWithSiPostRouteFix true
setNanoRouteMode -routeHonorPowerDomain false
setNanoRouteMode -routeMergeSpecialWire true
setNanoRouteMode -routeAntennaCellName ${antenna_cells}
setNanoRouteMode -routeSelectedNetOnly false

setNanoRouteMode -drouteFixAntenna true
setNanoRouteMode -drouteAutoStop false
setNanoRouteMode -drouteHonorStubRuleForBlockPin true
setNanoRouteMode -drouteSearchAndRepair true

# Route

setPGPinUseSignalRoute -all
setPGPinUseSignalRoute *:BIASNW
routePGPinUseSignalRoute -all
routeDesign

