############################################################################
# TCL script for Innovus 21.10
# Physical Cells
#---------------------------------------------------------------------------
# Author: Hyunwon Chung
# Last Updated: Feb 14 2025
############################################################################

############################################################################
# FILLER CELLS
############################################################################
# addFiller -cell ${svt_fillcap_cells} -prefix FILLCAP_PD0P8_NE -powerDomain PD_0P8_NE
# addFiller -cell ${svt_fillcap_cells} -prefix FILLCAP_PD0P8_CLK -powerDomain PD_0P8_CLK
# addFiller -cell ${svt_filler_cells} -prefix FILL_PD0P8_NE -powerDomain PD_0P8_NE
# addFiller -cell ${svt_filler_cells} -prefix FILL_PD0P8_CLK -powerDomain PD_0P8_CLK

# setFillerMode -core ${svt_filler_cells} -corePrefix FILL
# addFiller
addFiller -cell ${svt_fillcap_cells} -prefix FILLCAP
addFiller -cell ${svt_filler_cells} -prefix FILLCELL

fixVia -minCut
fixVia -minStep
fixVia -short

clearDrc
verifyGeometry -error 1000000000
verifyConnectivity -type regular -error 1000000 -warning 500000
verifyProcessAntenna -error 1000000
detailRoute -fix_drc
############################################################################
# METAL FILL
############################################################################

deleteRouteBlk -all
