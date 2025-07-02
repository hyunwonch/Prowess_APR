import os
import sys

io_file = open('stripes_part1.tcl', 'w')

def add_stripe(nets, direction, layer, width, spacing, set_to_set_distance, number_of_sets, start, stop, merge_stripes_value):
    stripe_str  = 'addStripe \\\n'
    stripe_str += '\t-nets "{}" \\\n'.format(nets)
    stripe_str += '\t-direction {} \\\n'.format(direction)
    stripe_str += '\t-layer {} \\\n'.format(layer)
    stripe_str += '\t-width {} -spacing {} \\\n'.format(width, spacing)
    stripe_str += '\t-set_to_set_distance {} \\\n'.format(set_to_set_distance) if set_to_set_distance else ''
    stripe_str += '\t-number_of_sets {} \\\n'.format(number_of_sets) if number_of_sets else ''
    stripe_str += '\t-start {} \\\n'.format(start) if start else ''
    stripe_str += '\t-stop {} \\\n'.format(stop) if stop else ''
    stripe_str += '\t-merge_stripes_value {}\n'.format(merge_stripes_value) if merge_stripes_value else ''

    io_file.write(stripe_str)

io_file.write('setAddStripeMode -stacked_via_bottom_layer M7\n')
io_file.write('setAddStripeMode -stacked_via_top_layer    M9\n')

io_file.write('# Stripes\n')
io_file.write('# Horizontal M8 for all power nets\n')
add_stripe("VSS VDD0P8_NE VDD0P8_CLK VDD3P3_MRAMVDIO VDD0P8_MRAMVDD_PG VDD0P8_MRAMVDDS_PG VDD3P3_MRAMVDIO_PG", \
            "horizontal", \
            "M8",	\
            "$stripe_w", \
            "$stripe_s", \
            "50", \
            "", \
            "[expr $mram_y_start + 10]", \
            "[expr $mram_y_end + 10]", \
            "10")

add_stripe("VSS VDD0P8_NE VDD0P8_CLK", \
            "horizontal", \
            "M8",	\
            "$stripe_w", \
            "$stripe_s", \
            "35", \
            "", \
            "[expr ($pad_height - $pad_offsets) + 50]", \
            "[expr $mram_y_start - 20 + 10]", \
            "10")

add_stripe("VSS VDD0P8_CLK", \
             "horizontal", \
             "M8", \
             "1.8", \
             "0.5", \
             "", \
             "1", \
             "[expr $CLK_GEN_NE_y + $CLK_GEN_CORE_h + 0.2]", \
             "", \
             "10")

add_stripe("VDD0P8_CLK VSS", \
            "horizontal", \
            "M8", \
            "1.8",\
            "0.5", \
            "", \
            "1", \
            "[expr $CLK_GEN_NE_y - 4.8]", \
            "", \
            "10")

io_file.write("# Small stripes for shared & local activation mem\n")
io_file.write("# M7\n")
io_file.write('setAddStripeMode -stacked_via_bottom_layer M1\n')
io_file.write('setAddStripeMode -stacked_via_top_layer    M8\n')

io_file.write("# Non-Interval\n")
for i in range(0, 25):
    add_stripe("VDD0P8_NE VSS", \
                "vertical", \
                "M7",	\
                "$stripe_w", \
                "$stripe_s", \
                "", \
                "2", \
                "[expr $shared_act_mem_x_start + {}*($SRAM_512x128_w + $sram_gap_x) + 0.25*($SRAM_512x128_w) - $stripe_p]".format(i), \
                "[expr $shared_act_mem_x_start + {}*($SRAM_512x128_w + $sram_gap_x) + 0.75*($SRAM_512x128_w) + $stripe_p]".format(i), \
                "10")
    if (i == 3 or i == 4):
        add_stripe("VDD0P8_MRAMVDD_PG VDD0P8_MRAMVDD_PG VDD0P8_MRAMVDD_PG", \
                    "vertical", \
                    "M7",	\
                    "$stripe_w", \
                    "$stripe_s", \
                    "", \
                    "1", \
                    "[expr $shared_act_mem_x_start + {}*($SRAM_512x128_w + $sram_gap_x) + 0.25*($SRAM_512x128_w) + $stripe_p]".format(i), \
                    "", \
                    "10")
    elif (i == 6):
        add_stripe("VDD0P8_MRAMVDDS_PG", \
                    "vertical", \
                    "M7",	\
                    "$stripe_w", \
                    "$stripe_s", \
                    "", \
                    "1", \
                    "[expr $shared_act_mem_x_start + {}*($SRAM_512x128_w + $sram_gap_x) + 0.25*($SRAM_512x128_w) + $stripe_p]".format(i), \
                    "", \
                    "10")
    elif (i == 8 or i == 9 or i == 10):
        add_stripe("VDD3P3_MRAMVDIO_PG VDD3P3_MRAMVDIO_PG VDD3P3_MRAMVDIO_PG", \
                    "vertical", \
                    "M7",	\
                    "$stripe_w", \
                    "$stripe_s", \
                    "", \
                    "1", \
                    "[expr $shared_act_mem_x_start + {}*($SRAM_512x128_w + $sram_gap_x) + 0.25*($SRAM_512x128_w) + $stripe_p]".format(i), \
                    "", \
                    "10")
 
        
