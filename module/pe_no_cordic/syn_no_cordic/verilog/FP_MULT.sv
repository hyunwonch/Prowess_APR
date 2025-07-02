module FP_MULT (a, b, rnd, z, status);
    parameter sig_width       = 10;
    parameter exp_width       = 5;
    parameter ieee_compliance = 0;
    parameter en_ubr_flag     = 0;

    input  [sig_width+exp_width : 0]    a;
    input  [sig_width+exp_width : 0]    b;
    input  [2 : 0]                      rnd;
    output [sig_width+exp_width : 0]    z;
    output [7 : 0]                      status;

    DW_fp_mult #(sig_width, exp_width, ieee_compliance, en_ubr_flag)
        DUT (.a(a), .b(b), .rnd(rnd), .z(z), .status(status));

endmodule
