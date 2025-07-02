############################################################################
# TCL script for Innovus 21.10
# Verification and Output
#---------------------------------------------------------------------------
# Author: Hyunwon Chung
# Last Updated: Feb 14 2025
############################################################################

############################################################################
# VERIFICATION
############################################################################
# Note: For 20nm or below, use verify_drc along with verifyGeometry
#       For 28nm or above, use verifyGeometry alone.


verifyGeometry -reportAllCell -noRoutingBlkg -noMinArea -noOverlap -report ${report_dir}/${top_level}.geom.rpt
#verify_drc -reportAllCell -noRoutingBlkg -noMinArea -noOverlap -report ${top_level}.drc.rpt
verifyconnectivity -noantenna -report ${report_dir}/${top_level}.conn.rpt
verifyprocessantenna -report ${report_dir}/${top_level}.antenna.rpt
verify_drc -report ${report_dir}/${top_level}.drc.rpt

############################################################################
# OUTPUT
############################################################################
setAnalysisMode -skew true -warn false -checkType hold
report_timing > ${report_dir}/final_hold_timing.rpt
report_timing -max_paths 1000 > ${report_dir}/full_hold_timing.rpt

setAnalysisMode -skew true -warn false -checkType setup
report_timing > ${report_dir}/final_setup_timing.rpt
report_timing -max_paths 1000 > ${report_dir}/full_setup_timing.rpt


timeDesign -prefix signoff \
    -signoff \
    -reportOnly \
    -outDir ${report_dir}
timeDesign -prefix signoff \
    -signoff \
    -reportOnly \
    -hold \
    -outDir ${report_dir}

foreach pgNet "VSS VDD" {
    set stripe [dbGet -i 0 -p1 [dbGet [dbGet -p1 top.nets.name $pgNet].sWires].shape followpin]
    createPGPin $pgNet -net $pgNet \
                    -geom [dbGet $stripe.layer.name] \
                    [dbGet $stripe.box_llx] \
                    [dbGet $stripe.box_lly] \
                    [expr [dbGet $stripe.box_llx] + [dbGet head.mfgGrid]] \
                    [expr [dbGet $stripe.box_lly] + [dbGet head.mfgGrid]]

}


set lefDefOutVersion 5.8 ;# Default=5.8
defOut ${output_dir}/${top_level}.def -floorplan -routing
write_lef_abstract ${output_dir}/${top_level}.lef -specifyTopLayer 7 -stripePin -PGpinLayers {7} -cutObsMinSpacing

saveNetlist -excludeLeafCell -excludeCellInst ${antenna_cells} ${output_dir}/${top_level}.apr.v

saveNetlist \
        -excludeLeafCell \
        -phys	\
        -includePowerGround \
        -excludeCellInst ${exclude_cells} \
        ${output_dir}/${top_level}.apr.pg.v

# -excludeTopCellPGPort ${internal_vdd_names}  \


saveNetlist \
        -excludeLeafCell \
        -phys \
        -excludeCellInst ${exclude_cells}   \
        ${output_dir}/${top_level}.apr.lvs.v \


streamOut ${output_dir}/${top_level}.gds \
    -mapFile ${map_file} \
    -libName ${top_level} \
    -structureName ${top_level} \
    -units 2000 \
    -mode ALL

setUseDefaultDelayLimit 10000
write_sdf -version 3.0 -max_view maxAnalysis -min_view minAnalysis \
    -process 1::1 -temperature 0::125 -voltage 1.32::1.08 \
    -target_application verilog ${output_dir}/${top_level}.apr.sdf

## Generate .lib
set_analysis_view -setup {maxAnalysis} -hold {minAnalysis maxAnalysis}
do_extract_model -pg -view maxAnalysis ${output_dir}/${top_level}.lib

## Miscellaneous Reports
reportFanoutViolation -all -outfile ${report_dir}/report_fanout_viol.rpt
reportGateCount -outfile ${report_dir}/${top_level}_gateCount.rpt
# reportClockTree -postRoute -macromodel ${report_dir}/report_clock_postroute.ctsmdl
summaryReport -noHtml -outfile ${report_dir}/${top_level}_summaryReport.rpt
report_constraint -check_type clock_period -all_violators > ${report_dir}/${top_level}_clock_period_constraint.rpt


# Define the directory to search
set directory "$report_dir"

# Get the list of .gz files in the directory
set gz_files [glob -nocomplain -directory $directory *.gz]

# Check if there are any .gz files
if {[llength $gz_files] > 0} {
    gzip -df $report_dir/*.gz
} else {
    puts "No .gz files found in $directory"
}

puts "**************************************"
puts "*                                    *"
puts "*   Innovus script finished          *"
puts "*                                    *"
puts "**************************************"
