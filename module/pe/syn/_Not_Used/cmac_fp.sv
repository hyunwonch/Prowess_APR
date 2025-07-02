module cmac_fp #(parameter DATA_WIDTH = 16) (
    input  clk,
    input  rst_n,
    input  [2:0] rnd,
    input  [DATA_WIDTH*2 - 1 : 0] opa,
    input  [DATA_WIDTH*2 - 1 : 0] opb,
    input  [DATA_WIDTH*2 - 1 : 0] opc,
    input  [DATA_WIDTH*2 - 1 : 0] opd,

    output logic  [DATA_WIDTH*2 - 1 : 0] out_mul,
    output logic  [DATA_WIDTH*2 - 1 : 0] out_add
);


    logic [DATA_WIDTH - 1 : 0] opa_r;
    logic [DATA_WIDTH - 1 : 0] opa_i;
    logic [DATA_WIDTH - 1 : 0] opb_r;
    logic [DATA_WIDTH - 1 : 0] opb_i;
    logic [DATA_WIDTH - 1 : 0] opc_r;
    logic [DATA_WIDTH - 1 : 0] opc_i;
    logic [DATA_WIDTH - 1 : 0] opd_r;
    logic [DATA_WIDTH - 1 : 0] opd_i;

    logic [DATA_WIDTH - 1 : 0] mout_r_pre;
    logic [DATA_WIDTH - 1 : 0] mout_i_pre;

    logic [DATA_WIDTH - 1 : 0] mout_r;
    logic [DATA_WIDTH - 1 : 0] mout_i;

    logic [DATA_WIDTH - 1 : 0] aout_r_pre;
    logic [DATA_WIDTH - 1 : 0] aout_i_pre;

    logic [DATA_WIDTH - 1 : 0] aout_r;
    logic [DATA_WIDTH - 1 : 0] aout_i;

    logic [2:0]                rnd_ff, rnd_ff2;

    logic [DATA_WIDTH - 1 : 0] arbr, arbi, aibr, aibi;
    logic [DATA_WIDTH - 1 : 0] arbrd, arbid, aibrd, aibid;


    assign opa_r = opa[DATA_WIDTH*2-1:DATA_WIDTH];
    assign opa_i = opa[DATA_WIDTH-1:0];
    assign opb_r = opb[DATA_WIDTH*2-1:DATA_WIDTH];
    assign opb_i = opb[DATA_WIDTH-1:0];

    assign opc_r = opc[DATA_WIDTH*2-1:DATA_WIDTH];
    assign opc_i = opc[DATA_WIDTH-1:0];
    assign opd_r = opd[DATA_WIDTH*2-1:DATA_WIDTH];
    assign opd_i = opd[DATA_WIDTH-1:0];



    assign out_mul = {mout_r,mout_i};
    assign out_add = {aout_r,aout_i};


    // assign arbr = real_opa_r * real_opb_r;
    // assign arbi = real_opa_r * real_opb_i;
    // assign aibr = real_opa_i * real_opb_r;
    // assign aibi = real_opa_i * real_opb_i;

    // assign as_pre_r = arbr - aibi;
    // assign as_pre_i = arbi + aibr;

    FP_MULT     fpmul1(
        .a(opa_r),
        .b(opb_r),
        .rnd(rnd),
        .z(arbr),
        .status()
    );

    FP_MULT     fpmul2(
        .a(opa_r),
        .b(opb_i),
        .rnd(rnd),
        .z(arbi),
        .status()
    );

    FP_MULT     fpmul3(
        .a(opa_i),
        .b(opb_r),
        .rnd(rnd),
        .z(aibr),
        .status()
    );

    FP_MULT     fpmul4(
        .a(opa_i),
        .b(opb_i),
        .rnd(rnd),
        .z(aibi),
        .status()
    );

    FP_ADD      fpadd1 (
        .a(arbr),
        .b(-aibi),
        .rnd(rnd),
        .z(mout_r_pre),
        .status()
    );

    FP_ADD      fpadd2 (
        .a(arbi),
        .b(aibr),
        .rnd(rnd),
        .z(mout_i_pre),
        .status()
    );

    FP_ADD      fpadd3 (
        .a(opc_i),
        .b(opd_i),
        .rnd(rnd),
        .z(aout_r_pre),
        .status()
    );

    FP_ADD      fpadd4 (
        .a(opc_r),
        .b(opd_r),
        .rnd(rnd),
        .z(aout_i_pre),
        .status()
    );

    always_ff @ (posedge clk or negedge rst_n) begin
        if (rst_n == 0) begin
            rnd_ff          <= 0;
            mout_r           <= 0;
            mout_i           <= 0;
            aout_r           <= 0;
            aout_i           <= 0;
        end
        else begin
            rnd_ff          <= rnd;;
            rnd_ff2         <= rnd_ff;
            mout_r           <= mout_r_pre;
            mout_i           <= mout_i_pre;
            aout_r           <= aout_r_pre;
            aout_i           <= aout_i_pre;
        end
    end
endmodule
