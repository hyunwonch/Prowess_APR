module dma_engine #(
    parameter DATA_WIDTH = 32,
    parameter ADDR_WIDTH = 9,      // for 512 deep memory
    parameter BANK_COUNT = 10
)(
    input  logic                     clk,
    input  logic                     rst_n,
    // input [DATA_WIDTH-1:0]           data_i,
    // DMA engine interface to the PE array
    output logic [DATA_WIDTH-1:0]    port_0_out,
    output logic [DATA_WIDTH-1:0]    port_1_out,
    output logic [DATA_WIDTH-1:0]    port_2_out,
    output logic [DATA_WIDTH-1:0]    port_3_out,
    output logic [DATA_WIDTH-1:0]    port_4_out,
    input  logic [DATA_WIDTH-1:0]    port_0_in,
    input  logic [DATA_WIDTH-1:0]    port_1_in,
    input  logic [DATA_WIDTH-1:0]    port_2_in,
    input  logic [DATA_WIDTH-1:0]    port_3_in,
    input  logic [DATA_WIDTH-1:0]    port_4_in
);

    // Array to capture the output Q from each memory bank.
    wire [DATA_WIDTH-1:0] mem_q [0:BANK_COUNT-1];

    // Generate eight memory bank instances.
    // For banks 0 to 4 we connect the incoming data to be written into the bank
    // and use a simple address counter. The Q output from each bank is driven
    // to the corresponding DMA output port.
    // Banks 5 to 7 are instantiated with default (inactive) connections.

    logic [BANK_COUNT-1:0][ADDR_WIDTH-1:0] wr_addr, wr_addr_next;

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n)
            wr_addr <= '0;
        else
            wr_addr <= wr_addr_next;
    end

    genvar i;
    generate
        for (i = 0; i < BANK_COUNT; i = i + 1) begin : mem_banks
            // Each used bank has its own write address register.


            TS1N28HPCPUHDHVTB512X32M4SSO mem_inst (
                .SLP    (1'b0),       // Not in sleep mode
                .SD     (1'b0),       // Not in shutdown
                .CLK    (clk),
                .CEB    (1'b0),       // Chip enabled (active low)
                .WEB    (1'b0),       // Write enabled (active low)
                .A      (wr_addr[i]),
                .D      (   (i == 0) ? port_0_in :
                            (i == 1) ? port_0_in :
                            (i == 2) ? port_1_in :
                            (i == 3) ? port_1_in :
                            (i == 4) ? port_2_in :
                            (i == 5) ? port_2_in :
                            (i == 6) ? port_3_in :
                            (i == 7) ? port_3_in :
                            (i == 8) ? port_4_in :
                            (i == 9) ? port_4_in : '0
                        ),
                .RTSEL  ('0),
                .WTSEL  ('0),
                .Q      (mem_q[i])
            );
        end
    endgenerate

    // Connect the outputs from memory banks 0-4 to the DMA engine output ports.
    assign port_0_out = mem_q[0];
    assign port_1_out = mem_q[2];
    assign port_2_out = mem_q[4];
    assign port_3_out = mem_q[6];
    assign port_4_out = mem_q[8];

endmodule
