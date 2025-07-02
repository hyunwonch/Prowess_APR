############################################################################
# TCL script for Innovus 21.10
# Clock, Route, Optimization
#---------------------------------------------------------------------------
# Author: Hyunwon CHung
# Last Updated: Apr 08 2025
############################################################################

############################################################################
# CLOCK TREE SYNTHESIS
############################################################################

# Optimization Options
setOptMode -verbose true
setOptMode -restruct false
setOptMode -addPortAsNeeded false
setOptMode -honorFence true
setOptMode -fixFanoutLoad true
setOptMode -enableDataToDataChecks true
setOptMode -usefulskew true
set_interactive_constraint_modes typConst

setDelayCalMode -engine aae -SIAware true -reportOutBound true
setAnalysisMode -analysisType onChipVariation -cppr both
setExtractRCMode -engine preRoute
extractRC

add_ndr -name CTS_1W2S -spacing_multiplier {M1:M8 2}
add_ndr -name CTS_1W1S
create_route_type -name top_rule -non_default_rule CTS_1W2S -top_preferred_layer M7 -bottom_preferred_layer M6 -shield_net VSS
create_route_type -name trunk_rule -non_default_rule CTS_1W2S -top_preferred_layer M5 -bottom_preferred_layer M4
create_route_type -name leaf_rule -non_default_rule CTS_1W1S -top_preferred_layer M3 -bottom_preferred_layer M2


set_ccopt_mode -cts_opt_priority insertion_delay \
               -cts_opt_type full \
			   -cts_target_skew 1.5

set_ccopt_property inverter_cells $clk_svt_inv_cells
set_ccopt_property use_inverters true
set_ccopt_property -net_type top route_type top_rule
set_ccopt_property -net_type trunk route_type trunk_rule
set_ccopt_property -net_type leaf route_type leaf_rule
set_ccopt_property routing_top_min_fanout 10000

set_ccopt_effort   -high


# Automatically extract sink pin types
create_ccopt_clock_tree_spec -file ${ccopt_file}

# Clock Tree Synthesis
source ${ccopt_file}
report_ccopt_clock_trees -file pre_ccopt.rpt -histograms -list_special_pins -no_invalidate
ccopt_design -prefix cts_setup_ -outDir ${report_dir}
report_ccopt_clock_trees -file post_ccopt.rpt -histograms -list_special_pins -no_invalidate
report_ccopt_skew_groups > post_cts_skewgroups.rpt

# Post-CTS Optimization
setOptMode -addInst true -addInstancePrefix POSTcts_hold_
optDesign -postCTS -prefix cts_setup0 -outDir ${report_dir}
optDesign -postCTS -hold -prefix cts_hold0 -outDir ${report_dir}

timeDesign -postCTS -numPaths 200
timeDesign -postCTS -hold -numPaths 200 

report_ccopt_skew_groups > ${report_dir}/post_opt_cts_skewgroups.rpt

