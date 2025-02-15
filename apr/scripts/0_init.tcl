###########################################################################
# TCL script for Innovus 15.21 (NROv1)
# Initialization
#---------------------------------------------------------------------------
# Author: Yejoong Kim
# Edit  : Pierre Abillama
# Last Updated: Feb 15 2022
############################################################################

set layer_type  PE_prowess
set layer_name  PE_prowess
set top_level   ${layer_name}

# Directory Names
set CURRENT_PATH [pwd]
set VC_dir      /net/badwater/z/hyunwon/Documents/TSMC_Prowess/tsmc28
set verilog_dir ${VC_dir}/verilog
set apr_dir     ${VC_dir}/apr
set syn_dir     ${VC_dir}/syn
set mem_dir     ${VC_dir}/mem/lef
set tech_dir    ${VC_dir}/techfile
set lib_dir     ${VC_dir}/lib
set lef_dir     ${VC_dir}/lef
set innovus_dir ${apr_dir}/innovus/N28
set script_dir  ${apr_dir}/scripts
set report_dir  ${apr_dir}/reports
set output_dir  ${apr_dir}/output

# Process Node
set process_node 28

# Useful Functions
source ${innovus_dir}/sub_proc.tcl


# Message Suppression
suppressMessage IMPLF-58        ;# IMPLF-58 : MACRO '*' has been found in the database. Its content except DENSITY and PIN ANTENNA* data will be ignored.
suppressMessage IMPLF-61        ;# * duplicated MACRO definitions have been found in the LEF file(s). Their content except DENSITY and PIN ANTENNA* data have been ignored.
suppressMessage IMPPP-557       ;# A single-layer VIARULE GENERATE for turn-vias is obsolete and is being ignored. Remove this statement from the technology file: VIARULE TURN1 GENERATE.
suppressMessage TECHLIB-436     ;# Attribute 'max_fanout' on 'output/inout' pin '*' of cell '*' is not defined in the library.
suppressMessage TECHLIB-302     ;# No function defined for cell '*'. The cell will only be used for analysis.
suppressMessage IMPMSMV-3502    ;# Power net * is not associated with any power domain.
suppressMessage NRDB-1005       ;# Cannot establish connection to PIN * at (*) on * for NET *. The NET is considered partially routed. Visually verify wiring at the specified location as the wire/via origin may not touch the PIN. This NET will be rerouted with same or different wiring.
suppressMessage NRDB-682        ;# Connectivity is broken at PIN * of INST * connects to NET * at location (*) on LAYER *. The location is not inside the pin geometry extraction.
suppressMessage NRIG-44         ;# Imported NET * has LVS problem. The integrity of the wires will be checked. NanoRoute will continue. Check the net for FIXED or misaligned routing connections. If necessary, skip this net or delete the net routing.
suppressMessage SDF-802         ;# The sum of the Setup and Hold sides of the SETUPHOLD check on pin * is negative - which is illegal in SDF V3.0. The negative side of the SETUPHOLD will be postively adjusted so that the resulting sum is zero. This will result in a more conservative analysis of the adjusted check.  Negative SETUPHOLD sums maybe an indication of a characterization problem in your timing libraries. You can set the timing global timing_write_sdf_allow_negative_setuphold_sum to 'true' to loosen this restriction.


source -verbose ${script_dir}/1_globals.tcl

############################################################################
# TCL Globals
#---------------------------------------------------------------------------
#   For more information, run 'find_global' in Innovus
############################################################################

##--------------------------------------------------------------------------
## Import and Export Global Variables
##--------------------------------------------------------------------------

# Specify the defOut hierarchy delimiter.
set defHierChar {/}     ;# (String, default="", persistent)

# Specifies the source of the design netlist. You can specify either "Verilog" or "OA".
set init_design_netlisttype {Verilog}    ;# (String, default=Verilog, persistent)

# Path to MMMC View Definition file.
set init_mmmc_file "${script_dir}/viewDefinition.tcl"    ;# (String, default="", persistent)
#set init_cpf_file "${script_dir}/hyochan.apr.cpf"    ;# (String, default="", persistent)

# Path to I/O Constraint file.
set init_io_file "" ;# (String, default="", persistent)

# List of Verilog netlist files to be read.
set init_verilog ${verilog_file}    ;# (String, default="", persistent)

# List of LEF files to be read. Mutually exclusive with init_oa_ref_lib.
set init_lef_file ${lef_file}

# List of global Power nets.
set init_pwr_net ${vdd_names}    ;# (String, default="", persistent)

# List of global Ground nets.
set init_gnd_net ${gnd_names}    ;# (String, default="", persistent)

# Name of top module (used when reading Verilog netlist information only).
set init_top_cell ${top_level}

##--------------------------------------------------------------------------
## General Global Variables
##--------------------------------------------------------------------------

# enable verbose script source
set enc_source_verbose 0    ;# (Integer, default=0, persistent)

##--------------------------------------------------------------------------
## Floorplan Global Variables
##--------------------------------------------------------------------------

# If this variable is set to 1, create rows based on default power domain's
# site, not design's default site.
set fpHonorDefaultPowerDomainSite 1 ;# (Integer, default=0, persistent)

##--------------------------------------------------------------------------
## Delay Calculation Global Variables
##--------------------------------------------------------------------------

# set threshold to apply the default delay
set delaycal_use_default_delay_limit 1000   ;# (Integer, default=1000, persistent)

# set default net delay. The software uses this default values for nets that
# exceeds N terminals. (N = # specified in 'delaycal_use_default_delay_limit')
# Delay calculation is performed for nets with fewer than N terminals.
set delaycal_default_net_delay 1000ps   ;# (String, default=1000ps, persistent)

# set default net load. You can use this global variable to specify the default
# net load value that is used for nets that exceed N terminals.
# (N = # specified in 'delaycal_use_default_delay_limit')
set delaycal_default_net_load 1pf ;# (String, default=0.5pf, persistent)

# set default input transition time and the ideal clock transition time for delay
# calculation. The software uses this default transition time for nets that exceed
# N terminals. (N = # specified in 'delaycal_use_default_delay_limit')
set delaycal_input_transition_delay 0ps ;# (String, default=0ps, persistent)

# Enables support of Liberty wire-load models and related SDC commands.
set delaycal_support_wire_load_model 0  ;# (Integer, default=0, persistent)

##--------------------------------------------------------------------------
## Timing Global Variables
##--------------------------------------------------------------------------

# Enables clocks to be created in propagated mode
set timing_create_clock_default_propagated 1    ;# (Boolean, default=0, persistent)

# Considers clock uncertainty when performing clock checks.
set timing_enable_uncertainty_for_clock_checks 1    ;# (Boolean, default=0, persistent)

# When set to true, considers clock uncertainty when performing minimum
# pulse width checks
set timing_enable_uncertainty_for_pulsewidth_checks 1   ;# (Boolean, default=0, persistent)

# Specifies the type of slew propagation to use for generating extracted
# timing model
set timing_extract_model_slew_propagation_mode path_based_slew   ;# (Enum, default=worst_slew, range={worst_slew path_based_slew}, persistent)

# Controls whether network latency of a reference clock is added or not
# to the data arrival time on the port. When set to 'ideal', the 'set_input_delay' and the
# 'set_output_delay' constraints will not add the network latency of the reference clock
# to the data arrival time on the port if the clock is in 'propagated' mode.
# When this global is set to 'always', network latency is added to the data arrival time
# on the port regardless of the clock propagation mode.
#set timing_io_use_clock_network_latency ideal   ;# (Enum, default=ideal, range={always ideal}, persistent)

# Controls whether the report_timing reports are generated using the default
# orextended report header
set timing_report_timing_header_detail_info extended ;# (Enum, default=default, range={default extended}, persistent)

