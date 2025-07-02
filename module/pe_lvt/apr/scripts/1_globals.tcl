# Multi-CPU
set num_cpu 16

# Power Nets (net_name, voltage)
set vdd_nets        [list \
    VDD                0.9 \
]
# Internal Power Nets (net_name, voltage)
set vdd_internal    [list \
    VDD_SRAM            0.9 \
]

# Ground Nets (net_name, voltage)
set gnd_nets        [list \
    VSS       0 \
]

# Verilog Files
set verilog_file    [list   ${syn_dir}/data/${top_level}.nl.v]

# LEF Files
# set lef_files [glob -nocomplain  -directory $lef_dir *.lef]
# /afs/eecs.umich.edu/kits/TSMC/.restricted/.contrib/tsmc_res_n28hpc/jhseol/tcbn28hpcplusbwp30p140_rev6.lef

set lef_file        [list \
    ${lef_dir}/tcbn28hpcplusbwp30p140lvt_rev6_viafix.lef         \
    ${mem_dir}/ts1n28hpcpuhdlvtb32x84m1sso_170a.lef  \
    ${mem_dir}/ts1n28hpcpuhdlvtb128x32m1sso_170a.lef  \
]


# /afs/eecs.umich.edu/kits/TSMC/N28HPC+/contrib/heejiny/tcbn28hpcplusbwp30p140_rev6_viafix.lef \


# LIB Files
set typ_svt_lib_file    [list   ${lib_dir}/tcbn28hpcplusbwp30p140lvttt0p9v25c.lib \
                        ]
set max_svt_lib_file    [list   ${lib_dir}/tcbn28hpcplusbwp30p140lvttt0p9v25c.lib \
                        ]
set min_svt_lib_file    [list   ${lib_dir}/tcbn28hpcplusbwp30p140lvttt0p9v25c.lib \
                        ]
set typ_hvt_lib_file    [list   ${lib_dir}/tcbn28hpcplusbwp30p140lvttt0p9v25c.lib \
                        ]

set typ_other_lib_file  [list   ]

set typ_sram_lib_file [glob -nocomplain  -directory /net/badwater/z/hyunwon/Documents/TSMC_Prowess/tsmc28/mem/active/lib *.lib]

set max_sram_lib_file [glob -nocomplain  -directory /net/badwater/z/hyunwon/Documents/TSMC_Prowess/tsmc28/mem/active/lib *.lib]

set min_sram_lib_file [glob -nocomplain  -directory /net/badwater/z/hyunwon/Documents/TSMC_Prowess/tsmc28/mem/active/lib *.lib]

# Cab Tables
#set max_captable_file   [list   ${tech_dir}/rcworst.captbl]
#set typ_captable_file   [list   ${tech_dir}/typical.captbl]
#set min_captable_file   [list   ${tech_dir}/rcbest.captbl]

#-----------------------------------------------------------------------------
# CELLS
#-----------------------------------------------------------------------------


# Antenna Cells
set antenna_cells       [list ANTENNABWP30P140]

# Filler Cells
set svt_filler_cells    [list FILL2BWP30P140 FILL3BWP30P140 FILL4BWP30P140 FILL8BWP30P140 FILL16BWP30P140 FILL32BWP30P140 FILL64BWP30P140]
set svt_fillcap_cells   [list DCAP4BWP30P140 DCAP8BWP30P140 DCAP16BWP30P140 DCAP32BWP30P140 DCAP64BWP30P140]

# Tap Cells
set svt_tap_cells       [list TAPCELLBWP30P140]

# Tie-Cells; Do not include an underscore at the end of $tie_prefix
set svt_tie_cells       [list TIEHBWP30P140 TIELBWP30P140]

# Exclude Cells
set exclude_cells  [list ANTENNABWP30P140 FILL2BWP30P140 FILL3BWP30P140 FILL4BWP30P140 FILL8BWP30P140 FILL16BWP30P140 FILL32BWP30P140 FILL64BWP30P140 TAPCELLBWP30P140 BOUNDARY_LEFTBWP30P140 BOUNDARY_RIGHTBWP30P140 \
                        PCORNER PRCUTA PRCUT PFILLER20 PFILLER10 PFILLER5 PFILLER1 PFILLER05 PFILLER0005 \
                        PCORNERA PFILLER20A PFILLER10A PFILLER5A PFILLER1A PFILLER05A PFILLER0005A \
]

set hvt_filler_cells    [list ]
set hvt_fillcap_cells   [list ]
set hvt_tap_cells       [list ]
set hvt_tie_cells       [list ]

set clk_hvt_buf_cells [list ]
set clk_hvt_dly_cells [list ]
set clk_hvt_inv_cells [list ]

# Don't Use Cells
set dontuse_cells       [list ]

# Clocks; By default, all clocks listed below are asynchronous to each other.
set clk_const_name "typConst"

set clk_svt_buf_cells [list  CKBD0BWP30P140 CKBD16BWP30P140 CKBD20BWP30P140 CKBD2BWP30P140 CKBD4BWP30P140 CKBD8BWP30P140 CKBD12BWP30P140 CKBD1BWP30P140 CKBD24BWP30P140 CKBD3BWP30P140 CKBD6BWP30P140]

# inverter cell
set clk_svt_inv_cells [list CKND0BWP30P140 CKND16BWP30P140 CKND20BWP30P140 CKND2BWP30P140 CKND2D1BWP30P140 CKND2D3BWP30P140 CKND2D8BWP30P140 CKND4BWP30P140 CKND8BWP30P140 CKND12BWP30P140 CKND1BWP30P140 CKND24BWP30P140 CKND2D0BWP30P140 CKND2D2BWP30P140 CKND2D4BWP30P140 CKND3BWP30P140 CKND6BWP30P140]

# Why it is commented out ? Maybe not for 28nm or not used ?
#set clk_svt_dly_cells [list DEL025D1BWP30P140 DEL050MD1BWP30P140 DEL075MD1BWP30P140 DEL100MD1BWP30P140 DEL150MD1BWP30P140 DEL200MD1BWP30P140 DEL250MD1BWP30P140 ]


set clk_max_fanout  32

# SDC File
set sdc_file        "${syn_dir}/data/${top_level}.sdc"

# CPF File
set cpf_file        "${script_dir}/apr.cpf"

# Clock Tree Specification File
set ccopt_file      "${script_dir}/ccopt.spec"

# Map File used for stream-out
set map_file        "${tech_dir}/mapOut_28HPC_7X1U"

############################################################################
# POST-PROCESSING
############################################################################
set vdd_nets  [concat ${vdd_nets} ${vdd_internal}]
set vdd_names [list ]
set gnd_names [list ]
set internal_vdd_names [list ]
foreach {my_vdd_name my_vdd_val} ${vdd_nets} { set vdd_names [concat ${vdd_names} ${my_vdd_name}] }
foreach {my_gnd_name my_gnd_val} ${gnd_nets} { set gnd_names [concat ${gnd_names} ${my_gnd_name}] }
foreach {my_vdd_name my_vdd_val} ${vdd_internal} { set internal_vdd_names [concat ${internal_vdd_names} ${my_vdd_name}] }