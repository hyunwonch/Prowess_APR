module fifo #(
    parameter DATA_WIDTH = 32,  // Parameterized data width
    parameter DEPTH = 16        // FIFO depth
)(
    input  logic clk,
    input  logic rst_n,
    input  logic rd_en,
    input  logic wr_en,
    input  logic [DATA_WIDTH-1:0] data_in,
    output logic [DATA_WIDTH-1:0] data_out
);
    localparam ADDR_WIDTH = $clog2(DEPTH);

    logic [DATA_WIDTH-1:0] mem [DEPTH-1:0];
    logic [ADDR_WIDTH-1:0] rd_ptr, wr_ptr;

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            rd_ptr <= 0;
            data_out <= 0;
        end else if (rd_en) begin
            data_out <= mem[rd_ptr];
            rd_ptr <= (rd_ptr + 1) % DEPTH;
        end
    end

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            wr_ptr <= 0;
        end else if (wr_en) begin
            mem[wr_ptr] <= data_in;
            wr_ptr <= (wr_ptr + 1) % DEPTH;
        end
    end
endmodule