# enables clocks to be given in -from/to options in report_timing command
set timing_report_enable_clock_object_in_from_to 1  ;# (Boolean, default=0, persistent)

# Controls whether report_timing reports the detailed clock latency path
set timing_report_launch_clock_path 1   ;# (Boolean, default=0, persistent)

init_design

read_power_intent -cpf ./scripts/power_intent.cpf
commit_power_intent -keepRows
set_power_analysis_mode -analysis_view default_typical_view
timeDesign -preplace -prefix preplace

##--------------------------------------------------------------------------
## Ununsed variables: these have default values.
##--------------------------------------------------------------------------

## Specifies the diagonal length of the chip, in microns
#aocv_chip_size 1e+30    ;# (Double, default=1e+30, range={}, persistent)

## Specifies the diagonal length of the core area, in microns
#aocv_core_size 1e+30    ;# (Double, default=1e+30, range={}, persistent)

## Represents the top-level directory to store files/sub-directories 'auto-generated'
## by the tool.
#auto_file_dir ./    ;# (String, default=./, persistent)

## Represents the prefix to be applied to all files/sub-directories 'auto-generated'
## by the tool.
#auto_file_prefix "" ;# (String, default="", persistent)

## enables the automatic selection of wire load models based on the area
## of hierarchical blocks containing the nets
#auto_wire_load_selection 1  ;# (Boolean, default=1, persistent)

## System defined transient global referring to origin of restored design.
#cvd ""  ;# (String, default="", transient)

## Controls whether arcs from a tristate enable to a inferred as tristate
## enable and disable arcs if they are not explicitly specified by the Liberty
## timing_type attribute. This functionality is mainly to support older
## modeling styles in legacy libraries.
#dbgAllowInferredTriStateArcs 1  ;# (Integer, default=1, persistent)

## Controls whether single-edged setup and hold checks on asynchronous pins
## in the Liberty library are inferred as recovery and removal checks. This
## is mainly to support older modeling styles in legacy libraries.
#dbgConvertSetupHoldOnAsyncToRecRem 1    ;# (Integer, default=1, persistent)

## Controls how timing library numbers are internally scaled to database
## units. The default is 1/10 pS per DBU. To represent very large delay
##  numbers accurately this value can be increased as needed.  This variable
## should be set before timing libraries are read.
#dbgPicoSecPerDBU 0.1    ;# (Double, default=0.1, persistent)

## This variable controls whether or not redundant timing arcs (no retain
## or conditional variance) are supported.  This variable is obsolete and
## will be removed from future releases of the software.
#dbgUseDuplicateTimeArc 1    ;# (Integer, default=1, persistent)

## Use this variable to specify input file is a shape based DEF. DEF file
## generated by shape based router may contain overlapping routing. By default
## defIn will drop any overlapping wire segment. Set this variable to 1
## so defIn will do special treatment for overlapping wire segments.
#defInShapeBasedDefFile 0    ;# (Integer, default=0, transient)

## Output bump as an instance or a pin. Bump can be modelled as instance
## or pin. By default defOut writes out bump as instance. Set this variable
## to 0 to output bump as pin.
#defOutBumpAsInstance 1  ;# (Integer, default=1, persistent)

## Compress the via statement in SPECIALNETS section. This variable controls
## defOut to sort vias with two dimension array, so it can use 'DO numX
## BY numY STEP stepX stepY' statement.
#defOutCompressVia 0 ;# (Integer, default=0, persistent)

## Output LEF NONDEFAULTRULES in DEF. This variable controls defOut to output
## LEF nondefault rule information. By default, defOut does not write out
## nondefaultrules defined in LEF. Set this variable to 1 to output nondefault
## rules defined in LEF .
#defOutLefNDR 0  ;# (Integer, default=0, persistent)

## Output LEF vias in DEF. This variable controls defOut to output LEF via
## information. By default, defOut does not write out via defined in LEF.
## Set this variable to 1 to output LEF via.
#defOutLefVia 0  ;# (Integer, default=0, persistent)

## By default defOut writes out polygon DIEAREA if the design is rectilinear.
## To write out rectangular DIEAERA along with blockages in cut-out area
## for a rectilinear design, set this variable to 0.
#defOutPolygonDieArea 1  ;# (Integer, default=1, persistent)

## Report overlapping wires in specified file name. This variable specifies
## the file name for reporting overlapping wire segments. This variable
## can be used in conjunction with the defShapeBasedDefFile variable.
#defOverlapWireReportFileName "" ;# (String, default="", transient)

## Ignore the default net load for Ilm
#delaycal_default_net_load_ignore_for_ilm 0  ;# (Integer, default=0, persistent)

## For nets that are classified as high-fanout, determines whether slew
## degradation across the net should be calculated
#delaycal_degrade_slew_for_hi_elmore 1   ;# (Integer, default=1, persistent)

## set file name for definition of exclude nets.
#delaycal_exclude_net <UNDEFINED>    ;# (String, default=<UNDEFINED>, persistent)

## Controls whether slews are propagated across nets that have constant
## logic state due to tie-offs, or case analysis.
#delaycal_prop_slew_for_constant_net 1   ;# (Integer, default=1, persistent)

## Controls whether slews from disabled timing arcs are worst-case merged
## with the slews from active timing arcs.
#delaycal_prop_slew_for_disable_timing_net 0 ;# (Integer, default=0, persistent)

## Specifies the ratio of drive resistance to net resistance at which specialy
## handling of  early path delays is invoked.  When active, slews across
## early delay paths nets are not degraded.
#delaycal_rd_rnet_fraction_threshold 0   ;# (Double, default=0, persistent)

## Controls FEDC delay engine's handling of of nets with different driver
## and receiver library thresholds.
#delaycal_support_different_trip_points 1    ;# (Integer, default=1, persistent)

## Controls whether SignalStorm delay calculation respects Liberty pin capacitance
## ranges.  A '0' setting is only required for correlation with the FEDC
## delay engine.
#delaycal_support_min_max_pin_cap 1  ;# (Integer, default=1, persistent)

## Controls whether FEDC or SignalStorm delay engines respect Liberty rise_capacitance
## and fall_capacitance attributes. This global is for backward compatibilty.
#delaycal_support_rise_fall_pin_cap 1    ;# (Integer, default=1, persistent)

## Controls whether a separate inbound and outbound slew is maintained for
## bidirectional pins and ports.  This global is for backward compatibility.
#delaycal_support_separate_bidi_slew 1   ;# (Integer, default=1, persistent)

## set threshold to apply the elmore delay.
#delaycal_use_elmore_delay_limit 100 ;# (Integer, default=100, range={}, persistent)

## Sets the net delay upper limit (in nS) for switching to Elmore delay
## calculation for high-fanout nets.
#delaycal_use_elmore_delay_upper_threshold 10    ;# (Double, default=10, persistent)

## setting 'true' will preserve path specified in report command. User need
## to specify unique path for each view to avoid all clients writing to
## same report file. With default setting (false), distributed mmmc run
## automatically updates report paths to a view unique directory structure.
#distributed_mmmc_disable_reports_auto_redirection 0 ;# (String, default=false, persistent)

## Specifies whether nets would be renamed in eco report of ecoCompareNetlist
## for flat netlist.
#ecoDisableNetRenamingForFlatNetlist 0   ;# (Integer, default=0, persistent)

## Controls design metrics display
#encEnableMetric 1000    ;# (Integer, default=1000, range={}, persistent)

