module FP_ADD (a, b, rnd, z, status);

    //parameter sig_width = 23;
    parameter sig_width = 10;
    //parameter exp_width = 8;
    parameter exp_width = 5;
    parameter ieee_compliance = 0;

    input [sig_width+exp_width : 0] a;
    input [sig_width+exp_width : 0] b;
    input [2 : 0] rnd;
    output [sig_width+exp_width : 0] z;
    output [7 : 0] status;

    DW_fp_add #(sig_width, exp_width, ieee_compliance)
    DUT (.a(a), .b(b), .rnd(rnd), .z(z), .status(status));

endmodule
