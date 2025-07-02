module config_gen #(
    parameter INST_WIDTH        = 64,
    parameter CONFIG_CMAC       = 16,
    parameter CONFIG_LOGI       = 9,
    parameter CONFIG_CORDIC     = 8,
    parameter CONFIG_DMEM       = 31,
    parameter CONFIG_ALL        = CONFIG_CMAC + CONFIG_LOGI + CONFIG_CORDIC + CONFIG_DMEM,
    parameter NUM_INPUTS        = 4,
    parameter NUM_OUTPUTS       = 4,
    parameter NUM_INPUTS_CB1    = 14,
    parameter NUM_OUTPUTS_CB1   = 16,
    parameter NUM_INPUTS_CB2    = 10,
    parameter NUM_OUTPUTS_CB2   = 4,

    localparam CONFIG_WIDTH_CB1 = $clog2(NUM_INPUTS_CB1),
    localparam CONFIG_WIDTH_CB2 = $clog2(NUM_INPUTS_CB2)
)(
    input  logic                                                clk,
    input  logic                                                rst_n,
    input  logic [INST_WIDTH-1:0]                               inst,
    output logic [CONFIG_ALL-1:0]                               config_all,
    output logic [NUM_OUTPUTS_CB1-1:0][CONFIG_WIDTH_CB1-1:0]    config_cb1_i,
    output logic [NUM_OUTPUTS_CB2-1:0][CONFIG_WIDTH_CB2-1:0]    config_cb2_i,
    output logic                                                cb1_en,
    output logic                                                cb2_en
);

    logic [NUM_OUTPUTS_CB1-1:0][CONFIG_WIDTH_CB1-1:0]    config_cb1_next;
    logic [NUM_OUTPUTS_CB2-1:0][CONFIG_WIDTH_CB2-1:0]    config_cb2_next;

    logic [CONFIG_CMAC-1:0]         config_cmac_i;
    logic [CONFIG_CORDIC-1:0]       config_cordic_i;
    logic [CONFIG_LOGI-1:0]         config_logical_i;
    logic [CONFIG_DMEM-1:0]         config_dmem_i;


    logic [CONFIG_CMAC-1:0]         config_cmac_i_next;
    logic [CONFIG_CORDIC-1:0]       config_cordic_i_next;
    logic [CONFIG_LOGI-1:0]         config_logical_i_next;
    logic [CONFIG_DMEM-1:0]         config_dmem_i_next;

    logic cmac_valid, cordic_valid, logical_valid, dmem_valid;

    logic [CONFIG_CMAC-1:0]         inst_cmac;
    logic [CONFIG_CORDIC-1:0]       inst_cordic;
    logic [CONFIG_LOGI-1:0]         inst_logical;
    logic [CONFIG_DMEM-1:0]         inst_dmem;

    assign config_all = {config_cmac_i, config_cordic_i, config_logical_i, config_dmem_i};

    assign inst_cmac        = inst[0 +: CONFIG_CMAC];
    assign inst_cordic      = inst[CONFIG_CMAC +: CONFIG_LOGI];
    assign inst_logical     = inst[CONFIG_CMAC+CONFIG_LOGI +: CONFIG_CORDIC];
    assign inst_dmem        = inst[CONFIG_CMAC+CONFIG_LOGI+CONFIG_CORDIC +: CONFIG_DMEM];

    assign cmac_valid       = inst_cmac[0];
    assign cordic_valid     = inst_cordic[0];
    assign logical_valid    = inst_logical[0];
    assign dmem_valid       = inst_dmem[0];

    logic cb1_valid, cb2_valid;
    logic [3:0] cb1_id, cb2_id;

    assign cb1_id = inst[3:0];
    assign cb2_id = inst[7:4];

    assign cb1_en = config_cb1_i[0];
    assign cb2_en = config_cb2_i[0];

    always_comb begin
        if(cb1_valid) begin
            for (int i = 0; i < NUM_OUTPUTS_CB1; i = i + 1) begin
                if(cb1_id == i) begin
                    config_cb1_next[i] = inst[8 +: CONFIG_WIDTH_CB1];
                end
                else begin
                    config_cb1_next = config_cb1_i;
                end
            end
        end
    end

    always_comb begin
        if(cb2_valid) begin
            for (int i = 0; i < NUM_OUTPUTS_CB2; i = i + 1) begin
                if(cb2_id == i) begin
                    config_cb2_next[i] = inst[8 +: CONFIG_WIDTH_CB2];
                end
                else begin
                    config_cb2_next = config_cb2_i;
                end
            end
        end
    end

    always_ff @(posedge clk or negedge rst_n) begin
        if(!rst_n) begin
            config_cb1_i       <= '0;
            config_cb2_i       <= '0;
        end else begin
            config_cb1_i       <= config_cb1_next;
            config_cb2_i       <= config_cb2_next;
        end
    end

    always_comb begin
        config_cmac_i_next = config_cmac_i;
        if(cmac_valid) begin
            config_cmac_i_next = inst_cmac;
        end
    end

    always_comb begin
        config_cordic_i_next = config_cordic_i;
        if(cordic_valid) begin
            config_cordic_i_next = inst_cordic;
        end
    end

    always_comb begin
        config_logical_i_next = config_logical_i;
        if(logical_valid) begin
            config_logical_i_next = inst_logical;
        end
    end

    always_comb begin
        config_dmem_i_next = config_dmem_i;
        if(dmem_valid) begin
            config_dmem_i_next = inst_dmem;
        end
    end


    always_ff @(posedge clk or negedge rst_n) begin
        if(!rst_n) begin
            config_cmac_i       <= '0;
            config_cordic_i     <= '0;
            config_logical_i    <= '0;
            config_dmem_i       <= '0;
        end else begin
            config_cmac_i       <= config_cmac_i_next;
            config_cordic_i     <= config_cordic_i_next;
            config_logical_i    <= config_logical_i_next;
            config_dmem_i       <= config_dmem_i_next;
        end
    end


endmodule