# set CURRENT_PATH    [pwd]
# set DESIGN_PATH     /net/badwater/z/hyunwon/Documents/TSMC_Prowess/syn_test/arbiter/verilog

#option 2: using read_file, elaborate

read_sverilog "
    $DESIGN_PATH/dma.svh    \
    $DESIGN_PATH/dma.sv
"

current_design $DESIGN_NAME
list_designs
link
uniquify -dont_skip_empty_designs
