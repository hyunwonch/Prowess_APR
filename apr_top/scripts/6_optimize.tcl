############################################################################
# TCL script for Innovus 21.10 (MEMv1)
# Clock, Route, Optimization
#---------------------------------------------------------------------------
# Author: Yejoong Kim
# Edit  : Hyunwon Chung
# Last Updated: Feb 14 2025
############################################################################

############################################################################
# POST-ROUTE OPTIMIZATION
############################################################################

# setOptMode -setupTargetSlack 0.0
# setOptMode -holdTargetSlack 0.0

setOptMode -addInst true -addInstancePrefix POSTROUTE_SETUP0_
optDesign -postRoute -prefix POSTROUTE_SETUP0 -outDir ${report_dir}
timeDesign -postRoute -numPaths 200

setOptMode -addInst true -addInstancePrefix POSTROUTE_HOLD0_
optDesign -postRoute -hold -prefix POSTROUTE_HOLD0 -outDir ${report_dir}
timeDesign -postRoute -hold -numPaths 200

setOptMode -addInst true -addInstancePrefix POSTROUTE_SETUP1_
optDesign -postRoute -prefix POSTROUTE_SETUP1 -outDir ${report_dir}
timeDesign -postRoute -numPaths 200

setOptMode -addInst true -addInstancePrefix POSTROUTE_HOLD1_
optDesign -postRoute -hold -prefix POSTROUTE_HOLD1 -outDir ${report_dir}
timeDesign -postRoute -hold -numPaths 200

setOptMode -addInst true -addInstancePrefix POSTROUTE_SETUP2_
optDesign -postRoute -prefix POSTROUTE_SETUP2 -outDir ${report_dir}
timeDesign -postRoute -numPaths 200

setOptMode -addInst true -addInstancePrefix POSTROUTE_HOLD2_
optDesign -postRoute -hold -prefix POSTROUTE_HOLD2 -outDir ${report_dir}
timeDesign -postRoute -hold -numPaths 200