## Limits the number of characters printed to the .cmd file for any single
## command. As the variables are expanded by default when stored in the
## .cmd file the file can become quite large if a variable contains a very
## large list (examples of comamnds that can produce large lists are: dbGet
## and dbShape). A value of -1 indicates that there is no limit on the number
## of characters per command output to the .cmd file
#enc_cmd_length_limit 1000   ;# (Integer, default=1000, persistent)

## Used to control argument partial matching
#enc_partial_cmd_argument_matching quiet ;# (Enum, default=quiet, range={quiet warn error}, persistent)

## Specifies whether perform exhaustive validation of saved files to make
## session portable (default=false)
#enc_save_design_exhaustive_portable_mode 0  ;# (Boolean, default=0, persistent)

## Specifies whether design is saved in a portable manner or not (default=true)
#enc_save_portable_design 1  ;# (Boolean, default=1, persistent)

## Specifies whether timing constraints are always saved or not (default=false)
#enc_save_timing_constraints_always 0    ;# (Boolean, default=0, persistent)

## Display the file name being sourced before the actual sourcing.
#enc_source_echo_filename 0  ;# (Boolean, default=0, persistent)

## Enable/Disable 'source -verbose' to continue the script on TCL_ERROR.
#enc_source_verbose_continue_on_error 0  ;# (Boolean, default=0, persistent)

## Used to control how 'source -verbose' output is. Specifying 'echo' indicates
## that the output only include the command lines themselves. Specifying
## 'debug' indicates that the output will include file name, line number,
## and command.
#enc_source_verbose_output echo  ;# (Enum, default=echo, range={debug echo}, persistent)

## Limits the number of characters displayed to stdout and the .log file.
## The Tcl return value itself is not truncated. A value of -1 indicates
## that there is no display limit. Some commands that are likely to have
## longer Tcl return values are dbGet, dbShape, and history.
#enc_tcl_return_display_limit 10000  ;# (Integer, default=10000, persistent)

## Sets the shrink factor used by the extractRC command.(Double, default=1)
#extract_shrink_factor 1 ;# (Double, default=1, persistent)

## specify whether to save metalfill settings
#fill_setting_save 0 ;# (Integer, default=0, persistent)

## By default bumps are allowed to be edited (moved, deleted, reassigned,
## swapped). If this variable is set to FALSE, any bump edit command for
## a bump with routing connected to it will give an error message and fail.
#flipchip_allow_routed_bump_edit 1   ;# (Boolean, default=1, persistent)

## Specify the target domain of the shifter. Setting this variable to 1
## allows the shifter table to specify the target domain of the shifter
## to be in 3rd domain other than from and to domain.
#fpAllowShifterIn3rdPD 0 ;# (Integer, default=0, persistent)

## If this variable is set to 1, area of modules are including IO CELL.
## Otherwise it will NOT including. Defalut value is 0.
#fpIsCalculateIOCellWhenInitArea 0   ;# (Integer, default=0, persistent)

## Use maximum I/O height to calculate a die box with IO placement. By default
## minimum IO height is used. Set this variable to 1 to use maximum I/O
## height.
#fpIsMaxIoHeight 1   ;# (Integer, default=1, persistent)

## Snap core to multiple first horizontal and vertical routing layers.
#fpSnapCore 1    ;# (Integer, default=1, persistent)

## Specifies that the rows in the floorplan are vertical (1) or horizontal
## (0).
#fp_vertical_row 0   ;# (Integer, default=0, persistent)

## Name prefix for placeBlockage and routeBlockage
#fpgDefaultBlockageNamePrefix "" ;# (String, default="", persistent)

## Set it to 0(default value), will disable this feature. set it to 1, will
## make row box snap row height to odd.
#fpgOddEvenSitesHeightConstraint 0   ;# (Integer, default=0, persistent)

## Set it to 0(default value), will disable this feature. set it to 1, will
## make row snap row to ploy grid.
#fpgOddEvenSitesRowConstraint 0  ;# (Integer, default=0, persistent)

## List of OpenAccess view names to be processed as abstracts (LEF MACRO
## equivalent).
#init_abstract_view ""   ;# (String, default="", persistent)

## Stops the Verilog reader if any output (or inout) signal pins have any
## 1'b0 or 1'b1 constants that would cause shorts to power/ground.
#init_check_output_pin_constant 1    ;# (Boolean, default=1, persistent)

## Path to CPF file.
#init_cpf_file "${cpf_file}"    ;# (String, default="", persistent)

## Specifies whether the top cell name is automatically assigned {0}, or
## is set by the user {1}
#init_design_settop 1    ;# (Integer, default=1, persistent)

## Specifies whether the top is uniquified. When set to 1 (true) the design
## will be uniquified during the read and flatten process. Optimization
## is not allowed on a non-unique design. For use in a master/clone partitioning
## flow, the value should be 0 (false). Default = 0 (false).
#init_design_uniquify 0  ;# (Integer, default=0, persistent)

## List of leaf cell pin names to ignore power/ground pin polarity check.
## By default globalNetConnect and CPF check for matching polarity between
## the net and pin.
#init_ignore_pgpin_polarity_check "" ;# (String, default="", persistent)

## This string is passed to setImportMode command during initialization,
## for example {-keepEmptyModule 1}.
#init_import_mode "" ;# (String, default="", persistent)

## List of OpenAccess view names to be processed for cell layout viewing
## (GDSII equivalent).
#init_layout_view "" ;# (String, default="", persistent)

## List of OpenAccess reference libraries to be searched when cells are
## used in the design that are not included in the list of cells in the
## libraries specified in init_oa_ref_lib list.
#init_oa_search_lib ""    ;# (String, default=*, persistent)

## The default rule to be used in OpenAccess.
#init_oa_default_rule "" ;# (String, default="", persistent)

## OpenAccess design cell name to be used.
#init_oa_design_cell ""  ;# (String, default="", persistent)

## OpenAccess design lib name to be used.
#init_oa_design_lib ""   ;# (String, default="", persistent)

## OpenAccess design view name to be used.
#init_oa_design_view ""  ;# (String, default="", persistent)

## List of OpenAccess reference libraries. All cells are processed.
#init_oa_ref_lib ""  ;# (String, default="", persistent)

## The special rule to be used in OpenAccess for power routing.
#init_oa_special_rule "" ;# (String, default="", persistent)

## Replace the assign statements that are read from the Verilog netlist
## with buffers.
#init_remove_assigns 0   ;# (Boolean, default=0, persistent)

## Specifies whether new Instance ports can be created during Verilog netlist
## parsing.
#init_verilog_tolerate_port_mismatch 0   ;# (Integer, default=0, persistent)

## Specifies whether to remember a list of unused macros during saving
#inn_save_lef_ignore_abstracts 0 ;# (Boolean, default=0, persistent)

## Specify LEF/DEF output version. Possible string value are 5.6, 5.7 and
## 5.8. The default is 5.8.
#lefDefOutVersion 5.8    ;# (Enum, default=5.8, range={5.6 5.7 5.8}, persistent)

## Controls whether input to output arcs from the preset or clear pins transitioning
## to inactivestate are included when the timing system is initialized
#lib_build_asynch_de_assert_arc 1    ;# (Boolean, default=1, persistent)

## Creates a dummy .lib file and a user-defined noise model (UDN) for cells
## that are not present in the loaded .lib or cdB.
#load_netlist_ignore_undefined_cell 0    ;# (Integer, default=0, persistent)

## Enable pin spreading related commands to work on both horizontal and
## vertical edges simutaneously, irrespective of side
#ptn91EnableSpreadPinOnSide 1    ;# (Integer, default=1, persistent)

## Creates placement blockage only
#ptngCreatePlaceBlkOnly 0    ;# (Integer, default=0, persistent)

## To enable/disable converting special pins to stripes in assemble
#ptngKeepSpecialPin 0    ;# (Integer, default=0, persistent)

