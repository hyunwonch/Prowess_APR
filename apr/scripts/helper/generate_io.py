import os
import sys

io_file = open('../SONA.io', 'w')

#io_list.write('test')
io_file.write('(globals\n')
io_file.write('     version = 3\n')
io_file.write('     io_order = default\n')
io_file.write(')\n')
io_file.write('(iopad\n')

global pad_itv
pad_itv = 70 # um

# functions for generation io file
def placeio(io_file, io_name, io_width, loop_prefix, start_offset, offset_itv):
    end_offset = start_offset
    if (io_width == 1):
        if loop_prefix == "RN":
            io_file.write('    (inst name=' + '"' + loop_prefix + ('_' if loop_prefix else '') + 'u_PAD_' + io_name + '"' + ' offset=' + str(start_offset) + ' place_status = fixed' + ')\n')
        else:
            io_file.write('    (inst name=' + '"' + loop_prefix + ('__' if loop_prefix else '') + 'u_PAD_' + io_name + '"' + ' offset=' + str(start_offset) + ' place_status = fixed' + ')\n')
        end_offset += offset_itv
    else:
        for i in range(io_width):
            io_file.write('    (inst name=' + '"' + loop_prefix + '_' + str(i) + '__u_PAD_' + io_name + '"' + ' offset=' + str(end_offset) + ' place_status = fixed' + ')\n')
            end_offset += offset_itv
    return end_offset

def placecorner (io_file, corner_name, orientation):
    io_file.write('    (inst name=' + '"u_PAD_' + corner_name + '"' + ' orientation=' + orientation + ')\n')

## LEFT
start_offset = 186.02 - 2 + 3.65 + 16 - 20
pad_itv = 70
io_file.write('   (left\n')

### CLEAN ###
start_offset = placeio(io_file, 'VDD0P8_NE_H', 1, "VDDNE_L_0", start_offset, pad_itv)
start_offset = placeio(io_file, 'VDD0P8_NE_H', 1, "VDDNE_L_1", start_offset, pad_itv)
start_offset = placeio(io_file, 'VDD0P8_SRAM_H', 1, "VDDSRAM_L_0", start_offset, pad_itv)
start_offset = placeio(io_file, 'VDD0P8_SRAM_H', 1, "VDDSRAM_L_1", start_offset, pad_itv)
start_offset = placeio(io_file, 'VDD0P8_NE_H', 1, "VDDNE_EXTRA_L_0", start_offset, pad_itv)
start_offset = placeio(io_file, 'VDD0P8_NE_H', 1, "VDDNE_EXTRA_L_1", start_offset, pad_itv)
start_offset = placeio(io_file, 'VDD0P8_SRAM_H', 1, "VDDSRAM_EXTRA_L_0", start_offset, pad_itv)
start_offset = placeio(io_file, 'VDD0P8_SRAM_H', 1, "VDDSRAM_EXTRA_L_1", start_offset, pad_itv)
start_offset = placeio(io_file, 'CVDD_VDD0P8_NE_H', 1, "CVDDNE_L_0", start_offset, pad_itv)
start_offset = start_offset - 50
start_offset = placeio(io_file, 'CVDD_VDD0P8_NE_H', 1, "RN_CVDDNE_L_0", start_offset, pad_itv)
start_offset = placeio(io_file, 'DVDD_VDD0P8_NE_H', 1, "DVDDNE_L_0", start_offset, pad_itv)
start_offset = placeio(io_file, 'POC_VDD0P8_NE_H', 1, "DVDDNE_L_0", start_offset, pad_itv)
start_offset = placeio(io_file, 'CVSS_VDD0P8_NE_H', 1, "CVSSNE_L_0", start_offset, pad_itv)
start_offset = placeio(io_file, 'NE_clk_ext', 1, "", start_offset, pad_itv)
start_offset = placeio(io_file, 'NE_clk_sel', 1, "", start_offset, pad_itv)
start_offset = placeio(io_file, 'NE_clk_gate', 1, "", start_offset, pad_itv)
start_offset = placeio(io_file, 'NE_clk_gen_div', 4, "NE_CLK_DIV_L", start_offset, pad_itv)
start_offset = placeio(io_file, 'MRAM_clk_ext', 1, "", start_offset, pad_itv)
start_offset = placeio(io_file, 'MRAM_clk_sel', 1, "", start_offset, pad_itv)
start_offset = placeio(io_file, 'MRAM_clk_gate', 1, "", start_offset, pad_itv)
start_offset = placeio(io_file, 'MRAM_clk_gen_div', 4, "MRAM_CLK_DIV_L", start_offset, pad_itv)
start_offset = start_offset + 11.5 - 3.65
start_offset = placeio(io_file, 'VSS_H', 1, "VSS_L_0", start_offset, pad_itv)
start_offset = placeio(io_file, 'VSS_H', 1, "VSS_L_1", start_offset, pad_itv)
start_offset = placeio(io_file, 'VSS_H', 1, "VSS_L_2", start_offset, pad_itv)
start_offset = placeio(io_file, 'VSS_H', 1, "VSS_L_3", start_offset, pad_itv)
start_offset = placeio(io_file, 'VSS_H', 1, "VSS_EXTRA_L_0", start_offset, pad_itv)
start_offset = placeio(io_file, 'VSS_H', 1, "VSS_EXTRA_L_1", start_offset, pad_itv)
start_offset = placeio(io_file, 'VSS_H', 1, "VSS_EXTRA_L_2", start_offset, pad_itv)
start_offset = placeio(io_file, 'VSS_H', 1, "VSS_EXTRA_L_3", start_offset, pad_itv)
start_offset = start_offset + 2 + 3.29
start_offset = placeio(io_file, 'VDD3P3_MRAMVDIO_H', 1, "VDDIO_H_L_0", start_offset, pad_itv)
start_offset = placeio(io_file, 'VDD3P3_MRAMVDIO_H', 1, "VDDIO_H_L_1", start_offset, pad_itv)
### CLEAN ###

