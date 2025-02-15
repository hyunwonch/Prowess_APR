parameter signed [9:0][15:0] NEW_ATAN = {
        16'd0020,
        16'd0040,
        16'd0081,
        16'd0162,
        16'd0325,
        16'd0651,
        16'd1297,
        16'd2555,
        16'd4836,
        16'd8192
};

parameter [15:0] SCL = 16'sh4dbc;

module cordic # (parameter DATA_WIDTH = 16) (
    input                       clk,
    input                       rst_n,
    input                       start,
    input  [2:0]                mode,
    input  [3:0]                shift,
    input  [DATA_WIDTH*2 - 1 : 0] opa,
    input  [DATA_WIDTH*2 - 1 : 0] opb,

    output logic [DATA_WIDTH*2 - 1 : 0] data_o
);


    logic [DATA_WIDTH-1:0] opa_r, opa_i, opb_r, opb_i, out_r, out_i;

    assign opa_r = opa[DATA_WIDTH*2-1:DATA_WIDTH];
    assign opa_i = opa[DATA_WIDTH-1:0];
    assign opb_r = opb[DATA_WIDTH*2-1:DATA_WIDTH];
    assign opb_i = opb[DATA_WIDTH-1:0];
    assign data_o = {out_r,out_i};


    logic  start1;
    logic  [2:0] mode1;


    always_ff @ (posedge clk or negedge rst_n) begin
        if (rst_n == 0) begin
            start1 <= '0;
        end
        else begin
            start1 <= start;
        end
    end
    always_ff @ (posedge clk or negedge rst_n) begin
        if (rst_n == 0) begin
            mode1 <= '0;
        end
        else if (start) begin
            mode1 <= mode;
        end
    end
/*
    input gating start
*/
    logic signed  [DATA_WIDTH - 1 : 0] real_opa_r;
    logic signed  [DATA_WIDTH - 1 : 0] real_opa_i;
    logic signed  [DATA_WIDTH - 1 : 0] real_opb_r;
    logic signed  [DATA_WIDTH - 1 : 0] real_opb_i;


    assign real_opa_r = (start == 1)? opa_r : '0;
    assign real_opa_i = (start == 1)? opa_i : '0;
    assign real_opb_r = (start == 1)? opb_r : '0;
    assign real_opb_i = (start == 1)? opb_i : '0;

    logic [3:0] shiftd;


