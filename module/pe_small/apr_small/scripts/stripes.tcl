setAddStripeMode -stacked_via_bottom_layer M3
setAddStripeMode -stacked_via_top_layer    M9
# Stripes
# Horizontal M8 for all power nets
addStripe \
	-nets "VDD0P8_MRAMVDD_PG VDD0P8_MRAMVDDS_PG VDD3P3_MRAMVDIO_PG VDD0P8_SRAM VDD3P3_MRAMVDIO VDD0P8_CLK VDD0P8_NE VSS" \
	-direction horizontal \
	-layer M8 \
	-width $stripe_w -spacing $stripe_s \
	-set_to_set_distance 70 \
	-start [expr $mram_y_start + 10] \
	-stop [expr 2631] \
	-merge_stripes_value 10
addStripe \
	-nets "VDD0P8_MRAMVDD_PG VDD0P8_MRAMVDDS_PG VDD3P3_MRAMVDIO_PG VDD0P8_SRAM VDD3P3_MRAMVDIO VDD0P8_CLK VDD0P8_NE VSS" \
	-direction horizontal \
	-layer M8 \
	-width $stripe_w -spacing $stripe_s \
	-set_to_set_distance 70 \
	-start [expr 2665.5] \
	-stop [expr $mram_y_end + 10 + 4] \
	-merge_stripes_value 10
addStripe \
	-nets "VDD0P8_SRAM VDD0P8_CLK VDD0P8_NE VSS" \
	-direction horizontal \
	-layer M8 \
	-width $stripe_w -spacing $stripe_s \
	-set_to_set_distance 35 \
	-start [expr 781 - 13] \
	-stop [expr 948 - 13] \
	-merge_stripes_value 10
addStripe \
	-nets "VDD0P8_SRAM VDD0P8_CLK VDD0P8_NE VSS" \
	-direction horizontal \
	-layer M8 \
	-width $stripe_w -spacing $stripe_s \
	-set_to_set_distance 35 \
	-start [expr ($pad_height - $pad_offsets) + 60 - 2.8] \
	-stop [expr 725] \
	-merge_stripes_value 10
addStripe \
	-nets "VDD0P8_SRAM VDD0P8_CLK VDD0P8_NE VSS" \
	-direction horizontal \
	-layer M8 \
	-width $stripe_w -spacing $stripe_s \
	-set_to_set_distance 35 \
	-start [expr 711 + 13] \
	-stop [expr 750] \
	-merge_stripes_value 10
addStripe \
	-nets "VDD0P8_SRAM VDD0P8_CLK VDD0P8_NE VSS" \
	-direction horizontal \
	-layer M8 \
	-width $stripe_w -spacing $stripe_s \
	-set_to_set_distance 35 \
	-start 1112 \
	-stop [expr $mram_y_start - 20 + 10] \
	-merge_stripes_value 10
addStripe \
	-nets "VDD0P8_SRAM VDD0P8_CLK VDD0P8_NE VSS" \
	-direction horizontal \
	-layer M8 \
	-width $stripe_w -spacing $stripe_s \
	-set_to_set_distance 35 \
	-start 955 \
	-stop [expr 1085 - 4] \
	-merge_stripes_value 10
addStripe \
	-nets "VSS VDD0P8_CLK" \
	-direction horizontal \
	-layer M8 \
	-width 1.8 -spacing 0.5 \
    -number_of_sets 1 \
	-start [expr $CLK_GEN_NE_y + $CLK_GEN_CORE_h + 0.2] \
	-merge_stripes_value 10
addStripe \
	-nets "VDD0P8_CLK VSS" \
	-direction horizontal \
	-layer M8 \
	-width 1.8 -spacing 0.5 \
    -number_of_sets 1 \
	-start [expr $CLK_GEN_NE_y - 4.8] \
	-merge_stripes_value 10
addStripe \
	-nets "VDD0P8_MRAMVDD_PG VDD0P8_MRAMVDDS_PG VDD3P3_MRAMVDIO_PG" \
	-direction horizontal \
	-layer M8 \
	-width 1.8 -spacing 0.5 \
    -number_of_sets 1 \
	-start [expr $LC_MRAM_VDIO_y + 5] \
	-merge_stripes_value 10


# Small stripes for shared & local activation mem
# M7
setAddStripeMode -stacked_via_bottom_layer M1
setAddStripeMode -stacked_via_top_layer    M8
# Non-Interval
addStripe \
	-nets "VDD0P8_SRAM VDD0P8_NE VSS" \
	-direction vertical \
	-layer M7 \
	-width $stripe_w -spacing $stripe_s \
	-number_of_sets 2 \
	-start [expr $shared_act_mem_x_start + 0*($SRAM_512x128_w + $sram_gap_x) + 0.175*($SRAM_512x128_w) - $stripe_p] \
	-stop [expr $shared_act_mem_x_start + 0*($SRAM_512x128_w + $sram_gap_x) + 0.75*($SRAM_512x128_w) + $stripe_p] \
	-merge_stripes_value 10
addStripe \
	-nets "VSS VDD0P8_NE VSS" \
	-direction vertical \
	-layer M7 \
	-width $stripe_w -spacing $stripe_s \
	-number_of_sets 1 \
	-start [expr $shared_act_mem_x_start + 1*($SRAM_512x128_w + $sram_gap_x) + 0.175*($SRAM_512x128_w) - $stripe_p] \
	-merge_stripes_value 10
addStripe \
	-nets "VDD0P8_SRAM VDD0P8_NE VDD0P8_SRAM" \
	-direction vertical \
	-layer M7 \
	-width $stripe_w -spacing $stripe_s \
	-number_of_sets 1 \
	-start [expr $shared_act_mem_x_start + 1*($SRAM_512x128_w + $sram_gap_x) + 0.68*($SRAM_512x128_w) - $stripe_p] \
	-merge_stripes_value 10
addStripe \
	-nets "VDD0P8_SRAM VDD0P8_NE VSS" \
	-direction vertical \
	-layer M7 \
	-width $stripe_w -spacing $stripe_s \
	-number_of_sets 2 \
	-start [expr $shared_act_mem_x_start + 2*($SRAM_512x128_w + $sram_gap_x) + 0.175*($SRAM_512x128_w) - $stripe_p] \
	-stop [expr $shared_act_mem_x_start + 2*($SRAM_512x128_w + $sram_gap_x) + 0.75*($SRAM_512x128_w) + $stripe_p] \
	-merge_stripes_value 10
addStripe \
	-nets "VDD0P8_MRAMVDD_PG" \
	-direction vertical \
	-layer M7 \
	-width $stripe_w -spacing $stripe_s \
	-number_of_sets 1 \
	-start [expr $shared_act_mem_x_start + 2*($SRAM_512x128_w + $sram_gap_x) + 0.26*($SRAM_512x128_w) + $stripe_p + 5] \
	-merge_stripes_value 10
addStripe \
	-nets "VDD0P8_SRAM VDD0P8_NE VSS" \
	-direction vertical \
	-layer M7 \
	-width $stripe_w -spacing $stripe_s \
	-number_of_sets 2 \
	-start [expr $shared_act_mem_x_start + 3*($SRAM_512x128_w + $sram_gap_x) + 0.175*($SRAM_512x128_w) - $stripe_p] \
	-stop [expr $shared_act_mem_x_start + 3*($SRAM_512x128_w + $sram_gap_x) + 0.75*($SRAM_512x128_w) + $stripe_p] \
	-merge_stripes_value 10
addStripe \
	-nets "VDD0P8_MRAMVDD_PG VDD0P8_MRAMVDD_PG VDD0P8_MRAMVDD_PG" \
	-direction vertical \
	-layer M7 \
	-width $stripe_w -spacing $stripe_s \
	-number_of_sets 1 \
	-start [expr $shared_act_mem_x_start + 3*($SRAM_512x128_w + $sram_gap_x) + 0.26*($SRAM_512x128_w) + $stripe_p] \
	-merge_stripes_value 10
addStripe \
	-nets "VDD0P8_SRAM VDD0P8_NE VDD0P8_SRAM" \
	-direction vertical \
	-layer M7 \
	-width $stripe_w -spacing $stripe_s \
	-number_of_sets 1 \
	-start [expr $shared_act_mem_x_start + 4*($SRAM_512x128_w + $sram_gap_x) + 0.175*($SRAM_512x128_w) - $stripe_p] \
	-merge_stripes_value 10
addStripe \
	-nets "VSS VDD0P8_NE VSS" \
	-direction vertical \
	-layer M7 \
	-width $stripe_w -spacing $stripe_s \
	-number_of_sets 1 \
	-start [expr $shared_act_mem_x_start + 4*($SRAM_512x128_w + $sram_gap_x) + 0.68*($SRAM_512x128_w) - $stripe_p] \
	-merge_stripes_value 10
addStripe \
	-nets "VDD0P8_MRAMVDD_PG VDD0P8_MRAMVDD_PG VDD0P8_MRAMVDD_PG" \
	-direction vertical \
	-layer M7 \
	-width $stripe_w -spacing $stripe_s \
	-number_of_sets 1 \
	-start [expr $shared_act_mem_x_start + 4*($SRAM_512x128_w + $sram_gap_x) + 0.26*($SRAM_512x128_w) + $stripe_p] \
	-merge_stripes_value 10
addStripe \
	-nets "VDD0P8_SRAM VDD0P8_NE VSS" \
	-direction vertical \
	-layer M7 \
	-width $stripe_w -spacing $stripe_s \
	-number_of_sets 2 \
	-start [expr $shared_act_mem_x_start + 5*($SRAM_512x128_w + $sram_gap_x) + 0.175*($SRAM_512x128_w) - $stripe_p] \
	-stop [expr $shared_act_mem_x_start + 5*($SRAM_512x128_w + $sram_gap_x) + 0.75*($SRAM_512x128_w) + $stripe_p] \
	-merge_stripes_value 10
addStripe \
	-nets "VDD0P8_MRAMVDDS_PG" \
	-direction vertical \
	-layer M7 \
	-width $stripe_w -spacing $stripe_s \
	-number_of_sets 1 \
	-start [expr $shared_act_mem_x_start + 5*($SRAM_512x128_w + $sram_gap_x) + 0.26*($SRAM_512x128_w) + $stripe_p] \
	-merge_stripes_value 10
addStripe \
	-nets "VDD0P8_SRAM VDD0P8_NE VSS" \
	-direction vertical \
	-layer M7 \
	-width $stripe_w -spacing $stripe_s \
	-number_of_sets 2 \
	-start [expr $shared_act_mem_x_start + 6*($SRAM_512x128_w + $sram_gap_x) + 0.175*($SRAM_512x128_w) - $stripe_p] \
	-stop [expr $shared_act_mem_x_start + 6*($SRAM_512x128_w + $sram_gap_x) + 0.75*($SRAM_512x128_w) + $stripe_p] \
	-merge_stripes_value 10
addStripe \
	-nets "VDD0P8_MRAMVDDS_PG" \
	-direction vertical \
	-layer M7 \
	-width $stripe_w -spacing $stripe_s \
	-number_of_sets 1 \
	-start [expr $shared_act_mem_x_start + 6*($SRAM_512x128_w + $sram_gap_x) + 0.26*($SRAM_512x128_w) + $stripe_p] \
	-merge_stripes_value 10
addStripe \
	-nets "VDD0P8_NE VSS VDD0P8_SRAM" \
	-direction vertical \
	-layer M7 \
	-width $stripe_w -spacing $stripe_s \
	-number_of_sets 2 \
	-start [expr $shared_act_mem_x_start + 7*($SRAM_512x128_w + $sram_gap_x) + 0.175*($SRAM_512x128_w) - $stripe_p] \
	-stop [expr $shared_act_mem_x_start + 7*($SRAM_512x128_w + $sram_gap_x) + 0.75*($SRAM_512x128_w) + $stripe_p] \
	-merge_stripes_value 10
addStripe \
	-nets "VDD0P8_SRAM VDD0P8_NE VSS" \
	-direction vertical \
	-layer M7 \
	-width $stripe_w -spacing $stripe_s \
	-number_of_sets 2 \
	-start [expr $shared_act_mem_x_start + 8*($SRAM_512x128_w + $sram_gap_x) + 0.175*($SRAM_512x128_w) - $stripe_p] \
	-stop [expr $shared_act_mem_x_start + 8*($SRAM_512x128_w + $sram_gap_x) + 0.75*($SRAM_512x128_w) + $stripe_p] \
	-merge_stripes_value 10
addStripe \
	-nets "VDD3P3_MRAMVDIO_PG VDD3P3_MRAMVDIO_PG VDD3P3_MRAMVDIO_PG" \
	-direction vertical \
	-layer M7 \
	-width $stripe_w -spacing $stripe_s \
	-number_of_sets 1 \
	-start [expr $shared_act_mem_x_start + 8*($SRAM_512x128_w + $sram_gap_x) + 0.26*($SRAM_512x128_w) + $stripe_p] \
	-merge_stripes_value 10
addStripe \
	-nets "VSS VDD0P8_NE VDD0P8_SRAM" \
	-direction vertical \
	-layer M7 \
	-width $stripe_w -spacing $stripe_s \
	-number_of_sets 2 \
	-start [expr $shared_act_mem_x_start + 9*($SRAM_512x128_w + $sram_gap_x) + 0.175*($SRAM_512x128_w) - $stripe_p] \
	-stop [expr $shared_act_mem_x_start + 9*($SRAM_512x128_w + $sram_gap_x) + 0.75*($SRAM_512x128_w) + $stripe_p] \
	-merge_stripes_value 10
addStripe \
	-nets "VDD3P3_MRAMVDIO_PG VDD3P3_MRAMVDIO_PG VDD3P3_MRAMVDIO_PG" \
	-direction vertical \
	-layer M7 \
	-width $stripe_w -spacing $stripe_s \
	-number_of_sets 1 \
	-start [expr $shared_act_mem_x_start + 9*($SRAM_512x128_w + $sram_gap_x) + 0.26*($SRAM_512x128_w) + $stripe_p] \
	-merge_stripes_value 10
addStripe \
	-nets "VDD0P8_SRAM VDD0P8_NE VSS" \
	-direction vertical \
	-layer M7 \
	-width $stripe_w -spacing $stripe_s \
	-number_of_sets 2 \
	-start [expr $shared_act_mem_x_start + 10*($SRAM_512x128_w + $sram_gap_x) + 0.175*($SRAM_512x128_w) - $stripe_p] \
	-stop [expr $shared_act_mem_x_start + 10*($SRAM_512x128_w + $sram_gap_x) + 0.75*($SRAM_512x128_w) + $stripe_p] \
	-merge_stripes_value 10
addStripe \
	-nets "VDD3P3_MRAMVDIO_PG VDD3P3_MRAMVDIO_PG VDD3P3_MRAMVDIO_PG" \
	-direction vertical \
	-layer M7 \
	-width $stripe_w -spacing $stripe_s \
	-number_of_sets 1 \
	-start [expr $shared_act_mem_x_start + 10*($SRAM_512x128_w + $sram_gap_x) + 0.26*($SRAM_512x128_w) + $stripe_p] \
	-merge_stripes_value 10
addStripe \
	-nets "VDD0P8_SRAM VDD0P8_NE VSS" \
	-direction vertical \
	-layer M7 \
	-width $stripe_w -spacing $stripe_s \
	-number_of_sets 2 \
	-start [expr $shared_act_mem_x_start + 11*($SRAM_512x128_w + $sram_gap_x) + 0.175*($SRAM_512x128_w) - $stripe_p] \
	-stop [expr $shared_act_mem_x_start + 11*($SRAM_512x128_w + $sram_gap_x) + 0.75*($SRAM_512x128_w) + $stripe_p] \
	-merge_stripes_value 10
addStripe \
	-nets "VDD0P8_SRAM VDD0P8_NE VSS" \
	-direction vertical \
	-layer M7 \
	-width $stripe_w -spacing $stripe_s \
	-number_of_sets 2 \
	-start [expr $shared_act_mem_x_start + 12*($SRAM_512x128_w + $sram_gap_x) + 0.175*($SRAM_512x128_w) - $stripe_p] \
	-stop [expr $shared_act_mem_x_start + 12*($SRAM_512x128_w + $sram_gap_x) + 0.75*($SRAM_512x128_w) + $stripe_p] \
	-merge_stripes_value 10
#addStripe \
	-nets "VDD0P8_SRAM VDD0P8_NE VSS" \
	-direction vertical \
	-layer M7 \
	-width $stripe_w -spacing $stripe_s \
	-number_of_sets 2 \
	-start [expr $shared_act_mem_x_start + 13*($SRAM_512x128_w + $sram_gap_x) + 0.175*($SRAM_512x128_w) - $stripe_p] \
	-stop [expr $shared_act_mem_x_start + 13*($SRAM_512x128_w + $sram_gap_x) + 0.75*($SRAM_512x128_w) + $stripe_p] \
	-merge_stripes_value 10