io_file.write('   )\n')
io_file.write('   (topleft\n')
placecorner(io_file, 'CORNER_TL', 'MX')
io_file.write('   )\n')

## TOP
pad_itv = 70
start_offset = 345.5 - pad_itv + 16 
io_file.write('   (top\n')

### CLEAN ###
start_offset = placeio(io_file, 'VSS_V', 1, "VSS_L_0", start_offset, pad_itv)
start_offset = placeio(io_file, 'VSS_V', 1, "VSS_L_1", start_offset, pad_itv)
start_offset = placeio(io_file, 'VSS_V', 1, "VSS_L_2", start_offset, pad_itv)
start_offset = placeio(io_file, 'VSS_V', 1, "VSS_L_3", start_offset, pad_itv)
start_offset = placeio(io_file, 'VSS_V', 1, "VSS_L_4", start_offset, pad_itv)
start_offset = start_offset + pad_itv - 37.855
start_offset = placeio(io_file, 'VDD3P3_MRAMVDIO_V', 1, "VDDIO_V_L_0", start_offset, pad_itv)
start_offset = start_offset + 11.01
start_offset = placeio(io_file, 'VDD3P3_MRAMVDIO_V', 1, "VDDIO_V_L_1", start_offset, pad_itv)
start_offset = start_offset + 11.32 
start_offset = placeio(io_file, 'VDD3P3_MRAMVDIO_V', 1, "VDDIO_V_L_2", start_offset, pad_itv)
start_offset = start_offset + 12.32 
start_offset = placeio(io_file, 'VDD3P3_MRAMVDIO_V', 1, "VDDIO_V_L_3", start_offset, pad_itv)
start_offset = start_offset + 13.32 
start_offset = placeio(io_file, 'VDD3P3_MRAMVDIO_V', 1, "VDDIO_V_L_4", start_offset, pad_itv)
start_offset = start_offset + 14.32 
start_offset = placeio(io_file, 'VDD3P3_MRAMVDIO_V', 1, "VDDIO_V_L_5", start_offset, pad_itv)
start_offset = start_offset + 10.53
start_offset = placeio(io_file, 'VDD3P3_MRAMVDIO_V', 1, "VDDIO_V_L_6", start_offset, pad_itv)
start_offset = start_offset + 5.04
start_offset = placeio(io_file, 'VDD3P3_MRAMVDIO_V', 1, "VDDIO_V_L_7", start_offset, pad_itv)
start_offset = start_offset + 11.04
start_offset = placeio(io_file, 'VDD3P3_MRAMVDIO_V', 1, "VDDIO_V_L_8", start_offset, pad_itv)
start_offset = start_offset + 11.04
start_offset = placeio(io_file, 'VDD3P3_MRAMVDIO_V', 1, "VDDIO_V_L_9", start_offset, pad_itv)
start_offset = placeio(io_file, 'MRAM_scan_test', 1, "", start_offset, pad_itv)
start_offset = placeio(io_file, 'MRAM_scan_en', 1, "", start_offset, pad_itv)
start_offset = placeio(io_file, 'MRAM_scan_rst_n', 1, "", start_offset, pad_itv)
start_offset = placeio(io_file, 'MRAM_clk_div_64', 1, "", start_offset, pad_itv)
start_offset = placeio(io_file, 'MRAM_JTAG_rst_n', 1, "", start_offset, pad_itv)
start_offset = placeio(io_file, 'MRAM_JTAG_tck', 1, "", start_offset, pad_itv)
start_offset = placeio(io_file, 'MRAM_JTAG_tms', 1, "", start_offset, pad_itv)
start_offset = placeio(io_file, 'MRAM_JTAG_tdi', 1, "", start_offset, pad_itv)
start_offset = placeio(io_file, 'MRAM_JTAG_tdo', 1, "", start_offset, pad_itv)
start_offset = start_offset - 18.38 - 7 - 32 - 58 
start_offset = placeio(io_file, 'DVDD_VDD0P8_NE_V', 1, "DVDDNE_L_0", start_offset + pad_itv * 15, pad_itv)
start_offset = placeio(io_file, 'POC_VDD0P8_NE_V', 1, "DVDDNE_L_0", start_offset, pad_itv)
start_offset = placeio(io_file, 'CVDD_VDD0P8_NE_V', 1, "RN_CVDDNE_L_0", start_offset, pad_itv)
start_offset = start_offset - 50
start_offset = placeio(io_file, 'CVDD_VDD0P8_NE_V', 1, "CVDDNE_L_0", start_offset, pad_itv)
start_offset = start_offset + 7 + 38
start_offset = placeio(io_file, 'VDD0P8_NE_V', 1, "VDDNE_L_0", start_offset, pad_itv)
start_offset = start_offset + 18.38
start_offset = placeio(io_file, 'VDD0P8_NE_V', 1, "VDDNE_L_1", start_offset, pad_itv)
start_offset = placeio(io_file, 'VDD0P8_SRAM_V', 1, "VDDSRAM_L_0", start_offset, pad_itv)
start_offset = placeio(io_file, 'VDD0P8_SRAM_V', 1, "VDDSRAM_L_1", start_offset, pad_itv)
start_offset = placeio(io_file, 'CVSS_VDD0P8_NE_V', 1, "CVSSNE_L_0", start_offset, pad_itv)
### CLEAN ###

