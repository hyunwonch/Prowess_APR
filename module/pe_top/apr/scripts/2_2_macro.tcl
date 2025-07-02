
# set inst_w [expr [dbGet [dbGetCellByName TS1N28HPCPUHDLVTB32X64M1SSO].size_x]]
# set inst_h [expr [dbGet [dbGetCellByName TS1N28HPCPUHDLVTB32X64M1SSO].size_y]]

# set dmem_w [expr [dbGet [dbGetCellByName TS1N28HPCPUHDLVTB512X32M4SSO].size_x]]
# set dmem_h [expr [dbGet [dbGetCellByName TS1N28HPCPUHDLVTB512X32M4SSO].size_y]]

# set start_x 5
# set start_y 10

# placeInstance fpu_config_inst/FUs_instance/dmem_gen_1__dmem_unit/mem1 $start_x $start_y -fixed
# placeInstance fpu_config_inst/FUs_instance/dmem_gen_1__dmem_unit/mem2 [expr $start_x + $dmem_w + 2*$t_pitch] $start_y -fixed
# placeInstance fpu_config_inst/FUs_instance/dmem_gen_0__dmem_unit/mem1 $start_x [expr $start_y + $dmem_h + 20] -fixed
# placeInstance fpu_config_inst/FUs_instance/dmem_gen_0__dmem_unit/mem2 [expr $start_x + $dmem_w + 2*$t_pitch] [expr $start_y + $dmem_h + 20] -fixed


# set start_x 184
# set start_y 10

# placeInstance imem_inst/mem1 $start_x $start_y MY -fixed
# placeInstance imem_inst/mem2 $start_x [expr $start_y + 1*$inst_h + 10] MY -fixed
# placeInstance imem_inst/mem3 $start_x [expr $start_y + 2*$inst_h + 20]  MY -fixed

# set cutRowGapL [expr 2*$t_pitch]
# set cutRowGapR [expr 2*$t_pitch]
# set cutRowGapT [expr 2*$t_pitch]
# set cutRowGapB [expr 2*$t_pitch]


# # Check for the presence of blocks
# set blocks_list [dbGet -p2 top.insts.cell.baseClass block]

# # Conditionally execute commands if blocks are found
# if {$blocks_list != 0x0} {
#     dbSelectObj $blocks_list
#     cutRow -selected -leftGap $cutRowGapL -rightGap $cutRowGapR -topGap $cutRowGapT -bottomGap $cutRowGapB
#     deselectAll
# }


# Macro Placement Tcl Script for PE Array

# === Variables ===
set num_row       8
set num_col       8
set macro_width   306.74
set macro_height  306.8
set spacing       20.0
set offset_x      100
set offset_y      10

set num_dma       9

# === Macro Placement ===
for {set row 0} {$row < $num_row} {incr row} {
    for {set col 0} {$col < $num_col} {incr col} {

        # Calculate x and y coordinates
        set x [expr $offset_x + $col * ($macro_width + $spacing)]
        set y [expr $offset_y + ($num_row - 1 - $row) * ($macro_height + $spacing)]  ;# Y-axis flips (top to bottom)

        # Generate instance name
        set instance_name "u_PE_array/p_${row}_${col}"

        # Place the macro
        placeInstance $instance_name $x $y
    }
}

for {set row 0} {$row < $num_dma} {incr row} {

    # Calculate x and y coordinates
    set x 15
    set y [expr 10 + (8-$row)*(10+$macro_height)]  ;# Y-axis flips (top to bottom)

    # Generate instance name
    set instance_name "u_dma_left/mem_banks_${row}__mem_inst"

    # Place the macro
    placeInstance $instance_name $x $y
}


for {set row 0} {$row < $num_dma} {incr row} {

    # Calculate x and y coordinates
    set x [expr $offset_x + $num_col * ($macro_width + $spacing) - $spacing + 30]
    set y [expr 10 + (8-$row)*(10+$macro_height)]  ;# Y-axis flips (top to bottom)

    # Generate instance name
    set instance_name "u_dma_right/mem_banks_${row}__mem_inst"

    # Place the macro
    placeInstance $instance_name $x $y MY
}



set cutRowGapL [expr 2*$t_pitch]
set cutRowGapR [expr 2*$t_pitch]
set cutRowGapT [expr 2*$t_pitch]
set cutRowGapB [expr 2*$t_pitch]


# Check for the presence of blocks
set blocks_list [dbGet -p2 top.insts.cell.baseClass block]

# Conditionally execute commands if blocks are found
if {$blocks_list != 0x0} {
    dbSelectObj $blocks_list
    cutRow -selected -leftGap $cutRowGapL -rightGap $cutRowGapR -topGap $cutRowGapT -bottomGap $cutRowGapB
    deselectAll
}

