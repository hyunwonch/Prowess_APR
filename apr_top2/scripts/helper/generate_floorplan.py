import os
import sys
import math

inst_file = open('../SONA.floorplan','w')

# SRAM bank sizes (w x h)
# 512x128: 66.04um x 322.22um
# 512x80: 66.04um x 210.86um
# 512x96: 66.04um x 247.98um
# 512x32: 66.04um x 99.5um
# 1024x110: 100.6um x 280.46um

# RF bank sizes (w x h)
# 32x32: 23.955um x 69.705um
# 32x96: 23.955um x 160.585um
# 32x128: 23.955um x 206.025um
# 16x128: 21.795um x 206.025um
# MRAM size: 1885um x 1441um

inst_file.write('#############################################################' + '\n')

# MRAM
inst_file.write('#############################################################' + '\n')
inst_file.write('# MRAM INSTANCES' + '\n')
inst_file.write('MRAM_0' + ' ' + 'u_ne_scan/u_ne_top/u_mram/mram_inst MY {$mram_x_start} {$mram_y_start}' + '\n')
inst_file.write('#############################################################' + '\n')

# Shared Activation Memory
row = 0
col = 0

inst_file.write('#############################################################' + '\n')
inst_file.write('# SHARED ACTIVATION MEMORY INSTANCES' + '\n')
for bank_idx in range (0, 12):
    for group_idx in range(0, 4):
        row = bank_idx // 6
        col = (bank_idx * 4 + group_idx) % 24
        if col == 23:
            inst_file.write('SHARED_ACT_MEM_' + str(bank_idx) + '_' + str(group_idx) + ' ' + 'u_ne_scan/u_ne_top/u_ne_controller/shared_activation_memory/banks_' + str(bank_idx) + '__groups_' + str(group_idx) + '__shared_act_memory_bank MY {$shared_act_mem_x_start + ' + str(col) + '*($SRAM_512x128_w + $sram_gap_x) + 2}' + ' ' + '{$shared_act_mem_y_start + ' + str(row) + '*($SRAM_512x128_h + $sram_gap_y)}' + ' \\'+'\n')
        else:
            inst_file.write('SHARED_ACT_MEM_' + str(bank_idx) + '_' + str(group_idx) + ' ' + 'u_ne_scan/u_ne_top/u_ne_controller/shared_activation_memory/banks_' + str(bank_idx) + '__groups_' + str(group_idx) + '__shared_act_memory_bank MY {$shared_act_mem_x_start + ' + str(col) + '*($SRAM_512x128_w + $sram_gap_x)}' + ' ' + '{$shared_act_mem_y_start + ' + str(row) + '*($SRAM_512x128_h + $sram_gap_y)}' + ' \\'+'\n')
inst_file.write('#############################################################' + '\n')


# Local Activation Memory
row = 0
col = 0

inst_file.write('#############################################################' + '\n')
inst_file.write('# LOCAL ACTIVATION MEMORY INSTANCES' + '\n')
for ping_pong_idx in range (0, 2):
    for bank_idx in range(0, 6):
        col = (ping_pong_idx * 6 + bank_idx) // 6
        row = (ping_pong_idx * 6 + bank_idx) % 6
        if ping_pong_idx % 2 == 0:
            inst_file.write('LOCAL_ACT_MEM_' + str(ping_pong_idx) + '_' + str(bank_idx) + ' ' + 'u_ne_scan/u_ne_top/u_ne_controller/pe/local_activation_memory/ping_pongs_' + str(ping_pong_idx) + '__banks_' + str(bank_idx) + '__local_act_memory_bank MY {$local_act_mem_x_start + ' + str(col) + '*($SRAM_512x32_w + $sram_gap_x)}' + ' ' + '{$local_act_mem_y_start + ' + str(row) + '*($SRAM_512x32_h + $sram_gap_y)}' + ' \\'+'\n')
        else:
            inst_file.write('LOCAL_ACT_MEM_' + str(ping_pong_idx) + '_' + str(bank_idx) + ' ' + 'u_ne_scan/u_ne_top/u_ne_controller/pe/local_activation_memory/ping_pongs_' + str(ping_pong_idx) + '__banks_' + str(bank_idx) + '__local_act_memory_bank R0 {$local_act_mem_x_start + ' + str(col) + '*($SRAM_512x32_w + $sram_gap_x)}' + ' ' + '{$local_act_mem_y_start + ' + str(row) + '*($SRAM_512x32_h + $sram_gap_y)}' + ' \\'+'\n')
