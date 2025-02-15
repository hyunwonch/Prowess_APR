# placeInstance u_PE_array/p_4_0 250 100 R0 -fixed
# placeInstance u_PE_array/p_4_1 569 100 R0 -fixed
# placeInstance u_PE_array/p_4_2 888 100 R0 -fixed
# placeInstance u_PE_array/p_4_3 1207 100 R0 -fixed
# placeInstance u_PE_array/p_3_0 250 419 R0 -fixed
# placeInstance u_PE_array/p_3_1 569 419 R0 -fixed
# placeInstance u_PE_array/p_3_2 888 419 R0 -fixed
# placeInstance u_PE_array/p_3_3 1207 419 R0 -fixed
# placeInstance u_PE_array/p_2_0 250 738 R0 -fixed
# placeInstance u_PE_array/p_2_1 569 738 R0 -fixed
# placeInstance u_PE_array/p_2_2 888 738 R0 -fixed
# placeInstance u_PE_array/p_2_3 1207 738 R0 -fixed
# placeInstance u_PE_array/p_1_0 250 1057 R0 -fixed
# placeInstance u_PE_array/p_1_1 569 1057 R0 -fixed
# placeInstance u_PE_array/p_1_2 888 1057 R0 -fixed
# placeInstance u_PE_array/p_1_3 1207 1057 R0 -fixed
# placeInstance u_PE_array/p_0_0 250 1376 R0 -fixed
# placeInstance u_PE_array/p_0_1 569 1376 R0 -fixed
# placeInstance u_PE_array/p_0_2 888 1376 R0 -fixed
# placeInstance u_PE_array/p_0_3 1207 1376 R0 -fixed

placeInstance u_PE_array/p_4_0 250 100 R0 -fixed
placeInstance u_PE_array/p_4_1 584 100 R0 -fixed
placeInstance u_PE_array/p_4_2 918 100 R0 -fixed
placeInstance u_PE_array/p_4_3 1252 100 R0 -fixed
placeInstance u_PE_array/p_3_0 250 434 R0 -fixed
placeInstance u_PE_array/p_3_1 584 434 R0 -fixed
placeInstance u_PE_array/p_3_2 918 434 R0 -fixed
placeInstance u_PE_array/p_3_3 1252 434 R0 -fixed
placeInstance u_PE_array/p_2_0 250 768 R0 -fixed
placeInstance u_PE_array/p_2_1 584 768 R0 -fixed
placeInstance u_PE_array/p_2_2 918 768 R0 -fixed
placeInstance u_PE_array/p_2_3 1252 768 R0 -fixed
placeInstance u_PE_array/p_1_0 250 1102 R0 -fixed
placeInstance u_PE_array/p_1_1 584 1102 R0 -fixed
placeInstance u_PE_array/p_1_2 918 1102 R0 -fixed
placeInstance u_PE_array/p_1_3 1252 1102 R0 -fixed
placeInstance u_PE_array/p_0_0 250 1436 R0 -fixed
placeInstance u_PE_array/p_0_1 584 1436 R0 -fixed
placeInstance u_PE_array/p_0_2 918 1436 R0 -fixed
placeInstance u_PE_array/p_0_3 1252 1436 R0 -fixed


placeInstance u_dma_left/mem_banks_0__mem_inst 160 1500 -fixed
placeInstance u_dma_left/mem_banks_1__mem_inst 160 1400 -fixed
placeInstance u_dma_left/mem_banks_2__mem_inst 160 1150 -fixed
placeInstance u_dma_left/mem_banks_3__mem_inst 160 1050 -fixed
placeInstance u_dma_left/mem_banks_4__mem_inst 160 800 -fixed
placeInstance u_dma_left/mem_banks_5__mem_inst 160 700 -fixed
placeInstance u_dma_left/mem_banks_6__mem_inst 160 500 -fixed
placeInstance u_dma_left/mem_banks_7__mem_inst 160 400 -fixed
placeInstance u_dma_left/mem_banks_8__mem_inst 160 200 -fixed
placeInstance u_dma_left/mem_banks_9__mem_inst 160 100 -fixed

placeInstance u_dma_right/mem_banks_0__mem_inst 1600 1500 MY -fixed
placeInstance u_dma_right/mem_banks_1__mem_inst 1600 1400 MY -fixed
placeInstance u_dma_right/mem_banks_2__mem_inst 1600 1150 MY -fixed
placeInstance u_dma_right/mem_banks_3__mem_inst 1600 1050 MY -fixed
placeInstance u_dma_right/mem_banks_4__mem_inst 1600 800  MY -fixed
placeInstance u_dma_right/mem_banks_5__mem_inst 1600 700  MY -fixed
placeInstance u_dma_right/mem_banks_6__mem_inst 1600 500  MY -fixed
placeInstance u_dma_right/mem_banks_7__mem_inst 1600 400  MY -fixed
placeInstance u_dma_right/mem_banks_8__mem_inst 1600 200  MY -fixed
placeInstance u_dma_right/mem_banks_9__mem_inst 1600 100  MY -fixed

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