addStripe \
	-nets "VDD0P8_SRAM VDD0P8_NE VSS" \
	-direction vertical \
	-layer M7 \
	-width $stripe_w -spacing $stripe_s \
	-number_of_sets 1 \
	-start [expr $shared_act_mem_x_start + 13*($SRAM_512x128_w + $sram_gap_x) + 0.175*($SRAM_512x128_w) - $stripe_p] \
	-merge_stripes_value 10
addStripe \
	-nets "VDD0P8_NE VSS VDD0P8_SRAM" \
	-direction vertical \
	-layer M7 \
	-width $stripe_w -spacing $stripe_s \
	-number_of_sets 1 \
	-start [expr $shared_act_mem_x_start + 13*($SRAM_512x128_w + $sram_gap_x) + 0.175*($SRAM_512x128_w) - $stripe_p + 33.97] \
	-merge_stripes_value 10

addStripe \
	-nets "VDD0P8_SRAM VDD0P8_NE VSS" \
	-direction vertical \
	-layer M7 \
	-width $stripe_w -spacing $stripe_s \
	-number_of_sets 1 \
	-start [expr $shared_act_mem_x_start + 14*($SRAM_512x128_w + $sram_gap_x) + 0.175*($SRAM_512x128_w) - $stripe_p] \
	-merge_stripes_value 10
addStripe \
	-nets "VDD3P3_MRAMVDIO VDD0P8_NE VSS" \
	-direction vertical \
	-layer M7 \
	-width $stripe_w -spacing $stripe_s \
	-number_of_sets 1 \
	-start [expr $shared_act_mem_x_start + 14*($SRAM_512x128_w + $sram_gap_x) + 0.175*($SRAM_512x128_w) - $stripe_p + 33.97] \
	-merge_stripes_value 10
#addStripe \
	-nets "VDD0P8_SRAM VDD0P8_NE VSS" \
	-direction vertical \
	-layer M7 \
	-width $stripe_w -spacing $stripe_s \
	-number_of_sets 2 \
	-start [expr $shared_act_mem_x_start + 14*($SRAM_512x128_w + $sram_gap_x) + 0.175*($SRAM_512x128_w) - $stripe_p] \
	-stop [expr $shared_act_mem_x_start + 14*($SRAM_512x128_w + $sram_gap_x) + 0.75*($SRAM_512x128_w) + $stripe_p] \
	-merge_stripes_value 10
addStripe \
	-nets "VDD3P3_MRAMVDIO_PG" \
	-direction vertical \
	-layer M7 \
	-width $stripe_w -spacing $stripe_s \
	-number_of_sets 1 \
	-start [expr $shared_act_mem_x_start + 14*($SRAM_512x128_w + $sram_gap_x) + 0.26*($SRAM_512x128_w) + $stripe_p + 10] \
	-merge_stripes_value 10

addStripe \
	-nets "VDD0P8_SRAM VDD0P8_NE VSS" \
	-direction vertical \
	-layer M7 \
	-width $stripe_w -spacing $stripe_s \
	-number_of_sets 2 \
	-start [expr $shared_act_mem_x_start + 15*($SRAM_512x128_w + $sram_gap_x) + 0.175*($SRAM_512x128_w) - $stripe_p] \
	-stop [expr $shared_act_mem_x_start + 15*($SRAM_512x128_w + $sram_gap_x) + 0.75*($SRAM_512x128_w) + $stripe_p] \
	-merge_stripes_value 10
addStripe \
	-nets " VSS VDD0P8_NE VDD0P8_CLK VDD3P3_MRAMVDIO VDD0P8_SRAM" \
	-direction vertical \
	-layer M7 \
	-width $stripe_w -spacing $stripe_s \
	-number_of_sets 1 \
	-start [expr $shared_act_mem_x_start + 16*($SRAM_512x128_w + $sram_gap_x) + 0.175*($SRAM_512x128_w) - $stripe_p] \
	-merge_stripes_value 10
addStripe \
	-nets "VDD0P8_SRAM VDD0P8_NE VSS" \
	-direction vertical \
	-layer M7 \
	-width $stripe_w -spacing $stripe_s \
	-number_of_sets 1 \
	-start [expr $shared_act_mem_x_start + 17*($SRAM_512x128_w + $sram_gap_x) + 0.175*($SRAM_512x128_w) - $stripe_p] \
	-merge_stripes_value 10
addStripe \
	-nets "VSS VDD0P8_NE VDD0P8_SRAM VDD0P8_CLK VDD3P3_MRAMVDIO" \
	-direction vertical \
	-layer M7 \
	-width $stripe_w -spacing $stripe_s \
	-number_of_sets 1 \
	-start [expr $shared_act_mem_x_start + 17*($SRAM_512x128_w + $sram_gap_x) + 0.26*($SRAM_512x128_w) + $stripe_p] \
	-merge_stripes_value 10
addStripe \
	-nets "VSS VDD0P8_NE VSS" \
	-direction vertical \
	-layer M7 \
	-width $stripe_w -spacing $stripe_s \
	-number_of_sets 1 \
	-start [expr $shared_act_mem_x_start + 18*($SRAM_512x128_w + $sram_gap_x) + 0.175*($SRAM_512x128_w) - $stripe_p] \
	-merge_stripes_value 10
addStripe \
	-nets "VDD0P8_SRAM VDD3P3_MRAMVDIO VDD0P8_SRAM VDD0P8_CLK VDD0P8_NE " \
	-direction vertical \
	-layer M7 \
	-width $stripe_w -spacing $stripe_s \
	-number_of_sets 1 \
	-start [expr $shared_act_mem_x_start + 18*($SRAM_512x128_w + $sram_gap_x) + 0.26*($SRAM_512x128_w) + $stripe_p] \
	-merge_stripes_value 10
addStripe \
	-nets "VSS VDD0P8_SRAM VDD3P3_MRAMVDIO" \
	-direction vertical \
	-layer M7 \
	-width $stripe_w -spacing $stripe_s \
	-number_of_sets 1 \
	-start [expr $shared_act_mem_x_start + 19*($SRAM_512x128_w + $sram_gap_x) + 0.175*($SRAM_512x128_w) - $stripe_p] \
	-merge_stripes_value 10
addStripe \
	-nets "VDD0P8_SRAM VDD0P8_NE VSS" \
	-direction vertical \
	-layer M7 \
	-width $stripe_w -spacing $stripe_s \
	-number_of_sets 1 \
	-start [expr $shared_act_mem_x_start + 19*($SRAM_512x128_w + $sram_gap_x) + 0.535*($SRAM_512x128_w) + $stripe_p] \
	-merge_stripes_value 10
addStripe \
	-nets "VDD0P8_NE VSS VDD0P8_SRAM" \
	-direction vertical \
	-layer M7 \
	-width $stripe_w -spacing $stripe_s \
	-number_of_sets 2 \
	-start [expr $shared_act_mem_x_start + 20*($SRAM_512x128_w + $sram_gap_x) + 0.175*($SRAM_512x128_w) - $stripe_p] \
	-stop [expr $shared_act_mem_x_start + 20*($SRAM_512x128_w + $sram_gap_x) + 0.75*($SRAM_512x128_w) + $stripe_p] \
	-merge_stripes_value 10
addStripe \
	-nets "VDD0P8_SRAM VDD3P3_MRAMVDIO" \
	-direction vertical \
	-layer M7 \
	-width $stripe_w -spacing $stripe_s \
	-number_of_sets 1 \
	-start [expr $shared_act_mem_x_start + 21*($SRAM_512x128_w + $sram_gap_x) + 0.175*($SRAM_512x128_w) - $stripe_p] \
	-merge_stripes_value 10
addStripe \
	-nets "VDD0P8_CLK VDD0P8_SRAM VDD0P8_NE VSS" \
	-direction vertical \
	-layer M7 \
	-width $stripe_w -spacing $stripe_s \
	-number_of_sets 1 \
	-start [expr $shared_act_mem_x_start + 21*($SRAM_512x128_w + $sram_gap_x) + 0.75*($SRAM_512x128_w) - $stripe_p] \
	-merge_stripes_value 10
addStripe \
	-nets "VDD0P8_SRAM VDD3P3_MRAMVDIO" \
	-direction vertical \
	-layer M7 \
	-width $stripe_w -spacing $stripe_s \
	-number_of_sets 1 \
	-start [expr $shared_act_mem_x_start + 22*($SRAM_512x128_w + $sram_gap_x) + 0.175*($SRAM_512x128_w) - $stripe_p] \
	-merge_stripes_value 10
addStripe \
	-nets "VDD0P8_CLK VDD0P8_SRAM VDD0P8_NE VSS" \
	-direction vertical \
	-layer M7 \
	-width $stripe_w -spacing $stripe_s \
	-number_of_sets 1 \
	-start [expr $shared_act_mem_x_start + 22*($SRAM_512x128_w + $sram_gap_x) + 0.75*($SRAM_512x128_w) - $stripe_p] \
	-merge_stripes_value 10
addStripe \
	-nets "VDD0P8_CLK VDD0P8_SRAM VDD0P8_NE VSS" \
	-direction vertical \
	-layer M7 \
	-width $stripe_w -spacing $stripe_s \
	-number_of_sets 1 \
	-start [expr $shared_act_mem_x_start + 23*($SRAM_512x128_w + $sram_gap_x) + 0.75*($SRAM_512x128_w) - $stripe_p] \
	-merge_stripes_value 10
addStripe \
	-nets "VDD0P8_CLK VDD3P3_MRAMVDIO" \
	-direction vertical \
	-layer M7 \
	-width $stripe_w -spacing $stripe_s \
	-number_of_sets 1 \
	-start [expr $shared_act_mem_x_start + 0*($SRAM_512x128_w + $sram_gap_x) + 0.75*($SRAM_512x128_w) + $stripe_p + $stripe_s] \
	-merge_stripes_value 10
addStripe \
	-nets "VDD0P8_CLK VDD3P3_MRAMVDIO" \
	-direction vertical \
	-layer M7 \
	-width $stripe_w -spacing $stripe_s \
	-number_of_sets 1 \
	-start [expr $shared_act_mem_x_start + 1*($SRAM_512x128_w + $sram_gap_x) + 0.75*($SRAM_512x128_w) + $stripe_p + $stripe_s] \
	-merge_stripes_value 10
addStripe \
	-nets "VDD0P8_CLK VDD3P3_MRAMVDIO" \
	-direction vertical \
	-layer M7 \
	-width $stripe_w -spacing $stripe_s \
	-number_of_sets 1 \
	-start [expr $shared_act_mem_x_start + 2*($SRAM_512x128_w + $sram_gap_x) + 0.75*($SRAM_512x128_w) + $stripe_p + $stripe_s] \
	-merge_stripes_value 10
addStripe \
	-nets "VDD0P8_CLK VDD3P3_MRAMVDIO" \
	-direction vertical \
	-layer M7 \
	-width $stripe_w -spacing $stripe_s \
	-number_of_sets 1 \
	-start [expr $shared_act_mem_x_start + 3*($SRAM_512x128_w + $sram_gap_x) + 0.75*($SRAM_512x128_w) + $stripe_p + $stripe_s] \
	-merge_stripes_value 10
addStripe \
	-nets "VDD0P8_CLK VDD3P3_MRAMVDIO" \
	-direction vertical \
	-layer M7 \
	-width $stripe_w -spacing $stripe_s \
	-number_of_sets 1 \
	-start [expr $shared_act_mem_x_start + 4*($SRAM_512x128_w + $sram_gap_x) + 0.75*($SRAM_512x128_w) + $stripe_p + $stripe_s] \
	-merge_stripes_value 10
addStripe \
	-nets "VDD0P8_CLK VDD3P3_MRAMVDIO" \
	-direction vertical \
	-layer M7 \
	-width $stripe_w -spacing $stripe_s \
	-number_of_sets 1 \
	-start [expr $shared_act_mem_x_start + 5*($SRAM_512x128_w + $sram_gap_x) + 0.75*($SRAM_512x128_w) + $stripe_p + $stripe_s] \
	-merge_stripes_value 10
addStripe \
	-nets "VDD0P8_CLK VDD3P3_MRAMVDIO" \
	-direction vertical \
	-layer M7 \
	-width $stripe_w -spacing $stripe_s \
	-number_of_sets 1 \
	-start [expr $shared_act_mem_x_start + 6*($SRAM_512x128_w + $sram_gap_x) + 0.75*($SRAM_512x128_w) + $stripe_p + $stripe_s] \
	-merge_stripes_value 10
addStripe \
	-nets "VDD0P8_CLK VDD3P3_MRAMVDIO" \
	-direction vertical \
	-layer M7 \
	-width $stripe_w -spacing $stripe_s \
	-number_of_sets 1 \
	-start [expr $shared_act_mem_x_start + 7*($SRAM_512x128_w + $sram_gap_x) + 0.75*($SRAM_512x128_w) + $stripe_p + $stripe_s] \
	-merge_stripes_value 10
addStripe \
	-nets "VDD0P8_CLK VDD3P3_MRAMVDIO" \
	-direction vertical \
	-layer M7 \
	-width $stripe_w -spacing $stripe_s \
	-number_of_sets 1 \
	-start [expr $shared_act_mem_x_start + 8*($SRAM_512x128_w + $sram_gap_x) + 0.75*($SRAM_512x128_w) + $stripe_p + $stripe_s] \
	-merge_stripes_value 10
addStripe \
	-nets "VDD0P8_CLK VDD3P3_MRAMVDIO" \
	-direction vertical \
	-layer M7 \
	-width $stripe_w -spacing $stripe_s \
	-number_of_sets 1 \
	-start [expr $shared_act_mem_x_start + 9*($SRAM_512x128_w + $sram_gap_x) + 0.75*($SRAM_512x128_w) + $stripe_p + $stripe_s] \
	-merge_stripes_value 10
addStripe \
	-nets "VDD0P8_CLK VDD3P3_MRAMVDIO" \
	-direction vertical \
	-layer M7 \
	-width $stripe_w -spacing $stripe_s \
	-number_of_sets 1 \
	-start [expr $shared_act_mem_x_start + 10*($SRAM_512x128_w + $sram_gap_x) + 0.75*($SRAM_512x128_w) + $stripe_p + $stripe_s] \
	-merge_stripes_value 10
addStripe \
	-nets "VDD0P8_CLK VDD3P3_MRAMVDIO" \
	-direction vertical \
	-layer M7 \
	-width $stripe_w -spacing $stripe_s \
	-number_of_sets 1 \
	-start [expr $shared_act_mem_x_start + 11*($SRAM_512x128_w + $sram_gap_x) + 0.75*($SRAM_512x128_w) + $stripe_p + $stripe_s] \
	-merge_stripes_value 10
addStripe \
	-nets "VDD0P8_CLK VDD3P3_MRAMVDIO" \
	-direction vertical \
	-layer M7 \
	-width $stripe_w -spacing $stripe_s \
	-number_of_sets 1 \
	-start [expr $shared_act_mem_x_start + 12*($SRAM_512x128_w + $sram_gap_x) + 0.75*($SRAM_512x128_w) + $stripe_p + $stripe_s] \
	-merge_stripes_value 10
addStripe \
	-nets "VDD0P8_CLK VDD3P3_MRAMVDIO" \
	-direction vertical \
	-layer M7 \
	-width $stripe_w -spacing $stripe_s \
	-number_of_sets 1 \
	-start [expr $shared_act_mem_x_start + 13*($SRAM_512x128_w + $sram_gap_x) + 0.75*($SRAM_512x128_w) + $stripe_p + $stripe_s] \
	-merge_stripes_value 10
addStripe \
	-nets "VDD0P8_CLK VDD0P8_SRAM" \
	-direction vertical \
	-layer M7 \
	-width $stripe_w -spacing $stripe_s \
	-number_of_sets 1 \
	-start [expr $shared_act_mem_x_start + 14*($SRAM_512x128_w + $sram_gap_x) + 0.75*($SRAM_512x128_w) + $stripe_p + $stripe_s] \
	-merge_stripes_value 10
addStripe \
	-nets "VDD0P8_CLK VDD3P3_MRAMVDIO" \
	-direction vertical \
	-layer M7 \
	-width $stripe_w -spacing $stripe_s \
	-number_of_sets 1 \
	-start [expr $shared_act_mem_x_start + 15*($SRAM_512x128_w + $sram_gap_x) + 0.75*($SRAM_512x128_w) + $stripe_p + $stripe_s] \
	-merge_stripes_value 10