io_file.write('   )\n')

io_file.write('   (topright\n')
placecorner(io_file, 'CORNER_TR', 'MXY')
io_file.write('   )\n')

## RIGHT
start_offset = 2590 - 16
pad_itv = - 70
io_file.write('   (right\n')

### CLEAN ###
start_offset = placeio(io_file, 'VSS_H', 1, "VSS_L_4", start_offset, pad_itv)
start_offset = placeio(io_file, 'VSS_H', 1, "VSS_L_5", start_offset, pad_itv)
start_offset = placeio(io_file, 'VSS_H', 1, "VSS_L_6", start_offset, pad_itv)
start_offset = placeio(io_file, 'VSS_H', 1, "VSS_L_7", start_offset, pad_itv)
start_offset = placeio(io_file, 'VSS_H', 1, "VSS_EXTRA_L_4", start_offset , pad_itv)
start_offset = placeio(io_file, 'VSS_H', 1, "VSS_EXTRA_L_5", start_offset, pad_itv)
start_offset = placeio(io_file, 'VSS_H', 1, "VSS_EXTRA_L_6", start_offset, pad_itv)
start_offset = placeio(io_file, 'VSS_H', 1, "VSS_EXTRA_L_7", start_offset, pad_itv)
start_offset = placeio(io_file, 'VDD3P3_MRAMVDIO_H', 1, "VDDIO_H_L_2", start_offset, pad_itv)
start_offset = placeio(io_file, 'VDD3P3_MRAMVDIO_H', 1, "VDDIO_H_L_3", start_offset, pad_itv)
start_offset = placeio(io_file, 'VDD3P3_MRAMVDIO_H', 1, "VDDIO_H_L_4", start_offset, pad_itv)
start_offset = placeio(io_file, 'VDD3P3_MRAMVDIO_H', 1, "VDDIO_H_L_5", start_offset, pad_itv)
start_offset = placeio(io_file, 'scan_phi', 1, "", start_offset, pad_itv)
start_offset = placeio(io_file, 'scan_phi_bar', 1, "", start_offset, pad_itv)
start_offset = placeio(io_file, 'scan_data_in', 1, "", start_offset, pad_itv)
start_offset = placeio(io_file, 'scan_load_chip', 1, "", start_offset, pad_itv)
start_offset = placeio(io_file, 'scan_load_chain', 1, "", start_offset, pad_itv)
start_offset = placeio(io_file, 'scan_id', 1, "", start_offset, pad_itv)
start_offset = placeio(io_file, 'scan_data_out', 1, "", start_offset, pad_itv)
start_offset = placeio(io_file, 'resetn', 1, "", start_offset, pad_itv)
start_offset = placeio(io_file, 'interrupt', 1, "", start_offset, pad_itv)
start_offset = placeio(io_file, 'CVDD_VDD0P8_NE_H', 1, "CVDDNE_L_1", start_offset, pad_itv)
start_offset = start_offset + 50
start_offset = placeio(io_file, 'CVDD_VDD0P8_NE_H', 1, "RN_CVDDNE_L_1", start_offset, pad_itv)
start_offset = placeio(io_file, 'DVDD_VDD0P8_NE_H', 1, "DVDDNE_L_1", start_offset, pad_itv)
start_offset = placeio(io_file, 'POC_VDD0P8_NE_H', 1, "DVDDNE_L_1", start_offset, pad_itv)
start_offset = start_offset - 127.25
start_offset = placeio(io_file, 'CVSS_VDD0P8_NE_H', 1, "CVSSNE_L_1", start_offset, pad_itv)
start_offset = placeio(io_file, 'VDD0P8_NE_H', 1, "VDDNE_L_2", start_offset, pad_itv)
start_offset = placeio(io_file, 'VDD0P8_NE_H', 1, "VDDNE_L_3", start_offset, pad_itv)
start_offset = start_offset - 2.1
start_offset = placeio(io_file, 'VDD0P8_SRAM_H', 1, "VDDSRAM_L_2", start_offset, pad_itv)
start_offset = placeio(io_file, 'VDD0P8_SRAM_H', 1, "VDDSRAM_L_3", start_offset, pad_itv)
start_offset = placeio(io_file, 'VDD0P8_NE_H', 1, "VDDNE_EXTRA_L_2", start_offset, pad_itv)
start_offset = placeio(io_file, 'VDD0P8_NE_H', 1, "VDDNE_EXTRA_L_3", start_offset, pad_itv)
start_offset = placeio(io_file, 'VDD0P8_SRAM_H', 1, "VDDSRAM_EXTRA_L_2", start_offset, pad_itv)
start_offset = placeio(io_file, 'VDD0P8_SRAM_H', 1, "VDDSRAM_EXTRA_L_3", start_offset, pad_itv)
### CLEAN ###

