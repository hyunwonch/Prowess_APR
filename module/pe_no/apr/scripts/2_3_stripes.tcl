
##################
####### M1 #######
##################

sroute -nets "VSS VDD" -connect corePin -corePinTarget none -layerChangeRange "M1 M1"
# sroute -nets {VSS} -connect corePin -allowLayerChange 0 -allowJogging 0 -crossoverViaLayerRange {M1 M7} -targetViaLayerRange {M1 M7} -corePinTarget none

#---------------------------------
# Vertical M7
#---------------------------------

set stripe_w 4  ; # Wire Width
set stripe_s 1  ; # Wire Spacing
set stripe_p [expr $stripe_w + $stripe_s]

setAddStripeMode -stacked_via_bottom_layer M1
setAddStripeMode -stacked_via_top_layer    M8
addStripe \
        -nets "VSS VDD" \
        -direction vertical \
        -layer M7    \
        -width $stripe_w -spacing $stripe_s \
        -set_to_set_distance 25 \
        -start 8 \
        -stop 108 \
        -merge_stripes_value 10

addStripe \
        -nets "VSS VDD" \
        -direction vertical \
        -layer M7    \
        -width $stripe_w -spacing $stripe_s \
        -set_to_set_distance 35 \
        -start 140 \
        -stop 300 \
        -merge_stripes_value 10




# #------------------------------
# # Ring
# #------------------------------

# # set ring_width   4
# # set ring_space   1
# # set ring_offset  0

# # myAddCoreRing $ring_width $ring_space M3 M4
# # myAddCoreRing $ring_width $ring_space M5 M4
# # myAddCoreRing $ring_width $ring_space M5 M6
# # myAddCoreRing $ring_width $ring_space M5 M8
# # myAddCoreRing $ring_width $ring_space M7 M8
# # myAddCoreRing $ring_width $ring_space M9 M8

# # # Stripe Dimension
# # set stripe_w 4  ; # Wire Width
# # set stripe_s 1  ; # Wire Spacing

# ##################
# ####### M1 #######
# ##################

# sroute -nets "VSS VDD" -connect corePin -corePinTarget none -layerChangeRange "M1 M1"

# ##################
# ####### M2 #######
# ##################
# set M2_stripe_pitch $t_pitch
# set M2_stripe_width $stripe_w

# setViaGenMode -reset
# setAddStripeMode -reset
# setAddStripeMode                                				\
#                 -stacked_via_bottom_layer M1    				\
#                 -stacked_via_top_layer M8       				\
#                 -route_over_rows_only true
# addStripe                                                       	\
# 				-nets "VSS VDD"                                     \
# 				-layer M7                                         \
# 				-direction vertical                               \
# 				-width $stripe_w                             \
# 				-spacing $stripe_s                                  \
# 				-set_to_set_distance [expr $M2_stripe_pitch * 2]    \
# 				-start_offset [expr 0 - $stripe_w / 2]       \
# 				-stop_offset [expr 0 - $stripe_w]

# ##################
# ####### M3 #######
# ##################
# set M3_stripe_width [expr 0.032 + 0.064*3]
# set M3_stripe_pitch [expr 10 * $M3_stripe_width]

# setViaGenMode -reset
# setAddStripeMode -reset
# setAddStripeMode												\
# 				-stacked_via_bottom_layer M2 					\
# 				-stacked_via_top_layer M3 						\
# 				-route_over_rows_only true

# addStripe															\
# 				-nets "VSS VDD"										\
# 				-layer M3              								\
# 				-direction vertical    								\
# 				-width $M3_stripe_width								\
# 				-spacing [expr $M3_stripe_pitch - $M3_stripe_width] \
# 				-set_to_set_distance [expr $M3_stripe_pitch * 2] 	\
# 				-start_offset [expr 0.064*20]


# ##################
# ####### M5 #######
# ##################
# set M5_stripe_width   [expr 0.04 * 6 + 0.04]
# set M5_stripe_pitch   [expr 8 * $M3_stripe_width]

# setViaGenMode -reset
# setAddStripeMode -reset
# setAddStripeMode -stacked_via_top_layer M5
# setAddStripeMode -route_over_rows_only false

# if {![catch {selectInstByCellName "TS1N28*"}]} {
#     addStripe -nets "VSS VDD" \
#             -layer M5 \
#             -direction vertical \
#             -width $M5_stripe_width \
#             -spacing [expr $M5_stripe_pitch - $M5_stripe_width] \
#             -set_to_set_distance [expr $M5_stripe_pitch * 2] \
#             -start_offset [expr 0.32*2] \
#             -stop_offset  [expr 0.32*2] \
# 			-all_blocks true
#     # deselectAll
# }


# # ##################
# # ####### M6 #######
# # ##################
# # set stripe_width   [expr 0.48]
# # set stripe_pitch   [expr 10*$stripe_width]

# # setViaGenMode -reset
# # setAddStripeMode -reset
# # setAddStripeMode												\
# # 				-stacked_via_bottom_layer "M3" 					\
# # 				-stacked_via_top_layer "M11" 					\
# # 				-route_over_rows_only false 						\
# # 				-allow_jog none

# # addStripe														\
# # 				-nets "VSS VDD" 								\
# # 				-layer M6            							\
# # 				-direction horizontal							\
# # 				-width $stripe_width 							\
# # 				-spacing [expr $stripe_pitch - $stripe_width] 	\
# # 				-set_to_set_distance [expr $stripe_pitch * 2] 	\
# # 				-start_offset [expr 0.64 * 2] 					\
# # 				-stop_offset [expr 0.64 * 2]