## Controls the number of digits appearing after the decimal point in the
## report_timing, report_net, report_cell_instance_timing, and report_clocks
## reports
#report_precision 3  ;# (Integer, default=3, range={}, persistent)

## Specifies a report_timing format
#report_timing_format instance arc cell delay arrival required   ;# (String, default=instance arc cell delay arrival required, persistent)

## Specifies a list of directory locations where the software should search
## for the timing libraries specified with the read_lib  command. When using
## this variable, you need not specify the absolute paths for the timing
## libraries in the  read_lib   command.
#search_path ""  ;# (String, default="", persistent)

## Width threshold in site-units for 'virtual' push-down of M3 stripe to
## M2 for M1 pin-access. Value of 0 means all M3 stripes will be pushed-down.
#spgM3StripePushDown -1  ;# (Integer, default=-1, persistent)

## Shrink the virtual M2 stripe (see spgM3StripePushDown) by given total
## site units, splitting value to each side, starting on left. e.g. value
## of 1 shrinks by 1 site on left, 2 shrinks by 1 site on each side, value
## of 3 shrinks 2 sites on left and 1 on right.
#spgM3StripeShrink 0 ;# (Integer, default=0, persistent)

## New Feed Thru algorithm
#tbgCorrelateMaxTranWithActualTran 0 ;# (Integer, default=0, persistent)

## tbgDistributedMMMCDeleteFolderAfterUse
#tbgDistributedMMMCDeleteFolderAfterUse 0    ;# (Integer, default=0, persistent)

## Ignore the missing clock transitions on boundary of block
#tbgIgnoreMissingClockTran 0 ;# (Integer, default=0, persistent)

## Intrapartition latencies in Model
#tbgIncludeIntraPtnLatenciesInModel 0    ;# (Integer, default=0, persistent)

## tbgPrototypeTiming
#tbgPrototypeTiming 0    ;# (Integer, default=0, persistent)

## Controls whether to include ICG cells as register in all_registers -edge_triggered
#timing_all_registers_include_icg_cells 1    ;# (Boolean, default=1, persistent)

## When set to true allows you to apply input delay constraints on a pin
## where a clock was previously asserted
#timing_allow_input_delay_on_clock_source 0  ;# (Boolean, default=0, persistent)

## Control delay precision 0.1ps or 0.01ps
#timing_analysis_precision_ps 0.1    ;# (Double, default=0.1, range={}, persistent)

## Controls handling of AOCV analysis modes
#timing_aocv_analysis_mode launch_capture    ;# (Enum, default=launch_capture, range={launch_capture clock_only separate_data_clock combine_launch_capture}, persistent)

## Controls the AOCV derating mode
#timing_aocv_derate_mode aocv_multiplicative ;# (Enum, default=aocv_multiplicative, range={aocv_multiplicative aocv_additive}, persistent)

## When set to true, the aocv stage counts are recalculated when timing
## is reset.
#timing_aocv_stage_count_recalculate_on_timing_reset 0   ;# (Boolean, default=0, persistent)

## Applies check derate to output external delay
#timing_apply_check_derate_to_external_output_delay 0    ;# (Boolean, default=0, persistent)

## When set to true, primary input and bidirectional ports that do not have
## an explicit arrival time specified are provided a default arrival time
#timing_apply_default_primary_input_assertion 1  ;# (Boolean, default=1, persistent)

## When set to true, any false path assertion which blocks the data path
## to the related (-from) pin of the data-to-data check also causes the
## check to be disabled
#timing_apply_exceptions_to_data_check_related_pin 0 ;# (Boolean, default=0, persistent)

## When set to true, includes hierarchical pins in the timing report
#timing_build_all_hierarchical_pins 0    ;# (Boolean, default=0, persistent)

## If set, this value is passed to setLibraryUnit -cap to set the capacitance
## units used in timing library and .sdc files and timing reports. Legal
## values are 1pf and 1ff.
#timing_cap_unit ""  ;# (String, default="", persistent)

# Determines whether constant propagation continues through integrated clock gating (ICG) cells
# timing_case_analysis_for_icg_propagation false    ;# (Enum, default=false, range={false require_seq_prop always}, persistent)

## When set to true, calculates constants on the outputs of sequential elements
#timing_case_analysis_for_sequential_propagation 0   ;# (Boolean, default=0, persistent)

## Lets you select appropriate clock phases at register clock pins when
## both positive and negative phases of the same clock signal are seen in
## the clock network
#timing_clock_phase_propagation both ;# (Enum, default=both, range={positive negative both}, persistent)

## When set to false, the create_clock command for output pins of cells
## uses default slew instead of the propagated slew from the primary input
## ports
#timing_clock_source_use_driving_cell 1  ;# (Boolean, default=1, persistent)

## Limits the number of objects of a collection to be displayed in the output
## report
#timing_collection_result_display_limit 100  ;# (Integer, default=100, persistent)

## When set to true, directs software to skip the error and continue processing
## when an error occurs during timing analysis
#timing_continue_on_error 0  ;# (Boolean, default=0, persistent)

## When set to true, removes clock reconvergence pessimism (CRP) for clock
## source paths
#timing_cppr_remove_clock_to_data_crp 0  ;# (Boolean, default=0, persistent)

## Controls mean delay component for CPPR credit for opposite transition
## edges at common pin
#timing_cppr_opposite_edge_mean_scale_factor 1   ;# (Double, default=1, range={}, persistent)

## Controls sigma delay component for CPPR credit for opposite transition
## edges at common pin
#timing_cppr_opposite_edge_sigma_scale_factor 1  ;# (Double, default=1, range={}, persistent)

## When set to true, the cppr of a timing path crossing a latch (or latches)
## is calculated using the common pin of its origin flop and the capture
## device at the end of the path. Oterhwise the usual segment-based cppr
## calculation is performed. This cppr setting is considered only when the
## latch thru analysis mode is enabled.
#timing_cppr_propagate_thru_latches 0    ;# (Boolean, default=0, persistent)

## When set to true in case of self-loop paths, computes CPPR adjustment
## by taking the difference between early and late clock arrival time of
## the common point
#timing_cppr_self_loop_mode 1    ;# (Boolean, default=1, persistent)

## Specifies the branch point to use for computing clock path pessimism
## removal (CPPR) adjustment when there is reconvergence in the clock tree
#timing_cppr_skip_clock_reconvergence 0  ;# (Boolean, default=0, persistent)

## Specifies the maximum amount of pessimism that clock path pessimism removal
## (CPPR) analysis is allowed to leave in the path
#timing_cppr_threshold_ps 20 ;# (Double, default=20, range={}, persistent)

## Specifies the transition sense of the launching and capturing clocksat
## the common node, to calculate clock path pessimism removal (CPPR)
#timing_cppr_transition_sense normal ;# (Enum, default=normal, range={normal same_transition same_transition_expanded}, persistent)

## timing_create_clock_use_ideal_slew
#timing_create_clock_use_ideal_slew 0    ;# (Boolean, default=0, persistent)

## When set to true, use default operating conditions for each lib
#timing_default_opcond_per_lib 1 ;# (Boolean, default=1, persistent)

## You can set the timing_defer_mmmc_object_updates global to true, so that
## the software allows a sequence of MMMC updates to be accumulated before
## new data is loaded and analyzed
#timing_defer_mmmc_object_updates 0  ;# (Boolean, default=0, persistent)

## This global controls whether or not  AOCV derating factors are applied
## to the dynamic, SI-induced delay component or not. With a value of '1',
##  the AOCV derating factor will be applied to both the static and dynamic
## components of the delay arc. When set to '0', the AOCV derate will only
## apply to the static component of the delay.
#timing_derate_aocv_dynamic_delays 1 ;# (Boolean, default=1, persistent)

