
#option 2: using read_file, elaborate

set svh_files       [glob -nocomplain $DESIGN_PATH/HEADER/*.svh]
set vh_files        [glob -nocomplain $DESIGN_PATH/HEADER/*.vh]

set V_FILE          [glob -nocomplain $DESIGN_PATH/*.v]
set SV_FILE         [glob -nocomplain $DESIGN_PATH/*.sv]

# Combine both sets of files into DEFINE_FILE
set DEFINE_FILE     [concat $svh_files $vh_files]
set VERILOG_FILE    [concat $V_FILE $SV_FILE]


read_sverilog "
    $DEFINE_FILE \
    $VERILOG_FILE
    "

current_design $DESIGN_NAME
list_designs
link
uniquify -dont_skip_empty_designs