/*
    input gating end
*/
/*
    stage 0, small shifting start
*/
    logic signed [DATA_WIDTH + 2 : 0] xs, ys;
    logic signed [DATA_WIDTH - 1 : 0] zs;
    logic signed [DATA_WIDTH/2 - 1 : 0] ws;
    logic signed [DATA_WIDTH + 2 : 0] x0, y0;
    logic signed [DATA_WIDTH - 1 : 0] z0;
    logic signed [DATA_WIDTH/2 - 1 : 0] w0;

    logic pre_shift, x_small, y_small, w_small;

    assign x_small = real_opa_r[DATA_WIDTH-1:8] == '1 || real_opa_r[DATA_WIDTH-1:8] == 0;
    assign y_small = real_opa_i[DATA_WIDTH-1:8] == '1 || real_opa_i[DATA_WIDTH-1:8] == 0;
    assign w_small = real_opb_r[DATA_WIDTH-1:8] == '1 || real_opb_r[DATA_WIDTH-1:8] == 0;

    assign pre_shift = x_small && y_small;

    always_comb begin
        xs = 0;
        ys = 0;
        ws = 0;
        if (pre_shift == 1) begin
            xs = {real_opa_r[DATA_WIDTH-1], real_opa_r[DATA_WIDTH-1], real_opa_r[DATA_WIDTH-1], real_opa_r[7:0], 8'b0};
            ys = {real_opa_i[DATA_WIDTH-1], real_opa_i[DATA_WIDTH-1], real_opa_i[DATA_WIDTH-1], real_opa_i[7:0], 8'b0};
        end
        else begin
            xs = {real_opa_r[DATA_WIDTH-1], real_opa_r[DATA_WIDTH-1], real_opa_r[DATA_WIDTH-1], real_opa_r};
            ys = {real_opa_i[DATA_WIDTH-1], real_opa_i[DATA_WIDTH-1], real_opa_i[DATA_WIDTH-1], real_opa_i};
        end
        if (w_small == 1) begin
            ws = real_opb_r [DATA_WIDTH/2 - 1 : 0];
        end
        else begin
            ws = real_opb_r [DATA_WIDTH - 1 : DATA_WIDTH/2];
        end
    end
    assign zs = (mode[2] == 1)? (~real_opb_i + 1) : real_opb_r;
/*
    stage 0, small shifting end
*/
/*
    stage 0, pre rotation start
*/
    logic  vectoring;
    assign vectoring = (mode[2] == 0 && mode [1:0] != 0);
    assign w0 = ws;
    always_comb begin
       x0 = 0;
       y0 = 0;
       z0 = 0;
       if (vectoring == 1) begin
          case ({ys[DATA_WIDTH+2], xs[DATA_WIDTH+2]})
             2'b00: begin
                x0 = xs;
                y0 = ys;
                z0 = {2'b00, zs[DATA_WIDTH - 3 : 0]};
             end
             2'b01: begin
                x0 = ys;
                y0 = ~xs + 1;
                z0 = {2'b01, zs[DATA_WIDTH - 3 : 0]};
             end
             2'b10: begin
                x0 = ~xs+1;
                y0 = ~ys+1;
                z0 = {2'b10, zs[DATA_WIDTH - 3 : 0]};
             end
             2'b11: begin
                x0 = ~ys + 1;
                y0 = xs;
                z0 = {2'b11, zs[DATA_WIDTH - 3 : 0]};
             end
          endcase
       end
       else begin
          z0 = {2'b00, zs[DATA_WIDTH-3:0]};
          case (zs[DATA_WIDTH-1 : DATA_WIDTH-2])
              2'b00: begin
                 x0 = xs;
                 y0 = ys;
              end
              2'b01: begin
                 x0 = ~ys + 1;
                 y0 = xs;
              end
              2'b10: begin
                 x0 = ~xs + 1;
                 y0 = ~ys + 1;
              end
              2'b11: begin
                 x0 = ys;
                 y0 = ~xs + 1;
              end
          endcase
       end
    end
/*
    stage 0, pre rotation end
*/
/*
    pipeline to first stage of cordic
*/
    logic signed [DATA_WIDTH + 2 : 0] x1, y1;
    logic signed [DATA_WIDTH - 1 : 0] z1;
    logic signed [DATA_WIDTH/2 - 1 : 0] w1;

    logic pre_shiftd, wsmalld;
    logic wactivate;
    always_ff @ (posedge clk or negedge rst_n) begin
       if (rst_n == 0) begin
          x1 <= '0;
          y1 <= '0;
          z1 <= '0;
          w1 <= '0;
          pre_shiftd <= '0;
          wsmalld <= '0;
          shiftd <= '0;
          wactivate <= '0;
       end
       else if (start ==1) begin
          x1 <= x0;
          y1 <= y0;
          z1 <= z0;
          w1 <= w0;
          pre_shiftd <= pre_shift;
          wsmalld <= w_small;
          shiftd <= shift;
          wactivate <= mode[2];
       end
    end
/*
   piping through corker
*/
    logic signed [5:0][DATA_WIDTH + 2 : 0] x_pipe, y_pipe;
    logic signed [5:0][DATA_WIDTH - 1 : 0] z_pipe;
    logic [5:0] preshift_pipe;
    logic [5:0] [2:0] mode_pipe;

    assign x_pipe[0] = x1;
    assign y_pipe[0] = y1;
    assign z_pipe[0] = z1;
    assign mode_pipe[0] = mode1;
    assign preshift_pipe [0] = pre_shiftd;

    genvar i;
    generate
        for (i = 0; i < 5; i = i + 1) begin
            corker #(.DATA_WIDTH(DATA_WIDTH), .ITER(i)) ck (
                .clk(clk),
                .rst_n(rst_n),
                .start(start),
                .mode (mode_pipe[i]),
                .moded (mode_pipe[i+1]),
                .preshift (preshift_pipe[i]),
                .preshiftd (preshift_pipe[i+1]),
                .x (x_pipe[i]),
                .y (y_pipe[i]),
                .z (z_pipe[i]),
                .x_new (x_pipe[i+1]),
                .y_new (y_pipe[i+1]),
                .z_new (z_pipe[i+1])
            );
        end
    endgenerate
/*
    instantiate reciprocal
*/

    logic [DATA_WIDTH - 1 : 0] mult_value;
    logic [5:0] final_shift;

    reciprocal r1 (
        .*,
        .shift(shiftd)
    );


/*
    start handling output
*/

    logic signed [DATA_WIDTH - 1 : 0]  final_mult;
    logic [5:0]  shift_amount;

    assign final_mult = (mode_pipe[5][2]) ? mult_value : $signed(SCL);
    assign shift_amount  = (mode_pipe[5][2]) ? final_shift : ((preshift_pipe[5])? 23 : 15);

    logic signed [2*DATA_WIDTH + 2 : 0] m_result0_pre, m_result1_pre;
    logic signed [2*DATA_WIDTH + 2 : 0] m_result0_sat, m_result1_sat;
    logic signed [DATA_WIDTH - 1 : 0] m_result0, m_result1;

    assign m_result0_pre = final_mult * $signed(x_pipe[5]);
    assign m_result1_pre = final_mult * $signed(y_pipe[5]);

    assign m_result0_sat = m_result0_pre >>> shift_amount;
    assign m_result1_sat = m_result1_pre >>> shift_amount;

    logic [DATA_WIDTH - 1 : 0] pos_ext, neg_ext;

    assign neg_ext = '1 >> 1;
    assign pos_ext = '1 << (DATA_WIDTH - 1);

    always_comb begin
        m_result0 = '0;
        if (m_result0_sat[2*DATA_WIDTH + 2] == 0) begin
            if (m_result0_sat[2*DATA_WIDTH + 2 : DATA_WIDTH - 1] == 0) m_result0 = m_result0_sat [DATA_WIDTH - 1 : 0];
            else m_result0 = pos_ext;
        end
        else begin
            if (m_result0_sat[2*DATA_WIDTH + 2 : DATA_WIDTH - 1] == '1) m_result0 = m_result0_sat [DATA_WIDTH - 1 : 0];
            else m_result0 = neg_ext;
        end
    end
    always_comb begin
        m_result1 = '0;
        if (m_result1_sat[2*DATA_WIDTH + 2] == 0) begin
            if (m_result1_sat[2*DATA_WIDTH + 2 : DATA_WIDTH - 1] == 0) m_result1 = m_result1_sat [DATA_WIDTH - 1 : 0];
            else m_result1 = pos_ext;
        end
        else begin
            if (m_result1_sat[2*DATA_WIDTH + 2 : DATA_WIDTH - 1] == '1) m_result1 = m_result1_sat [DATA_WIDTH - 1 : 0];
            else m_result1 = neg_ext;
        end
    end

    logic [DATA_WIDTH - 1 : 0] out_r_pre, out_i_pre;

    always_comb begin
        out_r_pre = '0;
        out_i_pre = '0;
        if (mode_pipe[5][2] == 1 || mode_pipe[5][1:0] == 0) begin
            out_r_pre = m_result0;
            out_i_pre = m_result1;
        end
        else if (mode_pipe[5][1:0] == 1) begin
            out_r_pre = z_pipe[5];
            out_i_pre = '0;
        end
        else if (mode_pipe[5][1:0] == 2) begin
            out_r_pre = m_result0;
            out_i_pre = '0;
        end
        else if (mode_pipe[5][1:0] == 3) begin
            out_r_pre = m_result0;
            out_i_pre = z_pipe[5];
        end
    end

    assign out_r = out_r_pre;
    assign out_i = out_i_pre;


endmodule

module reciprocal #(parameter DATA_WIDTH = 8) (
    input               clk,
    input               rst_n,

    input  [DATA_WIDTH - 1 : 0] w1,
    input               pre_shiftd,  // if 1, right shift by 8
    input               wsmalld,     // if 0, right shift by 8
    input               wactivate,
    input  [3:0]        shift,

    output logic  [2*DATA_WIDTH - 1 : 0] mult_value,
    output logic  [5:0]     final_shift
);

    logic [2*DATA_WIDTH - 1 : 0] lut_value0, lut_value1;


    logic [5:0] constant_shift, shift0, shift1;

    lut l1 (.index(w1), .enable(wactivate), .value(lut_value0));

    assign shift0 = constant_shift - shift;

    always_comb begin
       constant_shift = '0;
       if (w1 == 1) begin
       constant_shift = 15;
       case ({pre_shiftd, wsmalld})
           2'b10: constant_shift = 31;
           2'b00: constant_shift = 23;
           2'b11: constant_shift = 23;
           default: begin
           end
       endcase
       end
       else if (w1 == 2) begin
       constant_shift = 16;
       case ({pre_shiftd, wsmalld})
           2'b10: constant_shift = 32;
           2'b00: constant_shift = 24;
           2'b11: constant_shift = 24;
           default: begin
           end
       endcase
       end
       else begin
       constant_shift = 17;
       case ({pre_shiftd, wsmalld})
           2'b10: constant_shift = 33;
           2'b00: constant_shift = 25;
           2'b11: constant_shift = 25;
           default: begin
           end
       endcase
       end
    end

    logic start0, start1, start2, start3, start4;

    assign start0 = wactivate;

    always_ff @ (posedge clk or negedge rst_n) begin
       if (rst_n == 0) begin
          start1 <= '0;
          start2 <= '0;
          start3 <= '0;
          start4 <= '0;
       end
       else begin
          start1 <= start0;
          start2 <= start1;
          start3 <= start2;
          start4 <= start3;
       end
    end

    always_ff @(posedge clk or negedge rst_n) begin
       if (rst_n == 0) begin
          lut_value1 <= '0;
          shift1 <= '0;
       end
       else if (start0) begin
          lut_value1 <= lut_value0;
          shift1 <= shift0;
       end
    end

    logic [2*DATA_WIDTH - 1 : 0] lut_value2, lut_value3, lut_value4, lut_value2_pre;
    logic [5:0] shift2, shift3, shift4;
    assign lut_value2_pre = lut_value1;

    always_ff @ (posedge clk or negedge rst_n) begin
       if (rst_n == 0) begin
          lut_value2 <= '0;
          shift2 <= '0;
       end
       else if (start1) begin
          lut_value2 <= lut_value2_pre;
          shift2 <= shift1;
       end
    end

    always_ff @ (posedge clk or negedge rst_n) begin
       if (rst_n == 0) begin
          lut_value3 <= '0;
          shift3 <= '0;
       end
       else if (start2) begin
          lut_value3 <= lut_value2;
          shift3 <= shift2;
       end
    end

    always_ff @ (posedge clk or negedge rst_n) begin
       if (rst_n == 0) begin
          lut_value4 <= '0;
          shift4 <= '0;
       end
       else if (start3) begin
          lut_value4 <= lut_value3;
          shift4 <= shift3;
       end
    end


    always_ff @ (posedge clk or negedge rst_n) begin
       if (rst_n == 0) begin
          mult_value <= '0;
          final_shift <= '0;
       end
       else if (start4) begin
          mult_value <= lut_value4;
          final_shift <= shift4;
       end
    end

endmodule


module corker #(parameter DATA_WIDTH = 16, ITER = 0) (
    input   clk,
    input   rst_n,
    input   preshift,
    output logic preshiftd,
    input  [2:0] mode,
    input start,
    output logic [2:0] moded,
    input signed [DATA_WIDTH + 2 : 0] x,
    input signed [DATA_WIDTH + 2 : 0] y,
    input signed [DATA_WIDTH - 1 : 0] z,
    output logic signed [DATA_WIDTH + 2 : 0] x_new,
    output logic signed [DATA_WIDTH + 2 : 0] y_new,
    output logic signed [DATA_WIDTH - 1 : 0] z_new
);

    logic signed [DATA_WIDTH + 2 : 0] ximm1, yimm1, ximm2, yimm2;
    logic signed [DATA_WIDTH - 1 : 0] zimm1, zimm2;

    logic vectoring;
    assign vectoring = mode [2] == 0 && mode[1:0] != 0;

    always_comb begin
        ximm1 = 0;
        yimm1 = 0;
        zimm1 = 0;
        ximm2 = 0;
        yimm2 = 0;
        zimm2 = 0;
        if (start == 1 && vectoring == 1) begin
            if (y[DATA_WIDTH + 2] == 1) begin
                ximm1 = x - $signed(y >>> 2*ITER);
                yimm1 = y + $signed(x >>> 2*ITER);
                zimm1 = z - $signed(NEW_ATAN[2*ITER]);
            end
            else begin
                ximm1 = x + $signed(y >>> 2*ITER);
                yimm1 = y - $signed(x >>> 2*ITER);
                zimm1 = z + $signed(NEW_ATAN[2*ITER]);
            end
            if (yimm1[DATA_WIDTH + 2] == 1) begin
                ximm2 = ximm1 - $signed(yimm1 >>> (2*ITER+1));
                yimm2 = yimm1 + $signed(ximm1 >>> (2*ITER+1));
                zimm2 = zimm1 - $signed(NEW_ATAN[(2*ITER+1)]);
            end
            else begin
                ximm2 = ximm1 + $signed(yimm1 >>> (2*ITER+1));
                yimm2 = yimm1 - $signed(ximm1 >>> (2*ITER+1));
                zimm2 = zimm1 + $signed(NEW_ATAN[(2*ITER+1)]);
            end
        end
        else if (start == 1) begin
            if (z[DATA_WIDTH - 1] == 1) begin
                ximm1 = x + $signed(y >>> 2*ITER);
                yimm1 = y - $signed(x >>> 2*ITER);
                zimm1 = z + $signed(NEW_ATAN[2*ITER]);
            end
            else begin
                ximm1 = x - $signed(y >>> 2*ITER);
                yimm1 = y + $signed(x >>> 2*ITER);
                zimm1 = z - $signed(NEW_ATAN[2*ITER]);
            end
            if (zimm1[DATA_WIDTH - 1] == 1) begin
                ximm2 = ximm1 + $signed(yimm1 >>> (2*ITER+1));
                yimm2 = yimm1 - $signed(ximm1 >>> (2*ITER+1));
                zimm2 = zimm1 + $signed(NEW_ATAN[(2*ITER+1)]);
            end
            else begin
                ximm2 = ximm1 - $signed(yimm1 >>> (2*ITER+1));
                yimm2 = yimm1 + $signed(ximm1 >>> (2*ITER+1));
                zimm2 = zimm1 - $signed(NEW_ATAN[(2*ITER+1)]);
            end
        end
    end

    always_ff @ (posedge clk or negedge rst_n) begin
        if (rst_n == 0) begin
            moded <= '0;
            x_new <= '0;
            y_new <= '0;
            z_new <= '0;
            preshiftd <= '0;
        end
        else if (start == 1) begin
            moded <= mode;
            x_new <= ximm2;
            y_new <= yimm2;
            z_new <= zimm2;
            preshiftd <= preshift;
        end
    end

endmodule
