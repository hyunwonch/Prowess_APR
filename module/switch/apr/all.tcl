###########################################################################
# TCL script for Innovus 15.21 (MEMv1)
# Main
#---------------------------------------------------------------------------
# Author: Yejoong Kim
# Edit  : Pierre Abillama
# Last Updated: Dec 10 2021
############################################################################

############################################################################
# MAIN IMPLEMENTATION
############################################################################

# Initialization
source ./scripts/0_init.tcl
saveDesign db/${top_level}.init.enc
# restoreDesign db/${top_level}.init.enc.dat ${top_level}

# Process & Multi-Process
setDesignMode -process $process_node
setMultiCpuUsage -acquireLicense $num_cpu -localCpu $num_cpu

# Floorplan
source ./scripts/2_0_floorplan.tcl
saveDesign db/${top_level}.floorplan.enc
# restoreDesign db/${top_level}.floorplan.enc.dat ${top_level}

# # Power Routing
# source ./scripts/power.tcl
# saveDesign db/${top_level}.power.enc
# #restoreDesign db/${top_level}.power.enc.dat ${top_level}

# Place Design
source ./scripts/3_place.tcl
saveDesign db/${top_level}.place.enc
# restoreDesign db/${top_level}.place.enc.dat ${top_level}

## Clock, Route, Optimization
source ./scripts/4_cts.tcl
saveDesign db/${top_level}.cts.enc
# restoreDesign db/${top_level}.cts.enc.dat ${top_level}

source ./scripts/5_route.tcl
saveDesign db/${top_level}.route.enc
# restoreDesign db/${top_level}.route.enc.dat ${top_level}

source ./scripts/6_optimize.tcl
saveDesign db/${top_level}.optimize.enc
# restoreDesign db/${top_level}.optimize.enc.dat ${top_level}

## Physical Cells
source ./scripts/7_physical.tcl
saveDesign db/${top_level}.physical.enc
# restoreDesign db/${top_level}.physical.enc.dat ${top_level}

# Verification and Output
source ./scripts/8_final.tcl
saveDesign db/${top_level}.final.enc
# restoreDesign db/${top_level}.final.enc.dat ${top_level}

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