## Allows specification of reference point for AOCV factors
#timing_derate_aocv_reference_point 1    ;# (Integer, default=1, range={}, persistent)

## This global controls how the set_timing_derate factors that are not specified
## using either -static or -dynamic options are applied to the delay.  When
## this global is set to '1' the behavior will be compatible with previous
## releases. In this mode,  the static and dynamic components will be summed
## before  applying derating.  With a setting of '0',  the static and dynamic
## components will be derated separately and then combined. A setting of
## '0' is equivalent to using separate derate assertions with  the -dynamic
## and -static options explicitly specified.
#timing_derate_dynamic_compatibility 1   ;# (Boolean, default=1, persistent)

## Allows specification of reference point for OCV factors
#timing_derate_ocv_reference_point 1 ;# (Integer, default=1, range={}, persistent)

## Set the distance unit.
#timing_derate_spatial_distance_unit default ;# (Enum, default=default, range={default 1um 1nm}, persistent)

## When set to false, timing checks on both the input and output sides of
## the bidirectional pin are analyzed
#timing_disable_bidi_output_timing_checks 1  ;# (Boolean, default=1, persistent)

## Checks for setup and hold violations in three-state bus designs
#timing_disable_bus_contention_check 0   ;# (Boolean, default=0, persistent)

## When set to true, disables all clock gating checks, including those declared
## in the library on integrated clock gating cells, and those that are inferred
## on combinational gates in the clock path
#timing_disable_clock_gating_checks 0    ;# (Boolean, default=0, persistent)

## When set to true, disables timing model clock period checks during timing
## analysis
#timing_disable_clockperiod_checks 0 ;# (Boolean, default=0, persistent)

## Disables DRV checks for nets having disabled constant propagation:
#timing_disable_drv_reports_on_constant_nets 0   ;# (Boolean, default=0, persistent)

## When set to true, disables propagation of minimum delay through three
## state disable timing arcs and maximum delay through three state enable
## arcs. These checks are only valid during floating bus conditions
#timing_disable_floating_bus_check 0 ;# (Boolean, default=0, persistent)

## Disables blocking of generated clocks with '-combinational' option which
## are downstream of another generated clock
#timing_disable_genclk_combinational_blocking 0  ;# (Boolean, default=0, persistent)

## When set to true, disables clock gating checks that are inferred on combinational
## elements in the clock path. Explicit clock gating checks that are described
## in the timing library are not affected by this global variable
#timing_disable_inferred_clock_gating_checks 0   ;# (Boolean, default=0, persistent)

## When set to false, enables internal bidirectional feedback paths that
## are completely contained in one instance
#timing_disable_internal_inout_cell_paths 1  ;# (Boolean, default=1, persistent)

## When set to true, this global disables internal bidirectional feedback
## paths that span multiple instances
#timing_disable_internal_inout_net_arcs 1    ;# (Boolean, default=1, persistent)

## When set to true, disables timing model pulse width checks during timing
## analysis
#timing_disable_lib_pulsewidth_checks 0  ;# (Boolean, default=0, persistent)

## When set to true, this global disables data-to-data checks that are coded
## in the library as non-sequential timing checks
#timing_disable_library_data_to_data_checks 0    ;# (Boolean, default=0, persistent)

## Disables constant functions in a library
#timing_disable_library_tiehi_tielo 0    ;# (Boolean, default=0, persistent)

## When set to true, ignores constants defined in the Verilog netlist
#timing_disable_netlist_constants 0  ;# (Boolean, default=0, persistent)

## When set to true, disables no change timing model checks during timing
## analysis
#timing_disable_nochange_checks 0    ;# (Boolean, default=0, persistent)

## When set to true, disables the timing arcs between any data-to-clock
## or clock-to-clock checks
#timing_disable_non_sequential_checks 0  ;# (Boolean, default=0, persistent)

## Controls clock to output port to be treated as data or clock irrespective
## of constraints set on the port
#timing_disable_output_as_clock_port 0   ;# (Boolean, default=0, persistent)

## to control enabling/disabling both CTE's  parallel arc reduction, and
## the related task compression on the AAE side. Setting this variable to
## 'true' should yield AAE task compression mode '2'.  Setting it to 'false'
##  will result in task compression mode '0'
#timing_disable_parallel_arcs 1  ;# (Boolean, default=1, persistent)

## When set to true, disables recovery and removal timing model checks during
## timing analysis
#timing_disable_recovery_removal_checks 0    ;# (Boolean, default=0, persistent)

## Controls whether timing reports are generated using a common report header.
#timing_disable_report_header_info 0 ;# (Boolean, default=0, persistent)

## Controls whether analysis is performed on data or clock paths
#timing_disable_retime_clock_path_slew_propagation 1 ;# (Boolean, default=1, persistent)

## Controls handling of retain arcs in SDF2.1
#timing_disable_sdf_retain_arc_merging 0 ;# (Boolean, default=0, persistent)

## When set to true, blocks the application of constants from the timing
## constraints file. Constants that are introduced through the netlist and
## the timing library are not affected by this global.
#timing_disable_set_case_analysis 0  ;# (Boolean, default=0, persistent)

## When set to true, disables library skew checks for timing analysis
#timing_disable_skew_checks 0    ;# (Boolean, default=0, persistent)

## When set to true, timing analysis will not analyze the signal arcs coming
## from or going to the test pin
#timing_disable_test_signal_arc 0    ;# (Boolean, default=0, persistent)

## Controls whether latch behavior is inferred for cell descriptions tagged
## with the Liberty timing_model_type attribute, including all values: abstracted,
## extracted, or qtm
#timing_disable_timing_model_latch_inferencing 1 ;# (Boolean, default=1, persistent)

## When set to true, disables all 0/1->Z transitions of tristate arcs during
## timing analysis
#timing_disable_tristate_disable_arcs 0  ;# (Boolean, default=0, persistent)

## When set to true, disables data-to-data checks that are created by the
## set_data_check command
#timing_disable_user_data_to_data_checks 0   ;# (Boolean, default=0, persistent)

## Controls the selection of library cells specified using the set_driving_cell
## command
#timing_driving_cell_override_library 0  ;# (Boolean, default=0, persistent)

## Enables dynamic loop breaking.
#timing_dynamic_loop_breaking 0  ;# (Boolean, default=0, persistent)

## Enables computation of gate level count when an input pin is specified
## using the all_fanout -from parameter and output pin is specified using
## the all_fanin -to parameter
#timing_enable_all_fanin_fanout_levels_compatibility 1   ;# (Boolean, default=1, persistent)

## Enable aocv analysis using slack based method
#timing_enable_aocv_slack_based 0    ;# (Boolean, default=0, persistent)

## When set to false, enables new set_path_adjust handling mechanism.
#timing_enable_backward_compatible_path_adjust_mode 0    ;# (Boolean, default=0, persistent)

## Controls to report case analysis conflict warnings to CTE_constant_mismatch.rpt
## file.
#timing_enable_case_analysis_conflict_warning 1  ;# (Boolean, default=1, persistent)

## When set to true, performs clock to clock gating checks at gating elements
#timing_enable_clock2clock_clockgating_check 0   ;# (Boolean, default=0, persistent)

## Determines the interpretation of edge-specific derating factors for clock
## paths, specified using the set_timing_derate -rise/-fall parameters
#timing_enable_clock_phase_based_rise_fall_derating 0    ;# (Boolean, default=0, persistent)

## enables Constraint Analysis and Development mode
#timing_enable_constraint_development_mode 0 ;# (Boolean, default=0, persistent)