for ping_pong_idx in range (0, 2):
    for bank_idx in range(6, 9):
        col = (ping_pong_idx * 3 + bank_idx) // 3
        row = (ping_pong_idx * 3 + bank_idx) % 3
        if ping_pong_idx % 2 == 0:
            inst_file.write('LOCAL_ACT_MEM_' + str(ping_pong_idx) + '_' + str(bank_idx) + ' ' + 'u_ne_scan/u_ne_top/u_ne_controller/pe/local_activation_memory/ping_pongs_' + str(ping_pong_idx) + '__banks_' + str(bank_idx) + '__local_act_memory_bank MY {$local_act_mem_x_start + ' + str(col) + '*($SRAM_512x32_w + $sram_gap_x)}' + ' ' + '{$local_act_mem_y_start + ' + str(row) + '*($SRAM_512x32_h + $sram_gap_y)}' + ' \\'+'\n')
        else:
            inst_file.write('LOCAL_ACT_MEM_' + str(ping_pong_idx) + '_' + str(bank_idx) + ' ' + 'u_ne_scan/u_ne_top/u_ne_controller/pe/local_activation_memory/ping_pongs_' + str(ping_pong_idx) + '__banks_' + str(bank_idx) + '__local_act_memory_bank R0 {$local_act_mem_x_start + ' + str(col) + '*($SRAM_512x32_w + $sram_gap_x)}' + ' ' + '{$local_act_mem_y_start + ' + str(row) + '*($SRAM_512x32_h + $sram_gap_y)}' + ' \\'+'\n')

# Weight Memory
row = 0
col = 0

inst_file.write('#############################################################' + '\n')
inst_file.write('# WEIGHT MEMORY INSTANCES' + '\n')
for factor in range(0, 8):
    for bank_idx in range(0, 2):
        for ping_pong_idx in range (0, 2):
            col = (factor * 4 + bank_idx * 2 + ping_pong_idx) % 16
            row = (factor * 4 + bank_idx * 2 + ping_pong_idx) // 16
            if ping_pong_idx % 2 == 0:
                inst_file.write('WEIGHT_MEM_80_' + str(ping_pong_idx) + '_' + str(factor * 2 + bank_idx) + ' ' + 'u_ne_scan/u_ne_top/u_ne_controller/weight_memory/weight_memory_macro/ping_pongs_' + str(ping_pong_idx) + '__banks_' + str(factor * 2 + bank_idx) + '__SRAM_512x80 MY {$weight_mem_x_start + ' + str(col) + '*($SRAM_512x80_w + $sram_gap_x)}' + ' ' + '{$weight_mem_y_start + ' + str(row) + '*($SRAM_512x80_h + $SRAM_512x96_h + 2*($sram_gap_y))}' + ' \\'+'\n')
                inst_file.write('WEIGHT_MEM_96_' + str(ping_pong_idx) + '_' + str(factor * 2 + bank_idx) + ' ' + 'u_ne_scan/u_ne_top/u_ne_controller/weight_memory/weight_memory_macro/ping_pongs_' + str(ping_pong_idx) + '__banks_' + str(factor * 2 + bank_idx) + '__SRAM_512x96 MY {$weight_mem_x_start + ' + str(col) + '*($SRAM_512x96_w + $sram_gap_x)}' + ' ' + '{$weight_mem_y_start + $SRAM_512x80_h + $sram_gap_y + ' + str(row) + '*($SRAM_512x80_h + $SRAM_512x96_h + 2*($sram_gap_y))}' + ' \\'+'\n')
            else:
                inst_file.write('WEIGHT_MEM_80_' + str(ping_pong_idx) + '_' + str(factor * 2 + bank_idx) + ' ' + 'u_ne_scan/u_ne_top/u_ne_controller/weight_memory/weight_memory_macro/ping_pongs_' + str(ping_pong_idx) + '__banks_' + str(factor * 2 + bank_idx) + '__SRAM_512x80 R0 {$weight_mem_x_start + ' + str(col) + '*($SRAM_512x80_w + $sram_gap_x)}' + ' ' + '{$weight_mem_y_start + ' + str(row) + '*($SRAM_512x80_h + $SRAM_512x96_h + 2*($sram_gap_y))}' + ' \\'+'\n')
                inst_file.write('WEIGHT_MEM_96_' + str(ping_pong_idx) + '_' + str(factor * 2 + bank_idx) + ' ' + 'u_ne_scan/u_ne_top/u_ne_controller/weight_memory/weight_memory_macro/ping_pongs_' + str(ping_pong_idx) + '__banks_' + str(factor * 2 + bank_idx) + '__SRAM_512x96 R0 {$weight_mem_x_start + ' + str(col) + '*($SRAM_512x96_w + $sram_gap_x)}' + ' ' + '{$weight_mem_y_start + $SRAM_512x80_h + $sram_gap_y + ' + str(row) + '*($SRAM_512x80_h + $SRAM_512x96_h + 2*($sram_gap_y))}' + ' \\'+'\n')