for i in range(0, 24):
    if (i < 2 or i > 6):
        add_stripe("VDD0P8_CLK VDD3P3_MRAMVDIO", \
                    "vertical", \
                    "M7",	\
                    "$stripe_w", \
                    "$stripe_s", \
                    "", \
                    "1", \
                    "[expr $shared_act_mem_x_start + {}*($SRAM_512x128_w + $sram_gap_x) + 0.75*($SRAM_512x128_w) + $stripe_p + $stripe_s]".format(i), \
                    "", \
                    "10")

io_file.write("# Interval\n")
for i in range (0, 24):
    add_stripe("VDD0P8_NE VSS ", \
                "vertical", \
                "M7",	\
                "$stripe_w", \
                "$stripe_s", \
                "", \
                "1", \
                "[expr $shared_act_mem_x_start + ({} + 1)*($SRAM_512x128_w) + ({} + 0.5)*($sram_gap_x) - $stripe_w - 0.5*($stripe_s)]".format(i, i), \
                "", \
                "10")

io_file.write('# M9\n')
io_file.write('setAddStripeMode -stacked_via_bottom_layer M8\n')
io_file.write('setAddStripeMode -stacked_via_top_layer    M9\n')

io_file.write('# Non-Interval\n')

for i in range(0, 25):
    # TM_ANA
    if (i != 12):
        add_stripe("VDD0P8_NE VSS", \
                    "vertical", \
                    "M9",	\
                    "$stripe_w", \
                    "$stripe_s", \
                    "", \
                    "2", \
                    "[expr $shared_act_mem_x_start + {}*($SRAM_512x128_w + $sram_gap_x) + 0.25*($SRAM_512x128_w) - $stripe_p]".format(i), \
                    "[expr $shared_act_mem_x_start + {}*($SRAM_512x128_w + $sram_gap_x) + 0.75*($SRAM_512x128_w) + $stripe_p]".format(i), \
                    "10")
    if (i == 3 or i == 4):
        add_stripe("VDD0P8_MRAMVDD_PG VDD0P8_MRAMVDD_PG VDD0P8_MRAMVDD_PG", \
                    "vertical", \
                    "M9",	\
                    "$stripe_w", \
                    "$stripe_s", \
                    "", \
                    "1", \
                    "[expr $shared_act_mem_x_start + {}*($SRAM_512x128_w + $sram_gap_x) + 0.25*($SRAM_512x128_w) + $stripe_p]".format(i), \
                    "", \
                    "10")
    elif (i == 8 or i == 9 or i == 10):
        add_stripe("VDD3P3_MRAMVDIO_PG VDD3P3_MRAMVDIO_PG VDD3P3_MRAMVDIO_PG", \
                    "vertical", \
                    "M9",	\
                    "$stripe_w", \
                    "$stripe_s", \
                    "", \
                    "1", \
                    "[expr $shared_act_mem_x_start + {}*($SRAM_512x128_w + $sram_gap_x) + 0.25*($SRAM_512x128_w) + $stripe_p]".format(i), \
                    "", \
                    "10")
    else:
        add_stripe("VDD0P8_MRAMVDDS_PG VDD0P8_MRAMVDD_PG VDD3P3_MRAMVDIO_PG", \
                    "vertical", \
                    "M9",	\
                    "$stripe_w", \
                    "$stripe_s", \
                    "", \
                    "1", \
                    "[expr $shared_act_mem_x_start + {}*($SRAM_512x128_w + $sram_gap_x) + 0.25*($SRAM_512x128_w) + $stripe_p]".format(i), \
                    "", \
                    "10")
        
