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

placeInstance u_PE_array/p_4_0 180 100 R0 -fixed
placeInstance u_PE_array/p_4_1 514 100 R0 -fixed
placeInstance u_PE_array/p_4_2 848 100 R0 -fixed
placeInstance u_PE_array/p_4_3 1182 100 R0 -fixed
placeInstance u_PE_array/p_4_4 1516 100 R0 -fixed
placeInstance u_PE_array/p_3_0 180 434 R0 -fixed
placeInstance u_PE_array/p_3_1 514 434 R0 -fixed
placeInstance u_PE_array/p_3_2 848 434 R0 -fixed
placeInstance u_PE_array/p_3_3 1182 434 R0 -fixed
placeInstance u_PE_array/p_3_4 1516 434 R0 -fixed
placeInstance u_PE_array/p_2_0 180 768 R0 -fixed
placeInstance u_PE_array/p_2_1 514 768 R0 -fixed
placeInstance u_PE_array/p_2_2 848 768 R0 -fixed
placeInstance u_PE_array/p_2_3 1182 768 R0 -fixed
placeInstance u_PE_array/p_2_4 1516 768 R0 -fixed
placeInstance u_PE_array/p_1_0 180 1102 R0 -fixed
placeInstance u_PE_array/p_1_1 514 1102 R0 -fixed
placeInstance u_PE_array/p_1_2 848 1102 R0 -fixed
placeInstance u_PE_array/p_1_3 1182 1102 R0 -fixed
placeInstance u_PE_array/p_1_4 1516 1102 R0 -fixed
placeInstance u_PE_array/p_0_0 180 1436 R0 -fixed
placeInstance u_PE_array/p_0_1 514 1436 R0 -fixed
placeInstance u_PE_array/p_0_2 848 1436 R0 -fixed
placeInstance u_PE_array/p_0_3 1182 1436 R0 -fixed
placeInstance u_PE_array/p_0_4 1516 1436 R0 -fixed



placeInstance u_dma_left/mem_banks_0__mem_inst 100 1720 -fixed
placeInstance u_dma_left/mem_banks_1__mem_inst 100 1620 -fixed
placeInstance u_dma_left/mem_banks_2__mem_inst 100 1400 -fixed
placeInstance u_dma_left/mem_banks_3__mem_inst 100 1300 -fixed
placeInstance u_dma_left/mem_banks_4__mem_inst 100 1100 -fixed
placeInstance u_dma_left/mem_banks_5__mem_inst 100 1000 -fixed
placeInstance u_dma_left/mem_banks_6__mem_inst 100 750 -fixed
placeInstance u_dma_left/mem_banks_7__mem_inst 100 650 -fixed
placeInstance u_dma_left/mem_banks_8__mem_inst 100 450 -fixed
placeInstance u_dma_left/mem_banks_9__mem_inst 100 350 -fixed
placeInstance u_dma_left/mem_banks_10__mem_inst 100 150 -fixed
placeInstance u_dma_left/mem_banks_11__mem_inst 100 50 -fixed

placeInstance u_dma_right/mem_banks_0__mem_inst 1850 1720 MY -fixed
placeInstance u_dma_right/mem_banks_1__mem_inst 1850 1620 MY -fixed
placeInstance u_dma_right/mem_banks_2__mem_inst 1850 1400 MY -fixed
placeInstance u_dma_right/mem_banks_3__mem_inst 1850 1300 MY -fixed
placeInstance u_dma_right/mem_banks_4__mem_inst 1850 1100  MY -fixed
placeInstance u_dma_right/mem_banks_5__mem_inst 1850 1000  MY -fixed
placeInstance u_dma_right/mem_banks_6__mem_inst 1850 750  MY -fixed
placeInstance u_dma_right/mem_banks_7__mem_inst 1850 650  MY -fixed
placeInstance u_dma_right/mem_banks_8__mem_inst 1850 450  MY -fixed
placeInstance u_dma_right/mem_banks_9__mem_inst 1850 350  MY -fixed
placeInstance u_dma_right/mem_banks_10__mem_inst 1850 150  MY -fixed
placeInstance u_dma_right/mem_banks_11__mem_inst 1850 50  MY -fixed

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