# FCL Weight Memory
inst_file.write('#############################################################' + '\n')
inst_file.write('# FCL WEIGHT MEMORY INSTANCES' + '\n')
for group_idx in range(0, 6):
    col = 2 * group_idx
    row = 0
    inst_file.write('FCL_WEIGHT_MEM_0_' + str(group_idx) + ' ' + 'u_ne_scan/u_ne_top/u_ne_controller/fcl_weight_memory/fcl_weight_memory_macro/banks_0__groups_' + str(group_idx) + '__SRAM_1024x110 R0 {$fcl_weight_mem_x_start + ' + str(col) + '*($SRAM_512x128_w + $sram_gap_x)}' + ' ' + '{$fcl_weight_mem_y_start + ' + str(row) + '*($SRAM_1024x110_h + $sram_gap_y)}' + ' \\'+'\n')

# Instruction Memory
inst_file.write('#############################################################' + '\n')
inst_file.write('# INSTRUCTION MEMORY INSTANCES' + '\n')
for group_idx in range(0, 2):
    col = group_idx
    row = 0
    inst_file.write('INSTRUCTION_MEM_' + str(group_idx) + ' ' + 'u_ne_scan/u_ne_top/u_ne_controller/instruction_memory/instr_mem_macro_' + str(group_idx) + '__instruction_memory_bank R0 {$instr_mem_x_start + ' + str(col) + '*($SRAM_512x128_w + $sram_gap_x) ' + ('- 1.5' if col == 0 else '+ 0.63') + '}' + ' ' + '{$instr_mem_y_start + ' + str(row) + '*($SRAM_512x128_h + $sram_gap_y)}' + ' \\'+'\n')

# Accumulator Memory
row = 0
col = 0

inst_file.write('#############################################################' + '\n')
inst_file.write('# ACCUMULATOR MEMORY INSTANCES' + '\n')
for row_idx in range(0, 4):
    for col_idx in range(0, 4):
        for trans_idx in range(0, 3):
            col = (row_idx * 12 + col_idx * 3 + trans_idx) // 12  
            row = (row_idx * 12 + col_idx * 3 + trans_idx) % 12
            if col == 0 or col == 1:
                inst_file.write('ACCUMULATOR_MEM_' + str(trans_idx) + '_' + str(col_idx) + '_' + str(row_idx) + ' ' + 'u_ne_scan/u_ne_top/u_ne_controller/pe/accumulator_memory/trans_' + str(trans_idx) + '__rows_' + str(row_idx) + '__cols_' + str(col_idx) + '__acc_memory_bank R0 '+ '{$accumulator_mem_x_start + ' + str(col) + '*($RF_32x96_w + $sram_gap_x) - 1}' + ' ' + '{$accumulator_mem_y_start + ' + str(row) + '*($RF_32x96_h + $sram_gap_y)}' + ' \\'+'\n')
            else:
                inst_file.write('ACCUMULATOR_MEM_' + str(trans_idx) + '_' + str(col_idx) + '_' + str(row_idx) + ' ' + 'u_ne_scan/u_ne_top/u_ne_controller/pe/accumulator_memory/trans_' + str(trans_idx) + '__rows_' + str(row_idx) + '__cols_' + str(col_idx) + '__acc_memory_bank R0 '+ '{$accumulator_mem_x_start + ' + str(col) + '*($RF_32x96_w + $sram_gap_x)}' + ' ' + '{$accumulator_mem_y_start + ' + str(row) + '*($RF_32x96_h + $sram_gap_y)}' + ' \\'+'\n')