for i in range(0, 24):
    # TM_ANA
    if (i != 12): 
        add_stripe("VDD0P8_CLK VDD3P3_MRAMVDIO", \
                    "vertical", \
                    "M9",	\
                    "$stripe_w", \
                    "$stripe_s", \
                    "", \
                    "1", \
                    "[expr $shared_act_mem_x_start + {}*($SRAM_512x128_w + $sram_gap_x) + 0.75*($SRAM_512x128_w) + $stripe_p + $stripe_s]".format(i), \
                    "", \
                    "10")

io_file.write('# Boundary MRAM stripes, for DRC\n')
io_file.write('# M7\n')
io_file.write('setAddStripeMode -stacked_via_bottom_layer M1\n')
io_file.write('setAddStripeMode -stacked_via_top_layer    M8\n')
add_stripe("VDD3P3_MRAMVDIO_PG VDD0P8_MRAMVDDS_PG VDD0P8_MRAMVDD_PG VSS VDD0P8_NE", \
            "vertical", \
            "M7",	\
            "1.8", \
            "1.2", \
            "", \
            "1", \
            "[expr $mram_x_start - $mram_halo_l + 1.2]", \
            "", \
            "10")
add_stripe("VDD3P3_MRAMVDIO_PG VDD0P8_MRAMVDDS_PG VDD0P8_MRAMVDD_PG VSS VDD0P8_NE", \
            "vertical", \
            "M7",	\
            "1.8", \
            "1.2", \
            "", \
            "1", \
            "[expr $mram_x_end + 1.2]", \
            "", \
            "10")

io_file.write('# Boundary stripes\n')
io_file.write('# M7\n')
add_stripe("VSS VDD0P8_NE", \
            "vertical", \
            "M7",	\
            "1.8", \
            "1.2", \
            "", \
            "1", \
            "[expr $accumulator_mem_x_end - 11]", \
            "", \
            "10")


io_file.write('# Vertical Stripes\n')
io_file.write('# Small stripes for accumulator memory banks\n')
io_file.write('# M7\n')
io_file.write('setAddStripeMode -stacked_via_bottom_layer M1\n')
io_file.write('setAddStripeMode -stacked_via_top_layer    M8\n')

io_file.write('# Non-Interval\n')

add_stripe("VSS VDD0P8_NE", \
            "vertical", \
            "M7",	\
            "$stripe_w", \
            "$stripe_s", \
            "[expr $RF_32x96_w + $sram_gap_x]", \
            "", \
            "[expr $accumulator_mem_x_start + 0.5*($RF_32x96_w) - $stripe_p] -stop [expr $accumulator_mem_x_end]", \
            "", \
            "10")

io_file.write('# Interval\n')

for i in range(0, 3):
    add_stripe("VSS VDD0P8_NE", \
                "vertical", \
                "M7",	\
                "$stripe_w", \
                "$stripe_s", \
                "", \
                "1", \
                "[expr $accumulator_mem_x_start + ({} + 1)*($RF_32x96_w) + ({} + 0.5)*($sram_gap_x) - $stripe_w - 0.5*($stripe_s)]".format(i, i), \
                "", \
                "10")

io_file.write('# M9\n')
io_file.write('setAddStripeMode -stacked_via_bottom_layer M8\n')
io_file.write('setAddStripeMode -stacked_via_top_layer    M9\n')

io_file.write('# Non-Interval\n')

add_stripe("VSS VDD0P8_NE", \
            "vertical", \
            "M9",	\
            "$stripe_w", \
            "$stripe_s", \
            "[expr $RF_32x96_w + $sram_gap_x]", \
            "", \
            "[expr $accumulator_mem_x_start + 0.5*($RF_32x96_w) - $stripe_p] -stop [expr $accumulator_mem_x_end]", \
            "", \
            "10")