## When set to false, blocks signals arriving on the enable of the clock-gating
## check
#timing_enable_data_through_clock_gating 1   ;# (Boolean, default=1, persistent)

## Applies check derating for pulse width checks
#timing_enable_derating_for_pulsewidth_checks 0  ;# (Boolean, default=0, persistent)

## When set to true, the global variable enables propagation of early and
## late slews on data paths. Delay calculation then uses these early and
## late slews to calculate timing checks. You can use this global in simultaneous
## setup and hold mode only.
#timing_enable_early_late_data_slews_for_setuphold_mode_checks 0 ;# (Boolean, default=0, persistent)

## Controls inheritance of duty cycle from master clock for generated clocks
## with divide by option
#timing_enable_genclk_divide_by_inherit_parent_duty_cycle 0  ;# (Boolean, default=0, persistent)

## Controls how the software chooses generated clock source latency paths
#timing_enable_genclk_edge_based_source_latency 1    ;# (Boolean, default=1, persistent)

## Limits generated clock source latency path to traverse across one register
## only
#timing_enable_genclk_source_path_register_limit 0   ;# (Boolean, default=0, persistent)

## Enables printing of escape characters in the get_object_name command
## output.
#timing_enable_get_object_escaped_name_backward_compatible 0 ;# (Boolean, default=0, persistent)

## Controls propagation of latency phases across a clock gating element.
#timing_enable_latency_through_clock_gating 1    ;# (Boolean, default=1, persistent)

## Enables path segmentation in the presence of set_min/max_delay -from/-to
#timing_enable_minmax_delay_segmentation 0   ;# (Boolean, default=0, persistent)

## When set to true, loop breaking is handled independently per analysis
## view
#timing_enable_mmmc_loop_handling 1  ;# (Boolean, default=1, persistent)

## Controls whether multi-drive net reduction (if enabled) will attempt
## to reduce mult-drive nets that also have only either/both set_annotated_delay
## or set_annotated_transitions assertions present. By default, any assertions
## present on different drivers of multi-drive nets will prevent reduction
## of the multi-drive net.
#timing_enable_multi_drive_net_reduction_with_assertions none    ;# (Enum, default=none, range={none all delay}, persistent)

## Enables multi-threaded reporting
#timing_enable_multi_threaded_reporting 1    ;# (Boolean, default=0, persistent)

## Enables multi-frequency latch timing analysis of the latch time borrowing
## for when a data signal coming to a latch is controlled by a clock with
## a frequency different to a clock of the latch enabling signal
#timing_enable_multifrequency_latch_analysis 0   ;# (Boolean, default=0, persistent)

## When set to false, does not propagate path exceptions beyond -to pin.
#timing_enable_path_exception_to_pin_compatibility 1 ;# (Boolean, default=1, persistent)

## When set to true, enables pessimistic cppr adjustment for re-convergent
## clock paths
#timing_enable_pessimistic_cppr_for_reconvergent_clock_paths 0   ;# (Boolean, default=0, persistent)

## Controls whether case analysis is inferred from power and ground rail
## connections.
#timing_enable_power_ground_constants 0  ;# (Boolean, default=0, persistent)

## Determines whether timing arcs are created to model the transition to
## active state (assertion) of the preset or clear pin, and the subsequent
## transition of the output to controlled state
#timing_enable_preset_clear_arcs 0   ;# (Boolean, default=0, persistent)

## Enables pulse-latch analysis
#timing_enable_pulsed_latch 1    ;# (Boolean, default=1, persistent)

## Enables checking for SDC compatible data checks when set_multicycle_path
## -start parameter is specified
#timing_enable_sdc_compatible_data_check_mcp 0   ;# (Boolean, default=0, persistent)

## Enable SOCV accurate mode
#timing_enable_separate_device_slew_effect_sensitivities 0   ;# (Boolean, default=0, persistent)

## Enables more accurate CPPR analysis when incremental delays are present
## and the timing_remove_clock_reconvergence_pessimism global variable is
## set to true
#timing_enable_si_cppr 1 ;# (Boolean, default=1, persistent)

## Controls whether setup and hold checks are analyzed separately, or together
## on the same timing graph
#timing_enable_simultaneous_setup_hold_mode 0    ;# (Boolean, default=0, persistent)

## When set to true, the software performs statistical static timing analysis
## (SSTA) on clock paths only
#timing_enable_ssta_clock_only 0 ;# (Boolean, default=0, persistent)

## When this global is set to true, inferred gated-clock checks are added
## when clock and data signals converge through the tristate enable and
## data input of tristate buffers
#timing_enable_tristate_clock_gating 0   ;# (Boolean, default=0, persistent)

## Display Warning in case of partial success/failure while fetching objects
## in  certain constraints
#timing_enable_warning_on_partially_search_failure 0 ;# (Boolean, default=0, persistent)

## This global sets the AOCV mode to be used during model extraction
#timing_extract_model_aocv_mode none ;# (Enum, default=none, range={none graph_based path_based}, persistent)

## When set to false, specifies that port propagated constants are written
## to the generated constraints file
#timing_extract_model_case_analysis_in_library 1 ;# (Boolean, default=1, persistent)

## When set to false, specifies that user asserted design level DRVs should
## not be considered while writing to the extracted timing model
#timing_extract_model_consider_design_level_drv 1    ;# (Boolean, default=1, persistent)

## Specifies the output directory where the validation reports will be written
#timing_extract_model_exhaustive_validation_dir ""   ;# (String, default="", persistent)

## Enables ETM validation at the minimum and maximum indices of the slew
## / load indices
#timing_extract_model_exhaustive_validation_mode 0   ;# (Boolean, default=0, persistent)

## When set to false, disables conversion of clock gating checks to nochange
## arcs in the extracted timing model
#timing_extract_model_gating_as_nochange_arc 1   ;# (Boolean, default=1, persistent)

## Specifies if latency arc from ideal master clock need to be extracted
## in timing model
#timing_extract_model_ideal_clock_latency_arc 0  ;# (Boolean, default=0, persistent)

##<WARNING> This global seems deprecated in Innovus 15.21.
## Allows timing model to write min pulse width  or min period checks as
## arcs.
#timing_extract_model_write_clock_checks_as_arc 1    ;# (Boolean, default=0, persistent)

##<WARNING> This global seems deprecated in Innovus 15.21.
## Allows timing model to write min pulse width  or min period checks as
##  scalar arcs.
#timing_extract_model_write_clock_checks_as_scalar_tables 0  ;# (Boolean, default=0, persistent)

## No Description
#timing_generate_normalized_driver_waveform 1    ;# (Boolean, default=1, persistent)

## When set to true, makes generated clocks to inherit parent's ideal network
## latency
#timing_generated_clocks_inherit_ideal_latency 0 ;# (Boolean, default=0, persistent)

## When set to true, the get_pins -of_objects parameter will return hierarchical
## leaf pins connected to the specified objects
#timing_get_of_objects_hier_compatibility 0  ;# (Boolean, default=0, persistent)

## Controls how hierarchical delimiters are interpreted in the search pattern,
## when the -hier parameter is used with the get_* collection command
#timing_hier_object_name_compatibility 1 ;# (Boolean, default=1, persistent)

## When set to false, the set_load and set_resistance values override the
## actual extracted representation
#timing_ignore_lumped_rc_assertions 0    ;# (Boolean, default=0, persistent)

## When set to true, aocv-pba calculation with launch/capture path segment
## delay difference based computation using interface power domain (ipd)
## derate offsets is enabled
#timing_ipd_derate_flow_use_path_segment_delay_difference 0  ;# (Boolean, default=0, persistent)

## Specifies the weight factor to calculate the rise/fall capacitance range
## values from ccs receiver capacitance model
#timing_library_ccs_receiver_weight_K 1  ;# (Double, default=1, range={}, persistent)

