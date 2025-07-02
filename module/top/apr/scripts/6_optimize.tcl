############################################################################
# TCL script for Innovus 21.10 (MEMv1)
# Clock, Route, Optimization
#---------------------------------------------------------------------------
# Author: Hyunwon Chung
# Last Updated: Feb 14 2025
############################################################################

############################################################################
# POST-ROUTE OPTIMIZATION
############################################################################

# setOptMode -setupTargetSlack 0.0
# setOptMode -holdTargetSlack 0.0

setOptMode -addInst true -addInstancePrefix postroute_setup0_
optDesign -postRoute -prefix postroute_setup0 -outDir ${report_dir}
timeDesign -postRoute -numPaths 200

setOptMode -addInst true -addInstancePrefix postroute_hold0_
optDesign -postRoute -hold -prefix postroute_hold0 -outDir ${report_dir}
timeDesign -postRoute -hold -numPaths 200

setOptMode -addInst true -addInstancePrefix postroute_setup1_
optDesign -postRoute -prefix postroute_setup1 -outDir ${report_dir}
timeDesign -postRoute -numPaths 200

setOptMode -addInst true -addInstancePrefix postroute_hold1_
optDesign -postRoute -hold -prefix postroute_hold1 -outDir ${report_dir}
timeDesign -postRoute -hold -numPaths 200

setOptMode -addInst true -addInstancePrefix postroute_setup2_
optDesign -postRoute -prefix postroute_setup2 -outDir ${report_dir}
timeDesign -postRoute -numPaths 200

setOptMode -addInst true -addInstancePrefix postroute_hold2_
optDesign -postRoute -hold -prefix postroute_hold2 -outDir ${report_dir}
timeDesign -postRoute -hold -numPaths 200

