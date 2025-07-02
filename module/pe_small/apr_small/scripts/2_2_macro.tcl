placeInstance imem_inst/mem1 145 10 MY -fixed
placeInstance imem_inst/mem2 180 10 MY -fixed
placeInstance imem_inst/mem3 215 10 MY -fixed

placeInstance fpu_config_inst/FUs_instance/dmem_gen_1__dmem_unit/mem1 10 10 -fixed
placeInstance fpu_config_inst/FUs_instance/dmem_gen_1__dmem_unit/mem2 65 10 -fixed
placeInstance fpu_config_inst/FUs_instance/dmem_gen_0__dmem_unit/mem1 10 110 -fixed
placeInstance fpu_config_inst/FUs_instance/dmem_gen_0__dmem_unit/mem2 65 110 -fixed



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