##<WARNING> This global seems deprecated in Innovus 15.21.
## Controls whether single-edged setup and hold checks on asynchronous pins
## in the Liberty library are inferred as recovery and removal checks. This
## is mainly to support older modeling styles in legacy libraries.
#timing_library_convert_async_setuphold_to_recrem 1  ;# (Integer, default=1, persistent)

## If this global is ON, the statetables is generated for a multiff sequential
## cell.
#timing_library_create_statetable_multi_sequential_cells 0   ;# (Boolean, default=0, persistent)

## Generate constraint table using the sigma values
#timing_library_gen_constraint_table_using_sigma_values 0    ;# (Boolean, default=0, persistent)

## When set to true, the software uses the generated_clock group name when
## creating a generated clock from a library-generated clock group
#timing_library_genclk_use_group_name 0  ;# (Boolean, default=0, persistent)

## User control multiplier to generate constraint table applied for setup
## arc.
#timing_library_hold_sigma_multiplier 0  ;# (Double, default=0, persistent)

## This global marks the pins as async pins based on the timing arcs associated
## with the pin.
#timing_library_infer_async_pins_from_timing_arcs 0  ;# (Boolean, default=0, persistent)

## When true infer the rise/fall capacitance range values from ccs receiver
## capacitance model
#timing_library_infer_cap_range_from_ccs_receiver_model 0    ;# (Boolean, default=0, persistent)

## When this global is enabled would infer cap range from ecsm capacitance
## group of library.
#timing_library_infer_cap_range_from_ecsm_receiver_model 0   ;# (Boolean, default=0, persistent)

## When true while merging models, among all the same clock checks arc having
## the same modes the worst clock check arc value would be merged
#timing_library_merge_worst_case_mpw_arcs 0  ;# (Boolean, default=0, persistent)

## can read ccs noise construct from library when enabled.
#timing_library_read_ccs_noise_data 1    ;# (Boolean, default=1, persistent)

## can read library without power by setting this global to true
#timing_library_read_without_power 0 ;# (Boolean, default=0, persistent)

## AOCV derates are expected to be derived based on 3-sigma variation
#timing_library_scale_aocv_to_socv_to_n_sigma 3  ;# (Double, default=3, persistent)

## User control multiplier to generate constraint table using sigma values
## applied for setup arc.
#timing_library_setup_sigma_multiplier 0 ;# (Double, default=0, persistent)

## No Description
#timing_library_sort_non_monotonic_ccs_index 1   ;# (Boolean, default=1, persistent)

## Allows the timing arc structure of a cell to be different between MMMC
## delay corners.
#timing_library_support_mismatched_arcs 1    ;# (Integer, default=1, persistent)

## This global provide the support for timing library cells with more than
## one sequential group.
#timing_library_support_multi_sequential_cells 1 ;# (Boolean, default=1, persistent)

## Use Library pin voltage for reporting the term voltage.
#timing_library_term_voltage_from_lib_pin 0  ;# (Integer, default=0, persistent)

## The global will honour the minimum of the max load/slew indices for all
## arcs corresponding to the pin during DRV reporting.
#timing_library_use_table_limit_for_drv 0    ;# (Boolean, default=0, persistent)

## Allows the software to use a range of trilib DRV values for performing
## delay calculations
#timing_library_use_trilib_drv_values 0  ;# (Boolean, default=0, persistent)

## When true check for negative values in timing arcs
#timing_library_zero_negative_timing_check_arcs 0    ;# (Boolean, default=0, persistent)

## Rounds off irrational numbers so that they can be read appropriately
#timing_multifrequency_clock_rounding_factor 1e-05   ;# (Double, default=1e-05, range={}, persistent)

## No Description
#timing_normalized_driver_waveform_clip_linear_part 0    ;# (Boolean, default=0, persistent)

## No Description
#timing_normalized_driver_waveform_weight_factor 0.5 ;# (Double, default=0.5, persistent)

## Allows you to migrate previous release scripts to the new use model
#timing_null_collection_return_compatibility 0   ;# (Boolean, default=0, persistent)

## Limit the maximum number of paths which can be retimed by a command.
#timing_path_based_retimed_paths_limit 0 ;# (Integer, default=0, range={}, persistent)

## When set to true, the software appends the instance name to the clock
## pin name when creating a generated clock
#timing_prefix_module_name_with_library_genclk 1 ;# (Boolean, default=1, persistent)

## When set to true, uses the clock phase associated with a flush latch's
## data pin as the from clock phase for downstream uncertainty timing calculations
#timing_propagate_latch_data_uncertainty 0   ;# (Boolean, default=0, persistent)

## global is set to true, is_clock_used_as_data returns true for unconstrained
## clock source network
#timing_property_clock_used_as_data_unconstrained_clock_source_paths 1   ;# (Boolean, default=1, persistent)

## Switch off loading of ECSM data
#timing_read_library_without_ecsm 0  ;# (Boolean, default=0, persistent)

## Switch off loading of ECSM timing sensitivity data
#timing_read_library_without_sensitivity 0   ;# (Boolean, default=0, persistent)

## Controls the recomputing of SDF delays when the software is in simultaneous
## setup and hold analysis mode
#timing_recompute_sdf_in_setuphold_mode 0    ;# (Boolean, default=0, persistent)

## Controls the reduction of the number of net arcs created for timing analysis
## for nets driven by parallel buffers
#timing_reduce_multi_drive_net_arcs 1    ;# (Boolean, default=1, persistent)

## Sets a threshold number used by the tool to trigger the reduction of
## timing arcs of nets driven by parallel buffers
#timing_reduce_multi_drive_net_arcs_threshold 10000  ;# (Integer, default=10000, range={}, persistent)

## Enables Clock Path Pessimism Removal (CPPR) analysis during timing analysis
# timing_remove_clock_reconvergence_pessimism 0   ;# (Boolean, default=0, persistent)

## When set to false, worst max_paths across all the groups are reported
## (with each endpoint paths limited to nworst)
#timing_report_backward_compatible_max_paths_reporting 0 ;# (Boolean, default=0, persistent)

## Enables original(left) alignment for numbers in report_timing report
#timing_report_backward_compatible_number_alignment 1    ;# (Boolean, default=1, persistent)

## To enable new mode of toAdjustAssertion required time computation
#timing_report_backward_compatible_to_adjust 0   ;# (Boolean, default=1, persistent)

## Controls the number of max_paths to be reported by report_timing in begin_end_pair
## option
#timing_report_begin_end_pair_max_path_limit 2000000 ;# (Integer, default=2000000, range={}, persistent)

## To enable dual port support for cte commands
#timing_report_enable_dual_port_object_support 0 ;# (Boolean, default=0, persistent)

## Enables reporting of Instance/Net related bits in report_timing Flags
## column
#timing_report_enable_flag_field_symbols 0   ;# (Boolean, default=0, persistent)

## Enables marker for report_timing for Pin/timing points columns
#timing_report_enable_markers 1  ;# (Boolean, default=1, persistent)

## Enables max capactiance DRV checks for nets having disabled constant
## propagation
#timing_report_enable_max_capacitance_drv_for_constants 0    ;# (Boolean, default=0, persistent)

## warning message if max_paths option specified is not enough for coverage
#timing_report_enable_max_path_limit_crossed 0   ;# (Boolean, default=0, persistent)

## For decision regarding SI attribute debugging through path collection
## objects
#timing_report_enable_si_debug 0 ;# (Boolean, default=0, persistent)

## enables reporting different paths w.r.t ref clocks in unique_pins
#timing_report_enable_unique_pins_multiple_capture_clock_paths 0 ;# (Boolean, default=0, persistent)