addStripe \
	-nets "VDD0P8_NE VDD0P8_CLK" \
	-direction vertical \
	-layer M7 \
	-width $stripe_w -spacing $stripe_s \
	-number_of_sets 1 \
	-start [expr $shared_act_mem_x_start + 19*($SRAM_512x128_w + $sram_gap_x) + 0.75*($SRAM_512x128_w) + $stripe_p + $stripe_s] \
	-merge_stripes_value 10
addStripe \
	-nets "VDD0P8_CLK VDD3P3_MRAMVDIO" \
	-direction vertical \
	-layer M7 \
	-width $stripe_w -spacing $stripe_s \
	-number_of_sets 1 \
	-start [expr $shared_act_mem_x_start + 20*($SRAM_512x128_w + $sram_gap_x) + 0.75*($SRAM_512x128_w) + $stripe_p + $stripe_s] \
	-merge_stripes_value 10
addStripe \
	-nets "VSS VDD0P8_NE" \
	-direction vertical \
	-layer M7 \
	-width $stripe_w -spacing $stripe_s \
	-number_of_sets 1 \
	-start [expr $shared_act_mem_x_start + 21*($SRAM_512x128_w + $sram_gap_x) + 0.425*($SRAM_512x128_w) + $stripe_p + $stripe_s] \
	-merge_stripes_value 10
addStripe \
	-nets "VDD0P8_NE VSS" \
	-direction vertical \
	-layer M7 \
	-width $stripe_w -spacing $stripe_s \
	-number_of_sets 1 \
	-start [expr $shared_act_mem_x_start + 22*($SRAM_512x128_w + $sram_gap_x) + 0.335*($SRAM_512x128_w) + $stripe_p + $stripe_s + 5] \
	-merge_stripes_value 10
addStripe \
	-nets "VDD0P8_SRAM VDD0P8_NE VSS" \
	-direction vertical \
	-layer M7 \
	-width $stripe_w -spacing $stripe_s \
	-number_of_sets 1 \
	-start [expr $shared_act_mem_x_start + 23*($SRAM_512x128_w + $sram_gap_x) + 0.335*($SRAM_512x128_w) + $stripe_p + $stripe_s] \
	-merge_stripes_value 10
# Interval
addStripe \
	-nets "VDD0P8_NE VSS " \
	-direction vertical \
	-layer M7 \
	-width $stripe_w -spacing $stripe_s \
	-number_of_sets 1 \
	-start [expr $shared_act_mem_x_start + (0 + 1)*($SRAM_512x128_w) + (0 + 0.5)*($sram_gap_x) - $stripe_w - 0.5*($stripe_s)] \
	-merge_stripes_value 10
addStripe \
	-nets "VDD0P8_NE VSS " \
	-direction vertical \
	-layer M7 \
	-width $stripe_w -spacing $stripe_s \
	-number_of_sets 1 \
	-start [expr $shared_act_mem_x_start + (1 + 1)*($SRAM_512x128_w) + (1 + 0.5)*($sram_gap_x) - $stripe_w - 0.5*($stripe_s)] \
	-merge_stripes_value 10
addStripe \
	-nets "VDD0P8_NE VSS " \
	-direction vertical \
	-layer M7 \
	-width $stripe_w -spacing $stripe_s \
	-number_of_sets 1 \
	-start [expr $shared_act_mem_x_start + (2 + 1)*($SRAM_512x128_w) + (2 + 0.5)*($sram_gap_x) - $stripe_w - 0.5*($stripe_s)] \
	-merge_stripes_value 10
addStripe \
	-nets "VDD0P8_NE VSS " \
	-direction vertical \
	-layer M7 \
	-width $stripe_w -spacing $stripe_s \
	-number_of_sets 1 \
	-start [expr $shared_act_mem_x_start + (3 + 1)*($SRAM_512x128_w) + (3 + 0.5)*($sram_gap_x) - $stripe_w - 0.5*($stripe_s)] \
	-merge_stripes_value 10
addStripe \
	-nets "VDD0P8_NE VSS " \
	-direction vertical \
	-layer M7 \
	-width $stripe_w -spacing $stripe_s \
	-number_of_sets 1 \
	-start [expr $shared_act_mem_x_start + (4 + 1)*($SRAM_512x128_w) + (4 + 0.5)*($sram_gap_x) - $stripe_w - 0.5*($stripe_s)] \
	-merge_stripes_value 10
addStripe \
	-nets "VDD0P8_NE VSS " \
	-direction vertical \
	-layer M7 \
	-width $stripe_w -spacing $stripe_s \
	-number_of_sets 1 \
	-start [expr $shared_act_mem_x_start + (5 + 1)*($SRAM_512x128_w) + (5 + 0.5)*($sram_gap_x) - $stripe_w - 0.5*($stripe_s)] \
	-merge_stripes_value 10
addStripe \
	-nets "VDD0P8_NE VSS " \
	-direction vertical \
	-layer M7 \
	-width $stripe_w -spacing $stripe_s \
	-number_of_sets 1 \
	-start [expr $shared_act_mem_x_start + (6 + 1)*($SRAM_512x128_w) + (6 + 0.5)*($sram_gap_x) - $stripe_w - 0.5*($stripe_s)] \
	-merge_stripes_value 10
addStripe \
	-nets "VDD0P8_NE VSS " \
	-direction vertical \
	-layer M7 \
	-width $stripe_w -spacing $stripe_s \
	-number_of_sets 1 \
	-start [expr $shared_act_mem_x_start + (7 + 1)*($SRAM_512x128_w) + (7 + 0.5)*($sram_gap_x) - $stripe_w - 0.5*($stripe_s)] \
	-merge_stripes_value 10
addStripe \
	-nets "VDD0P8_NE VSS " \
	-direction vertical \
	-layer M7 \
	-width $stripe_w -spacing $stripe_s \
	-number_of_sets 1 \
	-start [expr $shared_act_mem_x_start + (8 + 1)*($SRAM_512x128_w) + (8 + 0.5)*($sram_gap_x) - $stripe_w - 0.5*($stripe_s)] \
	-merge_stripes_value 10
addStripe \
	-nets "VDD0P8_NE VSS " \
	-direction vertical \
	-layer M7 \
	-width $stripe_w -spacing $stripe_s \
	-number_of_sets 1 \
	-start [expr $shared_act_mem_x_start + (9 + 1)*($SRAM_512x128_w) + (9 + 0.5)*($sram_gap_x) - $stripe_w - 0.5*($stripe_s)] \
	-merge_stripes_value 10
addStripe \
	-nets "VDD0P8_NE VSS " \
	-direction vertical \
	-layer M7 \
	-width $stripe_w -spacing $stripe_s \
	-number_of_sets 1 \
	-start [expr $shared_act_mem_x_start + (10 + 1)*($SRAM_512x128_w) + (10 + 0.5)*($sram_gap_x) - $stripe_w - 0.5*($stripe_s)] \
	-merge_stripes_value 10
addStripe \
	-nets "VDD0P8_NE VSS " \
	-direction vertical \
	-layer M7 \
	-width $stripe_w -spacing $stripe_s \
	-number_of_sets 1 \
	-start [expr $shared_act_mem_x_start + (11 + 1)*($SRAM_512x128_w) + (11 + 0.5)*($sram_gap_x) - $stripe_w - 0.5*($stripe_s)] \
	-merge_stripes_value 10
addStripe \
	-nets "VDD0P8_NE VSS " \
	-direction vertical \
	-layer M7 \
	-width $stripe_w -spacing $stripe_s \
	-number_of_sets 1 \
	-start [expr $shared_act_mem_x_start + (12 + 1)*($SRAM_512x128_w) + (12 + 0.5)*($sram_gap_x) - $stripe_w - 0.5*($stripe_s)] \
	-merge_stripes_value 10
addStripe \
	-nets "VDD0P8_NE VSS " \
	-direction vertical \
	-layer M7 \
	-width $stripe_w -spacing $stripe_s \
	-number_of_sets 1 \
	-start [expr $shared_act_mem_x_start + (13 + 1)*($SRAM_512x128_w) + (13 + 0.5)*($sram_gap_x) - $stripe_w - 0.5*($stripe_s)] \
	-merge_stripes_value 10
addStripe \
	-nets "VDD0P8_NE VSS " \
	-direction vertical \
	-layer M7 \
	-width $stripe_w -spacing $stripe_s \
	-number_of_sets 1 \
	-start [expr $shared_act_mem_x_start + (14 + 1)*($SRAM_512x128_w) + (14 + 0.5)*($sram_gap_x) - $stripe_w - 0.5*($stripe_s)] \
	-merge_stripes_value 10
addStripe \
	-nets "VDD0P8_NE VSS " \
	-direction vertical \
	-layer M7 \
	-width $stripe_w -spacing $stripe_s \
	-number_of_sets 1 \
	-start [expr $shared_act_mem_x_start + (15 + 1)*($SRAM_512x128_w) + (15 + 0.5)*($sram_gap_x) - $stripe_w - 0.5*($stripe_s)] \
	-merge_stripes_value 10
addStripe \
	-nets "VDD0P8_NE VSS " \
	-direction vertical \
	-layer M7 \
	-width $stripe_w -spacing $stripe_s \
	-number_of_sets 1 \
	-start [expr $shared_act_mem_x_start + (16 + 1)*($SRAM_512x128_w) + (16 + 0.5)*($sram_gap_x) - $stripe_w - 0.5*($stripe_s)] \
	-merge_stripes_value 10
addStripe \
	-nets "VDD0P8_NE VSS " \
	-direction vertical \
	-layer M7 \
	-width $stripe_w -spacing $stripe_s \
	-number_of_sets 1 \
	-start [expr $shared_act_mem_x_start + (17 + 1)*($SRAM_512x128_w) + (17 + 0.5)*($sram_gap_x) - $stripe_w - 0.5*($stripe_s)] \
	-merge_stripes_value 10
addStripe \
	-nets "VDD0P8_NE VSS " \
	-direction vertical \
	-layer M7 \
	-width $stripe_w -spacing $stripe_s \
	-number_of_sets 1 \
	-start [expr $shared_act_mem_x_start + (18 + 1)*($SRAM_512x128_w) + (18 + 0.5)*($sram_gap_x) - $stripe_w - 0.5*($stripe_s)] \
	-merge_stripes_value 10
addStripe \
	-nets "VDD0P8_NE VSS " \
	-direction vertical \
	-layer M7 \
	-width $stripe_w -spacing $stripe_s \
	-number_of_sets 1 \
	-start [expr $shared_act_mem_x_start + (19 + 1)*($SRAM_512x128_w) + (19 + 0.5)*($sram_gap_x) - $stripe_w - 0.5*($stripe_s)] \
	-merge_stripes_value 10
addStripe \
	-nets "VDD0P8_NE VSS " \
	-direction vertical \
	-layer M7 \
	-width $stripe_w -spacing $stripe_s \
	-number_of_sets 1 \
	-start [expr $shared_act_mem_x_start + (20 + 1)*($SRAM_512x128_w) + (20 + 0.5)*($sram_gap_x) - $stripe_w - 0.5*($stripe_s)] \
	-merge_stripes_value 10
addStripe \
	-nets "VDD0P8_NE VSS " \
	-direction vertical \
	-layer M7 \
	-width $stripe_w -spacing $stripe_s \
	-number_of_sets 1 \
	-start [expr $shared_act_mem_x_start + (21 + 1)*($SRAM_512x128_w) + (21 + 0.5)*($sram_gap_x) - $stripe_w - 0.5*($stripe_s)] \
	-merge_stripes_value 10
addStripe \
	-nets "VDD0P8_NE VSS " \
	-direction vertical \
	-layer M7 \
	-width $stripe_w -spacing $stripe_s \
	-number_of_sets 1 \
	-start [expr $shared_act_mem_x_start + (22 + 1)*($SRAM_512x128_w) + (22 + 0.5)*($sram_gap_x) - $stripe_w - 0.5*($stripe_s) + 2.08] \
	-merge_stripes_value 10
# M9
setAddStripeMode -stacked_via_bottom_layer M8
setAddStripeMode -stacked_via_top_layer    M9
# Non-Interval
addStripe \
	-nets "VDD0P8_NE VSS" \
	-direction vertical \
	-layer M9 \
	-width $stripe_w -spacing $stripe_s \
	-number_of_sets 1 \
	-start [expr $shared_act_mem_x_start + 0*($SRAM_512x128_w + $sram_gap_x) + 0.175*($SRAM_512x128_w) - $stripe_p + 5] \
	-merge_stripes_value 10
addStripe \
	-nets "VDD0P8_SRAM VDD0P8_NE VSS" \
	-direction vertical \
	-layer M9 \
	-width $stripe_w -spacing $stripe_s \
	-number_of_sets 1 \
	-start [expr $shared_act_mem_x_start + 0*($SRAM_512x128_w + $sram_gap_x) + 0.175*($SRAM_512x128_w) - $stripe_p + 33.97] \
	-merge_stripes_value 10
#addStripe \
	-nets "VDD0P8_SRAM VDD0P8_NE VSS" \
	-direction vertical \
	-layer M9 \
	-width $stripe_w -spacing $stripe_s \
	-number_of_sets 2 \
	-start [expr $shared_act_mem_x_start + 0*($SRAM_512x128_w + $sram_gap_x) + 0.175*($SRAM_512x128_w) - $stripe_p] \
	-stop [expr $shared_act_mem_x_start + 0*($SRAM_512x128_w + $sram_gap_x) + 0.75*($SRAM_512x128_w) + $stripe_p] \
	-merge_stripes_value 10
addStripe \
	-nets "VDD0P8_MRAMVDDS_PG VDD0P8_MRAMVDD_PG VDD3P3_MRAMVDIO_PG" \
	-direction vertical \
	-layer M9 \
	-width $stripe_w -spacing $stripe_s \
	-number_of_sets 1 \
	-start [expr $shared_act_mem_x_start + 0*($SRAM_512x128_w + $sram_gap_x) + 0.26*($SRAM_512x128_w) + $stripe_p] \
	-merge_stripes_value 10
addStripe \
	-nets "VSS VDD0P8_NE VSS" \
	-direction vertical \
	-layer M9 \
	-width $stripe_w -spacing $stripe_s \
	-number_of_sets 1 \
	-start [expr $shared_act_mem_x_start + 1*($SRAM_512x128_w + $sram_gap_x) + 0.175*($SRAM_512x128_w) - $stripe_p] \
	-merge_stripes_value 10
addStripe \
	-nets "VDD0P8_NE VDD0P8_SRAM" \
	-direction vertical \
	-layer M9 \
	-width $stripe_w -spacing $stripe_s \
	-number_of_sets 1 \
	-start [expr $shared_act_mem_x_start + 1*($SRAM_512x128_w + $sram_gap_x) + 0.68*($SRAM_512x128_w) - $stripe_p + 5] \
	-merge_stripes_value 10
addStripe \
	-nets "VDD0P8_MRAMVDDS_PG VDD0P8_MRAMVDD_PG VDD3P3_MRAMVDIO_PG" \
	-direction vertical \
	-layer M9 \
	-width $stripe_w -spacing $stripe_s \
	-number_of_sets 1 \
	-start [expr $shared_act_mem_x_start + 1*($SRAM_512x128_w + $sram_gap_x) + 0.26*($SRAM_512x128_w) + $stripe_p] \
	-merge_stripes_value 10
addStripe \
	-nets "VDD0P8_NE VSS" \
	-direction vertical \
	-layer M9 \
	-width $stripe_w -spacing $stripe_s \
	-number_of_sets 1 \
	-start [expr $shared_act_mem_x_start + 2*($SRAM_512x128_w + $sram_gap_x) + 0.175*($SRAM_512x128_w) - $stripe_p + 5] \
	-merge_stripes_value 10
addStripe \
	-nets "VDD0P8_SRAM VDD0P8_NE VSS" \
	-direction vertical \
	-layer M9 \
	-width $stripe_w -spacing $stripe_s \
	-number_of_sets 1 \
	-start [expr $shared_act_mem_x_start + 2*($SRAM_512x128_w + $sram_gap_x) + 0.175*($SRAM_512x128_w) - $stripe_p + 33.97] \
	-merge_stripes_value 10
addStripe \
	-nets "VDD0P8_MRAMVDDS_PG VDD0P8_MRAMVDD_PG VDD3P3_MRAMVDIO_PG" \
	-direction vertical \
	-layer M9 \
	-width $stripe_w -spacing $stripe_s \
	-number_of_sets 1 \
	-start [expr $shared_act_mem_x_start + 2*($SRAM_512x128_w + $sram_gap_x) + 0.26*($SRAM_512x128_w) + $stripe_p] \
	-merge_stripes_value 10