io_file.write('# Small stripes for weight memory\n')
io_file.write('# M7\n')
io_file.write('setAddStripeMode -stacked_via_bottom_layer M1\n')
io_file.write('setAddStripeMode -stacked_via_top_layer    M8\n')

io_file.write('#Non-interval\n')

for i in range(0, 16):
    #if (i == 11 or i == 12):
    #    add_stripe("VSS VDD0P8_NE", \
    #        "vertical", \
    #        "M7",	\
    #        "$stripe_w", \
    #        "$stripe_s", \
    #        "", \
    #        "1", \
    #        "[expr $weight_mem_x_start + {}*($SRAM_512x80_w + $sram_gap_x) + 0.5*($SRAM_512x80_w) - $stripe_p]".format(i), \
    #        "", \
    #        "10")
    add_stripe("VDD0P8_CLK VSS VDD0P8_NE", \
            "vertical", \
            "M7",	\
            "$stripe_w", \
            "$stripe_s", \
            "", \
            "2", \
            "[expr $weight_mem_x_start + {}*($SRAM_512x80_w + $sram_gap_x) + 0.25*($SRAM_512x80_w) - $stripe_p]".format(i), \
            "[expr $weight_mem_x_start + {}*($SRAM_512x80_w + $sram_gap_x) + 0.75*($SRAM_512x80_w) + $stripe_p]".format(i), \
            "10")
         
io_file.write('# Interval\n')

for i in range(0, 16):
    add_stripe("VSS VDD0P8_NE", \
                "vertical", \
                "M7",	\
                "$stripe_w", \
                "$stripe_s", \
                "", \
                "1", \
                "[expr $weight_mem_x_start + ({} + 1)*($SRAM_512x80_w) + ({} + 0.5)*($sram_gap_x) - $stripe_w - 0.5*($stripe_s)]".format(i, i), \
                "", \
                "10")

io_file.write('# M9\n')
io_file.write('setAddStripeMode -stacked_via_bottom_layer M8\n')
io_file.write('setAddStripeMode -stacked_via_top_layer    M9\n')
io_file.write('# Non-Interval\n')

for i in range(0, 16):
    add_stripe("VDD0P8_CLK VSS VDD0P8_NE", \
            "vertical", \
            "M9",	\
            "$stripe_w", \
            "$stripe_s", \
            "", \
            "2", \
            "[expr $weight_mem_x_start + {}*($SRAM_512x80_w + $sram_gap_x) + 0.25*($SRAM_512x80_w) - $stripe_p]".format(i), \
            "[expr $weight_mem_x_start + {}*($SRAM_512x80_w + $sram_gap_x) + 0.75*($SRAM_512x80_w) + $stripe_p]".format(i), \
            "10")


io_file.write('# Small stripes for bias mem\n')
io_file.write('setAddStripeMode -stacked_via_bottom_layer M1\n')
io_file.write('setAddStripeMode -stacked_via_top_layer    M8\n')

add_stripe("VDD0P8_CLK VSS VDD0P8_NE", \
            "vertical", \
            "M7",	\
            "$stripe_w", \
            "$stripe_s", \
            "", \
            "3", \
            "[expr $bias_mem_x_start + 0.5*($RF_16x128_w) - $stripe_p]", \
            "[expr $bias_mem_x_start + 1.5*($RF_16x128_w) + $sram_gap_x + $stripe_p]", \
            "10")

io_file.write('# M9\n')
io_file.write('setAddStripeMode -stacked_via_bottom_layer M8\n')
io_file.write('setAddStripeMode -stacked_via_top_layer    M9\n')

add_stripe("VDD0P8_CLK VSS VDD0P8_NE", \
            "vertical", \
            "M9",	\
            "$stripe_w", \
            "$stripe_s", \
            "", \
            "2", \
            "[expr $bias_mem_x_start + 0.5*($RF_16x128_w) - $stripe_p]", \
            "[expr $bias_mem_x_start + 1.5*($RF_16x128_w) + $sram_gap_x + $stripe_p - 0.005]", \
            "10")

io_file.close()

io_file = open('stripes_part2.tcl', 'w')

io_file.write('# Non-Memory Vertical Stripes\n')
io_file.write('# Between MRAM and weight memory\n')
io_file.write('# M7\n')
io_file.write('setAddStripeMode -stacked_via_bottom_layer M1\n')
io_file.write('setAddStripeMode -stacked_via_top_layer    M8\n')
io_file.write('# Non-Interval\n')

