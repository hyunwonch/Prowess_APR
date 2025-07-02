module PE_prowess #(
    parameter DATA_WIDTH = 32,
    parameter INST_WIDTH = 64,
    parameter INST_WORD  = 32,
    parameter ID         = 2,
    parameter CONF       = 64+2+4,

    localparam NUM_INPUTS = 4,
    localparam NUM_OUTPUTS= 4,
    localparam NUM_INPUTS_CB1 = 14,
    localparam NUM_OUTPUTS_CB1 = 16,
    localparam NUM_INPUTS_CB2 = 10,
    localparam NUM_OUTPUTS_CB2 = 4,
    localparam CONFIG_WIDTH_CB1 = $clog2(NUM_INPUTS_CB1),
    localparam CONFIG_WIDTH_CB2 = $clog2(NUM_INPUTS_CB2)
)(
    input                                           clk,
    input                                           rst_n,
    input [DATA_WIDTH-1:0]                          data_i_1,
    input [DATA_WIDTH-1:0]                          data_i_2,
    input [DATA_WIDTH-1:0]                          data_i_3,
    input [DATA_WIDTH-1:0]                          data_i_4,
    input [DATA_WIDTH-1:0]                          data_bypass_i,
    input [CONF-1:0]                                pe_config_in,



    output logic [DATA_WIDTH-1:0]                   data_o_1,
    output logic [DATA_WIDTH-1:0]                   data_o_2,
    output logic [DATA_WIDTH-1:0]                   data_o_3,
    output logic [DATA_WIDTH-1:0]                   data_o_4,
    output logic [DATA_WIDTH-1:0]                   data_bypass_o,
    output logic [CONF-1:0]                         pe_config_out

);

    //////////////////////////////////////
    ////////  Signal Declaration  ////////
    //////////////////////////////////////

    logic [NUM_OUTPUTS_CB1-1:0][CONFIG_WIDTH_CB1-1:0]   config_cb1_i;
    logic [NUM_OUTPUTS_CB2-1:0][CONFIG_WIDTH_CB2-1:0]   config_cb2_i;
    logic                                               cb1_en;
    logic                                               cb2_en;
    // Signals for imem
    logic [$clog2(INST_WORD)-1:0]                       addr_r;
    logic                                               cen_r;
    logic                                               gwen_r;
    logic [INST_WIDTH-1:0]                              imem_data_o;
    logic [INST_WIDTH-1:0]                              config_all;

    logic [NUM_OUTPUTS-1:0][DATA_WIDTH-1:0]             data_o;

    logic [INST_WIDTH-1:0]                          inst_i;
    logic [ID-1:0]                                  id_i;
    logic                                           valid_i;
    logic                                           w_switch_i;
    logic                                           r_switch_i;
    logic                                           start;

    logic [INST_WIDTH-1:0]                          inst_tmp;
    logic [ID-1:0]                                  id_tmp;
    logic                                           valid_tmp;
    logic                                           w_switch_tmp;
    logic                                           r_switch_tmp;
    logic                                           start_tmp;

    logic [INST_WIDTH-1:0]                          inst_o;
    logic [ID-1:0]                                  id_o;
    logic                                           valid_o;
    logic                                           w_switch_o;
    logic                                           r_switch_o;
    logic                                           start_o;

    //////////////////////////////////////
    ///////  Signals for next PE  ////////
    //////////////////////////////////////

    assign id_o         = id_i - 1'b1;
    assign inst_o       = inst_i;
    assign valid_o      = valid_i;
    assign w_switch_o   = w_switch_i;
    assign r_switch_o   = r_switch_i;
    assign start_o      = start;

    assign {inst_i,id_i,valid_i, w_switch_i, r_switch_i, start} = pe_config_in;

    always_ff @(posedge clk or negedge rst_n) begin
        if(!rst_n) begin
            pe_config_out <= '0;
        end else begin
            pe_config_out <= {inst_o,id_o,valid_o, w_switch_o, r_switch_o, start_o};
        end
    end

    assign data_o_1 = data_o[0];
    assign data_o_2 = data_o[1];
    assign data_o_3 = data_o[2];
    assign data_o_4 = data_o[3];

    //////////////////////////////////////
    //////// Module instantiation ////////
    //////////////////////////////////////

    pc #(
        .INST_WORD          (   INST_WORD        )
    ) pc_inst (
        .clk                (   clk              ),
        .rst_n              (   rst_n            ),
        .start              (   start            ),
        .addr_r             (   addr_r           ),
        .cen_r              (   cen_r            ),
        .gwen_r             (   gwen_r           )
    );

    imem #(
        .INST_WIDTH         (   INST_WIDTH       ),
        .INST_WORD          (   INST_WORD        )
    ) imem_inst (
        .clk                (   clk              ),
        .rst_n              (   rst_n            ),
        .valid_i            (   valid_i          ),
        .id_i               (   id_i             ),
        .w_switch_i         (   w_switch_i       ),
        .r_switch_i         (   r_switch_i       ),
        .addr_r             (   addr_r           ),
        .cen_r              (   cen_r            ),
        .gwen_r             (   gwen_r           ),
        .data_i             (   inst_i           ),
        .data_o             (   imem_data_o      )
    );

    config_gen #(
        .INST_WIDTH         (   INST_WIDTH       ),
        .NUM_INPUTS         (   NUM_INPUTS       ),
        .NUM_OUTPUTS        (   NUM_OUTPUTS      ),
        .NUM_OUTPUTS_CB1    (   NUM_OUTPUTS_CB1  ),
        .NUM_INPUTS_CB1     (   NUM_INPUTS_CB1   ),
        .NUM_INPUTS_CB2     (   NUM_INPUTS_CB2   ),
        .NUM_OUTPUTS_CB2    (   NUM_OUTPUTS_CB2  )
    ) config_gen_inst (
        .clk                (   clk              ),
        .rst_n              (   rst_n            ),
        .inst               (   imem_data_o      ),
        .config_all         (   config_all       ),
        .config_cb1_i       (   config_cb1_i     ),
        .config_cb2_i       (   config_cb2_i     ),
        .cb1_en             (   cb1_en           ),
        .cb2_en             (   cb2_en           )
    );

    FPU_config #(
        .DATA_WIDTH         (   DATA_WIDTH       ),
        .INST_WIDTH         (   INST_WIDTH       ),
        .NUM_INPUTS         (   NUM_INPUTS       ),
        .NUM_OUTPUTS        (   NUM_OUTPUTS      ),
        .NUM_OUTPUTS_CB1    (   NUM_OUTPUTS_CB1  ),
        .NUM_INPUTS_CB1     (   NUM_INPUTS_CB1   ),
        .NUM_INPUTS_CB2     (   NUM_INPUTS_CB2   ),
        .NUM_OUTPUTS_CB2    (   NUM_OUTPUTS_CB2  )
    ) fpu_config_inst (
        .clk                (   clk              ),
        .rst_n              (   rst_n            ),
        .cb1_en             (   cb1_en           ),
        .cb2_en             (   cb2_en           ),
        .data_i             (   {data_i_1,data_i_2,data_i_3,data_i_4}           ),
        .config_cb1_i       (   config_cb1_i     ),
        .config_all         (   config_all       ),
        .config_cb2_i       (   config_cb2_i     ),
        .data_o             (   data_o           ),
        .data_bypass_i      (   data_bypass_i    ),
        .data_bypass_o      (   data_bypass_o    )
    );


endmodule