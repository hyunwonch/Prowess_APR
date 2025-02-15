# Version:1.0 MMMC View Definition File
# Do Not Remove Above Line

############################################################################
# TCL script for Innovus 15.21 (MEMv1)
# viewDefinition.tcl
#---------------------------------------------------------------------------
# Author: Yejoong Kim
# Edit  : Hyochan An
# View : Pierre Abillama
# Last Updated: Mar 12 2018
# Last Viewed: Dec 16 2021
#---------------------------------------------------------------------------
#
# <Note>
#   - "Using CapTable or QRC Techfiles" and "Using Library Operating Conditions"
#     are mutually exclusive. You must entirely comment out one of the sections.
#   - Captable is used by above 32nm nodes and QRC tech by below 32nm nodes
#
############################################################################

###################################################
# Using CapTable or QRC Techfiles
###################################################
#create_rc_corner -name typRC -cap_table ${typ_captable_file}
#create_rc_corner -name maxRC -cap_table ${max_captable_file}
#create_rc_corner -name minRC -cap_table ${min_captable_file}
set QRC_PATH	/afs/eecs.umich.edu/kits/TSMC/N28HPC+/2020.10/rf1p9m6x1z1u/QRC

# Create RC Corners
# note: Captable is used by above 32nm nodes and QRC tech by below 32nm nodes
create_rc_corner -name typRC \
        -T {25} -preRoute_res {1.0} -preRoute_cap {1.0} \
        -preRoute_clkres {0.0} -preRoute_clkcap {0.0} \
        -postRoute_res {1.0} -postRoute_cap {1.0} \
        -postRoute_xcap {1.0} -postRoute_clkres {0.0} -postRoute_clkcap {0.0} \
        -qx_tech_file "$QRC_PATH/RC_QRC_crn28hpc+_1p09m+ut-alrdl_6x1z1u_typical/qrcTechFile"

create_rc_corner -name minRC \
        -T {25} -preRoute_res {1.0} -preRoute_cap {1.0} \
        -preRoute_clkres {0.0} -preRoute_clkcap {0.0} \
        -postRoute_res {1.0} -postRoute_cap {1.0} \
        -postRoute_xcap {1.0} -postRoute_clkres {0.0} -postRoute_clkcap {0.0} \
        -qx_tech_file "$QRC_PATH/RC_QRC_crn28hpc+_1p09m+ut-alrdl_6x1z1u_rcbest/qrcTechFile"

create_rc_corner -name maxRC \
        -T {25} -preRoute_res {1.0} -preRoute_cap {1.0} \
        -preRoute_clkres {0.0} -preRoute_clkcap {0.0} \
        -postRoute_res {1.0} -postRoute_cap {1.0} \
        -postRoute_xcap {1.0} -postRoute_clkres {0.0} -postRoute_clkcap {0.0} \
        -qx_tech_file "$QRC_PATH/RC_QRC_crn28hpc+_1p09m+ut-alrdl_6x1z1u_rcworst/qrcTechFile"

create_library_set -name svtTypLib   -timing ${typ_svt_lib_file}
# create_library_set -name hvtTypLib   -timing ${typ_hvt_lib_file}
create_library_set -name otherTypLib -timing ${typ_other_lib_file}
create_library_set -name sramTypLib  -timing ${typ_sram_lib_file}

create_library_set -name svtMaxLib   -timing ${max_svt_lib_file}
#create_library_set -name hvtMaxLib   -timing ${typ_hvt_lib_file}
create_library_set -name otherMaxLib -timing ${typ_other_lib_file}
create_library_set -name sramMaxLib  -timing ${max_sram_lib_file}

create_library_set -name svtMinLib   -timing ${min_svt_lib_file}
#create_library_set -name hvtMinLib   -timing ${typ_hvt_lib_file}
create_library_set -name otherMinLib -timing ${typ_other_lib_file}
create_library_set -name sramMinLib  -timing ${min_sram_lib_file}

create_constraint_mode -name typConst -sdc_files $sdc_file

create_delay_corner -name maxDelay -library_set {svtMaxLib sramMaxLib otherMaxLib} -rc_corner maxRC
create_delay_corner -name minDelay -library_set {svtMinLib sramMinLib otherMaxLib} -rc_corner minRC

create_analysis_view -name maxAnalysis -constraint_mode typConst -delay_corner maxDelay
create_analysis_view -name minAnalysis -constraint_mode typConst -delay_corner minDelay

set_analysis_view -setup maxAnalysis -hold minAnalysis


###################################################
## Using Library Operating Conditions
###################################################
#
#create_library_set -name typLib    -timing $typ_lib_file
#create_library_set -name typLibSvt -timing $typ_svt_lib_file
#create_library_set -name typLibHvt -timing $typ_hvt_lib_file
#
#create_constraint_mode -name typConst \
#    -sdc_files $sdc_file
#
#create_delay_corner -name typDelay \
#    -library_set typLib \
#    -opcond_library typical \
#    -opcond typical \
#
#create_analysis_view -name typAnalysis \
#    -constraint_mode typConst \
#    -delay_corner typDelay
#
#set_analysis_view \
#    -setup {typAnalysis} \
#    -hold {typAnalysis}
#
