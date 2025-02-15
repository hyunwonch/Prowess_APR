
######################################
##
## Milkyway Techfile / Etc Warnings
##
######################################

#Warning: Layer 'lb' is missing the attribute 'minArea'. (line 591) (TFCHK-012)
suppress_message TFCHK-012  ;
suppress_message UID-401    ;
suppress_message VER-130    ;   # Intraassignment delay
suppress_message VER-318    ;   # Signed to unsigned
suppress_message VER-730    ;   # White space
suppress_message LINT-4     ;
suppress_message LINT-1     ;
suppress_message LINT-35    ;
suppress_message VER-941    ;

# Please check warnings below
suppress_message LINT-0     ;   # is not connected to any net.  Logic 0 assumed
suppress_message LINT-2     ;   # has no loads
suppress_message LINT-28    ;   # is not connected to any nets
suppress_message LINT-33    ;   # the same net is connected to more than one pin on submodule

suppress_message TIM-250    ;   # clock 'clk' does not have the needed 'rise' edge
suppress_message TIM-134    ;   # Design contains 1 high-fanout nets
