
set init_offset 5.0
set gap_between 42.0

set x_pos0 [expr $init_offset + $gap_between*0]
set x_pos1 [expr $init_offset + $gap_between*1]
set x_pos2 [expr $init_offset + $gap_between*2]
set x_pos3 [expr $init_offset + $gap_between*3]
set x_pos4 [expr $init_offset + $gap_between*4]

#TOP
editPin -pin port0_in* -pinWidth 0.05 -fixedpin 1 -layer M5 -snap TRACK -side TOP -spreadType START -start $x_pos0 100.0 -spacing 0.2
editPin -pin port1_out* -pinWidth 0.05 -fixedpin 1 -layer M5 -snap TRACK -side TOP -spreadType START -start $x_pos1 100.0 -spacing 0.2

editPin -pin clk -pinWidth 0.05 -fixedpin 1 -layer M5 -snap TRACK -side TOP -spreadType START -start 25.0 100.0 -spacing 0.2
editPin -pin rst_n -pinWidth 0.05 -fixedpin 1 -layer M5 -snap TRACK -side TOP -spreadType START -start 26.0 100.0 -spacing 0.2

# RIGHT
editPin -pin port1_in* -fixedpin 1 -layer M4 -snap TRACK -side RIGHT -spreadType START -start 100.0 $x_pos1 -spacing 0.2 -spreadDirection counterclockwise
editPin -pin port2_out* -fixedpin 1 -layer M4 -snap TRACK -side RIGHT -spreadType START -start 100.0 $x_pos0 -spacing 0.2 -spreadDirection counterclockwise
editPin -pin sw_config_out* -fixedpin 1 -layer M4 -snap TRACK -side RIGHT -spreadType START -start 0.0 23.4 -spacing 0.2 -spreadDirection counterclockwise

# BOTTOM
editPin -pin port2_in* -pinWidth 0.05 -fixedpin 1 -layer M5 -snap TRACK -side BOTTOM -spreadType START -start $x_pos1 0.0 -spacing 0.2 -spreadDirection counterclockwise
editPin -pin port3_out* -pinWidth 0.05 -fixedpin 1 -layer M5 -snap TRACK -side BOTTOM -spreadType START -start $x_pos0 0.0 -spacing 0.2 -spreadDirection counterclockwise

# LEFT
editPin -pin port3_in* -fixedpin 1 -layer M4 -snap TRACK -side LEFT -spreadType START -start 0.0 $x_pos0 -spacing 0.2
editPin -pin port0_out* -fixedpin 1 -layer M4 -snap TRACK -side LEFT -spreadType START -start 0.0 $x_pos1 -spacing 0.2
editPin -pin sw_config_in* -fixedpin 1 -layer M4 -snap TRACK -side LEFT -spreadType START -start 0.0 23.4 -spacing 0.2

