module cmac #(parameter DATA_WIDTH = 16) (
    input  clk,
    input  rst_n,
    input  mac,
    input  [4:0] shift,
    input  [DATA_WIDTH*2 - 1 : 0] opa,
    input  [DATA_WIDTH*2 - 1 : 0] opb,
    input  [DATA_WIDTH*2 - 1 : 0] opc,
    input  [DATA_WIDTH*2 - 1 : 0] opd,

    output logic  [DATA_WIDTH*2 - 1 : 0] out_mul,
    output logic  [DATA_WIDTH*2 - 1 : 0] out_add
);


    logic  [DATA_WIDTH - 1 : 0] opa_r;
    logic  [DATA_WIDTH - 1 : 0] opa_i;
    logic  [DATA_WIDTH - 1 : 0] opb_r;
    logic  [DATA_WIDTH - 1 : 0] opb_i;


    logic [DATA_WIDTH - 1 : 0] out_r;
    logic [DATA_WIDTH - 1 : 0] out_i;

    logic macd, macdd;

    assign opa_r = opa[DATA_WIDTH*2-1:DATA_WIDTH];
    assign opa_i = opa[DATA_WIDTH-1:0];
    assign opb_r = opb[DATA_WIDTH*2-1:DATA_WIDTH];
    assign opb_i = opb[DATA_WIDTH-1:0];

    assign out_mul = {out_r,out_i};

    assign out_add = macdd ? out_mul + opc : opc + opd;

    logic signed  [DATA_WIDTH - 1 : 0] real_opa_r;
    logic signed  [DATA_WIDTH - 1 : 0] real_opa_i;
    logic signed  [DATA_WIDTH - 1 : 0] real_opb_r;
    logic signed  [DATA_WIDTH - 1 : 0] real_opb_i;
    logic  [DATA_WIDTH - 1 : 0] out_r_pre, out_i_pre;
    logic [4:0] shiftd, shiftdd;


    assign real_opa_r = opa_r;
    assign real_opa_i = opa_i;
    assign real_opb_r = opb_r;
    assign real_opb_i = opb_i;

    logic signed [2*DATA_WIDTH - 1 : 0] arbr, arbi, aibr, aibi;
    logic signed [2*DATA_WIDTH - 1 : 0] arbrd, arbid, aibrd, aibid;

    assign arbr = real_opa_r * real_opb_r;
    assign arbi = real_opa_r * real_opb_i;
    assign aibr = real_opa_i * real_opb_r;
    assign aibi = real_opa_i * real_opb_i;

    logic signed [2*DATA_WIDTH : 0] as_pre_r, as_pre_i;
    logic signed [2*DATA_WIDTH : 0] as_pre_rd, as_pre_id;



    assign as_pre_r = arbr - aibi;
    assign as_pre_i = arbi + aibr;

    logic signed [2*DATA_WIDTH : 0] shift_pre_r, shift_pre_i;
    logic signed [2*DATA_WIDTH : 0] sat_pre_r, sat_pre_i;

    assign sat_pre_r = shift_pre_r >>> shiftdd;
    assign sat_pre_i = shift_pre_i >>> shiftdd;


    logic [DATA_WIDTH - 1 : 0] pos_ext, neg_ext;

    assign neg_ext = '1 >> 1;
    assign pos_ext = '1 << (DATA_WIDTH - 1);

    always_comb begin
        out_r_pre = 0;
        if (sat_pre_r[2*DATA_WIDTH] == 0) begin
            if (sat_pre_r[2*DATA_WIDTH : DATA_WIDTH - 1] == 0) out_r_pre = sat_pre_r [DATA_WIDTH - 1 : 0];
            else out_r_pre = pos_ext;
        end
        else begin
            if (sat_pre_r[2*DATA_WIDTH : DATA_WIDTH - 1] == '1) out_r_pre = sat_pre_r [DATA_WIDTH - 1 : 0];
            else out_r_pre = neg_ext;
        end
    end
    always_comb begin
        out_i_pre = 0;
        if (sat_pre_i[2*DATA_WIDTH] == 0) begin
            if (sat_pre_i[2*DATA_WIDTH : DATA_WIDTH - 1] == 0) out_i_pre = sat_pre_i [DATA_WIDTH - 1 : 0];
            else out_i_pre = pos_ext;
        end
        else begin
            if (sat_pre_i[2*DATA_WIDTH : DATA_WIDTH - 1] == '1) out_i_pre = sat_pre_i [DATA_WIDTH - 1 : 0];
            else out_i_pre = neg_ext;
        end
    end

    always_ff @ (posedge clk or negedge rst_n) begin
        if (rst_n == 0) begin
            shiftd          <= 0;
            arbrd           <= 0;
            arbid           <= 0;
            aibrd           <= 0;
            aibid           <= 0;
            out_r           <= 0;
            out_i           <= 0;
            shiftdd         <= 0;
            shift_pre_r     <= 0;
            shift_pre_i     <= 0;
            macd            <= 0;
            macdd           <= 0;
        end
        else begin
            shiftd          <= shift;
            arbrd           <= arbr;
            arbid           <= arbi;
            aibrd           <= aibr;
            aibid           <= aibi;
            out_r           <= out_r_pre;
            out_i           <= out_i_pre;
            shiftdd         <= shiftd;
            shift_pre_r     <= as_pre_r;
            shift_pre_i     <= as_pre_i;
            macd            <= mac;
            macdd           <= macd;

        end
    end
endmodule