addStripe \
	-nets "VDD0P8_NE VSS" \
	-direction vertical \
	-layer M9 \
	-width $stripe_w -spacing $stripe_s \
	-number_of_sets 1 \
	-start [expr $shared_act_mem_x_start + 3*($SRAM_512x128_w + $sram_gap_x) + 0.175*($SRAM_512x128_w) - $stripe_p + 5] \
	-merge_stripes_value 10
addStripe \
	-nets "VDD0P8_SRAM VDD0P8_NE VSS" \
	-direction vertical \
	-layer M9 \
	-width $stripe_w -spacing $stripe_s \
	-number_of_sets 1 \
	-start [expr $shared_act_mem_x_start + 3*($SRAM_512x128_w + $sram_gap_x) + 0.175*($SRAM_512x128_w) - $stripe_p + 33.97] \
	-merge_stripes_value 10
addStripe \
	-nets "VDD0P8_MRAMVDD_PG VDD0P8_MRAMVDD_PG VDD0P8_MRAMVDD_PG" \
	-direction vertical \
	-layer M9 \
	-width $stripe_w -spacing $stripe_s \
	-number_of_sets 1 \
	-start [expr $shared_act_mem_x_start + 3*($SRAM_512x128_w + $sram_gap_x) + 0.26*($SRAM_512x128_w) + $stripe_p] \
	-merge_stripes_value 10
addStripe \
	-nets "VDD0P8_NE VDD0P8_SRAM" \
	-direction vertical \
	-layer M9 \
	-width $stripe_w -spacing $stripe_s \
	-number_of_sets 1 \
	-start [expr $shared_act_mem_x_start + 4*($SRAM_512x128_w + $sram_gap_x) + 0.175*($SRAM_512x128_w) - $stripe_p + 5] \
	-merge_stripes_value 10
addStripe \
	-nets "VSS VDD0P8_NE VSS" \
	-direction vertical \
	-layer M9 \
	-width $stripe_w -spacing $stripe_s \
	-number_of_sets 1 \
	-start [expr $shared_act_mem_x_start + 4*($SRAM_512x128_w + $sram_gap_x) + 0.68*($SRAM_512x128_w) - $stripe_p] \
	-merge_stripes_value 10
addStripe \
	-nets "VDD0P8_MRAMVDD_PG VDD0P8_MRAMVDD_PG VDD0P8_MRAMVDD_PG" \
	-direction vertical \
	-layer M9 \
	-width $stripe_w -spacing $stripe_s \
	-number_of_sets 1 \
	-start [expr $shared_act_mem_x_start + 4*($SRAM_512x128_w + $sram_gap_x) + 0.26*($SRAM_512x128_w) + $stripe_p] \
	-merge_stripes_value 10
addStripe \
	-nets "VDD0P8_NE VSS" \
	-direction vertical \
	-layer M9 \
	-width $stripe_w -spacing $stripe_s \
	-number_of_sets 1 \
	-start [expr $shared_act_mem_x_start + 5*($SRAM_512x128_w + $sram_gap_x) + 0.175*($SRAM_512x128_w) - $stripe_p + 5] \
	-merge_stripes_value 10
addStripe \
	-nets "VDD0P8_SRAM VDD0P8_NE VSS" \
	-direction vertical \
	-layer M9 \
	-width $stripe_w -spacing $stripe_s \
	-number_of_sets 1 \
	-start [expr $shared_act_mem_x_start + 5*($SRAM_512x128_w + $sram_gap_x) + 0.175*($SRAM_512x128_w) - $stripe_p + 33.97] \
	-merge_stripes_value 10
addStripe \
	-nets "VDD0P8_MRAMVDDS_PG VDD0P8_MRAMVDD_PG VDD3P3_MRAMVDIO_PG" \
	-direction vertical \
	-layer M9 \
	-width $stripe_w -spacing $stripe_s \
	-number_of_sets 1 \
	-start [expr $shared_act_mem_x_start + 5*($SRAM_512x128_w + $sram_gap_x) + 0.26*($SRAM_512x128_w) + $stripe_p] \
	-merge_stripes_value 10
addStripe \
	-nets "VDD0P8_NE VSS" \
	-direction vertical \
	-layer M9 \
	-width $stripe_w -spacing $stripe_s \
	-number_of_sets 1 \
	-start [expr $shared_act_mem_x_start + 6*($SRAM_512x128_w + $sram_gap_x) + 0.175*($SRAM_512x128_w) - $stripe_p + 5] \
	-merge_stripes_value 10
addStripe \
	-nets "VDD0P8_SRAM VDD0P8_NE VSS" \
	-direction vertical \
	-layer M9 \
	-width $stripe_w -spacing $stripe_s \
	-number_of_sets 1 \
	-start [expr $shared_act_mem_x_start + 6*($SRAM_512x128_w + $sram_gap_x) + 0.175*($SRAM_512x128_w) - $stripe_p + 33.97] \
	-merge_stripes_value 10
addStripe \
	-nets "VDD0P8_MRAMVDDS_PG VDD0P8_MRAMVDD_PG VDD3P3_MRAMVDIO_PG" \
	-direction vertical \
	-layer M9 \
	-width $stripe_w -spacing $stripe_s \
	-number_of_sets 1 \
	-start [expr $shared_act_mem_x_start + 6*($SRAM_512x128_w + $sram_gap_x) + 0.26*($SRAM_512x128_w) + $stripe_p] \
	-merge_stripes_value 10
addStripe \
	-nets "VDD0P8_NE VSS" \
	-direction vertical \
	-layer M9 \
	-width $stripe_w -spacing $stripe_s \
	-number_of_sets 1 \
	-start [expr $shared_act_mem_x_start + 7*($SRAM_512x128_w + $sram_gap_x) + 0.175*($SRAM_512x128_w) - $stripe_p] \
	-merge_stripes_value 10
addStripe \
	-nets "VDD0P8_NE VSS VDD0P8_SRAM" \
	-direction vertical \
	-layer M9 \
	-width $stripe_w -spacing $stripe_s \
	-number_of_sets 1 \
	-start [expr $shared_act_mem_x_start + 7*($SRAM_512x128_w + $sram_gap_x) + 0.175*($SRAM_512x128_w) - $stripe_p + 33.97] \
	-merge_stripes_value 10
addStripe \
	-nets "VDD0P8_MRAMVDDS_PG VDD0P8_MRAMVDD_PG VDD3P3_MRAMVDIO_PG" \
	-direction vertical \
	-layer M9 \
	-width $stripe_w -spacing $stripe_s \
	-number_of_sets 1 \
	-start [expr $shared_act_mem_x_start + 7*($SRAM_512x128_w + $sram_gap_x) + 0.26*($SRAM_512x128_w) + $stripe_p] \
	-merge_stripes_value 10


addStripe \
	-nets "VDD0P8_NE VSS" \
	-direction vertical \
	-layer M9 \
	-width $stripe_w -spacing $stripe_s \
	-number_of_sets 1 \
	-start [expr $shared_act_mem_x_start + 8*($SRAM_512x128_w + $sram_gap_x) + 0.175*($SRAM_512x128_w) - $stripe_p + 5] \
	-merge_stripes_value 10
addStripe \
	-nets "VDD0P8_SRAM VDD0P8_NE VSS" \
	-direction vertical \
	-layer M9 \
	-width $stripe_w -spacing $stripe_s \
	-number_of_sets 1 \
	-start [expr $shared_act_mem_x_start + 8*($SRAM_512x128_w + $sram_gap_x) + 0.175*($SRAM_512x128_w) - $stripe_p + 33.97] \
	-merge_stripes_value 10

addStripe \
	-nets "VDD3P3_MRAMVDIO_PG VDD3P3_MRAMVDIO_PG VDD3P3_MRAMVDIO_PG" \
	-direction vertical \
	-layer M9 \
	-width $stripe_w -spacing $stripe_s \
	-number_of_sets 1 \
	-start [expr $shared_act_mem_x_start + 8*($SRAM_512x128_w + $sram_gap_x) + 0.26*($SRAM_512x128_w) + $stripe_p] \
	-merge_stripes_value 10

addStripe \
	-nets "VSS VDD0P8_NE" \
	-direction vertical \
	-layer M9 \
	-width $stripe_w -spacing $stripe_s \
	-number_of_sets 1 \
	-start [expr $shared_act_mem_x_start + 9*($SRAM_512x128_w + $sram_gap_x) + 0.175*($SRAM_512x128_w) - $stripe_p] \
	-merge_stripes_value 10
addStripe \
	-nets "VSS VDD0P8_NE VDD0P8_SRAM" \
	-direction vertical \
	-layer M9 \
	-width $stripe_w -spacing $stripe_s \
	-number_of_sets 1 \
	-start [expr $shared_act_mem_x_start + 9*($SRAM_512x128_w + $sram_gap_x) + 0.175*($SRAM_512x128_w) - $stripe_p + 33.97] \
	-merge_stripes_value 10

addStripe \
	-nets "VDD3P3_MRAMVDIO_PG VDD3P3_MRAMVDIO_PG VDD3P3_MRAMVDIO_PG" \
	-direction vertical \
	-layer M9 \
	-width $stripe_w -spacing $stripe_s \
	-number_of_sets 1 \
	-start [expr $shared_act_mem_x_start + 9*($SRAM_512x128_w + $sram_gap_x) + 0.26*($SRAM_512x128_w) + $stripe_p] \
	-merge_stripes_value 10

addStripe \
	-nets "VDD0P8_NE VSS" \
	-direction vertical \
	-layer M9 \
	-width $stripe_w -spacing $stripe_s \
	-number_of_sets 1 \
	-start [expr $shared_act_mem_x_start + 10*($SRAM_512x128_w + $sram_gap_x) + 0.175*($SRAM_512x128_w) - $stripe_p + 5] \
	-merge_stripes_value 10
addStripe \
	-nets "VDD0P8_SRAM VDD0P8_NE VSS" \
	-direction vertical \
	-layer M9 \
	-width $stripe_w -spacing $stripe_s \
	-number_of_sets 1 \
	-start [expr $shared_act_mem_x_start + 10*($SRAM_512x128_w + $sram_gap_x) + 0.175*($SRAM_512x128_w) - $stripe_p + 33.97] \
	-merge_stripes_value 10

addStripe \
	-nets "VDD3P3_MRAMVDIO_PG VDD3P3_MRAMVDIO_PG VDD3P3_MRAMVDIO_PG" \
	-direction vertical \
	-layer M9 \
	-width $stripe_w -spacing $stripe_s \
	-number_of_sets 1 \
	-start [expr $shared_act_mem_x_start + 10*($SRAM_512x128_w + $sram_gap_x) + 0.26*($SRAM_512x128_w) + $stripe_p] \
	-merge_stripes_value 10

addStripe \
	-nets "VDD0P8_NE VSS" \
	-direction vertical \
	-layer M9 \
	-width $stripe_w -spacing $stripe_s \
	-number_of_sets 1 \
	-start [expr $shared_act_mem_x_start + 11*($SRAM_512x128_w + $sram_gap_x) + 0.175*($SRAM_512x128_w) - $stripe_p + 5] \
	-merge_stripes_value 10
addStripe \
	-nets "VDD0P8_SRAM VDD0P8_NE VSS" \
	-direction vertical \
	-layer M9 \
	-width $stripe_w -spacing $stripe_s \
	-number_of_sets 1 \
	-start [expr $shared_act_mem_x_start + 11*($SRAM_512x128_w + $sram_gap_x) + 0.175*($SRAM_512x128_w) - $stripe_p + 33.97] \
	-merge_stripes_value 10

addStripe \
	-nets "VDD0P8_MRAMVDDS_PG VDD0P8_MRAMVDD_PG VDD3P3_MRAMVDIO_PG" \
	-direction vertical \
	-layer M9 \
	-width $stripe_w -spacing $stripe_s \
	-number_of_sets 1 \
	-start [expr $shared_act_mem_x_start + 11*($SRAM_512x128_w + $sram_gap_x) + 0.26*($SRAM_512x128_w) + $stripe_p] \
	-merge_stripes_value 10

addStripe \
	-nets "VDD0P8_NE VSS" \
	-direction vertical \
	-layer M9 \
	-width $stripe_w -spacing $stripe_s \
	-number_of_sets 1 \
	-start [expr $shared_act_mem_x_start + 12*($SRAM_512x128_w + $sram_gap_x) + 0.175*($SRAM_512x128_w) - $stripe_p + 5] \
	-merge_stripes_value 10
addStripe \
	-nets "VDD0P8_SRAM VDD0P8_NE VSS" \
	-direction vertical \
	-layer M9 \
	-width $stripe_w -spacing $stripe_s \
	-number_of_sets 1 \
	-start [expr $shared_act_mem_x_start + 12*($SRAM_512x128_w + $sram_gap_x) + 0.175*($SRAM_512x128_w) - $stripe_p + 33.97] \
	-merge_stripes_value 10

addStripe \
	-nets "VDD0P8_MRAMVDDS_PG VDD0P8_MRAMVDD_PG VDD3P3_MRAMVDIO_PG" \
	-direction vertical \
	-layer M9 \
	-width $stripe_w -spacing $stripe_s \
	-number_of_sets 1 \
	-start [expr $shared_act_mem_x_start + 12*($SRAM_512x128_w + $sram_gap_x) + 0.26*($SRAM_512x128_w) + $stripe_p] \
	-merge_stripes_value 10

addStripe \
	-nets "VDD0P8_NE VSS" \
	-direction vertical \
	-layer M9 \
	-width $stripe_w -spacing $stripe_s \
	-number_of_sets 1 \
	-start [expr $shared_act_mem_x_start + 13*($SRAM_512x128_w + $sram_gap_x) + 0.175*($SRAM_512x128_w) - $stripe_p + 5] \
	-merge_stripes_value 10
addStripe \
	-nets "VDD0P8_NE VSS VDD0P8_SRAM" \
	-direction vertical \
	-layer M9 \
	-width $stripe_w -spacing $stripe_s \
	-number_of_sets 1 \
	-start [expr $shared_act_mem_x_start + 13*($SRAM_512x128_w + $sram_gap_x) + 0.175*($SRAM_512x128_w) - $stripe_p + 33.97] \
	-merge_stripes_value 10

addStripe \
	-nets "VDD0P8_MRAMVDDS_PG VDD0P8_MRAMVDD_PG VDD3P3_MRAMVDIO_PG" \
	-direction vertical \
	-layer M9 \
	-width $stripe_w -spacing $stripe_s \
	-number_of_sets 1 \
	-start [expr $shared_act_mem_x_start + 13*($SRAM_512x128_w + $sram_gap_x) + 0.26*($SRAM_512x128_w) + $stripe_p] \
	-merge_stripes_value 10

addStripe \
	-nets "VDD0P8_NE VSS" \
	-direction vertical \
	-layer M9 \
	-width $stripe_w -spacing $stripe_s \
	-number_of_sets 1 \
	-start [expr $shared_act_mem_x_start + 14*($SRAM_512x128_w + $sram_gap_x) + 0.175*($SRAM_512x128_w) - $stripe_p + 5] \
	-merge_stripes_value 10
addStripe \
	-nets "VDD3P3_MRAMVDIO VDD0P8_NE VSS" \
	-direction vertical \
	-layer M9 \
	-width $stripe_w -spacing $stripe_s \
	-number_of_sets 1 \
	-start [expr $shared_act_mem_x_start + 14*($SRAM_512x128_w + $sram_gap_x) + 0.175*($SRAM_512x128_w) - $stripe_p + 33.97] \
	-merge_stripes_value 10

addStripe \
	-nets "VDD0P8_MRAMVDDS_PG VDD0P8_MRAMVDD_PG VDD3P3_MRAMVDIO_PG" \
	-direction vertical \
	-layer M9 \
	-width $stripe_w -spacing $stripe_s \
	-number_of_sets 1 \
	-start [expr $shared_act_mem_x_start + 14*($SRAM_512x128_w + $sram_gap_x) + 0.26*($SRAM_512x128_w) + $stripe_p] \
	-merge_stripes_value 10

addStripe \
	-nets "VDD0P8_NE VSS" \
	-direction vertical \
	-layer M9 \
	-width $stripe_w -spacing $stripe_s \
	-number_of_sets 1 \
	-start [expr $shared_act_mem_x_start + 15*($SRAM_512x128_w + $sram_gap_x) + 0.175*($SRAM_512x128_w) - $stripe_p + 5] \
	-merge_stripes_value 10