# ##################
# ####### M8 #######
# ##################
# set stripe_width   [expr 0.48]
# set stripe_pitch   [expr 10*$stripe_width]

# setViaGenMode -reset
# setAddStripeMode -reset
# setAddStripeMode -stacked_via_bottom_layer "M3" \
#                  -stacked_via_top_layer "M13"

# addStripe -nets "VSS VDD" \
#           -layer M8 \
#           -direction horizontal \
#           -width $stripe_width \
#           -spacing [expr $stripe_pitch - $stripe_width] \
#           -set_to_set_distance [expr $stripe_pitch * 2] \
#           -start_offset [expr 0.64 * 2] \
#           -stop_offset [expr 0.64 * 2]






# # setAddStripeMode -stacked_via_bottom_layer M3

# # setAddStripeMode -stacked_via_top_layer    M9
# # # Stripes
# # # Horizontal M8 for all power nets
# # addStripe \
# # 	-nets "VDD0P8_MRAMVDD_PG VDD0P8_MRAMVDDS_PG VDD3P3_MRAMVDIO_PG VDD0P8_SRAM VDD3P3_MRAMVDIO VDD0P8_CLK VDD0P8_NE VSS" \
# # 	-direction horizontal \
# # 	-layer M8 \
# # 	-width $stripe_w -spacing $stripe_s \
# # 	-set_to_set_distance 70 \
# # 	-start [expr $mram_y_start + 10] \
# # 	-stop [expr 2631] \
# # 	-merge_stripes_value 10
# # addStripe \
# # 	-nets "VDD0P8_MRAMVDD_PG VDD0P8_MRAMVDDS_PG VDD3P3_MRAMVDIO_PG VDD0P8_SRAM VDD3P3_MRAMVDIO VDD0P8_CLK VDD0P8_NE VSS" \
# # 	-direction horizontal \
# # 	-layer M8 \
# # 	-width $stripe_w -spacing $stripe_s \
# # 	-set_to_set_distance 70 \
# # 	-start [expr 2665.5] \
# # 	-stop [expr $mram_y_end + 10 + 4] \
# # 	-merge_stripes_value 10
# # addStripe \
# # 	-nets "VDD0P8_SRAM VDD0P8_CLK VDD0P8_NE VSS" \
# # 	-direction horizontal \
# # 	-layer M8 \
# # 	-width $stripe_w -spacing $stripe_s \
# # 	-set_to_set_distance 35 \
# # 	-start [expr 781 - 13] \
# # 	-stop [expr 948 - 13] \
# # 	-merge_stripes_value 10
# # addStripe \
# # 	-nets "VDD0P8_SRAM VDD0P8_CLK VDD0P8_NE VSS" \
# # 	-direction horizontal \
# # 	-layer M8 \
# # 	-width $stripe_w -spacing $stripe_s \
# # 	-set_to_set_distance 35 \
# # 	-start [expr ($pad_height - $pad_offsets) + 60 - 2.8] \
# # 	-stop [expr 725] \
# # 	-merge_stripes_value 10
# # addStripe \
# # 	-nets "VDD0P8_SRAM VDD0P8_CLK VDD0P8_NE VSS" \
# # 	-direction horizontal \
# # 	-layer M8 \
# # 	-width $stripe_w -spacing $stripe_s \
# # 	-set_to_set_distance 35 \
# # 	-start [expr 711 + 13] \
# # 	-stop [expr 750] \
# # 	-merge_stripes_value 10
# # addStripe \
# # 	-nets "VDD0P8_SRAM VDD0P8_CLK VDD0P8_NE VSS" \
# # 	-direction horizontal \
# # 	-layer M8 \
# # 	-width $stripe_w -spacing $stripe_s \
# # 	-set_to_set_distance 35 \
# # 	-start 1112 \
# # 	-stop [expr $mram_y_start - 20 + 10] \
# # 	-merge_stripes_value 10
# # addStripe \
# # 	-nets "VDD0P8_SRAM VDD0P8_CLK VDD0P8_NE VSS" \
# # 	-direction horizontal \
# # 	-layer M8 \
# # 	-width $stripe_w -spacing $stripe_s \
# # 	-set_to_set_distance 35 \
# # 	-start 955 \
# # 	-stop [expr 1085 - 4] \
# # 	-merge_stripes_value 10
# # addStripe \
# # 	-nets "VSS VDD0P8_CLK" \
# # 	-direction horizontal \
# # 	-layer M8 \
# # 	-width 1.8 -spacing 0.5 \
# #     -number_of_sets 1 \
# # 	-start [expr $CLK_GEN_NE_y + $CLK_GEN_CORE_h + 0.2] \
# # 	-merge_stripes_value 10
# # addStripe \
# # 	-nets "VDD0P8_CLK VSS" \
# # 	-direction horizontal \
# # 	-layer M8 \
# # 	-width 1.8 -spacing 0.5 \
# #     -number_of_sets 1 \
# # 	-start [expr $CLK_GEN_NE_y - 4.8] \
# # 	-merge_stripes_value 10
# # addStripe \
# # 	-nets "VDD0P8_MRAMVDD_PG VDD0P8_MRAMVDDS_PG VDD3P3_MRAMVDIO_PG" \
# # 	-direction horizontal \
# # 	-layer M8 \
# # 	-width 1.8 -spacing 0.5 \
# #     -number_of_sets 1 \
# # 	-start [expr $LC_MRAM_VDIO_y + 5] \
# # 	-merge_stripes_value 10