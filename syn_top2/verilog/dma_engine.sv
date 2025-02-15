module dma_engine #(
    parameter DATA_WIDTH = 32,
    parameter ADDR_WIDTH = 9,      // for 512 deep memory
    parameter DMA_PORTS = 10
)(
    input  logic                     clk,
    input  logic                     rst_n,
    // input [DATA_WIDTH-1:0]           data_i,
    // DMA engine interface to the PE array

    input  logic [DATA_WIDTH-1:0]    port_in [0:DMA_PORTS-1],
    output logic [DATA_WIDTH-1:0]    port_out[0:DMA_PORTS-1]


);

    localparam BANK_COUNT = DMA_PORTS*2;

    wire [DATA_WIDTH-1:0] mem_q [0:BANK_COUNT-1];

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
            TS1N28HPCPUHDHVTB512X32M4SSO mem_inst (
                .SLP    (1'b0),       // Not in sleep mode
                .SD     (1'b0),       // Not in shutdown
                .CLK    (clk),
                .CEB    (1'b0),       // Chip enabled (active low)
                .WEB    (1'b0),       // Write enabled (active low)
                .A      (wr_addr[i]),
                .D      (port_in[i/2]),
                .RTSEL  ('0),
                .WTSEL  ('0),
                .Q      (mem_q[i])
            );
        end
    endgenerate

    generate
        for (i = 0; i < DMA_PORTS; i = i + 1) begin
            assign port_out[i] = mem_q[i*2];
        end
    endgenerate

endmodule