addStripe \
	-nets "VDD0P8_SRAM VDD0P8_NE VSS" \
	-direction vertical \
	-layer M9 \
	-width $stripe_w -spacing $stripe_s \
	-number_of_sets 1 \
	-start [expr $shared_act_mem_x_start + 15*($SRAM_512x128_w + $sram_gap_x) + 0.175*($SRAM_512x128_w) - $stripe_p + 33.97] \
	-merge_stripes_value 10
addStripe \
	-nets "VDD0P8_MRAMVDDS_PG VDD0P8_MRAMVDD_PG VDD3P3_MRAMVDIO_PG" \
	-direction vertical \
	-layer M9 \
	-width $stripe_w -spacing $stripe_s \
	-number_of_sets 1 \
	-start [expr $shared_act_mem_x_start + 15*($SRAM_512x128_w + $sram_gap_x) + 0.26*($SRAM_512x128_w) + $stripe_p] \
	-merge_stripes_value 10
addStripe \
	-nets " VSS VDD0P8_NE VDD0P8_CLK VDD3P3_MRAMVDIO VDD0P8_SRAM" \
	-direction vertical \
	-layer M9 \
	-width $stripe_w -spacing $stripe_s \
	-number_of_sets 1 \
	-start [expr $shared_act_mem_x_start + 16*($SRAM_512x128_w + $sram_gap_x) + 0.175*($SRAM_512x128_w) - $stripe_p] \
	-merge_stripes_value 10
addStripe \
	-nets "VDD0P8_MRAMVDDS_PG VDD0P8_MRAMVDD_PG VDD3P3_MRAMVDIO_PG" \
	-direction vertical \
	-layer M9 \
	-width $stripe_w -spacing $stripe_s \
	-number_of_sets 1 \
	-start [expr $shared_act_mem_x_start + 16*($SRAM_512x128_w + $sram_gap_x) + 0.5*($SRAM_512x128_w) + $stripe_p] \
	-merge_stripes_value 10
addStripe \
	-nets "VDD0P8_NE VSS" \
	-direction vertical \
	-layer M9 \
	-width $stripe_w -spacing $stripe_s \
	-number_of_sets 1 \
	-start [expr $shared_act_mem_x_start + 17*($SRAM_512x128_w + $sram_gap_x) + 0.175*($SRAM_512x128_w) - $stripe_p + 5] \
	-merge_stripes_value 10
addStripe \
	-nets "VSS VDD0P8_NE VDD0P8_SRAM VDD0P8_CLK VDD3P3_MRAMVDIO" \
	-direction vertical \
	-layer M9 \
	-width $stripe_w -spacing $stripe_s \
	-number_of_sets 1 \
	-start [expr $shared_act_mem_x_start + 17*($SRAM_512x128_w + $sram_gap_x) + 0.26*($SRAM_512x128_w) + $stripe_p] \
	-merge_stripes_value 10
addStripe \
	-nets "VSS VDD0P8_NE VSS" \
	-direction vertical \
	-layer M9 \
	-width $stripe_w -spacing $stripe_s \
	-number_of_sets 1 \
	-start [expr $shared_act_mem_x_start + 18*($SRAM_512x128_w + $sram_gap_x) + 0.175*($SRAM_512x128_w) - $stripe_p] \
	-merge_stripes_value 10
addStripe \
	-nets "VDD3P3_MRAMVDIO VDD0P8_SRAM VDD0P8_CLK VDD0P8_NE " \
	-direction vertical \
	-layer M9 \
	-width $stripe_w -spacing $stripe_s \
	-number_of_sets 1 \
	-start [expr $shared_act_mem_x_start + 18*($SRAM_512x128_w + $sram_gap_x) + 0.26*($SRAM_512x128_w) + $stripe_p + 5] \
	-merge_stripes_value 10
addStripe \
	-nets "VSS VDD0P8_SRAM VDD3P3_MRAMVDIO" \
	-direction vertical \
	-layer M9 \
	-width $stripe_w -spacing $stripe_s \
	-number_of_sets 1 \
	-start [expr $shared_act_mem_x_start + 19*($SRAM_512x128_w + $sram_gap_x) + 0.175*($SRAM_512x128_w) - $stripe_p] \
	-merge_stripes_value 10
addStripe \
	-nets "VDD0P8_NE VSS" \
	-direction vertical \
	-layer M9 \
	-width $stripe_w -spacing $stripe_s \
	-number_of_sets 1 \
	-start [expr $shared_act_mem_x_start + 19*($SRAM_512x128_w + $sram_gap_x) + 0.535*($SRAM_512x128_w) + $stripe_p + 5] \
	-merge_stripes_value 10
addStripe \
	-nets "VDD0P8_MRAMVDDS_PG VDD0P8_MRAMVDD_PG VDD3P3_MRAMVDIO_PG" \
	-direction vertical \
	-layer M9 \
	-width $stripe_w -spacing $stripe_s \
	-number_of_sets 1 \
	-start [expr $shared_act_mem_x_start + 19*($SRAM_512x128_w + $sram_gap_x) + 0.26*($SRAM_512x128_w) + $stripe_p] \
	-merge_stripes_value 10
 

addStripe \
	-nets "VDD0P8_NE VSS" \
	-direction vertical \
	-layer M9 \
	-width $stripe_w -spacing $stripe_s \
	-number_of_sets 1 \
	-start [expr $shared_act_mem_x_start + 20*($SRAM_512x128_w + $sram_gap_x) + 0.175*($SRAM_512x128_w) - $stripe_p] \
	-merge_stripes_value 10
addStripe \
	-nets "VDD0P8_NE VSS VDD0P8_SRAM" \
	-direction vertical \
	-layer M9 \
	-width $stripe_w -spacing $stripe_s \
	-number_of_sets 1 \
	-start [expr $shared_act_mem_x_start + 20*($SRAM_512x128_w + $sram_gap_x) + 0.175*($SRAM_512x128_w) - $stripe_p + 33.97] \
	-merge_stripes_value 10

addStripe \
	-nets "VDD0P8_MRAMVDDS_PG VDD0P8_MRAMVDD_PG VDD3P3_MRAMVDIO_PG" \
	-direction vertical \
	-layer M9 \
	-width $stripe_w -spacing $stripe_s \
	-number_of_sets 1 \
	-start [expr $shared_act_mem_x_start + 20*($SRAM_512x128_w + $sram_gap_x) + 0.26*($SRAM_512x128_w) + $stripe_p] \
	-merge_stripes_value 10
addStripe \
	-nets "VDD3P3_MRAMVDIO" \
	-direction vertical \
	-layer M9 \
	-width $stripe_w -spacing $stripe_s \
	-number_of_sets 1 \
	-start [expr $shared_act_mem_x_start + 21*($SRAM_512x128_w + $sram_gap_x) + 0.175*($SRAM_512x128_w) - $stripe_p + 5] \
	-merge_stripes_value 10
addStripe \
	-nets "VDD0P8_SRAM VDD0P8_NE VSS" \
	-direction vertical \
	-layer M9 \
	-width $stripe_w -spacing $stripe_s \
	-number_of_sets 1 \
	-start [expr $shared_act_mem_x_start + 21*($SRAM_512x128_w + $sram_gap_x) + 0.75*($SRAM_512x128_w) - $stripe_p + 5] \
	-merge_stripes_value 10
addStripe \
	-nets "VDD0P8_MRAMVDDS_PG VDD0P8_MRAMVDD_PG VDD3P3_MRAMVDIO_PG" \
	-direction vertical \
	-layer M9 \
	-width $stripe_w -spacing $stripe_s \
	-number_of_sets 1 \
	-start [expr $shared_act_mem_x_start + 21*($SRAM_512x128_w + $sram_gap_x) + 0.195*($SRAM_512x128_w) + $stripe_p] \
	-merge_stripes_value 10
addStripe \
	-nets "VDD3P3_MRAMVDIO" \
	-direction vertical \
	-layer M9 \
	-width $stripe_w -spacing $stripe_s \
	-number_of_sets 1 \
	-start [expr $shared_act_mem_x_start + 22*($SRAM_512x128_w + $sram_gap_x) + 0.175*($SRAM_512x128_w) - $stripe_p + 5] \
	-merge_stripes_value 10
addStripe \
	-nets "VDD0P8_MRAMVDDS_PG VDD0P8_MRAMVDD_PG VDD3P3_MRAMVDIO_PG" \
	-direction vertical \
	-layer M9 \
	-width $stripe_w -spacing $stripe_s \
	-number_of_sets 1 \
	-start [expr $shared_act_mem_x_start + 22*($SRAM_512x128_w + $sram_gap_x) + 0.195*($SRAM_512x128_w) + $stripe_p] \
	-merge_stripes_value 10
addStripe \
	-nets "VDD0P8_SRAM VDD0P8_NE VSS" \
	-direction vertical \
	-layer M9 \
	-width $stripe_w -spacing $stripe_s \
	-number_of_sets 1 \
	-start [expr $shared_act_mem_x_start + 22*($SRAM_512x128_w + $sram_gap_x) + 0.75*($SRAM_512x128_w) - $stripe_p + 5] \
	-merge_stripes_value 10
addStripe \
	-nets "VDD0P8_SRAM VDD0P8_NE VSS" \
	-direction vertical \
	-layer M9 \
	-width $stripe_w -spacing $stripe_s \
	-number_of_sets 1 \
	-start [expr $shared_act_mem_x_start + 23*($SRAM_512x128_w + $sram_gap_x) + 0.75*($SRAM_512x128_w) - $stripe_p + 5] \
	-merge_stripes_value 10
addStripe \
	-nets "VDD3P3_MRAMVDIO" \
	-direction vertical \
	-layer M9 \
	-width $stripe_w -spacing $stripe_s \
	-number_of_sets 1 \
	-start [expr $shared_act_mem_x_start + 0*($SRAM_512x128_w + $sram_gap_x) + 0.75*($SRAM_512x128_w) + $stripe_p + $stripe_s + 5] \
	-merge_stripes_value 10
addStripe \
	-nets "VDD3P3_MRAMVDIO" \
	-direction vertical \
	-layer M9 \
	-width $stripe_w -spacing $stripe_s \
	-number_of_sets 1 \
	-start [expr $shared_act_mem_x_start + 1*($SRAM_512x128_w + $sram_gap_x) + 0.75*($SRAM_512x128_w) + $stripe_p + $stripe_s + 5] \
	-merge_stripes_value 10
addStripe \
	-nets "VDD3P3_MRAMVDIO" \
	-direction vertical \
	-layer M9 \
	-width $stripe_w -spacing $stripe_s \
	-number_of_sets 1 \
	-start [expr $shared_act_mem_x_start + 2*($SRAM_512x128_w + $sram_gap_x) + 0.75*($SRAM_512x128_w) + $stripe_p + $stripe_s + 5] \
	-merge_stripes_value 10
addStripe \
	-nets "VDD3P3_MRAMVDIO" \
	-direction vertical \
	-layer M9 \
	-width $stripe_w -spacing $stripe_s \
	-number_of_sets 1 \
	-start [expr $shared_act_mem_x_start + 3*($SRAM_512x128_w + $sram_gap_x) + 0.75*($SRAM_512x128_w) + $stripe_p + $stripe_s + 5] \
	-merge_stripes_value 10
addStripe \
	-nets "VDD3P3_MRAMVDIO" \
	-direction vertical \
	-layer M9 \
	-width $stripe_w -spacing $stripe_s \
	-number_of_sets 1 \
	-start [expr $shared_act_mem_x_start + 4*($SRAM_512x128_w + $sram_gap_x) + 0.75*($SRAM_512x128_w) + $stripe_p + $stripe_s + 5] \
	-merge_stripes_value 10
addStripe \
	-nets "VDD3P3_MRAMVDIO" \
	-direction vertical \
	-layer M9 \
	-width $stripe_w -spacing $stripe_s \
	-number_of_sets 1 \
	-start [expr $shared_act_mem_x_start + 5*($SRAM_512x128_w + $sram_gap_x) + 0.75*($SRAM_512x128_w) + $stripe_p + $stripe_s + 5] \
	-merge_stripes_value 10
addStripe \
	-nets "VDD3P3_MRAMVDIO" \
	-direction vertical \
	-layer M9 \
	-width $stripe_w -spacing $stripe_s \
	-number_of_sets 1 \
	-start [expr $shared_act_mem_x_start + 6*($SRAM_512x128_w + $sram_gap_x) + 0.75*($SRAM_512x128_w) + $stripe_p + $stripe_s + 5] \
	-merge_stripes_value 10
addStripe \
	-nets "VDD3P3_MRAMVDIO" \
	-direction vertical \
	-layer M9 \
	-width $stripe_w -spacing $stripe_s \
	-number_of_sets 1 \
	-start [expr $shared_act_mem_x_start + 7*($SRAM_512x128_w + $sram_gap_x) + 0.75*($SRAM_512x128_w) + $stripe_p + $stripe_s + 5] \
	-merge_stripes_value 10
addStripe \
	-nets "VDD3P3_MRAMVDIO" \
	-direction vertical \
	-layer M9 \
	-width $stripe_w -spacing $stripe_s \
	-number_of_sets 1 \
	-start [expr $shared_act_mem_x_start + 8*($SRAM_512x128_w + $sram_gap_x) + 0.75*($SRAM_512x128_w) + $stripe_p + $stripe_s + 5] \
	-merge_stripes_value 10
addStripe \
	-nets "VDD3P3_MRAMVDIO" \
	-direction vertical \
	-layer M9 \
	-width $stripe_w -spacing $stripe_s \
	-number_of_sets 1 \
	-start [expr $shared_act_mem_x_start + 9*($SRAM_512x128_w + $sram_gap_x) + 0.75*($SRAM_512x128_w) + $stripe_p + $stripe_s + 5] \
	-merge_stripes_value 10
addStripe \
	-nets "VDD3P3_MRAMVDIO" \
	-direction vertical \
	-layer M9 \
	-width $stripe_w -spacing $stripe_s \
	-number_of_sets 1 \
	-start [expr $shared_act_mem_x_start + 10*($SRAM_512x128_w + $sram_gap_x) + 0.75*($SRAM_512x128_w) + $stripe_p + $stripe_s + 5] \
	-merge_stripes_value 10
addStripe \
	-nets "VDD3P3_MRAMVDIO" \
	-direction vertical \
	-layer M9 \
	-width $stripe_w -spacing $stripe_s \
	-number_of_sets 1 \
	-start [expr $shared_act_mem_x_start + 11*($SRAM_512x128_w + $sram_gap_x) + 0.75*($SRAM_512x128_w) + $stripe_p + $stripe_s + 5] \
	-merge_stripes_value 10
addStripe \
	-nets "VDD3P3_MRAMVDIO" \
	-direction vertical \
	-layer M9 \
	-width $stripe_w -spacing $stripe_s \
	-number_of_sets 1 \
	-start [expr $shared_act_mem_x_start + 12*($SRAM_512x128_w + $sram_gap_x) + 0.75*($SRAM_512x128_w) + $stripe_p + $stripe_s + 5] \
	-merge_stripes_value 10
addStripe \
	-nets "VDD3P3_MRAMVDIO" \
	-direction vertical \
	-layer M9 \
	-width $stripe_w -spacing $stripe_s \
	-number_of_sets 1 \
	-start [expr $shared_act_mem_x_start + 13*($SRAM_512x128_w + $sram_gap_x) + 0.75*($SRAM_512x128_w) + $stripe_p + $stripe_s + 5] \
	-merge_stripes_value 10
addStripe \
	-nets "VDD0P8_SRAM" \
	-direction vertical \
	-layer M9 \
	-width $stripe_w -spacing $stripe_s \
	-number_of_sets 1 \
	-start [expr $shared_act_mem_x_start + 14*($SRAM_512x128_w + $sram_gap_x) + 0.75*($SRAM_512x128_w) + $stripe_p + $stripe_s + 5] \
	-merge_stripes_value 10
addStripe \
	-nets "VDD3P3_MRAMVDIO" \
	-direction vertical \
	-layer M9 \
	-width $stripe_w -spacing $stripe_s \
	-number_of_sets 1 \
	-start [expr $shared_act_mem_x_start + 15*($SRAM_512x128_w + $sram_gap_x) + 0.75*($SRAM_512x128_w) + $stripe_p + $stripe_s + 5] \
	-merge_stripes_value 10
addStripe \
	-nets "VDD0P8_NE" \
	-direction vertical \
	-layer M9 \
	-width $stripe_w -spacing $stripe_s \
	-number_of_sets 1 \
	-start [expr $shared_act_mem_x_start + 19*($SRAM_512x128_w + $sram_gap_x) + 0.75*($SRAM_512x128_w) + $stripe_p + $stripe_s] \
	-merge_stripes_value 10
