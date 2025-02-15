module pc #(
    parameter INST_WORD = 32
)(
    input clk,
    input rst_n,
    input start,
    output logic [$clog2(INST_WORD)-1:0]   addr_r,
    output logic                       cen_r,
    output logic                       gwen_r
);



    logic       cen_r_next;
    logic       gwen_r_next;
    logic [$clog2(INST_WORD)-1:0] addr_r_next;


    always_comb begin
        cen_r_next = cen_r;
        gwen_r_next = gwen_r;
        addr_r_next = addr_r;
        if(start) begin
            cen_r_next = 1'b0;
            gwen_r_next = 1'b1;
            addr_r_next = addr_r + 1;
        end
    end



    always_ff @(posedge clk or negedge rst_n) begin
        if(!rst_n) begin
            cen_r <= 1'b1;
            gwen_r <= 1'b1;
            addr_r <= '0;
        end else begin
            cen_r <= cen_r_next;
            gwen_r <= gwen_r_next;
            addr_r <= addr_r_next;
        end
    end








endmodule