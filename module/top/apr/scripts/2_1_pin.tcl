
# set init_offset 22.0
# set gap_between 15.0

# set init_offset1 10.0
# set x_pos0 [expr $init_offset1 + $gap_between*0]
# set x_pos1 [expr $init_offset1 + $gap_between*1]
# set x_pos2 [expr $init_offset1 + $gap_between*2]
# set x_pos3 [expr $init_offset1 + $gap_between*3]
# set x_pos4 [expr $init_offset1 + $gap_between*4]

# # set x_size [dbGet top.fPlan.coreBox_sizex]
# # set y_size [dbGet top.fPlan.coreBox_sizey]

set x_size [dbGet top.fPlan.box_sizex]
set y_size [dbGet top.fPlan.box_sizey]

# set init_x [dbGet top.fplan.coreBox_llx]
# set init_y [dbGet top.fplan.coreBox_lly]

set clk [expr -1 + $x_size/2]
set rst [expr  1 + $x_size/2]


# set config [expr $clk - 20]


# #TOP

editPin -pin control* -pinWidth 0.05 -fixedpin 1 -layer M5 -snap TRACK -side TOP -spreadType START -start 070.0 3000.0 -spacing 0.6
editPin -pin inst* -pinWidth 0.05 -fixedpin 1 -layer M5 -snap TRACK -side TOP -spreadType START -start 300.0 3000.0 -spacing 0.6
editPin -pin sm* -pinWidth 0.05 -fixedpin 1 -layer M5 -snap TRACK -side TOP -spreadType START -start 400.0 3000.0 -spacing 0.6
editPin -pin st* -pinWidth 0.05 -fixedpin 1 -layer M5 -snap TRACK -side TOP -spreadType START -start 5000.0 3000.0 -spacing 0.6
editPin -pin spm* -pinWidth 0.05 -fixedpin 1 -layer M5 -snap TRACK -side TOP -spreadType START -start 600.0 3000.0 -spacing 0.6
editPin -pin cmd* -pinWidth 0.05 -fixedpin 1 -layer M5 -snap TRACK -side TOP -spreadType START -start 700.0 3000.0 -spacing 0.6
# editPin -pin data_o_2* -pinWidth 0.05 -fixedpin 1 -layer M5 -snap TRACK -side TOP -spreadType START -start [expr $x_size - $init_x - $init_offset] $y_size -spacing 0.6

editPin -pin clk -pinWidth 0.05 -fixedpin 1 -layer M5 -snap TRACK -side TOP -spreadType START -start $clk $y_size -spacing 0.6
editPin -pin rst_n -pinWidth 0.05 -fixedpin 1 -layer M5 -snap TRACK -side TOP -spreadType START -start $rst $y_size -spacing 0.6

# editPin -pin pe_config_in* -fixedpin 1 -layer M5 -snap TRACK -side TOP -spreadType START -start $config $y_size -spacing 0.6


# # RIGHT
# editPin -pin data_i_2* -fixedpin 1 -layer M4 -snap TRACK -side RIGHT -spreadType START -start $x_size [expr $y_size - $init_y - 25] -spacing 0.6 -spreadDirection counterclockwise
# editPin -pin data_o_3* -fixedpin 1 -layer M4 -snap TRACK -side RIGHT -spreadType START -start $x_size $x_pos0 -spacing 0.6 -spreadDirection counterclockwise
# editPin -pin data_bypass_o* -fixedpin 1 -layer M4 -snap TRACK -side RIGHT -spreadType START -start $x_size $clk -spacing 0.6 -spreadDirection counterclockwise


# # BOTTOM
# editPin -pin data_i_3* -pinWidth 0.05 -fixedpin 1 -layer M5 -snap TRACK -side BOTTOM -spreadType START -start [expr $x_size - $init_x - $init_offset] 0.0 -spacing 0.6 -spreadDirection counterclockwise
# editPin -pin data_o_4* -pinWidth 0.05 -fixedpin 1 -layer M5 -snap TRACK -side BOTTOM -spreadType START -start $x_pos0 0.0 -spacing 0.6 -spreadDirection counterclockwise
# editPin -pin pe_config_out* -fixedpin 1 -layer M5 -snap TRACK -side BOTTOM -spreadType START -start $config 0.0 -spacing 0.6 -spreadDirection counterclockwise


# # LEFT
# editPin -pin data_i_4* -fixedpin 1 -layer M4 -snap TRACK -side LEFT -spreadType START -start 0.0 $x_pos0 -spacing 0.6
# editPin -pin data_o_1* -fixedpin 1 -layer M4 -snap TRACK -side LEFT -spreadType START -start 0.0 [expr $y_size - $init_y - 25] -spacing 0.6

# editPin -pin data_bypass_i* -fixedpin 1 -layer M4 -snap TRACK -side LEFT -spreadType START -start 0.0 $clk -spacing 0.6