for i in range(0, 1):
    add_stripe("VSS VDD0P8_NE", \
                "vertical", \
                "M7",	\
                "$stripe_w", \
                "$stripe_s", \
                "", \
                "2", \
                "[expr $mram_x_end + 12 + {}*($SRAM_512x128_w + $sram_gap_x) + 0.25*($SRAM_512x128_w) - $stripe_p]".format(i), \
                "[expr $mram_x_end + 12 + {}*($SRAM_512x128_w + $sram_gap_x) + 0.75*($SRAM_512x128_w) + $stripe_p]".format(i), \
                "10")

io_file.write('# Interval\n')
for i in range(0, 1):
    add_stripe("VSS VDD0P8_NE", \
                "vertical", \
                "M7",	\
                "$stripe_w", \
                "$stripe_s", \
                "", \
                "1", \
                "[expr $mram_x_end + 12 + ({} + 1)*($SRAM_512x128_w) + ({} + 0.5)*($sram_gap_x) - $stripe_w - 0.5*($stripe_s)]".format(i, i), \
                "", \
                "10")

io_file.write('# M9\n')
io_file.write('setAddStripeMode -stacked_via_bottom_layer M8\n')
io_file.write('setAddStripeMode -stacked_via_top_layer    M9\n')
io_file.write('# Non-Interval\n')

for i in range(0, 1):
    add_stripe("VSS VDD0P8_NE", \
                "vertical", \
                "M9",	\
                "$stripe_w", \
                "$stripe_s", \
                "", \
                "2", \
                "[expr $mram_x_end + 12 + {}*($SRAM_512x128_w + $sram_gap_x) + 0.25*($SRAM_512x128_w) - $stripe_p]".format(i), \
                "[expr $mram_x_end + 12 + {}*($SRAM_512x128_w + $sram_gap_x) + 0.75*($SRAM_512x128_w) + $stripe_p]".format(i), \
                "10")

io_file.write('# Between bias memory and accumulator memory\n')
io_file.write('# M7\n')
io_file.write('setAddStripeMode -stacked_via_bottom_layer M1\n')
io_file.write('setAddStripeMode -stacked_via_top_layer    M8\n')
io_file.write('# Non-Interval\n')

for i in range (0, 3):
    add_stripe("VSS VDD0P8_NE", \
            "vertical", \
            "M7",	\
            "$stripe_w", \
            "$stripe_s", \
            "", \
            "2", \
            "[expr $bias_mem_x_end + {}*($SRAM_512x128_w + $sram_gap_x) + 0.25*($SRAM_512x128_w) - $stripe_p]".format(i), \
            "[expr $bias_mem_x_end + {}*($SRAM_512x128_w + $sram_gap_x) + 0.75*($SRAM_512x128_w) + $stripe_p]".format(i), \
            "10")

io_file.write('# Interval\n')

for i in range (0, 2):
    add_stripe("VSS VDD0P8_NE", \
                "vertical", \
                "M7",	\
                "$stripe_w", \
                "$stripe_s", \
                "", \
                "1", \
                "[expr $bias_mem_x_end + ({} + 1)*($SRAM_512x128_w) + ({} + 0.5)*($sram_gap_x) - $stripe_w - 0.5*($stripe_s)]".format(i, i), \
                "", \
                "10")

io_file.write('# M9\n')
io_file.write('setAddStripeMode -stacked_via_bottom_layer M8\n')
io_file.write('setAddStripeMode -stacked_via_top_layer    M9\n')
io_file.write('# Non-Interval\n')
    
for i in range (0, 3):
    add_stripe("VSS VDD0P8_NE", \
            "vertical", \
            "M9",	\
            "$stripe_w", \
            "$stripe_s", \
            "", \
            "2", \
            "[expr $bias_mem_x_end + {}*($SRAM_512x128_w + $sram_gap_x) + 0.25*($SRAM_512x128_w) - $stripe_p]".format(i), \
            "[expr $bias_mem_x_end + {}*($SRAM_512x128_w + $sram_gap_x) + 0.75*($SRAM_512x128_w) + $stripe_p]".format(i), \
            "10")

io_file.close()