addStripe \
	-nets "VDD3P3_MRAMVDIO" \
	-direction vertical \
	-layer M9 \
	-width $stripe_w -spacing $stripe_s \
	-number_of_sets 1 \
	-start [expr $shared_act_mem_x_start + 20*($SRAM_512x128_w + $sram_gap_x) + 0.75*($SRAM_512x128_w) + $stripe_p + $stripe_s + 5] \
	-merge_stripes_value 10
addStripe \
	-nets "VSS VDD0P8_NE" \
	-direction vertical \
	-layer M9 \
	-width $stripe_w -spacing $stripe_s \
	-number_of_sets 1 \
	-start [expr $shared_act_mem_x_start + 21*($SRAM_512x128_w + $sram_gap_x) + 0.425*($SRAM_512x128_w) + $stripe_p + $stripe_s] \
	-merge_stripes_value 10
addStripe \
	-nets "VDD0P8_NE VSS" \
	-direction vertical \
	-layer M9 \
	-width $stripe_w -spacing $stripe_s \
	-number_of_sets 1 \
	-start [expr $shared_act_mem_x_start + 22*($SRAM_512x128_w + $sram_gap_x) + 0.335*($SRAM_512x128_w) + $stripe_p + $stripe_s + 5] \
	-merge_stripes_value 10
addStripe \
	-nets "VDD0P8_SRAM VDD0P8_NE VSS" \
	-direction vertical \
	-layer M9 \
	-width $stripe_w -spacing $stripe_s \
	-number_of_sets 1 \
	-start [expr $shared_act_mem_x_start + 23*($SRAM_512x128_w + $sram_gap_x) + 0.335*($SRAM_512x128_w) + $stripe_p + $stripe_s] \
	-merge_stripes_value 10
# MRAM Boundary stripes, for DRC
# M7
setAddStripeMode -stacked_via_bottom_layer M1
setAddStripeMode -stacked_via_top_layer    M8
addStripe \
	-nets "VSS VDD3P3_MRAMVDIO_PG VDD0P8_MRAMVDDS_PG VDD0P8_MRAMVDD_PG VDD0P8_NE" \
	-direction vertical \
	-layer M7 \
	-width 1.8 -spacing 1.2 \
	-number_of_sets 1 \
	-start [expr $mram_x_start - $mram_halo_l + 1.2] \
	-merge_stripes_value 10
addStripe \
	-nets "VDD0P8_MRAMVDD_PG VDD0P8_MRAMVDDS_PG VDD3P3_MRAMVDIO_PG VSS" \
	-direction vertical \
	-layer M7 \
	-width 1.8 -spacing 1.2 \
	-number_of_sets 1 \
	-start [expr $shared_act_mem_x_start + 23*($SRAM_512x128_w + $sram_gap_x) + 0.175*($SRAM_512x128_w) - $stripe_p] \
	-merge_stripes_value 10

# Right Boundary stripes
# M7
addStripe \
	-nets "VSS VDD0P8_NE" \
	-direction vertical \
	-layer M7 \
	-width $stripe_w -spacing $stripe_s \
	-number_of_sets 1 \
	-start [expr $accumulator_mem_x_end - 11] \
	-merge_stripes_value 10

# Vertical Stripes
# Small stripes for accumulator memory banks
# M7
setAddStripeMode -stacked_via_bottom_layer M1
setAddStripeMode -stacked_via_top_layer    M8
# Non-Interval
addStripe \
	-nets "VSS VDD0P8_SRAM VDD0P8_NE" \
	-direction vertical \
	-layer M7 \
	-width $stripe_w -spacing $stripe_s \
    -number_of_sets 1 \
	-start [expr $accumulator_mem_x_start + 0.5*($RF_32x96_w) - $stripe_p - 6] -stop [expr $accumulator_mem_x_end] \
	-merge_stripes_value 10
addStripe \
	-nets "VSS VDD0P8_NE VDD0P8_SRAM" \
	-direction vertical \
	-layer M7 \
	-width $stripe_w -spacing $stripe_s \
    -number_of_sets 1 \
	-start [expr $accumulator_mem_x_start + 1.5*($RF_32x96_w) + $sram_gap_x - $stripe_p - 6] -stop [expr $accumulator_mem_x_end] \
	-merge_stripes_value 10
addStripe \
	-nets "VSS VDD0P8_NE VDD0P8_SRAM" \
	-direction vertical \
	-layer M7 \
	-width $stripe_w -spacing $stripe_s \
    -number_of_sets 1 \
	-start [expr $accumulator_mem_x_start + 2.5*($RF_32x96_w) + 2 * $sram_gap_x - $stripe_p - 6] -stop [expr $accumulator_mem_x_end] \
	-merge_stripes_value 10
addStripe \
	-nets "VDD0P8_SRAM VDD0P8_NE VSS " \
	-direction vertical \
	-layer M7 \
	-width $stripe_w -spacing $stripe_s \
    -number_of_sets 1 \
	-start [expr $accumulator_mem_x_start + 3.5*($RF_32x96_w) + 3 * $sram_gap_x - $stripe_p + 0.5] -stop [expr $accumulator_mem_x_end] \
	-merge_stripes_value 10
# Interval
addStripe \
	-nets "VSS VDD0P8_NE" \
	-direction vertical \
	-layer M7 \
	-width $stripe_w -spacing $stripe_s \
	-number_of_sets 1 \
	-start [expr $accumulator_mem_x_start + (0 + 1)*($RF_32x96_w) + (0 + 0.5)*($sram_gap_x) - $stripe_w - 0.5*($stripe_s)] \
	-merge_stripes_value 10
addStripe \
	-nets "VSS VDD0P8_NE" \
	-direction vertical \
	-layer M7 \
	-width $stripe_w -spacing $stripe_s \
	-number_of_sets 1 \
	-start [expr $accumulator_mem_x_start + (1 + 1)*($RF_32x96_w) + (1 + 0.5)*($sram_gap_x) - 6] \
	-merge_stripes_value 10
addStripe \
	-nets "VSS VDD0P8_NE" \
	-direction vertical \
	-layer M7 \
	-width $stripe_w -spacing $stripe_s \
	-number_of_sets 1 \
	-start [expr $accumulator_mem_x_start + (2 + 1)*($RF_32x96_w) + (2 + 0.5)*($sram_gap_x) - $stripe_w - 0.5*($stripe_s)] \
	-merge_stripes_value 10

# M9
setAddStripeMode -stacked_via_bottom_layer M8
setAddStripeMode -stacked_via_top_layer    M9
# Non-Interval
addStripe \
	-nets "VSS VDD0P8_SRAM VDD0P8_NE" \
	-direction vertical \
	-layer M9 \
	-width $stripe_w -spacing $stripe_s \
    -number_of_sets 1 \
	-start [expr $accumulator_mem_x_start + 0.5*($RF_32x96_w) - $stripe_p - 6] -stop [expr $accumulator_mem_x_end] \
	-merge_stripes_value 10
addStripe \
	-nets "VSS VDD0P8_NE VDD0P8_SRAM" \
	-direction vertical \
	-layer M9 \
	-width $stripe_w -spacing $stripe_s \
    -number_of_sets 1 \
	-start [expr $accumulator_mem_x_start + 1.5*($RF_32x96_w) + $sram_gap_x - $stripe_p - 6] -stop [expr $accumulator_mem_x_end] \
	-merge_stripes_value 10
addStripe \
	-nets "VSS VDD0P8_NE VDD0P8_SRAM" \
	-direction vertical \
	-layer M9 \
	-width $stripe_w -spacing $stripe_s \
    -number_of_sets 1 \
	-start [expr $accumulator_mem_x_start + 2.5*($RF_32x96_w) + 2 * $sram_gap_x - $stripe_p - 6] -stop [expr $accumulator_mem_x_end] \
	-merge_stripes_value 10
addStripe \
	-nets "VDD0P8_SRAM VDD0P8_NE VSS " \
	-direction vertical \
	-layer M9 \
	-width $stripe_w -spacing $stripe_s \
    -number_of_sets 1 \
	-start [expr $accumulator_mem_x_start + 3.5*($RF_32x96_w) + 3 * $sram_gap_x - $stripe_p + 0.5] -stop [expr $accumulator_mem_x_end] \
	-merge_stripes_value 10

# Small stripes for weight memory
# M7
setAddStripeMode -stacked_via_bottom_layer M1
setAddStripeMode -stacked_via_top_layer    M8
#Non-interval
addStripe \
	-nets "VSS VDD0P8_CLK VDD0P8_NE VDD0P8_SRAM" \
	-direction vertical \
	-layer M7 \
	-width $stripe_w -spacing $stripe_s \
	-number_of_sets 2 \
	-start [expr $weight_mem_x_start + 0*($SRAM_512x80_w + $sram_gap_x) + 0.25*($SRAM_512x80_w) - $stripe_p] \
	-stop [expr $weight_mem_x_start + 0*($SRAM_512x80_w + $sram_gap_x) + 0.75*($SRAM_512x80_w) + $stripe_p] \
	-merge_stripes_value 10
addStripe \
	-nets "VDD0P8_SRAM VDD0P8_CLK VDD0P8_NE VSS" \
	-direction vertical \
	-layer M7 \
	-width $stripe_w -spacing $stripe_s \
	-number_of_sets 2 \
	-start [expr $weight_mem_x_start + 1*($SRAM_512x80_w + $sram_gap_x) + 0.25*($SRAM_512x80_w) - $stripe_p - 1] \
	-stop [expr $weight_mem_x_start + 1*($SRAM_512x80_w + $sram_gap_x) + 0.75*($SRAM_512x80_w) + $stripe_p] \
	-merge_stripes_value 10
addStripe \
	-nets "VDD0P8_SRAM VDD0P8_CLK VDD0P8_NE VSS" \
	-direction vertical \
	-layer M7 \
	-width $stripe_w -spacing $stripe_s \
	-number_of_sets 2 \
	-start [expr $weight_mem_x_start + 2*($SRAM_512x80_w + $sram_gap_x) + 0.25*($SRAM_512x80_w) - $stripe_p] \
	-stop [expr $weight_mem_x_start + 2*($SRAM_512x80_w + $sram_gap_x) + 0.75*($SRAM_512x80_w) + $stripe_p] \
	-merge_stripes_value 10
addStripe \
	-nets "VDD0P8_SRAM VDD0P8_CLK VDD0P8_NE VSS" \
	-direction vertical \
	-layer M7 \
	-width $stripe_w -spacing $stripe_s \
	-number_of_sets 2 \
	-start [expr $weight_mem_x_start + 3*($SRAM_512x80_w + $sram_gap_x) + 0.25*($SRAM_512x80_w) - $stripe_p - 1] \
	-stop [expr $weight_mem_x_start + 3*($SRAM_512x80_w + $sram_gap_x) + 0.75*($SRAM_512x80_w) + $stripe_p] \
	-merge_stripes_value 10
addStripe \
	-nets "VDD0P8_SRAM VDD0P8_CLK VDD0P8_NE VSS" \
	-direction vertical \
	-layer M7 \
	-width $stripe_w -spacing $stripe_s \
	-number_of_sets 2 \
	-start [expr $weight_mem_x_start + 4*($SRAM_512x80_w + $sram_gap_x) + 0.25*($SRAM_512x80_w) - $stripe_p] \
	-stop [expr $weight_mem_x_start + 4*($SRAM_512x80_w + $sram_gap_x) + 0.75*($SRAM_512x80_w) + $stripe_p] \
	-merge_stripes_value 10
addStripe \
	-nets "VDD0P8_SRAM VDD0P8_CLK VDD0P8_NE VSS" \
	-direction vertical \
	-layer M7 \
	-width $stripe_w -spacing $stripe_s \
	-number_of_sets 2 \
	-start [expr $weight_mem_x_start + 5*($SRAM_512x80_w + $sram_gap_x) + 0.25*($SRAM_512x80_w) - $stripe_p - 1] \
	-stop [expr $weight_mem_x_start + 5*($SRAM_512x80_w + $sram_gap_x) + 0.75*($SRAM_512x80_w) + $stripe_p] \
	-merge_stripes_value 10
addStripe \
	-nets "VDD0P8_SRAM VDD0P8_CLK VDD0P8_NE VSS" \
	-direction vertical \
	-layer M7 \
	-width $stripe_w -spacing $stripe_s \
	-number_of_sets 2 \
	-start [expr $weight_mem_x_start + 6*($SRAM_512x80_w + $sram_gap_x) + 0.25*($SRAM_512x80_w) - $stripe_p] \
	-stop [expr $weight_mem_x_start + 6*($SRAM_512x80_w + $sram_gap_x) + 0.75*($SRAM_512x80_w) + $stripe_p] \
	-merge_stripes_value 10
addStripe \
	-nets "VDD0P8_SRAM VDD0P8_CLK VDD0P8_NE VSS" \
	-direction vertical \
	-layer M7 \
	-width $stripe_w -spacing $stripe_s \
	-number_of_sets 1 \
	-start [expr $weight_mem_x_start + 7*($SRAM_512x80_w + $sram_gap_x) + 0.25*($SRAM_512x80_w) - $stripe_p - 1] \
	-merge_stripes_value 10
addStripe \
	-nets "VDD0P8_SRAM VDD0P8_CLK VDD0P8_NE VSS" \
	-direction vertical \
	-layer M7 \
	-width $stripe_w -spacing $stripe_s \
	-number_of_sets 1 \
	-start [expr $weight_mem_x_start + 7*($SRAM_512x80_w + $sram_gap_x) + 0.73*($SRAM_512x80_w) - $stripe_p - 1] \
	-merge_stripes_value 10
addStripe \
	-nets "VDD0P8_SRAM VDD0P8_CLK VDD0P8_NE VSS" \
	-direction vertical \
	-layer M7 \
	-width $stripe_w -spacing $stripe_s \
	-number_of_sets 1 \
	-start [expr $weight_mem_x_start + 8*($SRAM_512x80_w + $sram_gap_x) + 0.25*($SRAM_512x80_w) - $stripe_p - 1] \
	-merge_stripes_value 10
addStripe \
	-nets "VDD0P8_SRAM VDD0P8_CLK VDD0P8_NE VSS" \
	-direction vertical \
	-layer M7 \
	-width $stripe_w -spacing $stripe_s \
	-number_of_sets 1 \
	-start [expr $weight_mem_x_start + 8*($SRAM_512x80_w + $sram_gap_x) + 0.73*($SRAM_512x80_w) - $stripe_p - 1] \
	-merge_stripes_value 10
addStripe \
	-nets "VDD0P8_SRAM VDD0P8_CLK VDD0P8_NE VSS" \
	-direction vertical \
	-layer M7 \
	-width $stripe_w -spacing $stripe_s \
	-number_of_sets 1 \
	-start [expr $weight_mem_x_start + 9*($SRAM_512x80_w + $sram_gap_x) + 0.25*($SRAM_512x80_w) - $stripe_p - 1] \
	-merge_stripes_value 10
addStripe \
	-nets "VDD0P8_SRAM VDD0P8_CLK VDD0P8_NE VSS" \
	-direction vertical \
	-layer M7 \
	-width $stripe_w -spacing $stripe_s \
	-number_of_sets 1 \
	-start [expr $weight_mem_x_start + 9*($SRAM_512x80_w + $sram_gap_x) + 0.73*($SRAM_512x80_w) - $stripe_p - 1] \
	-merge_stripes_value 10
addStripe \
	-nets "VDD0P8_SRAM VDD0P8_CLK VDD0P8_NE VSS" \
	-direction vertical \
	-layer M7 \
	-width $stripe_w -spacing $stripe_s \
	-number_of_sets 1 \
	-start [expr $weight_mem_x_start + 10*($SRAM_512x80_w + $sram_gap_x) + 0.25*($SRAM_512x80_w) - $stripe_p - 1] \
	-merge_stripes_value 10
addStripe \
	-nets "VDD0P8_SRAM VDD0P8_CLK VDD0P8_NE VSS" \
	-direction vertical \
	-layer M7 \
	-width $stripe_w -spacing $stripe_s \
	-number_of_sets 1 \
	-start [expr $weight_mem_x_start + 10*($SRAM_512x80_w + $sram_gap_x) + 0.73*($SRAM_512x80_w) - $stripe_p - 1] \
	-merge_stripes_value 10
