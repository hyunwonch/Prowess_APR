module FUs #(
    parameter DATA_WIDTH = 16,  // Assuming DATA_WIDTH for individual complex numbers or components.
    parameter CONFIG_ALL = 64,  // Total configuration width
    localparam FIFO_DEPTH = 16,
    localparam CONFIG_CMAC=16,
    localparam CONFIG_LOGI=9,
    localparam CONFIG_CORDIC=8,
    localparam CONFIG_DMEM=31
) (
    input  logic clk,
    input  logic rst_n,
    input  logic [15:0][DATA_WIDTH*2 - 1:0] data_i ,  // 16 inputs total
    input  logic [CONFIG_ALL-1:0]           config_all,
    output logic [9:0][DATA_WIDTH*2 - 1:0]  data_o   // 10 outputs total
);


    // Outputs from FU modules
    logic [1:0][DATA_WIDTH*2 - 1:0] cmac_out_mul;
    logic [1:0][DATA_WIDTH*2 - 1:0] cmac_out_add;

    logic [1:0][DATA_WIDTH*2 - 1:0] dmem_out;
    logic [DATA_WIDTH*2 - 1:0] logical_out;
    logic [DATA_WIDTH*2 - 1:0] cordic_out;
    logic [1:0][DATA_WIDTH*2 - 1:0] fifo_outputs;


    logic [CONFIG_CMAC-1:0]                              config_cmac_i;
    logic [CONFIG_CORDIC-1:0]                            config_cordic_i;
    logic [CONFIG_LOGI-1:0]                              config_logical_i;
    logic [CONFIG_DMEM-1:0]                              config_dmem_i;


    assign {config_cmac_i, config_cordic_i, config_logical_i, config_dmem_i} = config_all;


    // Unpack config_i signal into individual control signals
    logic [1:0] mac;
    logic [1:0][4:0] shift ;
    logic [1:0] rd_en;
    logic [1:0] wr_en;

    // Assuming config_i is packed as follows:
    always_comb begin
        {mac, shift[1], shift[0], rd_en, wr_en} = config_cmac_i[15:0];
    end


    logic [1:0] cen, gwen;
    logic [1:0][8:0] addr_r ;
    logic [1:0][8:0] addr_w ;

    always_comb begin
        {gwen, addr_r[1], addr_r[0], addr_w[1], addr_w[0]} = config_dmem_i[28:0];
        cen = config_dmem_i[28:25];
    end

    localparam SHIFT = 5;
    localparam LOGICAL_MODE = 4;

    logic [LOGICAL_MODE-1:0]  mode_logical;
    logic [SHIFT-1:0]         shift_logical;

    always_comb begin
        {mode_logical, shift_logical} = config_logical_i[8:0];
    end


    logic                       start_cordic;
    logic  [2:0]                mode_cordic;
    logic  [3:0]                shift_cordic;

    always_comb begin
        {start_cordic, mode_cordic, shift_cordic} = config_cordic_i[7:0];
    end

    // Instantiate two CMAC modules
    genvar i;
    generate
        for (i = 0; i < 2; i = i + 1) begin : cmac_gen
            cmac_fp #(.DATA_WIDTH(DATA_WIDTH)) cmac_unit(
                .clk(clk),
                .rst_n(rst_n),
                .mac(mac[i]),
                .shift(shift[i]),
                .opa(data_i[4*i]),
                .opb(data_i[4*i + 1]),
                .opc(data_i[4*i + 2]),
                .opd(data_i[4*i + 3]),
                .out_mul(cmac_out_mul[i]),
                .out_add(cmac_out_add[i])
            );
        end
    endgenerate

    generate
        for (i = 0; i < 2; i = i + 1) begin : dmem_gen
            dmem    dmem_unit(
                .clk(clk),
                .rst_n(rst_n),
                .cen(cen[i]),
                .gwen(gwen[i]),
                .addr_r(addr_r[i]),
                .addr_w(addr_w[i]),
                .data_i(data_i[8+i]),
                .data_o(dmem_out[i])
            );
        end
    endgenerate

    logical     logical_unit(
                .opa(data_i[10]),
                .opb(data_i[11]),
                .mode(mode_logical),
                .shift(shift_logical),
                .result(logical_out)
    );

    // cordic      cordic_unit(
    //             .clk(clk),
    //             .rst_n(rst_n),
    //             .start(start_cordic),
    //             .mode(mode_cordic),
    //             .shift(shift_cordic),
    //             .opa(data_i[12]),
    //             .opb(data_i[13]),
    //             .data_o(cordic_out)
    // );


    // Instantiate two FIFO modules
    generate
    for (i = 0; i < 2; i = i + 1) begin : fifo_gen
        fifo #(.DATA_WIDTH(DATA_WIDTH*2), .DEPTH(FIFO_DEPTH)) fifo_unit(
            .clk(clk),
            .rst_n(rst_n),
            .rd_en(rd_en[i]),
            .wr_en(wr_en[i]),
            .data_in(data_i[12 + i]),  // Last two inputs for FIFOs
            .data_out(fifo_outputs[i])
        );
    end
    endgenerate


    // Assign FUs outputs
    assign data_o[0] = cmac_out_mul[0];
    assign data_o[1] = cmac_out_add[0];
    assign data_o[2] = cmac_out_mul[1];
    assign data_o[3] = cmac_out_add[1];
    assign data_o[4] = dmem_out[0];
    assign data_o[5] = dmem_out[1];
    assign data_o[6] = logical_out[1];
    assign data_o[7] = fifo_outputs[0];
    assign data_o[8] = fifo_outputs[1];


endmodule