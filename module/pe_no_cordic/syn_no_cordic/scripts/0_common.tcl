# common.tcl setup library files

# if {$synopsys_program_name == "icc_shell"} {
#     source -echo -verbose $SCRIPTS_PATH/suppress_icc.tcl
#     set mw_use_allowable_orientation true
#     set SYNOPSYS_DIR /afs/engin.umich.edu/caen/rhel_5/synopsys-icc-[get_unix_variable SW_SYNICC]
# } else {
#     source -echo -verbose $SCRIPTS_PATH/suppress_dc.tcl
#     if {$synopsys_program_name == "dc_shell"} {
#         # put useless files in the work directory
#         define_design_lib WORK -path "/tmp/SJ"
#         set SYNOPSYS_DIR /afs/engin.umich.edu/caen/rhel_5/synopsys-synth-[get_unix_variable SW_SYNOPSYS]
#     }
# }

# enable multicore
set NO_HOST_CORES [exec cat /proc/cpuinfo | grep -c processor]

if {[expr $NO_HOST_CORES >= 16]} {
    set NO_HOST_CORES 14
} elseif {[expr $NO_HOST_CORES <= 2]} {
    set NO_HOST_CORES 1
} else {
    incr NO_HOST_CORES -2
}

set_host_options -max_cores $NO_HOST_CORES

set designer                              "Hyunwon"

set case_analysis_with_logic_constants    "true"
set timing_enable_multiple_clocks_per_reg "true"
set enable_recovery_removal_arcs          "true"
set power_keep_tns                        "true"

set hdlin_latch_always_async_set_reset    "true"
set hdlin_auto_save_templates             "true"
set hdlout_internal_busses                "true"
set verilogout_single_bit                 "false"
set verilogout_no_tri                     "true"
set bus_inference_style                   {%s[%d]}
set bus_naming_style                      {%s[%d]}
set link_force_case                       "check_reference"
set bus_dimension_separator_style         "\]\["
set duplicate_ports                       "false"
set single_group_per_sheet                "true"
set write_name_nets_same_as_ports         "true"
set verilogout_equation                   "false"
set hdl_preferred_license                 verilog
#set_fix_multiple_port_nets -all -buffer_constants

#set optimize_reg_max_time_borrow 0

# put the cache in /tmp rather than home directory (~ is the default)
set cache_read                            "/tmp"
set cache_write                           "/tmp"