addStripe \
	-nets "VSS VDD0P8_CLK VDD0P8_NE VDD0P8_SRAM" \
	-direction vertical \
	-layer M7 \
	-width $stripe_w -spacing $stripe_s \
	-number_of_sets 2 \
	-start [expr $weight_mem_x_start + 11*($SRAM_512x80_w + $sram_gap_x) + 0.25*($SRAM_512x80_w) - $stripe_p] \
	-stop [expr $weight_mem_x_start + 11*($SRAM_512x80_w + $sram_gap_x) + 0.75*($SRAM_512x80_w) + $stripe_p] \
	-merge_stripes_value 10
addStripe \
	-nets "VDD0P8_SRAM VDD0P8_CLK VDD0P8_NE VSS" \
	-direction vertical \
	-layer M7 \
	-width $stripe_w -spacing $stripe_s \
	-number_of_sets 2 \
	-start [expr $weight_mem_x_start + 12*($SRAM_512x80_w + $sram_gap_x) + 0.25*($SRAM_512x80_w) - $stripe_p] \
	-stop [expr $weight_mem_x_start + 12*($SRAM_512x80_w + $sram_gap_x) + 0.75*($SRAM_512x80_w) + $stripe_p] \
	-merge_stripes_value 10
addStripe \
	-nets "VSS VDD0P8_NE VDD0P8_SRAM VDD0P8_CLK" \
	-direction vertical \
	-layer M7 \
	-width $stripe_w -spacing $stripe_s \
	-number_of_sets 1 \
	-start [expr $weight_mem_x_start + 13*($SRAM_512x80_w + $sram_gap_x) + 0.25*($SRAM_512x80_w) - $stripe_p] \
	-merge_stripes_value 10

addStripe \
	-nets "VDD0P8_SRAM VDD0P8_CLK VDD0P8_NE VSS" \
	-direction vertical \
	-layer M7 \
	-width $stripe_w -spacing $stripe_s \
	-number_of_sets 2 \
	-start [expr $weight_mem_x_start + 14*($SRAM_512x80_w + $sram_gap_x) + 0.25*($SRAM_512x80_w) - $stripe_p] \
	-stop [expr $weight_mem_x_start + 14*($SRAM_512x80_w + $sram_gap_x) + 0.75*($SRAM_512x80_w) + $stripe_p] \
	-merge_stripes_value 10
addStripe \
	-nets "VDD0P8_SRAM VDD0P8_CLK VDD0P8_NE VSS" \
	-direction vertical \
	-layer M7 \
	-width $stripe_w -spacing $stripe_s \
	-number_of_sets 2 \
	-start [expr $weight_mem_x_start + 15*($SRAM_512x80_w + $sram_gap_x) + 0.25*($SRAM_512x80_w) - $stripe_p] \
	-stop [expr $weight_mem_x_start + 15*($SRAM_512x80_w + $sram_gap_x) + 0.75*($SRAM_512x80_w) + $stripe_p] \
	-merge_stripes_value 10
# Interval
addStripe \
	-nets "VSS VDD0P8_NE" \
	-direction vertical \
	-layer M7 \
	-width $stripe_w -spacing $stripe_s \
	-number_of_sets 1 \
	-start [expr $weight_mem_x_start + (0 + 1)*($SRAM_512x80_w) + (0 + 0.5)*($sram_gap_x) - $stripe_w - 0.5*($stripe_s)] \
	-merge_stripes_value 10
addStripe \
	-nets "VSS VDD0P8_NE" \
	-direction vertical \
	-layer M7 \
	-width $stripe_w -spacing $stripe_s \
	-number_of_sets 1 \
	-start [expr $weight_mem_x_start + (1 + 1)*($SRAM_512x80_w) + (1 + 0.5)*($sram_gap_x) - $stripe_w - 0.5*($stripe_s)] \
	-merge_stripes_value 10
addStripe \
	-nets "VSS VDD0P8_NE" \
	-direction vertical \
	-layer M7 \
	-width $stripe_w -spacing $stripe_s \
	-number_of_sets 1 \
	-start [expr $weight_mem_x_start + (2 + 1)*($SRAM_512x80_w) + (2 + 0.5)*($sram_gap_x) - $stripe_w - 0.5*($stripe_s)] \
	-merge_stripes_value 10
addStripe \
	-nets "VSS VDD0P8_NE" \
	-direction vertical \
	-layer M7 \
	-width $stripe_w -spacing $stripe_s \
	-number_of_sets 1 \
	-start [expr $weight_mem_x_start + (3 + 1)*($SRAM_512x80_w) + (3 + 0.5)*($sram_gap_x) - $stripe_w - 0.5*($stripe_s)] \
	-merge_stripes_value 10
addStripe \
	-nets "VSS VDD0P8_NE" \
	-direction vertical \
	-layer M7 \
	-width $stripe_w -spacing $stripe_s \
	-number_of_sets 1 \
	-start [expr $weight_mem_x_start + (4 + 1)*($SRAM_512x80_w) + (4 + 0.5)*($sram_gap_x) - $stripe_w - 0.5*($stripe_s)] \
	-merge_stripes_value 10
addStripe \
	-nets "VSS VDD0P8_NE" \
	-direction vertical \
	-layer M7 \
	-width $stripe_w -spacing $stripe_s \
	-number_of_sets 1 \
	-start [expr $weight_mem_x_start + (5 + 1)*($SRAM_512x80_w) + (5 + 0.5)*($sram_gap_x) - $stripe_w - 0.5*($stripe_s)] \
	-merge_stripes_value 10
addStripe \
	-nets "VSS VDD0P8_NE" \
	-direction vertical \
	-layer M7 \
	-width $stripe_w -spacing $stripe_s \
	-number_of_sets 1 \
	-start [expr $weight_mem_x_start + (6 + 1)*($SRAM_512x80_w) + (6 + 0.5)*($sram_gap_x) - $stripe_w - 0.5*($stripe_s)] \
	-merge_stripes_value 10
addStripe \
	-nets "VSS VDD0P8_NE" \
	-direction vertical \
	-layer M7 \
	-width $stripe_w -spacing $stripe_s \
	-number_of_sets 1 \
	-start [expr $weight_mem_x_start + (7 + 1)*($SRAM_512x80_w) + (7 + 0.5)*($sram_gap_x) - $stripe_w - 0.5*($stripe_s)] \
	-merge_stripes_value 10
addStripe \
	-nets "VSS VDD0P8_NE" \
	-direction vertical \
	-layer M7 \
	-width $stripe_w -spacing $stripe_s \
	-number_of_sets 1 \
	-start [expr $weight_mem_x_start + (8 + 1)*($SRAM_512x80_w) + (8 + 0.5)*($sram_gap_x) - $stripe_w - 0.5*($stripe_s)] \
	-merge_stripes_value 10
addStripe \
	-nets "VSS VDD0P8_NE" \
	-direction vertical \
	-layer M7 \
	-width $stripe_w -spacing $stripe_s \
	-number_of_sets 1 \
	-start [expr $weight_mem_x_start + (9 + 1)*($SRAM_512x80_w) + (9 + 0.5)*($sram_gap_x) - $stripe_w - 0.5*($stripe_s)] \
	-merge_stripes_value 10
addStripe \
	-nets "VSS VDD0P8_NE" \
	-direction vertical \
	-layer M7 \
	-width $stripe_w -spacing $stripe_s \
	-number_of_sets 1 \
	-start [expr $weight_mem_x_start + (10 + 1)*($SRAM_512x80_w) + (10 + 0.5)*($sram_gap_x) - $stripe_w - 0.5*($stripe_s)] \
	-merge_stripes_value 10
addStripe \
	-nets "VSS VDD0P8_NE" \
	-direction vertical \
	-layer M7 \
	-width $stripe_w -spacing $stripe_s \
	-number_of_sets 1 \
	-start [expr $weight_mem_x_start + (11 + 1)*($SRAM_512x80_w) + (11 + 0.5)*($sram_gap_x) - $stripe_w - 0.5*($stripe_s)] \
	-merge_stripes_value 10
addStripe \
	-nets "VSS VDD0P8_NE" \
	-direction vertical \
	-layer M7 \
	-width $stripe_w -spacing $stripe_s \
	-number_of_sets 1 \
	-start [expr $weight_mem_x_start + (12 + 1)*($SRAM_512x80_w) + (12 + 0.5)*($sram_gap_x) - $stripe_w - 0.5*($stripe_s)] \
	-merge_stripes_value 10
addStripe \
	-nets "VSS VDD0P8_NE" \
	-direction vertical \
	-layer M7 \
	-width $stripe_w -spacing $stripe_s \
	-number_of_sets 1 \
	-start [expr $weight_mem_x_start + (13 + 1)*($SRAM_512x80_w) + (13 + 0.5)*($sram_gap_x) - $stripe_w - 0.5*($stripe_s)] \
	-merge_stripes_value 10
addStripe \
	-nets "VSS VDD0P8_NE" \
	-direction vertical \
	-layer M7 \
	-width $stripe_w -spacing $stripe_s \
	-number_of_sets 1 \
	-start [expr $weight_mem_x_start + (14 + 1)*($SRAM_512x80_w) + (14 + 0.5)*($sram_gap_x) - $stripe_w - 0.5*($stripe_s)] \
	-merge_stripes_value 10
addStripe \
	-nets "VSS VDD0P8_NE" \
	-direction vertical \
	-layer M7 \
	-width $stripe_w -spacing $stripe_s \
	-number_of_sets 1 \
	-start [expr $weight_mem_x_start + (15 + 1)*($SRAM_512x80_w) + (15 + 0.5)*($sram_gap_x) - $stripe_w - 0.5*($stripe_s) - 1.9] \
	-merge_stripes_value 10
addStripe \
	-nets "VSS VDD0P8_NE" \
	-direction vertical \
	-layer M7 \
	-width $stripe_w -spacing $stripe_s \
	-number_of_sets 1 \
	-start [expr $weight_mem_x_start + (15 + 1)*($SRAM_512x80_w) + (15 + 0.5)*($sram_gap_x) - $stripe_w - 0.5*($stripe_s) + 8.1] \
	-merge_stripes_value 10
addStripe \
	-nets "VDD0P8_CLK VDD0P8_SRAM" \
	-direction vertical \
	-layer M7 \
	-width $stripe_w -spacing $stripe_s \
	-number_of_sets 1 \
	-start [expr $weight_mem_x_start + (15 + 1)*($SRAM_512x80_w) + (15 + 0.5)*($sram_gap_x) - $stripe_w - 0.5*($stripe_s) + 18.3] \
	-merge_stripes_value 10
# M9
setAddStripeMode -stacked_via_bottom_layer M8
setAddStripeMode -stacked_via_top_layer    M9
# Non-Interval
addStripe \
	-nets "VSS VDD0P8_CLK VDD0P8_NE VDD0P8_SRAM" \
	-direction vertical \
	-layer M9 \
	-width $stripe_w -spacing $stripe_s \
	-number_of_sets 2 \
	-start [expr $weight_mem_x_start + 0*($SRAM_512x80_w + $sram_gap_x) + 0.25*($SRAM_512x80_w) - $stripe_p] \
	-stop [expr $weight_mem_x_start + 0*($SRAM_512x80_w + $sram_gap_x) + 0.75*($SRAM_512x80_w) + $stripe_p] \
	-merge_stripes_value 10
addStripe \
	-nets "VDD0P8_SRAM VDD0P8_CLK VDD0P8_NE VSS" \
	-direction vertical \
	-layer M9 \
	-width $stripe_w -spacing $stripe_s \
	-number_of_sets 2 \
	-start [expr $weight_mem_x_start + 1*($SRAM_512x80_w + $sram_gap_x) + 0.25*($SRAM_512x80_w) - $stripe_p - 1] \
	-stop [expr $weight_mem_x_start + 1*($SRAM_512x80_w + $sram_gap_x) + 0.75*($SRAM_512x80_w) + $stripe_p] \
	-merge_stripes_value 10
addStripe \
	-nets "VDD0P8_SRAM VDD0P8_CLK VDD0P8_NE VSS" \
	-direction vertical \
	-layer M9 \
	-width $stripe_w -spacing $stripe_s \
	-number_of_sets 2 \
	-start [expr $weight_mem_x_start + 2*($SRAM_512x80_w + $sram_gap_x) + 0.25*($SRAM_512x80_w) - $stripe_p] \
	-stop [expr $weight_mem_x_start + 2*($SRAM_512x80_w + $sram_gap_x) + 0.75*($SRAM_512x80_w) + $stripe_p] \
	-merge_stripes_value 10
addStripe \
	-nets "VDD0P8_SRAM VDD0P8_CLK VDD0P8_NE VSS" \
	-direction vertical \
	-layer M9 \
	-width $stripe_w -spacing $stripe_s \
	-number_of_sets 2 \
	-start [expr $weight_mem_x_start + 3*($SRAM_512x80_w + $sram_gap_x) + 0.25*($SRAM_512x80_w) - $stripe_p - 1] \
	-stop [expr $weight_mem_x_start + 3*($SRAM_512x80_w + $sram_gap_x) + 0.75*($SRAM_512x80_w) + $stripe_p] \
	-merge_stripes_value 10
addStripe \
	-nets "VDD0P8_SRAM VDD0P8_CLK VDD0P8_NE VSS" \
	-direction vertical \
	-layer M9 \
	-width $stripe_w -spacing $stripe_s \
	-number_of_sets 2 \
	-start [expr $weight_mem_x_start + 4*($SRAM_512x80_w + $sram_gap_x) + 0.25*($SRAM_512x80_w) - $stripe_p] \
	-stop [expr $weight_mem_x_start + 4*($SRAM_512x80_w + $sram_gap_x) + 0.75*($SRAM_512x80_w) + $stripe_p] \
	-merge_stripes_value 10
addStripe \
	-nets "VDD0P8_SRAM VDD0P8_CLK VDD0P8_NE VSS" \
	-direction vertical \
	-layer M9 \
	-width $stripe_w -spacing $stripe_s \
	-number_of_sets 2 \
	-start [expr $weight_mem_x_start + 5*($SRAM_512x80_w + $sram_gap_x) + 0.25*($SRAM_512x80_w) - $stripe_p - 1] \
	-stop [expr $weight_mem_x_start + 5*($SRAM_512x80_w + $sram_gap_x) + 0.75*($SRAM_512x80_w) + $stripe_p] \
	-merge_stripes_value 10
addStripe \
	-nets "VDD0P8_SRAM VDD0P8_CLK VDD0P8_NE VSS" \
	-direction vertical \
	-layer M9 \
	-width $stripe_w -spacing $stripe_s \
	-number_of_sets 2 \
	-start [expr $weight_mem_x_start + 6*($SRAM_512x80_w + $sram_gap_x) + 0.25*($SRAM_512x80_w) - $stripe_p] \
	-stop [expr $weight_mem_x_start + 6*($SRAM_512x80_w + $sram_gap_x) + 0.75*($SRAM_512x80_w) + $stripe_p] \
	-merge_stripes_value 10
addStripe \
	-nets "VDD0P8_SRAM VDD0P8_CLK VDD0P8_NE VSS" \
	-direction vertical \
	-layer M9 \
	-width $stripe_w -spacing $stripe_s \
	-number_of_sets 1 \
	-start [expr $weight_mem_x_start + 7*($SRAM_512x80_w + $sram_gap_x) + 0.25*($SRAM_512x80_w) - $stripe_p - 1] \
	-merge_stripes_value 10
addStripe \
	-nets "VDD0P8_SRAM VDD0P8_CLK VDD0P8_NE VSS" \
	-direction vertical \
	-layer M9 \
	-width $stripe_w -spacing $stripe_s \
	-number_of_sets 1 \
	-start [expr $weight_mem_x_start + 7*($SRAM_512x80_w + $sram_gap_x) + 0.73*($SRAM_512x80_w) - $stripe_p - 1] \
	-merge_stripes_value 10
addStripe \
	-nets "VDD0P8_SRAM VDD0P8_CLK VDD0P8_NE VSS" \
	-direction vertical \
	-layer M9 \
	-width $stripe_w -spacing $stripe_s \
	-number_of_sets 1 \
	-start [expr $weight_mem_x_start + 8*($SRAM_512x80_w + $sram_gap_x) + 0.25*($SRAM_512x80_w) - $stripe_p - 1] \
	-merge_stripes_value 10
addStripe \
	-nets "VDD0P8_SRAM VDD0P8_CLK VDD0P8_NE VSS" \
	-direction vertical \
	-layer M9 \
	-width $stripe_w -spacing $stripe_s \
	-number_of_sets 1 \
	-start [expr $weight_mem_x_start + 8*($SRAM_512x80_w + $sram_gap_x) + 0.73*($SRAM_512x80_w) - $stripe_p - 1] \
	-merge_stripes_value 10
