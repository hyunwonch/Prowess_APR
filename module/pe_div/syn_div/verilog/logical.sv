// logical operation
module logical #(
    parameter F_DATA = 32,
    parameter H_DATA = F_DATA/2,
    parameter SHIFT = 5,
    parameter LOGICAL_MODE = 4
    )(
    input [F_DATA-1:0]        opa,
    input [F_DATA-1:0]        opb,
    input [LOGICAL_MODE-1:0]  mode,
    input [SHIFT-1:0]         shift,
    output logic [F_DATA-1:0]       result
);


    localparam RELU       = 0;   // only real
    localparam MAX        = 1;   // only real
    localparam MIN        = 2;   // only real
    localparam SHIFT_L    = 3;
    localparam COMP       = 4;
    localparam EQUAL      = 5;
    localparam XOR        = 6;
    localparam SHIFT_R    = 7;
    localparam TAKE_SIGN  = 8;   // only real
    localparam ABS        = 9;   // only real
    localparam NEGATE     = 10;
    localparam ADD_SIGN   = 11;
    localparam CONJU      = 12;  // only complex
    localparam R_I_SWITCH = 13;  // only complex
    localparam AND        = 14;
    localparam OR         = 15;




    logic sign_a, sign_b;
    assign sign_a = opa[F_DATA-1 -: H_DATA];
    assign sign_b = opb[F_DATA-1 -: H_DATA];

    logic [H_DATA-1:0]  r_data_n, i_data_n;
    neg nr (
        .in(opa[F_DATA-1 -: H_DATA]),
        .out(r_data_n)
    );

    neg ni (
        .in(opa[H_DATA-1 :0]),
        .out(i_data_n)
    );

    always_comb begin
        case (mode)
            RELU: begin
                if (sign_a == 0) begin
                    result = opa;
                end
                else begin
                    result = 0;
                end
            end
            SHIFT_R: begin
                result[F_DATA-1 -: H_DATA] = $signed(opa[F_DATA-1 -: H_DATA]) >>> shift;
                result[H_DATA-1 : 0] = $signed(opa[H_DATA-1 : 0]) >>> shift;
            end
            SHIFT_L: begin
                result[F_DATA-1 -: H_DATA] = $signed(opa[F_DATA-1 -: H_DATA]) <<< shift;
                result[H_DATA-1 : 0] = $signed(opa[H_DATA-1 : 0]) <<< shift;
            end
            MAX: begin
                case ({sign_a, sign_b})
                2'b00: begin
                    if(opa[F_DATA-2 : H_DATA] > opb[F_DATA-2 : H_DATA]) begin
                        result = opa;
                    end
                    else begin
                        result = opb;
                    end
                end
                2'b01: begin
                    result = opa;
                end
                2'b10: begin
                    result = opb;
                end
                2'b11: begin
                    if(opa[F_DATA-2 : H_DATA] > opb[F_DATA-2 : H_DATA]) begin
                        result = opa;
                    end
                    else begin
                        result = opb;
                    end
                end
                endcase
            end
            MIN: begin
                case ({sign_a, sign_b})
                2'b00: begin
                    if(opa[F_DATA-2 : H_DATA] > opb[F_DATA-2 : H_DATA]) begin
                        result = opb;
                    end
                    else begin
                        result = opa;
                    end
                end
                2'b01: begin
                    result = opb;
                end
                2'b10: begin
                    result = opa;
                end
                2'b11: begin
                    if(opa[F_DATA-2 : H_DATA] > opb[F_DATA-2 : H_DATA]) begin
                        result = opb;
                    end
                    else begin
                        result = opa;
                    end
                end
                endcase
            end
            COMP: begin
                case ({sign_a, sign_b})
                2'b00: begin
                    if(opa[F_DATA-2 : H_DATA] > opb[F_DATA-2 : H_DATA]) begin
                        result = opa;
                    end
                    else begin
                        result = opb;
                    end
                end
                2'b01: begin
                    result = opa;
                end
                2'b10: begin
                    result = opb;
                end
                2'b11: begin
                    if(opa[F_DATA-2 : H_DATA] > opb[F_DATA-2 : H_DATA]) begin
                        result = opa;
                    end
                    else begin
                        result = opb;
                    end
                end
                endcase
            end
            XOR: begin
                result = opa ^ opb;
            end
            TAKE_SIGN: begin
                if (sign_a == 0) begin
                    result = 0;
                end
                else begin
                    result = {1'b1, 31'b0};
                end
            end
            ABS: begin
                if (sign_a == 0) begin
                    result = opa;
                end
                else begin
                    result = {r_data_n, 16'b0};
                end
            end
            NEGATE: begin
                result[F_DATA-1 -: H_DATA] = r_data_n;
                result[H_DATA-1 : 0] = i_data_n;
            end
            ADD_SIGN: begin
                if (opb[F_DATA - 1] == 0) begin
                    result[F_DATA-1 -: H_DATA] = opa[F_DATA-1 -: H_DATA];
                    result[H_DATA-1 : 0] = opa[H_DATA-1 : 0];
                end
                else begin
                    result[F_DATA-1 -: H_DATA] = r_data_n;
                    result[H_DATA-1 : 0] = i_data_n;
                end
            end
            CONJU: begin
                result[F_DATA-1 -: H_DATA] = opa[F_DATA-1 -: H_DATA];
                result[H_DATA-1 : 0] = i_data_n;
            end
            R_I_SWITCH: begin
                result[F_DATA-1 -: H_DATA] = opa[H_DATA-1 : 0];
                result[H_DATA-1 : 0] = opa[F_DATA-1 -: H_DATA];
            end
            AND: begin
                result = opa & opb;
            end
            OR: begin
                result = opa | opb;
            end
            default: result = 0;
        endcase
    end
endmodule
