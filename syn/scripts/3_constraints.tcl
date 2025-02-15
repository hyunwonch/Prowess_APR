#***********************************************
# Global Definitions
#***********************************************
set		CLK_PERIOD  0.9
set		CLK_HIGH_TIME	0.72

set		register_input_delay		0.1
set		register_output_delay		0.1

set     typical_wire_load 0.2
set     clk_port "clk"
set     clk_name "clk"

#***********************************************
# Creating Clocks
#***********************************************
create_clock [get_ports clk] \
                -name       "clk" \
                -period     $CLK_PERIOD

set_clock_uncertainty -setup 0.05 [all_clocks]
set_clock_uncertainty -hold  0.1 [all_clocks]
set_clock_latency 0 [all_clocks]
set_clock_transition 0.2 [all_clocks]
set_ideal_network [all_clocks]

#***********************************************
# define environment attributes
#***********************************************
set_max_fanout  32 $DESIGN_NAME
set_max_transition 0.4 $DESIGN_NAME
set_max_capacitance 0.35 $DESIGN_NAME

set_input_delay $register_input_delay  -clock $clk_name [all_inputs]
remove_input_delay [get_ports clk]

set_output_delay $register_output_delay -clock $clk_name [all_outputs]
set_dont_touch_network [all_clocks]

set_false_path -through [get_nets -hier *rst_n*]
# set_false_path -through [get_nets -hier *wablm*]
# set_false_path -through [get_nets -hier *wabl*]
# set_false_path -through [get_nets -hier *rawlm*]
# set_false_path -through [get_nets -hier *rawl*]
# set_false_path -through [get_nets -hier *emas*]
# set_false_path -through [get_nets -hier *emaw*]
# set_false_path -through [get_nets -hier *ema*]
# set_false_path -through [get_nets -hier *stov*]
# set_wire_load_mode "segmented"

set_load $typical_wire_load [all_outputs]
set_leakage_optimization true


set_fix_hold [all_clocks]
# set_fix_multiple_port_nets -all -buffer_constants
set_fix_multiple_port_nets -all -buffer_constants [get_designs *]
#*********************************************
# apply timing exception for MRAM
#*********************************************
# if 0 {
#     # set_attr use_tiehilo_for_const 0
#     set timing_apply_default_primary_input_assertion false
#     #disable eFlash LIB timing check
#     set timing_enable_non_sequential_checks true
#     set timing_enable_multiple_clocks_per_reg true
#     #disable unnecessary timing checks in eFlash IP
#     # these timing paths are controlled by tester program
#     set_case_analysis 0 [get_pins mram/tmc_top/tmc_regif/op_reg_reg[30]/Q]
#     set_case_analysis 0 [get_pins mram/tmc_top/tmc_regif/op_reg_reg[15]/Q]

#     set_case_analysis 0 [get_pins mram/mram_inst/TRIM_WRITE]
#     set_case_analysis 0 [get_pins mram/mram_inst/WRITE]
#     set_case_analysis 0 [get_pins mram/mram_inst/WRITE0]
#     set_case_analysis 0 [get_pins mram/mram_inst/WRITE1]
#     set_case_analysis 1 [get_pins mram/mram_inst/READ]

#     set_input_delay 3.0 -clock $clk_name [get_ports { i_MRAM_scan_en i_MRAM_scan_test }]

#     set_false_path -from {mram/bist_enable}

#     set_false_path -from mram/mram_inst/SR_CLK -through mram/tmc_top/tmc_rw/col_repair/*
#     set_false_path -from mram/mram_inst/SR_CLK -through mram/tmc_top/tmc_rw/bist_ecc2_decode/*

#     set_multicycle_path 1 -hold -to mram/mram_inst/XADR[*] -through {mram/tmc_top/tmc_rw/* mram/tmc_top/tmc_ctrl/*}
#     set_multicycle_path 1 -hold -to mram/mram_inst/YADR[*] -through {mram/tmc_top/tmc_rw/* mram/tmc_top/tmc_ctrl/*}
#     set_multicycle_path 1 -hold -to mram/mram_inst/BADR[*] -through {mram/tmc_top/tmc_rw/* mram/tmc_top/tmc_ctrl/*}
#     set_multicycle_path 1 -hold -to mram/mram_inst/BADR[*] -through {mram/tmc_top/tmc_rw/* mram/tmc_top/tmc_ctrl/*}
#     set_multicycle_path 1 -hold -to mram/mram_inst/IFREN1 -through {mram/tmc_top/tmc_rw/* mram/tmc_top/tmc_ctrl/*}

#     #Multicycle design for critical path

#     #set mult_cycle_read 5
#     #set_multicycle_path $mult_cycle_read -setup -from mram/mram_inst/CLK -to [get_cells mram/tmc_top/tmc_rw/bank/ind_reg*]
#     #set_multicycle_path [expr $mult_cycle_read - 1] -hold  -from mram/mram_inst/CLK -to [get_cells mram/tmc_top/tmc_rw/bank/ind_reg*]
#     #set_multicycle_path $mult_cycle_read -setup -from mram/mram_inst/CLK -through mram/mram_inst/DOUT*
#     #set_multicycle_path [expr $mult_cycle_read - 1] -hold -from mram/mram_inst/CLK -through mram/mram_inst/DOUT*
#     #set_multicycle_path $mult_cycle_read -setup -from mram/mram_inst/CLK -through mram/mram_inst/DOUT_RDY
#     #set_multicycle_path [expr $mult_cycle_read - 1] -hold -from mram/mram_inst/CLK -through mram/mram_inst/DOUT_RDY


#     #set_dont_touch [get_cells mram/tmc_top/tmc_if/u_DNT*]
#     #set_dont_touch [get_cells mram/tmc_top/tmc_rw/u_DNT*]
#     #set_dont_touch [get_cells mram/tmc_top/clk_*/u_DNT*]
# }