# Transform Memory
row = 0
col = 0

inst_file.write('#############################################################' + '\n')
inst_file.write('# TRANSFORM MEMORY INSTANCES' + '\n')
for row_idx in range(0, 4):
    for col_idx in range(0, 4):
        if row_idx != 3 or col_idx != 3:
            for trans_idx in range(0, 3):
                col = (row_idx * 12 + col_idx * 3 + trans_idx) // 9
                row = (row_idx * 12 + col_idx * 3 + trans_idx) % 9
                if col % 2 == 0:
                    inst_file.write('TRANSFORM_MEM_' + str(trans_idx) + '_' + str(col_idx) + '_' + str(row_idx) + ' ' + 'u_ne_scan/u_ne_top/u_ne_controller/pe/transform_memory/trans_' + str(trans_idx) + '__rows_' + str(row_idx) + '__cols_' + str(col_idx) + '__transform_memory_bank R0 '+ '{$transform_mem_x_start + ' + str(col // 2) + '*($SRAM_512x128_w + $sram_gap_x) + ' + str(col % 2) + '*($RF_32x32_w + $sram_gap_x - 2.5)}' + ' ' + '{$transform_mem_y_start + ' + str(row) + '*($RF_32x32_h + $sram_gap_y)}' + ' \\'+'\n')
                else:
                    inst_file.write('TRANSFORM_MEM_' + str(trans_idx) + '_' + str(col_idx) + '_' + str(row_idx) + ' ' + 'u_ne_scan/u_ne_top/u_ne_controller/pe/transform_memory/trans_' + str(trans_idx) + '__rows_' + str(row_idx) + '__cols_' + str(col_idx) + '__transform_memory_bank MY '+ '{$transform_mem_x_start + ' + str(col // 2) + '*($SRAM_512x128_w + $sram_gap_x) + ' + str(col % 2) + '*($RF_32x32_w + $sram_gap_x - 2.5)}' + ' ' + '{$transform_mem_y_start + ' + str(row) + '*($RF_32x32_h + $sram_gap_y)}' + ' \\'+'\n')
        else:
            col = col + 1
            row = 0
            for trans_idx in range(0, 3):
                if col % 2 == 0:
                    inst_file.write('TRANSFORM_MEM_' + str(trans_idx) + '_' + str(col_idx) + '_' + str(row_idx) + ' ' + 'u_ne_scan/u_ne_top/u_ne_controller/pe/transform_memory/trans_' + str(trans_idx) + '__rows_' + str(row_idx) + '__cols_' + str(col_idx) + '__transform_memory_bank R0 '+ '{$transform_mem_x_start + ' + str(col // 2) + '*($SRAM_512x128_w + $sram_gap_x) + ' + str(col % 2) + '*($RF_32x32_w + $sram_gap_x - 2.5)}' + ' ' + '{$transform_mem_y_start + ' + str(row) + '*($RF_32x32_h + $sram_gap_y)}' + ' \\'+'\n')
                else:
                    inst_file.write('TRANSFORM_MEM_' + str(trans_idx) + '_' + str(col_idx) + '_' + str(row_idx) + ' ' + 'u_ne_scan/u_ne_top/u_ne_controller/pe/transform_memory/trans_' + str(trans_idx) + '__rows_' + str(row_idx) + '__cols_' + str(col_idx) + '__transform_memory_bank MY '+ '{$transform_mem_x_start + ' + str(col // 2) + '*($SRAM_512x128_w + $sram_gap_x) + ' + str(col % 2) + '*($RF_32x32_w + $sram_gap_x - 2.5)}' + ' ' + '{$transform_mem_y_start + ' + str(row) + '*($RF_32x32_h + $sram_gap_y)}' + ' \\'+'\n')
                row = row + 1    

# Bias Memory
inst_file.write('#############################################################' + '\n')
inst_file.write('# BIAS MEMORY INSTANCES' + '\n')
for ping_pong_idx in range(0, 2):
    col = ping_pong_idx
    row = 0
    if ping_pong_idx % 2 == 0:
        inst_file.write('BIAS_MEM_' + str(ping_pong_idx) + ' ' + 'u_ne_scan/u_ne_top/u_ne_controller/bias_memory/ping_pongs_' + str(ping_pong_idx) + '__bias_memory_bank MY {$bias_mem_x_start + ' + str(col) + '*($RF_16x128_w + $sram_gap_x)}' + ' ' + '{$bias_mem_y_start + ' + str(row) + '*($RF_16x128_h + $sram_gap_y)}' + ' \\'+'\n')
    else:
        inst_file.write('BIAS_MEM_' + str(ping_pong_idx) + ' ' + 'u_ne_scan/u_ne_top/u_ne_controller/bias_memory/ping_pongs_' + str(ping_pong_idx) + '__bias_memory_bank R0 {$bias_mem_x_start + ' + str(col) + '*($RF_16x128_w + $sram_gap_x) + 2}' + ' ' + '{$bias_mem_y_start + ' + str(row) + '*($RF_16x128_h + $sram_gap_y)}' + ' \\'+'\n')

# FCL Bias Memory
inst_file.write('#############################################################' + '\n')
inst_file.write('# FCL BIAS MEMORY INSTANCES' + '\n')
for bank_idx in range(0, 4):
    col = bank_idx
    row = 0
    inst_file.write('FCL_BIAS_MEM_' + str(bank_idx) + ' ' + 'u_ne_scan/u_ne_top/u_ne_controller/fcl_bias_memory/banks_' + str(bank_idx) + '__fcl_bias_memory_bank MY {$fcl_bias_mem_x_start + ' + str(col) + '*(81.04)}' + ' ' + '{$fcl_bias_mem_y_start + ' + str(row) + '*($RF_32x128_h + $sram_gap_y)}' + ' \\'+'\n')

# BN Memory
inst_file.write('#############################################################' + '\n')
inst_file.write('# BN MEMORY INSTANCES' + '\n')
for ping_pong_idx in range(0, 2):
    for bank_idx in range(0, 2):
        col = ping_pong_idx
        row = bank_idx
        if ping_pong_idx % 2 == 0:
            inst_file.write('BN_MEM_' + str(ping_pong_idx) + '_' + str(bank_idx) + ' ' + 'u_ne_scan/u_ne_top/u_ne_controller/bn_memory/ping_pongs_' + str(ping_pong_idx) + '__banks_' + str(bank_idx) + '__bn_memory_bank MY {$bn_mem_x_start + ' + str(col) + '*($RF_16x128_w + $sram_gap_x)}' + ' ' + '{$bn_mem_y_start + ' + str(row) + '*($RF_16x128_h + $sram_gap_y)}' + ' \\'+'\n')
        else:
            inst_file.write('BN_MEM_' + str(ping_pong_idx) + '_' + str(bank_idx) + ' ' + 'u_ne_scan/u_ne_top/u_ne_controller/bn_memory/ping_pongs_' + str(ping_pong_idx) + '__banks_' + str(bank_idx) + '__bn_memory_bank R0 {$bn_mem_x_start + ' + str(col) + '*($RF_16x128_w + $sram_gap_x) + 2}' + ' ' + '{$bn_mem_y_start + ' + str(row) + '*($RF_16x128_h + $sram_gap_y)}' + ' \\'+'\n')
inst_file.write('\n')

inst_file.close()

