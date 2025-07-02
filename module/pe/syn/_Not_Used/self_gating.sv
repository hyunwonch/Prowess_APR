module self_gating (
    input clk,
    input rst_n,
    input start,
    input finish,

    output logic gated_clk_out
);

    parameter ACTIVE = 0;
    parameter IDLE = 1;

    logic clk_en;

    logic gated_clk;
    assign gated_clk = clk & clk_en;

    logic [2:0] state, state_next;

    always_comb begin
        state_next = state;
        if(start) begin
            state_next = ACTIVE;
        end else if (finish) begin
            state_next = IDLE;
        end
    end

    always_latch begin
        clk_en = 0;
        if(start || state == ACTIVE) begin
            clk_en = 1;
        end
    end

    always_ff @(posedge gated_clk or negedge rst_n) begin
        if(!rst_n) begin
            state <= '0;
        end else begin
            state <= state_next;
        end
    end






endmodule