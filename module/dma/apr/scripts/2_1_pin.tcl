
set init_offset 5.0
set gap_between 42.0

set x_pos0 [expr $init_offset + $gap_between*0]
set x_pos1 [expr $init_offset + $gap_between*1]
set x_pos2 [expr $init_offset + $gap_between*2]
set x_pos3 [expr $init_offset + $gap_between*3]
set x_pos4 [expr $init_offset + $gap_between*4]

#TOP
editPin -pin rpkt_i* -pinWidth 0.05 -fixedpin 1 -layer M5 -snap TRACK -side TOP -spreadType START -start $x_pos0 100.0 -spacing 0.2
editPin -pin wpkt_i* -pinWidth 0.05 -fixedpin 1 -layer M5 -snap TRACK -side TOP -spreadType START -start 35 100.0 -spacing 0.2
editPin -pin res_o* -pinWidth 0.05 -fixedpin 1 -layer M5 -snap TRACK -side TOP -spreadType START -start 15 100.0 -spacing 0.2

editPin -pin clk -pinWidth 0.05 -fixedpin 1 -layer M5 -snap TRACK -side TOP -spreadType START -start 25.0 100.0 -spacing 0.2
editPin -pin rst_n -pinWidth 0.05 -fixedpin 1 -layer M5 -snap TRACK -side TOP -spreadType START -start 26.0 100.0 -spacing 0.2

# RIGHT

# BOTTOM
editPin -pin rpkt_o* -pinWidth 0.05 -fixedpin 1 -layer M5 -snap TRACK -side BOTTOM -spreadType START -start $x_pos0 0.0 -spacing 0.2 -spreadDirection counterclockwise
editPin -pin wpkt_o* -pinWidth 0.05 -fixedpin 1 -layer M5 -snap TRACK -side BOTTOM -spreadType START -start 35 0.0 -spacing 0.2 -spreadDirection counterclockwise
editPin -pin res_i* -pinWidth 0.05 -fixedpin 1 -layer M5 -snap TRACK -side BOTTOM -spreadType START -start 15 100.0 -spacing 0.2 -spreadDirection counterclockwise

# LEFT
editPin -pin mem_pkt* -fixedpin 1 -layer M4 -snap TRACK -side LEFT -spreadType START -start 0.0 20 -spacing 0.2

