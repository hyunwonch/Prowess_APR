set top_level   PE

restoreDesign db/${top_level}.final.enc.dat ${top_level}

clearDrc
loadViolationReport -type Calibre -filename ../calibre/results/drc/drc.results

win