addStripe \
	-nets "VDD0P8_SRAM VDD0P8_CLK VDD0P8_NE VSS" \
	-direction vertical \
	-layer M9 \
	-width $stripe_w -spacing $stripe_s \
	-number_of_sets 1 \
	-start [expr $weight_mem_x_start + 9*($SRAM_512x80_w + $sram_gap_x) + 0.25*($SRAM_512x80_w) - $stripe_p - 1] \
	-merge_stripes_value 10
addStripe \
	-nets "VDD0P8_SRAM VDD0P8_CLK VDD0P8_NE VSS" \
	-direction vertical \
	-layer M9 \
	-width $stripe_w -spacing $stripe_s \
	-number_of_sets 1 \
	-start [expr $weight_mem_x_start + 9*($SRAM_512x80_w + $sram_gap_x) + 0.73*($SRAM_512x80_w) - $stripe_p - 1] \
	-merge_stripes_value 10
addStripe \
	-nets "VDD0P8_SRAM VDD0P8_CLK VDD0P8_NE VSS" \
	-direction vertical \
	-layer M9 \
	-width $stripe_w -spacing $stripe_s \
	-number_of_sets 1 \
	-start [expr $weight_mem_x_start + 10*($SRAM_512x80_w + $sram_gap_x) + 0.25*($SRAM_512x80_w) - $stripe_p - 1] \
	-merge_stripes_value 10
addStripe \
	-nets "VDD0P8_SRAM VDD0P8_CLK VDD0P8_NE VSS" \
	-direction vertical \
	-layer M9 \
	-width $stripe_w -spacing $stripe_s \
	-number_of_sets 1 \
	-start [expr $weight_mem_x_start + 10*($SRAM_512x80_w + $sram_gap_x) + 0.73*($SRAM_512x80_w) - $stripe_p - 1] \
	-merge_stripes_value 10
addStripe \
	-nets "VSS VDD0P8_CLK VDD0P8_NE VDD0P8_SRAM" \
	-direction vertical \
	-layer M9 \
	-width $stripe_w -spacing $stripe_s \
	-number_of_sets 2 \
	-start [expr $weight_mem_x_start + 11*($SRAM_512x80_w + $sram_gap_x) + 0.25*($SRAM_512x80_w) - $stripe_p] \
	-stop [expr $weight_mem_x_start + 11*($SRAM_512x80_w + $sram_gap_x) + 0.75*($SRAM_512x80_w) + $stripe_p] \
	-merge_stripes_value 10
addStripe \
	-nets "VDD0P8_SRAM VDD0P8_CLK VDD0P8_NE VSS" \
	-direction vertical \
	-layer M9 \
	-width $stripe_w -spacing $stripe_s \
	-number_of_sets 2 \
	-start [expr $weight_mem_x_start + 12*($SRAM_512x80_w + $sram_gap_x) + 0.25*($SRAM_512x80_w) - $stripe_p] \
	-stop [expr $weight_mem_x_start + 12*($SRAM_512x80_w + $sram_gap_x) + 0.75*($SRAM_512x80_w) + $stripe_p] \
	-merge_stripes_value 10
addStripe \
	-nets "VSS VDD0P8_NE VDD0P8_SRAM VDD0P8_CLK " \
	-direction vertical \
	-layer M9 \
	-width $stripe_w -spacing $stripe_s \
	-number_of_sets 1 \
	-start [expr $weight_mem_x_start + 13*($SRAM_512x80_w + $sram_gap_x) + 0.25*($SRAM_512x80_w) - $stripe_p] \
	-merge_stripes_value 10

addStripe \
	-nets "VDD0P8_SRAM VDD0P8_CLK VDD0P8_NE VSS" \
	-direction vertical \
	-layer M9 \
	-width $stripe_w -spacing $stripe_s \
	-number_of_sets 2 \
	-start [expr $weight_mem_x_start + 14*($SRAM_512x80_w + $sram_gap_x) + 0.25*($SRAM_512x80_w) - $stripe_p] \
	-stop [expr $weight_mem_x_start + 14*($SRAM_512x80_w + $sram_gap_x) + 0.75*($SRAM_512x80_w) + $stripe_p] \
	-merge_stripes_value 10
addStripe \
	-nets "VDD0P8_SRAM VDD0P8_CLK VDD0P8_NE VSS" \
	-direction vertical \
	-layer M9 \
	-width $stripe_w -spacing $stripe_s \
	-number_of_sets 2 \
	-start [expr $weight_mem_x_start + 15*($SRAM_512x80_w + $sram_gap_x) + 0.25*($SRAM_512x80_w) - $stripe_p] \
	-stop [expr $weight_mem_x_start + 15*($SRAM_512x80_w + $sram_gap_x) + 0.75*($SRAM_512x80_w) + $stripe_p] \
	-merge_stripes_value 10
# Interval
addStripe \
	-nets "VSS VDD0P8_NE" \
	-direction vertical \
	-layer M9 \
	-width $stripe_w -spacing $stripe_s \
	-number_of_sets 1 \
	-start [expr $weight_mem_x_start + (0 + 1)*($SRAM_512x80_w) + (0 + 0.5)*($sram_gap_x) - $stripe_w - 0.5*($stripe_s)] \
	-merge_stripes_value 10
addStripe \
	-nets "VSS VDD0P8_NE" \
	-direction vertical \
	-layer M9 \
	-width $stripe_w -spacing $stripe_s \
	-number_of_sets 1 \
	-start [expr $weight_mem_x_start + (1 + 1)*($SRAM_512x80_w) + (1 + 0.5)*($sram_gap_x) - $stripe_w - 0.5*($stripe_s)] \
	-merge_stripes_value 10
addStripe \
	-nets "VSS VDD0P8_NE" \
	-direction vertical \
	-layer M9 \
	-width $stripe_w -spacing $stripe_s \
	-number_of_sets 1 \
	-start [expr $weight_mem_x_start + (2 + 1)*($SRAM_512x80_w) + (2 + 0.5)*($sram_gap_x) - $stripe_w - 0.5*($stripe_s)] \
	-merge_stripes_value 10
addStripe \
	-nets "VSS VDD0P8_NE" \
	-direction vertical \
	-layer M9 \
	-width $stripe_w -spacing $stripe_s \
	-number_of_sets 1 \
	-start [expr $weight_mem_x_start + (3 + 1)*($SRAM_512x80_w) + (3 + 0.5)*($sram_gap_x) - $stripe_w - 0.5*($stripe_s)] \
	-merge_stripes_value 10
addStripe \
	-nets "VSS VDD0P8_NE" \
	-direction vertical \
	-layer M9 \
	-width $stripe_w -spacing $stripe_s \
	-number_of_sets 1 \
	-start [expr $weight_mem_x_start + (4 + 1)*($SRAM_512x80_w) + (4 + 0.5)*($sram_gap_x) - $stripe_w - 0.5*($stripe_s)] \
	-merge_stripes_value 10
addStripe \
	-nets "VSS VDD0P8_NE" \
	-direction vertical \
	-layer M9 \
	-width $stripe_w -spacing $stripe_s \
	-number_of_sets 1 \
	-start [expr $weight_mem_x_start + (5 + 1)*($SRAM_512x80_w) + (5 + 0.5)*($sram_gap_x) - $stripe_w - 0.5*($stripe_s)] \
	-merge_stripes_value 10
addStripe \
	-nets "VSS VDD0P8_NE" \
	-direction vertical \
	-layer M9 \
	-width $stripe_w -spacing $stripe_s \
	-number_of_sets 1 \
	-start [expr $weight_mem_x_start + (6 + 1)*($SRAM_512x80_w) + (6 + 0.5)*($sram_gap_x) - $stripe_w - 0.5*($stripe_s)] \
	-merge_stripes_value 10
addStripe \
	-nets "VSS VDD0P8_NE" \
	-direction vertical \
	-layer M9 \
	-width $stripe_w -spacing $stripe_s \
	-number_of_sets 1 \
	-start [expr $weight_mem_x_start + (7 + 1)*($SRAM_512x80_w) + (7 + 0.5)*($sram_gap_x) - $stripe_w - 0.5*($stripe_s)] \
	-merge_stripes_value 10
addStripe \
	-nets "VSS VDD0P8_NE" \
	-direction vertical \
	-layer M9 \
	-width $stripe_w -spacing $stripe_s \
	-number_of_sets 1 \
	-start [expr $weight_mem_x_start + (8 + 1)*($SRAM_512x80_w) + (8 + 0.5)*($sram_gap_x) - $stripe_w - 0.5*($stripe_s)] \
	-merge_stripes_value 10
addStripe \
	-nets "VSS VDD0P8_NE" \
	-direction vertical \
	-layer M9 \
	-width $stripe_w -spacing $stripe_s \
	-number_of_sets 1 \
	-start [expr $weight_mem_x_start + (9 + 1)*($SRAM_512x80_w) + (9 + 0.5)*($sram_gap_x) - $stripe_w - 0.5*($stripe_s)] \
	-merge_stripes_value 10
addStripe \
	-nets "VSS VDD0P8_NE" \
	-direction vertical \
	-layer M9 \
	-width $stripe_w -spacing $stripe_s \
	-number_of_sets 1 \
	-start [expr $weight_mem_x_start + (10 + 1)*($SRAM_512x80_w) + (10 + 0.5)*($sram_gap_x) - $stripe_w - 0.5*($stripe_s)] \
	-merge_stripes_value 10
addStripe \
	-nets "VSS VDD0P8_NE" \
	-direction vertical \
	-layer M9 \
	-width $stripe_w -spacing $stripe_s \
	-number_of_sets 1 \
	-start [expr $weight_mem_x_start + (11 + 1)*($SRAM_512x80_w) + (11 + 0.5)*($sram_gap_x) - $stripe_w - 0.5*($stripe_s)] \
	-merge_stripes_value 10
addStripe \
	-nets "VSS VDD0P8_NE" \
	-direction vertical \
	-layer M9 \
	-width $stripe_w -spacing $stripe_s \
	-number_of_sets 1 \
	-start [expr $weight_mem_x_start + (12 + 1)*($SRAM_512x80_w) + (12 + 0.5)*($sram_gap_x) - $stripe_w - 0.5*($stripe_s)] \
	-merge_stripes_value 10
addStripe \
	-nets "VSS VDD0P8_NE" \
	-direction vertical \
	-layer M9 \
	-width $stripe_w -spacing $stripe_s \
	-number_of_sets 1 \
	-start [expr $weight_mem_x_start + (13 + 1)*($SRAM_512x80_w) + (13 + 0.5)*($sram_gap_x) - $stripe_w - 0.5*($stripe_s)] \
	-merge_stripes_value 10
addStripe \
	-nets "VSS VDD0P8_NE" \
	-direction vertical \
	-layer M9 \
	-width $stripe_w -spacing $stripe_s \
	-number_of_sets 1 \
	-start [expr $weight_mem_x_start + (14 + 1)*($SRAM_512x80_w) + (14 + 0.5)*($sram_gap_x) - $stripe_w - 0.5*($stripe_s)] \
	-merge_stripes_value 10
addStripe \
	-nets "VSS VDD0P8_NE" \
	-direction vertical \
	-layer M9 \
	-width $stripe_w -spacing $stripe_s \
	-number_of_sets 1 \
	-start [expr $weight_mem_x_start + (15 + 1)*($SRAM_512x80_w) + (15 + 0.5)*($sram_gap_x) - $stripe_w - 0.5*($stripe_s) - 1.9] \
	-merge_stripes_value 10
addStripe \
	-nets "VDD0P8_CLK VDD0P8_SRAM" \
	-direction vertical \
	-layer M9 \
	-width $stripe_w -spacing $stripe_s \
	-number_of_sets 1 \
	-start [expr $weight_mem_x_start + (15 + 1)*($SRAM_512x80_w) + (15 + 0.5)*($sram_gap_x) - $stripe_w - 0.5*($stripe_s) + 18.3] \
	-merge_stripes_value 10 
# Small stripes for bias mem
setAddStripeMode -stacked_via_bottom_layer M1
setAddStripeMode -stacked_via_top_layer    M8
addStripe \
	-nets "VSS VDD0P8_NE VDD0P8_CLK VDD0P8_SRAM" \
	-direction vertical \
	-layer M7 \
	-width $stripe_w -spacing $stripe_s \
	-number_of_sets 1 \
	-start [expr $bias_mem_x_start] \
	-merge_stripes_value 10
addStripe \
	-nets "VSS VDD0P8_NE" \
	-direction vertical \
	-layer M7 \
	-width $stripe_w -spacing $stripe_s \
	-number_of_sets 1 \
	-start [expr $bias_mem_x_start + ($RF_16x128_w) + 3.6] \
	-merge_stripes_value 10
addStripe \
	-nets "VSS VDD0P8_NE VDD0P8_SRAM" \
	-direction vertical \
	-layer M7 \
	-width $stripe_w -spacing $stripe_s \
	-number_of_sets 1 \
	-start [expr $bias_mem_x_start + ($RF_16x128_w) + $sram_gap_x + 2] \
	-merge_stripes_value 10
addStripe \
	-nets "VSS VDD0P8_NE" \
	-direction vertical \
	-layer M7 \
	-width $stripe_w -spacing $stripe_s \
	-number_of_sets 1 \
	-start [expr $bias_mem_x_end - 2] \
	-merge_stripes_value 10
addStripe \
	-nets "VSS VDD0P8_NE" \
	-direction vertical \
	-layer M7 \
	-width $stripe_w -spacing $stripe_s \
	-number_of_sets 1 \
	-start [expr $bias_mem_x_end + 2*($stripe_s + $stripe_w) - 2] \
	-merge_stripes_value 10
addStripe \
	-nets "VDD0P8_CLK VDD0P8_SRAM" \
	-direction vertical \
	-layer M7 \
	-width $stripe_w -spacing $stripe_s \
	-number_of_sets 1 \
	-start [expr $bias_mem_x_end + 4*($stripe_s + $stripe_w) - 2] \
	-merge_stripes_value 10
addStripe \
	-nets "VSS VDD0P8_NE" \
	-direction vertical \
	-layer M7 \
	-width $stripe_w -spacing $stripe_s \
	-number_of_sets 1 \
	-start [expr $bias_mem_x_end + 6*($stripe_s + $stripe_w) - 2] \
	-merge_stripes_value 10
addStripe \
	-nets "VSS VDD0P8_NE" \
	-direction vertical \
	-layer M7 \
	-width $stripe_w -spacing $stripe_s \
	-number_of_sets 1 \
	-start [expr $bias_mem_x_end + 8*($stripe_s + $stripe_w) - 2.3] \
	-merge_stripes_value 10
# M9
setAddStripeMode -stacked_via_bottom_layer M8
setAddStripeMode -stacked_via_top_layer    M9
addStripe \
	-nets "VSS VDD0P8_NE VDD0P8_CLK VDD0P8_SRAM" \
	-direction vertical \
	-layer M9 \
	-width $stripe_w -spacing $stripe_s \
	-number_of_sets 1 \
	-start [expr $bias_mem_x_start] \
	-merge_stripes_value 10
addStripe \
	-nets "VSS VDD0P8_NE VDD0P8_SRAM" \
	-direction vertical \
	-layer M9 \
	-width $stripe_w -spacing $stripe_s \
	-number_of_sets 1 \
	-start [expr $bias_mem_x_start + ($RF_16x128_w) + $sram_gap_x + 2] \
	-merge_stripes_value 10
addStripe \
	-nets "VSS VDD0P8_NE" \
	-direction vertical \
	-layer M9 \
	-width $stripe_w -spacing $stripe_s \
	-number_of_sets 1 \
	-start [expr $bias_mem_x_end - 2] \
	-merge_stripes_value 10
addStripe \
	-nets "VSS VDD0P8_NE" \
	-direction vertical \
	-layer M9 \
	-width $stripe_w -spacing $stripe_s \
	-number_of_sets 1 \
	-start [expr $bias_mem_x_end + 2*($stripe_s + $stripe_w) - 2] \
	-merge_stripes_value 10
addStripe \
	-nets "VDD0P8_CLK VDD0P8_SRAM" \
	-direction vertical \
	-layer M9 \
	-width $stripe_w -spacing $stripe_s \
	-number_of_sets 1 \
	-start [expr $bias_mem_x_end + 4*($stripe_s + $stripe_w) - 2] \
	-merge_stripes_value 10
addStripe \
	-nets "VSS VDD0P8_NE" \
	-direction vertical \
	-layer M9 \
	-width $stripe_w -spacing $stripe_s \
	-number_of_sets 1 \
	-start [expr $bias_mem_x_end + 6*($stripe_s + $stripe_w) - 2] \
	-merge_stripes_value 10
