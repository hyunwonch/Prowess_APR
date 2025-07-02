
######################################
##
## Milkyway Techfile / Etc Warnings
##
######################################

suppress_message TFCHK-012  ;   # Layer 'lb' is missing the attribute 'minArea'
suppress_message UID-401    ;
suppress_message VER-130    ;   # Intraassignment delay
suppress_message VER-318    ;   # Signed to unsigned
suppress_message VER-730    ;   # White space
suppress_message LINT-4     ;
suppress_message LINT-1     ;
suppress_message LINT-35    ;
suppress_message VER-941    ;
suppress_message UIO-231    ;   # You requested 14 cores. However, load on host vlsipool-k06 is 4



suppress_message LINT-31    ;   # Connected directly to output port


# Inputs/Outputs
#     Unconnected ports (LINT-28)
#     Feedthrough (LINT-29)
#     Constant outputs (LINT-52)

# Cells
#     Connected to power or ground (LINT-32)
#     Nets connected to multiple pins on same cell (LINT-33)

# Nets
#     Unloaded nets (LINT-2)