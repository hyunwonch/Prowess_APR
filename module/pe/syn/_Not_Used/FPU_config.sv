module FPU_config #(
    parameter DATA_WIDTH      = 32,  // Externally configurable parameter
    parameter INST_WIDTH      = 64,
    parameter NUM_INPUTS      = 4,
    parameter NUM_OUTPUTS     = 4,
    parameter NUM_INPUTS_CB1  = 14,
    parameter NUM_OUTPUTS_CB1 = 16,
    parameter NUM_INPUTS_CB2  = 10,
    parameter NUM_OUTPUTS_CB2 = 4,

    // Define local parameters first, before their usage

    localparam CONFIG_WIDTH_CB1 = $clog2(NUM_INPUTS_CB1),
    localparam CONFIG_WIDTH_CB2 = $clog2(NUM_INPUTS_CB2),
    localparam CONFIG_CMAC=16,
    localparam CONFIG_LOGI=9,
    localparam CONFIG_CORDIC=8,
    localparam CONFIG_DMEM=31
)(

    input clk,
    input rst_n,

    input cb1_en,
    input cb2_en,

    // Module port definitions using the localparam values
    input  logic [NUM_INPUTS-1:0][DATA_WIDTH-1:0]               data_i,
    input  logic [DATA_WIDTH-1:0]                               data_bypass_i,
    input  logic [NUM_OUTPUTS_CB1-1:0][CONFIG_WIDTH_CB1-1:0]    config_cb1_i,
    input  logic [INST_WIDTH-1:0]                               config_all,
    input  logic [NUM_OUTPUTS_CB2-1:0][CONFIG_WIDTH_CB2-1:0]    config_cb2_i,
    output logic [NUM_OUTPUTS-1:0][DATA_WIDTH-1:0]              data_o,
    output logic [DATA_WIDTH-1:0]                               data_bypass_o
);
    // Internal connections follow the parameter and localparam definitions
    logic [NUM_OUTPUTS_CB1-1:0][DATA_WIDTH-1:0] cb1_data_o;
    logic [NUM_INPUTS_CB2-1:0][DATA_WIDTH-1:0]  FUs_data_o;

    logic [NUM_INPUTS_CB1-1:0][DATA_WIDTH-1:0] data_i_cb;




    // Assign data_i_cb using a for loop
    genvar i;
    generate
        for (i = 0; i < NUM_INPUTS; i = i + 1) begin : assign_data_i_cb
            assign data_i_cb[i] = data_i[i];
        end
        for (i = 0; i < NUM_INPUTS_CB2; i = i + 1) begin : assign_data_o
            assign data_i_cb[NUM_INPUTS+i] = FUs_data_o[i];
        end
    endgenerate


    // Instantiate crossbar1 with parameterized values
    crossbar_v3 #(
        .NUM_INPUTS(NUM_INPUTS_CB1),
        .NUM_OUTPUTS(NUM_OUTPUTS_CB1),
        .DATA_WIDTH(DATA_WIDTH)
    ) crossbar1 (
        .data_i(data_i_cb),
        .select_i(config_cb1_i),
        .data_o(cb1_data_o),
        .cb_en(cb1_en),
        .*
    );

    // FUs instance, assuming its interface and internal logic use DATA_WIDTH
    FUs #(
        .DATA_WIDTH(DATA_WIDTH/2)
    ) FUs_instance (
        .data_i(cb1_data_o),
        .data_o(FUs_data_o),
        .*
    );

    // Instantiate crossbar2 with parameterized values
    crossbar_v3 #(
        .NUM_INPUTS(NUM_INPUTS_CB2),
        .NUM_OUTPUTS(NUM_OUTPUTS_CB2),
        .DATA_WIDTH(DATA_WIDTH)
    ) crossbar2 (
        .data_i(FUs_data_o),
        .select_i(config_cb2_i),
        .data_o(data_o),
        .cb_en(cb2_en),
        .*
    );

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            data_bypass_o <= 0;
        end else begin
            data_bypass_o <= data_bypass_i;
        end
    end



endmodule