## Enables new format for header in report_timing SOCV mode
#timing_report_enable_verbose_ssta_mode 0    ;# (Boolean, default=0, persistent)

## When set to true (the default), generated clock information is automatically
## added to the report if generated clocks are encountered in either the
## launching or latching clock paths
#timing_report_generated_clock_info 1    ;# (Boolean, default=1, persistent)

## Groups paths by clock domain
#timing_report_group_based_mode 0    ;# (Boolean, default=0, persistent)

## This global allows latch data pin in from and through option of report_timing.
#timing_report_latch_analysis_compatibility 0    ;# (Boolean, default=0, persistent)

## Controls whether the report_timing -from and -through parameters are
## allowed to reference pins or ports that strictly belong to the clock
## path
#timing_report_paths_through_sequential_arcs 0   ;# (Boolean, default=0, persistent)

## This variable can be used to manage the retiming fields in reporting
## format. Based upon given setting it would automatically replaces (or
## add) the default columns with respective retiming columns. For example
## in case of delay column it will add(or replace) the 'Retime Delay' automatically.
#timing_report_retime_formatting_mode manual ;# (Enum, default=manual, range={manual retime_compare retime_replace}, persistent)

## For decision regarding reporting proper term voltage
#timing_report_term_voltage_backward_compatible_mode 0   ;# (Boolean, default=0, persistent)

## When set to true, the report_timing command reports unconstrained paths
## if it cannot find a constrained path to report
#timing_report_unconstrained_paths 0 ;# (Boolean, default=0, persistent)

## When set to false, setting the -nworst parameter reports several paths
## by selecting parallel arcs in the library cell between two pins
#timing_report_use_worst_parallel_cell_arc 0 ;# (Boolean, default=0, persistent)

## Resolves values of nets having multiple drivers
#timing_resolve_driver_conflicts aggressive  ;# (Enum, default=aggressive, range={conservative aggressive}, persistent)

## Controls how Setup and Hold check values are adjusted when both are initially
## negative.
#timing_sdf_adjust_negative_setuphold 0  ;# (Boolean, default=0, persistent)

## No Description
#timing_sdf_default_arc_worst_casing_backward_compatibility 1    ;# (Boolean, default=1, persistent)

## To enable proper generation of SDF (Standard Delay Format) with scond
## and ccond qualifiers on SETUPHOLD and RECREM timing checks
#timing_sdf_enable_setuphold_scond_ccond 0   ;# (Boolean, default=0, persistent)

## When set to true, factors the skew on self loops
#timing_self_loop_paths_no_skew 0    ;# (Boolean, default=0, persistent)

## Identifies self-loop paths at the specified depth.
#timing_self_loop_paths_no_skew_max_depth 10 ;# (Integer, default=10, range={}, persistent)

## Identifies self-loop paths at the specified threshold
#timing_self_loop_paths_no_skew_max_slack 0  ;# (Double, default=0, persistent)

## When set to true, causes a clock source path leading to an output or
## bidi port to be treated as a data path if there is a set_output_delay
## or set_data_check assertion on the port
#timing_set_clock_source_to_output_as_data 0 ;# (Boolean, default=0, persistent)

## Controls sigma multiplier to be used in SOCV mode
#timing_set_nsigma_multiplier 3  ;# (Double, default=3, persistent)

## Modifies the scaling of the negative timing analysis check value
#timing_set_scaling_for_negative_checks default  ;# (Enum, default=default, range={default divider multiplier}, persistent)

## Modifies the scaling of the negative delay value to be used during timing
## analysis
#timing_set_scaling_for_negative_delays default  ;# (Enum, default=default, range={default divider multiplier}, persistent)

## Sets sigma multiplier to be used in hold mode SOCV reporting
#timing_socv_nsigma_hold_multiplier 3    ;# (Double, default=3, persistent)

## Sets sigma multiplier to be used in setup mode SOCV reporting
#timing_socv_nsigma_setup_multiplier 3   ;# (Double, default=3, persistent)

## Controls worstcasing mode to be used for SOCV
#timing_socv_statistical_min_max_mode statistical    ;# (Enum, default=statistical, range={statistical three_sigma_bounded mean_and_sigma_bounded mean_and_three_sigma_bounded}, persistent)

## Enables detailed description of end-point slack, arrival and required
## times in SSTA report
#timing_ssta_report_endpoint_description 0   ;# (Boolean, default=0, persistent)

## Supresses the reporting of escape characters in timing object names
#timing_suppress_escape_characters 1 ;# (Boolean, default=1, persistent)

## When set to true, the software suppresses all error and warning messages
## related to objects not found when loading SDC constraint files for the
## ILM flow
#timing_suppress_ilm_constraint_mismatches 0 ;# (Boolean, default=0, persistent)

## This value is passed to setLibraryUnit -time to set the time units used
## in timing library and .sdc files and timing reports. Legal values are
## none, 1ns, 1ps, 10ps, 100ps.
#timing_time_unit none   ;# (String, default=none, persistent)

## To allow the propagation of clocks to pins with clock attributes regardless
## of the presence of check arcs or trigger arcs at the pins
#timing_use_clock_pin_attribute_for_clock_net_marking 0  ;# (Boolean, default=0, persistent)

## Enables the latch use early launch edge feature.
#timing_use_latch_early_launch_edge 1    ;# (Boolean, default=1, persistent)

## When set to false, does not consider time borrowing during timing analysis.
## Time borrowing is the amount of time borrowed by a previous logic
#timing_use_latch_time_borrow 1  ;# (Boolean, default=1, persistent)

## Supports various patterns of the escape character.
#timing_write_sdf_no_escape_backslash_control 0  ;# (Boolean, default=0, persistent)

## set/get correcly dont_use flag in early mode
#togFixDontUseWithOcvMin 1   ;# (Integer, default=1, persistent)

## Number of nets to be printed connecting a pad term to a fterm without
## geometry
#trPrintIgnoredPadNets 0 ;# (Integer, default=0, persistent)

## set execuable name for tso mode tempus clients. Default is same as master
## execuable
#tso_client_tempus_executable "" ;# (String, default="", persistent)

## set def files for using with logical flow
#tso_def_file_list ""    ;# (String, default="", persistent)

## set view names for tso master
#tso_hold_view_list ""   ;# (String, default="", persistent)

## set lef files for using with logical flow
#tso_lef_file_list ""    ;# (String, default="", persistent)

## set view names for tso master
#tso_setup_view_list ""  ;# (String, default="", persistent)

## ttgCorrelateWithNewTrialIpoData
#ttgCorrelateWithNewTrialIpoData 0   ;# (Integer, default=0, persistent)

## ttgDumpClkToVirClkMap
#ttgDumpClkToVirClkMap 0 ;# (Integer, default=0, persistent)

## Push down virtual clocks forcefully
#ttgPushDownVirtualClocks 0  ;# (Integer, default=0, persistent)

## ttgUseThresholdForPositiveSlack
#ttgUseThresholdForPositiveSlack 0   ;# (Integer, default=0, persistent)

## ttgWrExtGenClkInLib
#ttgWrExtGenClkInLib 0   ;# (Integer, default=0, persistent)

## Specifies whether design import should continue in the presence of Verilog
## netlist errors.
#vl_tolerate_illegal_syntax 0    ;# (Integer, default=0, persistent)

## report slack pf write global slack report in ps
#write_global_slack_report_time_unit_backward_compatible_mode 0  ;# (Boolean, default=0, persistent)

## Specifies whether the write_global_slack_report command reports worst
## slack on the register clock pins or not
#write_global_slack_worst_trigger_path_on_clocks 0   ;# (Boolean, default=0, persistent)

