set num_cpus 16
set_host_options -max_cores $num_cpus


set CURRENT_PATH [getenv CURRENT_PATH]
set DESIGN_PATH [getenv DESIGN_PATH]
set DESIGN_NAME [getenv DESIGN_NAME]

set SCRIPTS_PATH $CURRENT_PATH/scripts
set REPORT_PATH  $CURRENT_PATH/reports
set OUTPUT_PATH  $CURRENT_PATH/data

###################################
###
### Loading common settings ...
###
###################################
source -verbose $SCRIPTS_PATH/0_common.tcl

###################################
###
### Loading technology settings ...
###
###################################
source -verbose $SCRIPTS_PATH/1_technology_tsmc28.tcl

###################################
###
### Loading verilog source files...
###
###################################
source -verbose $SCRIPTS_PATH/2_read_verilog.tcl

###################################
###
### Loading constraints files...
###
###################################
source -verbose $SCRIPTS_PATH/3_constraints.tcl
check_design
report_ideal_network

###################################
###
### Start synthesis...
###
###################################
compile_ultra -no_boundary_optimization -no_seq_output_inversion -no_autoungroup 
#-gate_clock

######### Fix min violations ######
set_fix_hold [all_clocks]
check_design

###################################
###
### writing outputs ...
###
###################################
set verilogout_show_unconnectes_pins true
change_names -rule verilog -hierarchy
# Rename modules, signals according to the naming rules
# Used for tool exchange
source -verbose $SCRIPTS_PATH/4_namingrules.tcl

# Generate structural verilog netlist
write -hierarchy -format verilog -output "${OUTPUT_PATH}/${DESIGN_NAME}.nl.v"
write            -format svsim   -output "${OUTPUT_PATH}/${DESIGN_NAME}_svsim.sv" [get_attribute [current_design] name]
# Generate Standard Delay Format (SDF) file
write_sdf -context verilog "${OUTPUT_PATH}/${DESIGN_NAME}.dc.sdf"

# Write SDC
write_sdc -nosplit -version 2.0 "${OUTPUT_PATH}/${DESIGN_NAME}.sdc"

# Write DDC
write_file -format ddc -hierarchy -output "${OUTPUT_PATH}/${DESIGN_NAME}.ddc"

report_constraint -all_violators -verbose > ${REPORT_PATH}/${DESIGN_NAME}_constraint_violators.rpt
report_timing -path full -delay max -max_paths 30 -nworst 100 > ${REPORT_PATH}/${DESIGN_NAME}_timing.rpt
report_resources -hierarchy > ${REPORT_PATH}/${DESIGN_NAME}_resources.rpt
report_area -hierarchy > ${REPORT_PATH}/${DESIGN_NAME}_area.rpt
report_net > ${REPORT_PATH}/${DESIGN_NAME}_nets.rpt
report_cell > ${REPORT_PATH}/${DESIGN_NAME}_cells.rpt
report_power -hierarchy > ${REPORT_PATH}/${DESIGN_NAME}_power.rpt
check_timing > ${REPORT_PATH}/${DESIGN_NAME}_check_timing.rpt
exit