io_file.write('   )\n')

io_file.write('   (bottomright\n')
placecorner(io_file, 'CORNER_BR', 'MY')
io_file.write('    )\n')

## BOTTOM
##start_offset = 3529
start_offset = 3674 + 18.98 - 16
pad_itv = -70
io_file.write('   (bottom\n')

### CLEAN ###
start_offset = placeio(io_file, 'VDD0P8_NE_V', 1, "VDDNE_L_2", start_offset, pad_itv)
start_offset = placeio(io_file, 'VDD0P8_NE_V', 1, "VDDNE_L_3", start_offset, pad_itv)
start_offset = placeio(io_file, 'VDD0P8_SRAM_V', 1, "VDDSRAM_L_2", start_offset, pad_itv)
start_offset = placeio(io_file, 'VDD0P8_SRAM_V', 1, "VDDSRAM_L_3", start_offset, pad_itv)
start_offset = placeio(io_file, 'DVDD_VDD0P8_NE_V', 1, "DVDDNE_L_1", start_offset, pad_itv)
start_offset = placeio(io_file, 'POC_VDD0P8_NE_V', 1, "DVDDNE_L_1", start_offset, pad_itv)
start_offset = start_offset - 68 + 5
start_offset = placeio(io_file, 'CVDD_VDD0P8_NE_V', 1, "CVDDNE_L_1", start_offset, pad_itv)
start_offset = start_offset + 50
start_offset = placeio(io_file, 'CVDD_VDD0P8_NE_V', 1, "RN_CVDDNE_L_1", start_offset, pad_itv)
start_offset = placeio(io_file, 'CVSS_VDD0P8_NE_V', 1, "CVSSNE_L_1", start_offset, pad_itv)
start_offset = start_offset - 5
start_offset = placeio(io_file, 'CUT_VDD0P8_NE_VDD0P8_CLK', 1, "", start_offset, pad_itv)
start_offset = placeio(io_file, 'NE_clk_gen_en', 1, "", start_offset, pad_itv)
start_offset = placeio(io_file, 'NE_clk_gen_s', 7, "NE_CLK_GEN_L", start_offset, pad_itv)
start_offset = placeio(io_file, 'MRAM_clk_gen_en', 1, "", start_offset, pad_itv)
start_offset = placeio(io_file, 'MRAM_clk_gen_s', 7, "MRAM_CLK_GEN_L", start_offset, pad_itv)
start_offset = start_offset - 32.23 - 17.28 + 0.47 + 18.23
start_offset = placeio(io_file, 'VDD0P8_CLK', 1, "VDDCLK_L_0", start_offset, pad_itv)
start_offset = start_offset - 18.23
start_offset = placeio(io_file, 'VDD0P8_CLK', 1, "VDDCLK_L_1", start_offset, pad_itv)
start_offset = placeio(io_file, 'VDD0P8_CLK', 1, "VDDCLK_L_2", start_offset, pad_itv)
start_offset = placeio(io_file, 'VDD0P8_CLK', 1, "VDDCLK_L_3", start_offset, pad_itv)
start_offset = start_offset - 0.64
start_offset = placeio(io_file, 'CVDD_VDD0P8_CLK', 1, "CVDDCLK_L_0", start_offset, pad_itv)
start_offset = start_offset + 50
start_offset = placeio(io_file, 'CVDD_VDD0P8_CLK', 1, "RN_CVDDCLK_L_0", start_offset, pad_itv)
start_offset = placeio(io_file, 'DVDD_VDD0P8_CLK', 1, "RN_DVDDCLK_L_0", start_offset, pad_itv)
start_offset = placeio(io_file, 'DVDD_VDD0P8_CLK', 1, "DVDDCLK_L_0", start_offset, pad_itv)
start_offset = placeio(io_file, 'POC_VDD0P8_CLK', 1, "DVDDCLK_L_0", start_offset, pad_itv)
start_offset = start_offset - 47.54
start_offset = placeio(io_file, 'CVSS_VDD0P8_CLK', 1, "CVSSCLK_L_0", start_offset, pad_itv)
start_offset = placeio(io_file, 'CUTA_VDD3P3_MRAMVDIO', 1, "", start_offset, pad_itv)
start_offset = placeio(io_file, 'CAVDD', 1, "", start_offset, pad_itv)
start_offset = start_offset + 50
start_offset = placeio(io_file, 'CAVDD', 1, "RN", start_offset, pad_itv)
start_offset = placeio(io_file, 'MRAM_TMANA0', 1, "", start_offset, pad_itv)
start_offset = placeio(io_file, 'MRAM_TMANA1', 1, "", start_offset, pad_itv)
start_offset = placeio(io_file, 'CAVSS', 1, "", start_offset, pad_itv)
start_offset = placeio(io_file, 'CUTA_VDD0P8_NE', 1, "", start_offset, pad_itv)
start_offset = placeio(io_file, 'NE_clk_div_64', 1, "", start_offset, pad_itv)
start_offset = start_offset - 1.01 - 2.43 - 3.84
start_offset = placeio(io_file, 'VSS_V', 1, "VSS_L_5", start_offset, pad_itv)
start_offset = placeio(io_file, 'VSS_V', 1, "VSS_L_6", start_offset, pad_itv)
start_offset = placeio(io_file, 'VSS_V', 1, "VSS_L_7", start_offset, pad_itv)
### CLEAN ###



io_file.write('   )\n')

io_file.write('   (bottomleft\n')
placecorner(io_file, 'CORNER_BL', 'R0')
io_file.write('   )\n')

io_file.close()
