###########################################################################
# TCL script for Innovus 21.10
# Main
#---------------------------------------------------------------------------
# Author: Hyunwon Chung
# Last Updated: Feb 16 2025
############################################################################

############################################################################
# MAIN IMPLEMENTATION
############################################################################

# Initialization
source ./scripts/0_init.tcl
saveDesign db/${top_level}.init.enc

# Process & Multi-Process
setDesignMode -process $process_node
setMultiCpuUsage -acquireLicense $num_cpu -localCpu $num_cpu

# Floorplan
source ./scripts/2_0_floorplan.tcl
saveDesign db/${top_level}.floorplan.enc

# # Power Routing
# source ./scripts/power.tcl
# saveDesign db/${top_level}.power.enc

# Place Design
source ./scripts/3_place.tcl
saveDesign db/${top_level}.place.enc

## Clock, Route, Optimization
source ./scripts/4_cts.tcl
saveDesign db/${top_level}.cts.enc

source ./scripts/5_route.tcl
saveDesign db/${top_level}.route.enc

source ./scripts/6_optimize.tcl
saveDesign db/${top_level}.optimize.enc

## Physical Cells
source ./scripts/7_physical.tcl
saveDesign db/${top_level}.physical.enc

# Verification and Output
source ./scripts/8_final.tcl
saveDesign db/${top_level}.final.enc

# Make netlist files and check report
#make cdl
#make check
######################################
# FINISH
######################################
puts "***************************"
puts "*                         *"
puts "* Innovus Script Finished *"
puts "*                         *"
puts "***************************"

win