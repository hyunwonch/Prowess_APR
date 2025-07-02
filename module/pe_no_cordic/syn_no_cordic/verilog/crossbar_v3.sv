module crossbar_v3 #(
    parameter int NUM_INPUTS = 14,  // Number of inputs
    parameter int NUM_OUTPUTS = 16, // Number of outputs
    parameter int DATA_WIDTH = 32   // Width of data buses
) (
    input  logic                                            clk,
    input  logic                                            rst_n,
    input  logic                                            cb_en,
    input  logic [NUM_INPUTS-1:0][DATA_WIDTH-1:0]           data_i,       // Input data buses
    input  logic [NUM_OUTPUTS-1:0][$clog2(NUM_INPUTS)-1:0]  select_i ,      // Configuration for each output
    output logic [NUM_OUTPUTS-1:0][DATA_WIDTH-1:0]          data_o          // Output data buses
);

    logic [NUM_INPUTS-1:0][DATA_WIDTH-1:0]                  data_i_f;                        // Output data buses


    logic clk_gated;
    assign clk_gated = cb_en & clk;

    // Generate statements to create configurable connections for each output
    genvar i;

    generate
        for (i = 0; i < 2; i = i + 1) begin : direct_routing
            always_comb begin
                if(cb_en) begin
                    if (select_i[i] < NUM_INPUTS) begin
                        data_o[i] = data_i_f[select_i[i]];  // Valid input selection
                    end else begin
                        data_o[i] = {DATA_WIDTH{1'b0}};  // Default value for data_o-of-range indices
                    end
                end
                else begin
                    data_o[i] = data_i_f[i];
                end
            end
        end
    endgenerate


    generate
        for (i = 2; i < NUM_OUTPUTS; i = i + 1) begin : crossbar_routing
            always_comb begin
                // Check if the selected input index is within range
                if (select_i[i] < NUM_INPUTS) begin
                    data_o[i] = data_i_f[select_i[i]];  // Valid input selection
                end else begin
                    data_o[i] = {DATA_WIDTH{1'b0}};  // Default value for data_o-of-range indices
                end
            end
        end
    endgenerate


    // Generate statements to create configurable connections for each output
    generate
        for (i = 0; i < 2; i = i + 1) begin : direct_ff
            always_ff @(posedge clk or negedge rst_n) begin
                if (!rst_n) begin
                    data_i_f[i] <= 0;
                end else begin
                    data_i_f[i] <= data_i[i];
                end
            end
        end
    endgenerate


    generate
        for (i = 2; i < NUM_INPUTS; i = i + 1) begin : output_ff
            always_ff @(posedge clk_gated or negedge rst_n) begin
                if (!rst_n) begin
                    data_i_f[i] <= 0;
                end else begin
                    data_i_f[i] <= data_i[i];
                end
            end
        end
    endgenerate

endmodule