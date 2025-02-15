module PE_array_Prowess_5X4 #(
    parameter DATA_WIDTH = 32,
    parameter CONF       = 64+2+4
)(
    input [CONF-1:0]                  pe_config_0,
    input [CONF-1:0]                  pe_config_1,
    input [CONF-1:0]                  pe_config_2,
    input [CONF-1:0]                  pe_config_3,
    input SW_CONFIG                   sw_config_0,
    input SW_CONFIG                   sw_config_1,
    input SW_CONFIG                   sw_config_2,
    input SW_CONFIG                   sw_config_3,
    input SW_CONFIG                   sw_config_4,
    input [DATA_WIDTH-1:0]            port_left_0_in,
    input [DATA_WIDTH-1:0]            port_left_1_in,
    input [DATA_WIDTH-1:0]            port_left_2_in,
    input [DATA_WIDTH-1:0]            port_left_3_in,
    input [DATA_WIDTH-1:0]            port_left_4_in,
    input [DATA_WIDTH-1:0]            port_left_5_in,
    input [DATA_WIDTH-1:0]            port_right_0_in,
    input [DATA_WIDTH-1:0]            port_right_1_in,
    input [DATA_WIDTH-1:0]            port_right_2_in,
    input [DATA_WIDTH-1:0]            port_right_3_in,
    input [DATA_WIDTH-1:0]            port_right_4_in,
    input [DATA_WIDTH-1:0]            port_right_5_in,
    output logic [DATA_WIDTH-1:0]     port_left_0_out,
    output logic [DATA_WIDTH-1:0]     port_left_1_out,
    output logic [DATA_WIDTH-1:0]     port_left_2_out,
    output logic [DATA_WIDTH-1:0]     port_left_3_out,
    output logic [DATA_WIDTH-1:0]     port_left_4_out,
    output logic [DATA_WIDTH-1:0]     port_left_5_out,
    output logic [DATA_WIDTH-1:0]     port_right_0_out,
    output logic [DATA_WIDTH-1:0]     port_right_1_out,
    output logic [DATA_WIDTH-1:0]     port_right_2_out,
    output logic [DATA_WIDTH-1:0]     port_right_3_out,
    output logic [DATA_WIDTH-1:0]     port_right_4_out,
    output logic [DATA_WIDTH-1:0]     port_right_5_out,
    input                             clk,
    input                             rst_n
);

    // PE Port
    // 1 row, 1 column
    logic [DATA_WIDTH-1:0] port0_in_0_0,  port1_in_0_0,  port2_in_0_0,  port3_in_0_0;
    logic [DATA_WIDTH-1:0] port0_out_0_0, port1_out_0_0, port2_out_0_0, port3_out_0_0;

    // 1 row, 2 column
    logic [DATA_WIDTH-1:0] port0_in_0_1,  port1_in_0_1,  port2_in_0_1,  port3_in_0_1;
    logic [DATA_WIDTH-1:0] port0_out_0_1, port1_out_0_1, port2_out_0_1, port3_out_0_1;

    // 1 row, 3 column
    logic [DATA_WIDTH-1:0] port0_in_0_2,  port1_in_0_2,  port2_in_0_2,  port3_in_0_2;
    logic [DATA_WIDTH-1:0] port0_out_0_2, port1_out_0_2, port2_out_0_2, port3_out_0_2;

    // 1 row, 4 column
    logic [DATA_WIDTH-1:0] port0_in_0_3,  port1_in_0_3,  port2_in_0_3,  port3_in_0_3;
    logic [DATA_WIDTH-1:0] port0_out_0_3, port1_out_0_3, port2_out_0_3, port3_out_0_3;

    // 2 row, 1 column
    logic [DATA_WIDTH-1:0] port0_in_1_0,  port1_in_1_0,  port2_in_1_0,  port3_in_1_0;
    logic [DATA_WIDTH-1:0] port0_out_1_0, port1_out_1_0, port2_out_1_0, port3_out_1_0;

    // 2 row, 2 column
    logic [DATA_WIDTH-1:0] port0_in_1_1,  port1_in_1_1,  port2_in_1_1,  port3_in_1_1;
    logic [DATA_WIDTH-1:0] port0_out_1_1, port1_out_1_1, port2_out_1_1, port3_out_1_1;

    // 2 row, 3 column
    logic [DATA_WIDTH-1:0] port0_in_1_2,  port1_in_1_2,  port2_in_1_2,  port3_in_1_2;
    logic [DATA_WIDTH-1:0] port0_out_1_2, port1_out_1_2, port2_out_1_2, port3_out_1_2;

    // 2 row, 4 column
    logic [DATA_WIDTH-1:0] port0_in_1_3,  port1_in_1_3,  port2_in_1_3,  port3_in_1_3;
    logic [DATA_WIDTH-1:0] port0_out_1_3, port1_out_1_3, port2_out_1_3, port3_out_1_3;

    // 3 row, 1 column
    logic [DATA_WIDTH-1:0] port0_in_2_0,  port1_in_2_0,  port2_in_2_0,  port3_in_2_0;
    logic [DATA_WIDTH-1:0] port0_out_2_0, port1_out_2_0, port2_out_2_0, port3_out_2_0;

    // 3 row, 2 column
    logic [DATA_WIDTH-1:0] port0_in_2_1,  port1_in_2_1,  port2_in_2_1,  port3_in_2_1;
    logic [DATA_WIDTH-1:0] port0_out_2_1, port1_out_2_1, port2_out_2_1, port3_out_2_1;

    // 3 row, 3 column
    logic [DATA_WIDTH-1:0] port0_in_2_2,  port1_in_2_2,  port2_in_2_2,  port3_in_2_2;
    logic [DATA_WIDTH-1:0] port0_out_2_2, port1_out_2_2, port2_out_2_2, port3_out_2_2;

    // 3 row, 4 column
    logic [DATA_WIDTH-1:0] port0_in_2_3,  port1_in_2_3,  port2_in_2_3,  port3_in_2_3;
    logic [DATA_WIDTH-1:0] port0_out_2_3, port1_out_2_3, port2_out_2_3, port3_out_2_3;

    // 4 row, 1 column
    logic [DATA_WIDTH-1:0] port0_in_3_0,  port1_in_3_0,  port2_in_3_0,  port3_in_3_0;
    logic [DATA_WIDTH-1:0] port0_out_3_0, port1_out_3_0, port2_out_3_0, port3_out_3_0;

    // 4 row, 2 column
    logic [DATA_WIDTH-1:0] port0_in_3_1,  port1_in_3_1,  port2_in_3_1,  port3_in_3_1;
    logic [DATA_WIDTH-1:0] port0_out_3_1, port1_out_3_1, port2_out_3_1, port3_out_3_1;

    // 4 row, 3 column
    logic [DATA_WIDTH-1:0] port0_in_3_2,  port1_in_3_2,  port2_in_3_2,  port3_in_3_2;
    logic [DATA_WIDTH-1:0] port0_out_3_2, port1_out_3_2, port2_out_3_2, port3_out_3_2;

    // 4 row, 4 column
    logic [DATA_WIDTH-1:0] port0_in_3_3,  port1_in_3_3,  port2_in_3_3,  port3_in_3_3;
    logic [DATA_WIDTH-1:0] port0_out_3_3, port1_out_3_3, port2_out_3_3, port3_out_3_3;

    // 5 row, 1 column
    logic [DATA_WIDTH-1:0] port0_in_4_0,  port1_in_4_0,  port2_in_4_0,  port3_in_4_0;
    logic [DATA_WIDTH-1:0] port0_out_4_0, port1_out_4_0, port2_out_4_0, port3_out_4_0;

    // 5 row, 2 column
    logic [DATA_WIDTH-1:0] port0_in_4_1,  port1_in_4_1,  port2_in_4_1,  port3_in_4_1;
    logic [DATA_WIDTH-1:0] port0_out_4_1, port1_out_4_1, port2_out_4_1, port3_out_4_1;

    // 5 row, 3 column
    logic [DATA_WIDTH-1:0] port0_in_4_2,  port1_in_4_2,  port2_in_4_2,  port3_in_4_2;
    logic [DATA_WIDTH-1:0] port0_out_4_2, port1_out_4_2, port2_out_4_2, port3_out_4_2;

    // 5 row, 4 column
    logic [DATA_WIDTH-1:0] port0_in_4_3,  port1_in_4_3,  port2_in_4_3,  port3_in_4_3;
    logic [DATA_WIDTH-1:0] port0_out_4_3, port1_out_4_3, port2_out_4_3, port3_out_4_3;

    // Bypass
    // 1 row, 1 column
    logic [DATA_WIDTH-1:0] data_bypass_in_0_0;
    logic [DATA_WIDTH-1:0] data_bypass_out_0_0;

    // 1 row, 2 column
    logic [DATA_WIDTH-1:0] data_bypass_in_0_1;
    logic [DATA_WIDTH-1:0] data_bypass_out_0_1;

    // 1 row, 3 column
    logic [DATA_WIDTH-1:0] data_bypass_in_0_2;
    logic [DATA_WIDTH-1:0] data_bypass_out_0_2;

    // 1 row, 4 column
    logic [DATA_WIDTH-1:0] data_bypass_in_0_3;
    logic [DATA_WIDTH-1:0] data_bypass_out_0_3;

    // 2 row, 1 column
    logic [DATA_WIDTH-1:0] data_bypass_in_1_0;
    logic [DATA_WIDTH-1:0] data_bypass_out_1_0;

    // 2 row, 2 column
    logic [DATA_WIDTH-1:0] data_bypass_in_1_1;
    logic [DATA_WIDTH-1:0] data_bypass_out_1_1;

    // 2 row, 3 column
    logic [DATA_WIDTH-1:0] data_bypass_in_1_2;
    logic [DATA_WIDTH-1:0] data_bypass_out_1_2;

    // 2 row, 4 column
    logic [DATA_WIDTH-1:0] data_bypass_in_1_3;
    logic [DATA_WIDTH-1:0] data_bypass_out_1_3;

    // 3 row, 1 column
    logic [DATA_WIDTH-1:0] data_bypass_in_2_0;
    logic [DATA_WIDTH-1:0] data_bypass_out_2_0;

    // 3 row, 2 column
    logic [DATA_WIDTH-1:0] data_bypass_in_2_1;
    logic [DATA_WIDTH-1:0] data_bypass_out_2_1;

    // 3 row, 3 column
    logic [DATA_WIDTH-1:0] data_bypass_in_2_2;
    logic [DATA_WIDTH-1:0] data_bypass_out_2_2;

    // 3 row, 4 column
    logic [DATA_WIDTH-1:0] data_bypass_in_2_3;
    logic [DATA_WIDTH-1:0] data_bypass_out_2_3;

    // 4 row, 1 column
    logic [DATA_WIDTH-1:0] data_bypass_in_3_0;
    logic [DATA_WIDTH-1:0] data_bypass_out_3_0;

    // 4 row, 2 column
    logic [DATA_WIDTH-1:0] data_bypass_in_3_1;
    logic [DATA_WIDTH-1:0] data_bypass_out_3_1;

    // 4 row, 3 column
    logic [DATA_WIDTH-1:0] data_bypass_in_3_2;
    logic [DATA_WIDTH-1:0] data_bypass_out_3_2;

    // 4 row, 4 column
    logic [DATA_WIDTH-1:0] data_bypass_in_3_3;
    logic [DATA_WIDTH-1:0] data_bypass_out_3_3;

    // 5 row, 1 column
    logic [DATA_WIDTH-1:0] data_bypass_in_4_0;
    logic [DATA_WIDTH-1:0] data_bypass_out_4_0;

    // 5 row, 2 column
    logic [DATA_WIDTH-1:0] data_bypass_in_4_1;
    logic [DATA_WIDTH-1:0] data_bypass_out_4_1;

    // 5 row, 3 column
    logic [DATA_WIDTH-1:0] data_bypass_in_4_2;
    logic [DATA_WIDTH-1:0] data_bypass_out_4_2;

    // 5 row, 4 column
    logic [DATA_WIDTH-1:0] data_bypass_in_4_3;
    logic [DATA_WIDTH-1:0] data_bypass_out_4_3;

    // Switch Port
    // 1 row, 1 column
    logic [DATA_WIDTH-1:0] switch0_in_0_0, switch1_in_0_0, switch2_in_0_0, switch3_in_0_0;
    logic [DATA_WIDTH-1:0] switch0_out_0_0, switch1_out_0_0, switch2_out_0_0, switch3_out_0_0;

    // 1 row, 2 column
    logic [DATA_WIDTH-1:0] switch0_in_0_1, switch1_in_0_1, switch2_in_0_1, switch3_in_0_1;
    logic [DATA_WIDTH-1:0] switch0_out_0_1, switch1_out_0_1, switch2_out_0_1, switch3_out_0_1;

    // 1 row, 3 column
    logic [DATA_WIDTH-1:0] switch0_in_0_2, switch1_in_0_2, switch2_in_0_2, switch3_in_0_2;
    logic [DATA_WIDTH-1:0] switch0_out_0_2, switch1_out_0_2, switch2_out_0_2, switch3_out_0_2;

    // 1 row, 4 column
    logic [DATA_WIDTH-1:0] switch0_in_0_3, switch1_in_0_3, switch2_in_0_3, switch3_in_0_3;
    logic [DATA_WIDTH-1:0] switch0_out_0_3, switch1_out_0_3, switch2_out_0_3, switch3_out_0_3;

    // 1 row, 5 column
    logic [DATA_WIDTH-1:0] switch0_in_0_4, switch1_in_0_4, switch2_in_0_4, switch3_in_0_4;
    logic [DATA_WIDTH-1:0] switch0_out_0_4, switch1_out_0_4, switch2_out_0_4, switch3_out_0_4;

    // 2 row, 1 column
    logic [DATA_WIDTH-1:0] switch0_in_1_0, switch1_in_1_0, switch2_in_1_0, switch3_in_1_0;
    logic [DATA_WIDTH-1:0] switch0_out_1_0, switch1_out_1_0, switch2_out_1_0, switch3_out_1_0;

    // 2 row, 2 column
    logic [DATA_WIDTH-1:0] switch0_in_1_1, switch1_in_1_1, switch2_in_1_1, switch3_in_1_1;
    logic [DATA_WIDTH-1:0] switch0_out_1_1, switch1_out_1_1, switch2_out_1_1, switch3_out_1_1;

    // 2 row, 3 column
    logic [DATA_WIDTH-1:0] switch0_in_1_2, switch1_in_1_2, switch2_in_1_2, switch3_in_1_2;
    logic [DATA_WIDTH-1:0] switch0_out_1_2, switch1_out_1_2, switch2_out_1_2, switch3_out_1_2;

    // 2 row, 4 column
    logic [DATA_WIDTH-1:0] switch0_in_1_3, switch1_in_1_3, switch2_in_1_3, switch3_in_1_3;
    logic [DATA_WIDTH-1:0] switch0_out_1_3, switch1_out_1_3, switch2_out_1_3, switch3_out_1_3;

    // 2 row, 5 column
    logic [DATA_WIDTH-1:0] switch0_in_1_4, switch1_in_1_4, switch2_in_1_4, switch3_in_1_4;
    logic [DATA_WIDTH-1:0] switch0_out_1_4, switch1_out_1_4, switch2_out_1_4, switch3_out_1_4;

    // 3 row, 1 column
    logic [DATA_WIDTH-1:0] switch0_in_2_0, switch1_in_2_0, switch2_in_2_0, switch3_in_2_0;
    logic [DATA_WIDTH-1:0] switch0_out_2_0, switch1_out_2_0, switch2_out_2_0, switch3_out_2_0;

    // 3 row, 2 column
    logic [DATA_WIDTH-1:0] switch0_in_2_1, switch1_in_2_1, switch2_in_2_1, switch3_in_2_1;
    logic [DATA_WIDTH-1:0] switch0_out_2_1, switch1_out_2_1, switch2_out_2_1, switch3_out_2_1;

    // 3 row, 3 column
    logic [DATA_WIDTH-1:0] switch0_in_2_2, switch1_in_2_2, switch2_in_2_2, switch3_in_2_2;
    logic [DATA_WIDTH-1:0] switch0_out_2_2, switch1_out_2_2, switch2_out_2_2, switch3_out_2_2;

    // 3 row, 4 column
    logic [DATA_WIDTH-1:0] switch0_in_2_3, switch1_in_2_3, switch2_in_2_3, switch3_in_2_3;
    logic [DATA_WIDTH-1:0] switch0_out_2_3, switch1_out_2_3, switch2_out_2_3, switch3_out_2_3;

    // 3 row, 5 column
    logic [DATA_WIDTH-1:0] switch0_in_2_4, switch1_in_2_4, switch2_in_2_4, switch3_in_2_4;
    logic [DATA_WIDTH-1:0] switch0_out_2_4, switch1_out_2_4, switch2_out_2_4, switch3_out_2_4;

    // 4 row, 1 column
    logic [DATA_WIDTH-1:0] switch0_in_3_0, switch1_in_3_0, switch2_in_3_0, switch3_in_3_0;
    logic [DATA_WIDTH-1:0] switch0_out_3_0, switch1_out_3_0, switch2_out_3_0, switch3_out_3_0;

    // 4 row, 2 column
    logic [DATA_WIDTH-1:0] switch0_in_3_1, switch1_in_3_1, switch2_in_3_1, switch3_in_3_1;
    logic [DATA_WIDTH-1:0] switch0_out_3_1, switch1_out_3_1, switch2_out_3_1, switch3_out_3_1;

    // 4 row, 3 column
    logic [DATA_WIDTH-1:0] switch0_in_3_2, switch1_in_3_2, switch2_in_3_2, switch3_in_3_2;
    logic [DATA_WIDTH-1:0] switch0_out_3_2, switch1_out_3_2, switch2_out_3_2, switch3_out_3_2;

    // 4 row, 4 column
    logic [DATA_WIDTH-1:0] switch0_in_3_3, switch1_in_3_3, switch2_in_3_3, switch3_in_3_3;
    logic [DATA_WIDTH-1:0] switch0_out_3_3, switch1_out_3_3, switch2_out_3_3, switch3_out_3_3;

    // 4 row, 5 column
    logic [DATA_WIDTH-1:0] switch0_in_3_4, switch1_in_3_4, switch2_in_3_4, switch3_in_3_4;
    logic [DATA_WIDTH-1:0] switch0_out_3_4, switch1_out_3_4, switch2_out_3_4, switch3_out_3_4;

    // 5 row, 1 column
    logic [DATA_WIDTH-1:0] switch0_in_4_0, switch1_in_4_0, switch2_in_4_0, switch3_in_4_0;
    logic [DATA_WIDTH-1:0] switch0_out_4_0, switch1_out_4_0, switch2_out_4_0, switch3_out_4_0;

    // 5 row, 2 column
    logic [DATA_WIDTH-1:0] switch0_in_4_1, switch1_in_4_1, switch2_in_4_1, switch3_in_4_1;
    logic [DATA_WIDTH-1:0] switch0_out_4_1, switch1_out_4_1, switch2_out_4_1, switch3_out_4_1;

    // 5 row, 3 column
    logic [DATA_WIDTH-1:0] switch0_in_4_2, switch1_in_4_2, switch2_in_4_2, switch3_in_4_2;
    logic [DATA_WIDTH-1:0] switch0_out_4_2, switch1_out_4_2, switch2_out_4_2, switch3_out_4_2;

    // 5 row, 4 column
    logic [DATA_WIDTH-1:0] switch0_in_4_3, switch1_in_4_3, switch2_in_4_3, switch3_in_4_3;
    logic [DATA_WIDTH-1:0] switch0_out_4_3, switch1_out_4_3, switch2_out_4_3, switch3_out_4_3;

    // 5 row, 5 column
    logic [DATA_WIDTH-1:0] switch0_in_4_4, switch1_in_4_4, switch2_in_4_4, switch3_in_4_4;
    logic [DATA_WIDTH-1:0] switch0_out_4_4, switch1_out_4_4, switch2_out_4_4, switch3_out_4_4;

    // 6 row, 1 column
    logic [DATA_WIDTH-1:0] switch0_in_5_0, switch1_in_5_0, switch2_in_5_0, switch3_in_5_0;
    logic [DATA_WIDTH-1:0] switch0_out_5_0, switch1_out_5_0, switch2_out_5_0, switch3_out_5_0;

    // 6 row, 2 column
    logic [DATA_WIDTH-1:0] switch0_in_5_1, switch1_in_5_1, switch2_in_5_1, switch3_in_5_1;
    logic [DATA_WIDTH-1:0] switch0_out_5_1, switch1_out_5_1, switch2_out_5_1, switch3_out_5_1;

    // 6 row, 3 column
    logic [DATA_WIDTH-1:0] switch0_in_5_2, switch1_in_5_2, switch2_in_5_2, switch3_in_5_2;
    logic [DATA_WIDTH-1:0] switch0_out_5_2, switch1_out_5_2, switch2_out_5_2, switch3_out_5_2;

    // 6 row, 4 column
    logic [DATA_WIDTH-1:0] switch0_in_5_3, switch1_in_5_3, switch2_in_5_3, switch3_in_5_3;
    logic [DATA_WIDTH-1:0] switch0_out_5_3, switch1_out_5_3, switch2_out_5_3, switch3_out_5_3;

    // 6 row, 5 column
    logic [DATA_WIDTH-1:0] switch0_in_5_4, switch1_in_5_4, switch2_in_5_4, switch3_in_5_4;
    logic [DATA_WIDTH-1:0] switch0_out_5_4, switch1_out_5_4, switch2_out_5_4, switch3_out_5_4;


    // PE Configuration
    logic [CONF-1:0] pe_config_in_0_0, pe_config_out_0_0;
    logic [CONF-1:0] pe_config_in_0_1, pe_config_out_0_1;
    logic [CONF-1:0] pe_config_in_0_2, pe_config_out_0_2;
    logic [CONF-1:0] pe_config_in_0_3, pe_config_out_0_3;
    logic [CONF-1:0] pe_config_in_1_0, pe_config_out_1_0;
    logic [CONF-1:0] pe_config_in_1_1, pe_config_out_1_1;
    logic [CONF-1:0] pe_config_in_1_2, pe_config_out_1_2;
    logic [CONF-1:0] pe_config_in_1_3, pe_config_out_1_3;
    logic [CONF-1:0] pe_config_in_2_0, pe_config_out_2_0;
    logic [CONF-1:0] pe_config_in_2_1, pe_config_out_2_1;
    logic [CONF-1:0] pe_config_in_2_2, pe_config_out_2_2;
    logic [CONF-1:0] pe_config_in_2_3, pe_config_out_2_3;
    logic [CONF-1:0] pe_config_in_3_0, pe_config_out_3_0;
    logic [CONF-1:0] pe_config_in_3_1, pe_config_out_3_1;
    logic [CONF-1:0] pe_config_in_3_2, pe_config_out_3_2;
    logic [CONF-1:0] pe_config_in_3_3, pe_config_out_3_3;
    logic [CONF-1:0] pe_config_in_4_0, pe_config_out_4_0;
    logic [CONF-1:0] pe_config_in_4_1, pe_config_out_4_1;
    logic [CONF-1:0] pe_config_in_4_2, pe_config_out_4_2;
    logic [CONF-1:0] pe_config_in_4_3, pe_config_out_4_3;

    // Switch Configuration
    SW_CONFIG sw_config_in_0_0, sw_config_out_0_0;
    SW_CONFIG sw_config_in_0_1, sw_config_out_0_1;
    SW_CONFIG sw_config_in_0_2, sw_config_out_0_2;
    SW_CONFIG sw_config_in_0_3, sw_config_out_0_3;
    SW_CONFIG sw_config_in_0_4, sw_config_out_0_4;
    SW_CONFIG sw_config_in_1_0, sw_config_out_1_0;
    SW_CONFIG sw_config_in_1_1, sw_config_out_1_1;
    SW_CONFIG sw_config_in_1_2, sw_config_out_1_2;
    SW_CONFIG sw_config_in_1_3, sw_config_out_1_3;
    SW_CONFIG sw_config_in_1_4, sw_config_out_1_4;
    SW_CONFIG sw_config_in_2_0, sw_config_out_2_0;
    SW_CONFIG sw_config_in_2_1, sw_config_out_2_1;
    SW_CONFIG sw_config_in_2_2, sw_config_out_2_2;
    SW_CONFIG sw_config_in_2_3, sw_config_out_2_3;
    SW_CONFIG sw_config_in_2_4, sw_config_out_2_4;
    SW_CONFIG sw_config_in_3_0, sw_config_out_3_0;
    SW_CONFIG sw_config_in_3_1, sw_config_out_3_1;
    SW_CONFIG sw_config_in_3_2, sw_config_out_3_2;
    SW_CONFIG sw_config_in_3_3, sw_config_out_3_3;
    SW_CONFIG sw_config_in_3_4, sw_config_out_3_4;
    SW_CONFIG sw_config_in_4_0, sw_config_out_4_0;
    SW_CONFIG sw_config_in_4_1, sw_config_out_4_1;
    SW_CONFIG sw_config_in_4_2, sw_config_out_4_2;
    SW_CONFIG sw_config_in_4_3, sw_config_out_4_3;
    SW_CONFIG sw_config_in_4_4, sw_config_out_4_4;
    SW_CONFIG sw_config_in_5_0, sw_config_out_5_0;
    SW_CONFIG sw_config_in_5_1, sw_config_out_5_1;
    SW_CONFIG sw_config_in_5_2, sw_config_out_5_2;
    SW_CONFIG sw_config_in_5_3, sw_config_out_5_3;
    SW_CONFIG sw_config_in_5_4, sw_config_out_5_4;

    // PE bypass connection
    assign data_bypass_in_0_1     = data_bypass_out_0_0;
    assign data_bypass_in_0_2     = data_bypass_out_0_1;
    assign data_bypass_in_0_3     = data_bypass_out_0_2;
    assign data_bypass_in_1_1     = data_bypass_out_1_0;
    assign data_bypass_in_1_2     = data_bypass_out_1_1;
    assign data_bypass_in_1_3     = data_bypass_out_1_2;
    assign data_bypass_in_2_1     = data_bypass_out_2_0;
    assign data_bypass_in_2_2     = data_bypass_out_2_1;
    assign data_bypass_in_2_3     = data_bypass_out_2_2;
    assign data_bypass_in_3_1     = data_bypass_out_3_0;
    assign data_bypass_in_3_2     = data_bypass_out_3_1;
    assign data_bypass_in_3_3     = data_bypass_out_3_2;
    assign data_bypass_in_4_1     = data_bypass_out_4_0;
    assign data_bypass_in_4_2     = data_bypass_out_4_1;
    assign data_bypass_in_4_3     = data_bypass_out_4_2;

    // PE Configuration Connection
    assign pe_config_in_1_0     = pe_config_out_0_0;
    assign pe_config_in_1_1     = pe_config_out_0_1;
    assign pe_config_in_1_2     = pe_config_out_0_2;
    assign pe_config_in_1_3     = pe_config_out_0_3;
    assign pe_config_in_2_0     = pe_config_out_1_0;
    assign pe_config_in_2_1     = pe_config_out_1_1;
    assign pe_config_in_2_2     = pe_config_out_1_2;
    assign pe_config_in_2_3     = pe_config_out_1_3;
    assign pe_config_in_3_0     = pe_config_out_2_0;
    assign pe_config_in_3_1     = pe_config_out_2_1;
    assign pe_config_in_3_2     = pe_config_out_2_2;
    assign pe_config_in_3_3     = pe_config_out_2_3;
    assign pe_config_in_4_0     = pe_config_out_3_0;
    assign pe_config_in_4_1     = pe_config_out_3_1;
    assign pe_config_in_4_2     = pe_config_out_3_2;
    assign pe_config_in_4_3     = pe_config_out_3_3;

    // Switch Configuration Connection
    assign sw_config_in_1_0     = sw_config_out_0_0;
    assign sw_config_in_1_1     = sw_config_out_0_1;
    assign sw_config_in_1_2     = sw_config_out_0_2;
    assign sw_config_in_1_3     = sw_config_out_0_3;
    assign sw_config_in_1_4     = sw_config_out_0_4;
    assign sw_config_in_2_0     = sw_config_out_1_0;
    assign sw_config_in_2_1     = sw_config_out_1_1;
    assign sw_config_in_2_2     = sw_config_out_1_2;
    assign sw_config_in_2_3     = sw_config_out_1_3;
    assign sw_config_in_2_4     = sw_config_out_1_4;
    assign sw_config_in_3_0     = sw_config_out_2_0;
    assign sw_config_in_3_1     = sw_config_out_2_1;
    assign sw_config_in_3_2     = sw_config_out_2_2;
    assign sw_config_in_3_3     = sw_config_out_2_3;
    assign sw_config_in_3_4     = sw_config_out_2_4;
    assign sw_config_in_4_0     = sw_config_out_3_0;
    assign sw_config_in_4_1     = sw_config_out_3_1;
    assign sw_config_in_4_2     = sw_config_out_3_2;
    assign sw_config_in_4_3     = sw_config_out_3_3;
    assign sw_config_in_4_4     = sw_config_out_3_4;
    assign sw_config_in_5_0     = sw_config_out_4_0;
    assign sw_config_in_5_1     = sw_config_out_4_1;
    assign sw_config_in_5_2     = sw_config_out_4_2;
    assign sw_config_in_5_3     = sw_config_out_4_3;
    assign sw_config_in_5_4     = sw_config_out_4_4;

    // Port
    assign port0_in_0_0         = switch2_out_0_0;
    assign port1_in_0_0         = switch3_out_0_1;
    assign port2_in_0_0         = switch0_out_1_1;
    assign port3_in_0_0         = switch1_out_1_0;
    assign port0_in_0_1         = switch2_out_0_1;
    assign port1_in_0_1         = switch3_out_0_2;
    assign port2_in_0_1         = switch0_out_1_2;
    assign port3_in_0_1         = switch1_out_1_1;
    assign port0_in_0_2         = switch2_out_0_2;
    assign port1_in_0_2         = switch3_out_0_3;
    assign port2_in_0_2         = switch0_out_1_3;
    assign port3_in_0_2         = switch1_out_1_2;
    assign port0_in_0_3         = switch2_out_0_3;
    assign port1_in_0_3         = switch3_out_0_4;
    assign port2_in_0_3         = switch0_out_1_4;
    assign port3_in_0_3         = switch1_out_1_3;
    assign port0_in_1_0         = switch2_out_1_0;
    assign port1_in_1_0         = switch3_out_1_1;
    assign port2_in_1_0         = switch0_out_2_1;
    assign port3_in_1_0         = switch1_out_2_0;
    assign port0_in_1_1         = switch2_out_1_1;
    assign port1_in_1_1         = switch3_out_1_2;
    assign port2_in_1_1         = switch0_out_2_2;
    assign port3_in_1_1         = switch1_out_2_1;
    assign port0_in_1_2         = switch2_out_1_2;
    assign port1_in_1_2         = switch3_out_1_3;
    assign port2_in_1_2         = switch0_out_2_3;
    assign port3_in_1_2         = switch1_out_2_2;
    assign port0_in_1_3         = switch2_out_1_3;
    assign port1_in_1_3         = switch3_out_1_4;
    assign port2_in_1_3         = switch0_out_2_4;
    assign port3_in_1_3         = switch1_out_2_3;
    assign port0_in_2_0         = switch2_out_2_0;
    assign port1_in_2_0         = switch3_out_2_1;
    assign port2_in_2_0         = switch0_out_3_1;
    assign port3_in_2_0         = switch1_out_3_0;
    assign port0_in_2_1         = switch2_out_2_1;
    assign port1_in_2_1         = switch3_out_2_2;
    assign port2_in_2_1         = switch0_out_3_2;
    assign port3_in_2_1         = switch1_out_3_1;
    assign port0_in_2_2         = switch2_out_2_2;
    assign port1_in_2_2         = switch3_out_2_3;
    assign port2_in_2_2         = switch0_out_3_3;
    assign port3_in_2_2         = switch1_out_3_2;
    assign port0_in_2_3         = switch2_out_2_3;
    assign port1_in_2_3         = switch3_out_2_4;
    assign port2_in_2_3         = switch0_out_3_4;
    assign port3_in_2_3         = switch1_out_3_3;
    assign port0_in_3_0         = switch2_out_3_0;
    assign port1_in_3_0         = switch3_out_3_1;
    assign port2_in_3_0         = switch0_out_4_1;
    assign port3_in_3_0         = switch1_out_4_0;
    assign port0_in_3_1         = switch2_out_3_1;
    assign port1_in_3_1         = switch3_out_3_2;
    assign port2_in_3_1         = switch0_out_4_2;
    assign port3_in_3_1         = switch1_out_4_1;
    assign port0_in_3_2         = switch2_out_3_2;
    assign port1_in_3_2         = switch3_out_3_3;
    assign port2_in_3_2         = switch0_out_4_3;
    assign port3_in_3_2         = switch1_out_4_2;
    assign port0_in_3_3         = switch2_out_3_3;
    assign port1_in_3_3         = switch3_out_3_4;
    assign port2_in_3_3         = switch0_out_4_4;
    assign port3_in_3_3         = switch1_out_4_3;
    assign port0_in_4_0         = switch2_out_4_0;
    assign port1_in_4_0         = switch3_out_4_1;
    assign port2_in_4_0         = switch0_out_5_1;
    assign port3_in_4_0         = switch1_out_5_0;
    assign port0_in_4_1         = switch2_out_4_1;
    assign port1_in_4_1         = switch3_out_4_2;
    assign port2_in_4_1         = switch0_out_5_2;
    assign port3_in_4_1         = switch1_out_5_1;
    assign port0_in_4_2         = switch2_out_4_2;
    assign port1_in_4_2         = switch3_out_4_3;
    assign port2_in_4_2         = switch0_out_5_3;
    assign port3_in_4_2         = switch1_out_5_2;
    assign port0_in_4_3         = switch2_out_4_3;
    assign port1_in_4_3         = switch3_out_4_4;
    assign port2_in_4_3         = switch0_out_5_4;
    assign port3_in_4_3         = switch1_out_5_3;

    // Switch Connection
    assign switch0_in_0_0       = port_left_0_in;
    assign switch1_in_0_0       = '0;
    assign switch2_in_0_0       = port0_out_0_0;
    assign switch3_in_0_0       = port_left_0_in;
    assign switch0_in_0_1       = '0;
    assign switch1_in_0_1       = '0;
    assign switch2_in_0_1       = port0_out_0_1;
    assign switch3_in_0_1       = port1_out_0_0;
    assign switch0_in_0_2       = '0;
    assign switch1_in_0_2       = '0;
    assign switch2_in_0_2       = port0_out_0_2;
    assign switch3_in_0_2       = port1_out_0_1;
    assign switch0_in_0_3       = '0;
    assign switch1_in_0_3       = '0;
    assign switch2_in_0_3       = port0_out_0_3;
    assign switch3_in_0_3       = port1_out_0_2;
    assign switch0_in_0_4       = '0;
    assign switch1_in_0_4       = port_right_0_in;
    assign switch2_in_0_4       = port_right_0_in;
    assign switch3_in_0_4       = port1_out_0_3;
    assign switch0_in_1_0       = port_left_1_in;
    assign switch1_in_1_0       = port3_out_0_0;
    assign switch2_in_1_0       = port0_out_1_0;
    assign switch3_in_1_0       = port_left_1_in;
    assign switch0_in_1_1       = port2_out_0_0;
    assign switch1_in_1_1       = port3_out_0_1;
    assign switch2_in_1_1       = port0_out_1_1;
    assign switch3_in_1_1       = port1_out_1_0;
    assign switch0_in_1_2       = port2_out_0_1;
    assign switch1_in_1_2       = port3_out_0_2;
    assign switch2_in_1_2       = port0_out_1_2;
    assign switch3_in_1_2       = port1_out_1_1;
    assign switch0_in_1_3       = port2_out_0_2;
    assign switch1_in_1_3       = port3_out_0_3;
    assign switch2_in_1_3       = port0_out_1_3;
    assign switch3_in_1_3       = port1_out_1_2;
    assign switch0_in_1_4       = port2_out_0_3;
    assign switch1_in_1_4       = port_right_1_in;
    assign switch2_in_1_4       = port_right_1_in;
    assign switch3_in_1_4       = port1_out_1_3;
    assign switch0_in_2_0       = port_left_2_in;
    assign switch1_in_2_0       = port3_out_1_0;
    assign switch2_in_2_0       = port0_out_2_0;
    assign switch3_in_2_0       = port_left_2_in;
    assign switch0_in_2_1       = port2_out_1_0;
    assign switch1_in_2_1       = port3_out_1_1;
    assign switch2_in_2_1       = port0_out_2_1;
    assign switch3_in_2_1       = port1_out_2_0;
    assign switch0_in_2_2       = port2_out_1_1;
    assign switch1_in_2_2       = port3_out_1_2;
    assign switch2_in_2_2       = port0_out_2_2;
    assign switch3_in_2_2       = port1_out_2_1;
    assign switch0_in_2_3       = port2_out_1_2;
    assign switch1_in_2_3       = port3_out_1_3;
    assign switch2_in_2_3       = port0_out_2_3;
    assign switch3_in_2_3       = port1_out_2_2;
    assign switch0_in_2_4       = port2_out_1_3;
    assign switch1_in_2_4       = port_right_2_in;
    assign switch2_in_2_4       = port_right_2_in;
    assign switch3_in_2_4       = port1_out_2_3;
    assign switch0_in_3_0       = port_left_3_in;
    assign switch1_in_3_0       = port3_out_2_0;
    assign switch2_in_3_0       = port0_out_3_0;
    assign switch3_in_3_0       = port_left_3_in;
    assign switch0_in_3_1       = port2_out_2_0;
    assign switch1_in_3_1       = port3_out_2_1;
    assign switch2_in_3_1       = port0_out_3_1;
    assign switch3_in_3_1       = port1_out_3_0;
    assign switch0_in_3_2       = port2_out_2_1;
    assign switch1_in_3_2       = port3_out_2_2;
    assign switch2_in_3_2       = port0_out_3_2;
    assign switch3_in_3_2       = port1_out_3_1;
    assign switch0_in_3_3       = port2_out_2_2;
    assign switch1_in_3_3       = port3_out_2_3;
    assign switch2_in_3_3       = port0_out_3_3;
    assign switch3_in_3_3       = port1_out_3_2;
    assign switch0_in_3_4       = port2_out_2_3;
    assign switch1_in_3_4       = port_right_3_in;
    assign switch2_in_3_4       = port_right_3_in;
    assign switch3_in_3_4       = port1_out_3_3;
    assign switch0_in_4_0       = port_left_4_in;
    assign switch1_in_4_0       = port3_out_3_0;
    assign switch2_in_4_0       = port0_out_4_0;
    assign switch3_in_4_0       = port_left_4_in;
    assign switch0_in_4_1       = port2_out_3_0;
    assign switch1_in_4_1       = port3_out_3_1;
    assign switch2_in_4_1       = port0_out_4_1;
    assign switch3_in_4_1       = port1_out_4_0;
    assign switch0_in_4_2       = port2_out_3_1;
    assign switch1_in_4_2       = port3_out_3_2;
    assign switch2_in_4_2       = port0_out_4_2;
    assign switch3_in_4_2       = port1_out_4_1;
    assign switch0_in_4_3       = port2_out_3_2;
    assign switch1_in_4_3       = port3_out_3_3;
    assign switch2_in_4_3       = port0_out_4_3;
    assign switch3_in_4_3       = port1_out_4_2;
    assign switch0_in_4_4       = port2_out_3_3;
    assign switch1_in_4_4       = port_right_4_in;
    assign switch2_in_4_4       = port_right_4_in;
    assign switch3_in_4_4       = port1_out_4_3;
    assign switch0_in_5_0       = port_left_5_in;
    assign switch1_in_5_0       = port3_out_4_0;
    assign switch2_in_5_0       = '0;
    assign switch3_in_5_0       = port_left_5_in;
    assign switch0_in_5_1       = port2_out_4_0;
    assign switch1_in_5_1       = port3_out_4_1;
    assign switch2_in_5_1       = '0;
    assign switch3_in_5_1       = '0;
    assign switch0_in_5_2       = port2_out_4_1;
    assign switch1_in_5_2       = port3_out_4_2;
    assign switch2_in_5_2       = '0;
    assign switch3_in_5_2       = '0;
    assign switch0_in_5_3       = port2_out_4_2;
    assign switch1_in_5_3       = port3_out_4_3;
    assign switch2_in_5_3       = '0;
    assign switch3_in_5_3       = '0;
    assign switch0_in_5_4       = port2_out_4_3;
    assign switch1_in_5_4       = port_right_5_in;
    assign switch2_in_5_4       = port_right_5_in;
    assign switch3_in_5_4       = '0;

    // Boundary Configuration Connection
    assign data_bypass_in_0_0   = port_left_0_in;
    assign data_bypass_in_1_0   = port_left_1_in;
    assign data_bypass_in_2_0   = port_left_2_in;
    assign data_bypass_in_3_0   = port_left_3_in;
    assign data_bypass_in_4_0   = port_left_4_in;
    assign pe_config_in_0_0     = pe_config_0;
    assign pe_config_in_0_1     = pe_config_1;
    assign pe_config_in_0_2     = pe_config_2;
    assign pe_config_in_0_3     = pe_config_3;
    assign sw_config_in_0_0     = sw_config_0;
    assign sw_config_in_0_1     = sw_config_1;
    assign sw_config_in_0_2     = sw_config_2;
    assign sw_config_in_0_3     = sw_config_3;
    assign sw_config_in_0_4     = sw_config_4;

    // Boundary Port Connection
    assign port_left_0_out      = switch0_out_0_0;
    assign port_right_0_out     = switch1_out_0_4;
    assign port_left_1_out      = switch0_out_1_0;
    assign port_right_1_out     = switch1_out_1_4;
    assign port_left_2_out      = switch0_out_2_0;
    assign port_right_2_out     = switch1_out_2_4;
    assign port_left_3_out      = switch0_out_3_0;
    assign port_right_3_out     = switch1_out_3_4;
    assign port_left_4_out      = switch0_out_4_0;
    assign port_right_4_out     = switch1_out_4_4;

    PE_prowess p_0_0 (
                .pe_config_in       (pe_config_in_0_0   ),
                .pe_config_out      (pe_config_out_0_0  ),
                .data_bypass_i      (data_bypass_in_0_0  ),
                .data_bypass_o      (data_bypass_out_0_0  ),
                .data_i_1           (port0_in_0_0       ),
                .data_o_1           (port0_out_0_0      ),
                .data_i_2           (port1_in_0_0       ),
                .data_o_2           (port1_out_0_0      ),
                .data_i_3           (port2_in_0_0       ),
                .data_o_3           (port2_out_0_0      ),
                .data_i_4           (port3_in_0_0       ),
                .data_o_4           (port3_out_0_0      ),
                .clk                (clk                ),
                .rst_n              (rst_n              )
    );

    PE_prowess p_0_1 (
                .pe_config_in       (pe_config_in_0_1   ),
                .pe_config_out      (pe_config_out_0_1  ),
                .data_bypass_i      (data_bypass_in_0_1  ),
                .data_bypass_o      (data_bypass_out_0_1  ),
                .data_i_1           (port0_in_0_1       ),
                .data_o_1           (port0_out_0_1      ),
                .data_i_2           (port1_in_0_1       ),
                .data_o_2           (port1_out_0_1      ),
                .data_i_3           (port2_in_0_1       ),
                .data_o_3           (port2_out_0_1      ),
                .data_i_4           (port3_in_0_1       ),
                .data_o_4           (port3_out_0_1      ),
                .clk                (clk                ),
                .rst_n              (rst_n              )
    );

    PE_prowess p_0_2 (
                .pe_config_in       (pe_config_in_0_2   ),
                .pe_config_out      (pe_config_out_0_2  ),
                .data_bypass_i      (data_bypass_in_0_2  ),
                .data_bypass_o      (data_bypass_out_0_2  ),
                .data_i_1           (port0_in_0_2       ),
                .data_o_1           (port0_out_0_2      ),
                .data_i_2           (port1_in_0_2       ),
                .data_o_2           (port1_out_0_2      ),
                .data_i_3           (port2_in_0_2       ),
                .data_o_3           (port2_out_0_2      ),
                .data_i_4           (port3_in_0_2       ),
                .data_o_4           (port3_out_0_2      ),
                .clk                (clk                ),
                .rst_n              (rst_n              )
    );

    PE_prowess p_0_3 (
                .pe_config_in       (pe_config_in_0_3   ),
                .pe_config_out      (pe_config_out_0_3  ),
                .data_bypass_i      (data_bypass_in_0_3  ),
                .data_bypass_o      (data_bypass_out_0_3  ),
                .data_i_1           (port0_in_0_3       ),
                .data_o_1           (port0_out_0_3      ),
                .data_i_2           (port1_in_0_3       ),
                .data_o_2           (port1_out_0_3      ),
                .data_i_3           (port2_in_0_3       ),
                .data_o_3           (port2_out_0_3      ),
                .data_i_4           (port3_in_0_3       ),
                .data_o_4           (port3_out_0_3      ),
                .clk                (clk                ),
                .rst_n              (rst_n              )
    );

    PE_prowess p_1_0 (
                .pe_config_in       (pe_config_in_1_0   ),
                .pe_config_out      (pe_config_out_1_0  ),
                .data_bypass_i      (data_bypass_in_1_0  ),
                .data_bypass_o      (data_bypass_out_1_0  ),
                .data_i_1           (port0_in_1_0       ),
                .data_o_1           (port0_out_1_0      ),
                .data_i_2           (port1_in_1_0       ),
                .data_o_2           (port1_out_1_0      ),
                .data_i_3           (port2_in_1_0       ),
                .data_o_3           (port2_out_1_0      ),
                .data_i_4           (port3_in_1_0       ),
                .data_o_4           (port3_out_1_0      ),
                .clk                (clk                ),
                .rst_n              (rst_n              )
    );

    PE_prowess p_1_1 (
                .pe_config_in       (pe_config_in_1_1   ),
                .pe_config_out      (pe_config_out_1_1  ),
                .data_bypass_i      (data_bypass_in_1_1  ),
                .data_bypass_o      (data_bypass_out_1_1  ),
                .data_i_1           (port0_in_1_1       ),
                .data_o_1           (port0_out_1_1      ),
                .data_i_2           (port1_in_1_1       ),
                .data_o_2           (port1_out_1_1      ),
                .data_i_3           (port2_in_1_1       ),
                .data_o_3           (port2_out_1_1      ),
                .data_i_4           (port3_in_1_1       ),
                .data_o_4           (port3_out_1_1      ),
                .clk                (clk                ),
                .rst_n              (rst_n              )
    );

    PE_prowess p_1_2 (
                .pe_config_in       (pe_config_in_1_2   ),
                .pe_config_out      (pe_config_out_1_2  ),
                .data_bypass_i      (data_bypass_in_1_2  ),
                .data_bypass_o      (data_bypass_out_1_2  ),
                .data_i_1           (port0_in_1_2       ),
                .data_o_1           (port0_out_1_2      ),
                .data_i_2           (port1_in_1_2       ),
                .data_o_2           (port1_out_1_2      ),
                .data_i_3           (port2_in_1_2       ),
                .data_o_3           (port2_out_1_2      ),
                .data_i_4           (port3_in_1_2       ),
                .data_o_4           (port3_out_1_2      ),
                .clk                (clk                ),
                .rst_n              (rst_n              )
    );

    PE_prowess p_1_3 (
                .pe_config_in       (pe_config_in_1_3   ),
                .pe_config_out      (pe_config_out_1_3  ),
                .data_bypass_i      (data_bypass_in_1_3  ),
                .data_bypass_o      (data_bypass_out_1_3  ),
                .data_i_1           (port0_in_1_3       ),
                .data_o_1           (port0_out_1_3      ),
                .data_i_2           (port1_in_1_3       ),
                .data_o_2           (port1_out_1_3      ),
                .data_i_3           (port2_in_1_3       ),
                .data_o_3           (port2_out_1_3      ),
                .data_i_4           (port3_in_1_3       ),
                .data_o_4           (port3_out_1_3      ),
                .clk                (clk                ),
                .rst_n              (rst_n              )
    );

    PE_prowess p_2_0 (
                .pe_config_in       (pe_config_in_2_0   ),
                .pe_config_out      (pe_config_out_2_0  ),
                .data_bypass_i      (data_bypass_in_2_0  ),
                .data_bypass_o      (data_bypass_out_2_0  ),
                .data_i_1           (port0_in_2_0       ),
                .data_o_1           (port0_out_2_0      ),
                .data_i_2           (port1_in_2_0       ),
                .data_o_2           (port1_out_2_0      ),
                .data_i_3           (port2_in_2_0       ),
                .data_o_3           (port2_out_2_0      ),
                .data_i_4           (port3_in_2_0       ),
                .data_o_4           (port3_out_2_0      ),
                .clk                (clk                ),
                .rst_n              (rst_n              )
    );

    PE_prowess p_2_1 (
                .pe_config_in       (pe_config_in_2_1   ),
                .pe_config_out      (pe_config_out_2_1  ),
                .data_bypass_i      (data_bypass_in_2_1  ),
                .data_bypass_o      (data_bypass_out_2_1  ),
                .data_i_1           (port0_in_2_1       ),
                .data_o_1           (port0_out_2_1      ),
                .data_i_2           (port1_in_2_1       ),
                .data_o_2           (port1_out_2_1      ),
                .data_i_3           (port2_in_2_1       ),
                .data_o_3           (port2_out_2_1      ),
                .data_i_4           (port3_in_2_1       ),
                .data_o_4           (port3_out_2_1      ),
                .clk                (clk                ),
                .rst_n              (rst_n              )
    );

    PE_prowess p_2_2 (
                .pe_config_in       (pe_config_in_2_2   ),
                .pe_config_out      (pe_config_out_2_2  ),
                .data_bypass_i      (data_bypass_in_2_2  ),
                .data_bypass_o      (data_bypass_out_2_2  ),
                .data_i_1           (port0_in_2_2       ),
                .data_o_1           (port0_out_2_2      ),
                .data_i_2           (port1_in_2_2       ),
                .data_o_2           (port1_out_2_2      ),
                .data_i_3           (port2_in_2_2       ),
                .data_o_3           (port2_out_2_2      ),
                .data_i_4           (port3_in_2_2       ),
                .data_o_4           (port3_out_2_2      ),
                .clk                (clk                ),
                .rst_n              (rst_n              )
    );

    PE_prowess p_2_3 (
                .pe_config_in       (pe_config_in_2_3   ),
                .pe_config_out      (pe_config_out_2_3  ),
                .data_bypass_i      (data_bypass_in_2_3  ),
                .data_bypass_o      (data_bypass_out_2_3  ),
                .data_i_1           (port0_in_2_3       ),
                .data_o_1           (port0_out_2_3      ),
                .data_i_2           (port1_in_2_3       ),
                .data_o_2           (port1_out_2_3      ),
                .data_i_3           (port2_in_2_3       ),
                .data_o_3           (port2_out_2_3      ),
                .data_i_4           (port3_in_2_3       ),
                .data_o_4           (port3_out_2_3      ),
                .clk                (clk                ),
                .rst_n              (rst_n              )
    );

    PE_prowess p_3_0 (
                .pe_config_in       (pe_config_in_3_0   ),
                .pe_config_out      (pe_config_out_3_0  ),
                .data_bypass_i      (data_bypass_in_3_0  ),
                .data_bypass_o      (data_bypass_out_3_0  ),
                .data_i_1           (port0_in_3_0       ),
                .data_o_1           (port0_out_3_0      ),
                .data_i_2           (port1_in_3_0       ),
                .data_o_2           (port1_out_3_0      ),
                .data_i_3           (port2_in_3_0       ),
                .data_o_3           (port2_out_3_0      ),
                .data_i_4           (port3_in_3_0       ),
                .data_o_4           (port3_out_3_0      ),
                .clk                (clk                ),
                .rst_n              (rst_n              )
    );

    PE_prowess p_3_1 (
                .pe_config_in       (pe_config_in_3_1   ),
                .pe_config_out      (pe_config_out_3_1  ),
                .data_bypass_i      (data_bypass_in_3_1  ),
                .data_bypass_o      (data_bypass_out_3_1  ),
                .data_i_1           (port0_in_3_1       ),
                .data_o_1           (port0_out_3_1      ),
                .data_i_2           (port1_in_3_1       ),
                .data_o_2           (port1_out_3_1      ),
                .data_i_3           (port2_in_3_1       ),
                .data_o_3           (port2_out_3_1      ),
                .data_i_4           (port3_in_3_1       ),
                .data_o_4           (port3_out_3_1      ),
                .clk                (clk                ),
                .rst_n              (rst_n              )
    );

    PE_prowess p_3_2 (
                .pe_config_in       (pe_config_in_3_2   ),
                .pe_config_out      (pe_config_out_3_2  ),
                .data_bypass_i      (data_bypass_in_3_2  ),
                .data_bypass_o      (data_bypass_out_3_2  ),
                .data_i_1           (port0_in_3_2       ),
                .data_o_1           (port0_out_3_2      ),
                .data_i_2           (port1_in_3_2       ),
                .data_o_2           (port1_out_3_2      ),
                .data_i_3           (port2_in_3_2       ),
                .data_o_3           (port2_out_3_2      ),
                .data_i_4           (port3_in_3_2       ),
                .data_o_4           (port3_out_3_2      ),
                .clk                (clk                ),
                .rst_n              (rst_n              )
    );

    PE_prowess p_3_3 (
                .pe_config_in       (pe_config_in_3_3   ),
                .pe_config_out      (pe_config_out_3_3  ),
                .data_bypass_i      (data_bypass_in_3_3  ),
                .data_bypass_o      (data_bypass_out_3_3  ),
                .data_i_1           (port0_in_3_3       ),
                .data_o_1           (port0_out_3_3      ),
                .data_i_2           (port1_in_3_3       ),
                .data_o_2           (port1_out_3_3      ),
                .data_i_3           (port2_in_3_3       ),
                .data_o_3           (port2_out_3_3      ),
                .data_i_4           (port3_in_3_3       ),
                .data_o_4           (port3_out_3_3      ),
                .clk                (clk                ),
                .rst_n              (rst_n              )
    );

    PE_prowess p_4_0 (
                .pe_config_in       (pe_config_in_4_0   ),
                .pe_config_out      (pe_config_out_4_0  ),
                .data_bypass_i      (data_bypass_in_4_0  ),
                .data_bypass_o      (data_bypass_out_4_0  ),
                .data_i_1           (port0_in_4_0       ),
                .data_o_1           (port0_out_4_0      ),
                .data_i_2           (port1_in_4_0       ),
                .data_o_2           (port1_out_4_0      ),
                .data_i_3           (port2_in_4_0       ),
                .data_o_3           (port2_out_4_0      ),
                .data_i_4           (port3_in_4_0       ),
                .data_o_4           (port3_out_4_0      ),
                .clk                (clk                ),
                .rst_n              (rst_n              )
    );

    PE_prowess p_4_1 (
                .pe_config_in       (pe_config_in_4_1   ),
                .pe_config_out      (pe_config_out_4_1  ),
                .data_bypass_i      (data_bypass_in_4_1  ),
                .data_bypass_o      (data_bypass_out_4_1  ),
                .data_i_1           (port0_in_4_1       ),
                .data_o_1           (port0_out_4_1      ),
                .data_i_2           (port1_in_4_1       ),
                .data_o_2           (port1_out_4_1      ),
                .data_i_3           (port2_in_4_1       ),
                .data_o_3           (port2_out_4_1      ),
                .data_i_4           (port3_in_4_1       ),
                .data_o_4           (port3_out_4_1      ),
                .clk                (clk                ),
                .rst_n              (rst_n              )
    );

    PE_prowess p_4_2 (
                .pe_config_in       (pe_config_in_4_2   ),
                .pe_config_out      (pe_config_out_4_2  ),
                .data_bypass_i      (data_bypass_in_4_2  ),
                .data_bypass_o      (data_bypass_out_4_2  ),
                .data_i_1           (port0_in_4_2       ),
                .data_o_1           (port0_out_4_2      ),
                .data_i_2           (port1_in_4_2       ),
                .data_o_2           (port1_out_4_2      ),
                .data_i_3           (port2_in_4_2       ),
                .data_o_3           (port2_out_4_2      ),
                .data_i_4           (port3_in_4_2       ),
                .data_o_4           (port3_out_4_2      ),
                .clk                (clk                ),
                .rst_n              (rst_n              )
    );

    PE_prowess p_4_3 (
                .pe_config_in       (pe_config_in_4_3   ),
                .pe_config_out      (pe_config_out_4_3  ),
                .data_bypass_i      (data_bypass_in_4_3  ),
                .data_bypass_o      (data_bypass_out_4_3  ),
                .data_i_1           (port0_in_4_3       ),
                .data_o_1           (port0_out_4_3      ),
                .data_i_2           (port1_in_4_3       ),
                .data_o_2           (port1_out_4_3      ),
                .data_i_3           (port2_in_4_3       ),
                .data_o_3           (port2_out_4_3      ),
                .data_i_4           (port3_in_4_3       ),
                .data_o_4           (port3_out_4_3      ),
                .clk                (clk                ),
                .rst_n              (rst_n              )
    );

    switch_Prowess s_0_0 (
                .sw_config_in       (sw_config_in_0_0   ),
                .sw_config_out      (sw_config_out_0_0  ),
                .port0_in           (switch0_in_0_0     ),
                .port0_out          (switch0_out_0_0    ),
                .port1_in           (switch1_in_0_0     ),
                .port1_out          (switch1_out_0_0    ),
                .port2_in           (switch2_in_0_0     ),
                .port2_out          (switch2_out_0_0    ),
                .port3_in           (switch3_in_0_0     ),
                .port3_out          (switch3_out_0_0    ),
                .clk                (clk                ),
                .rst_n              (rst_n              )
    );

    switch_Prowess s_0_1 (
                .sw_config_in       (sw_config_in_0_1   ),
                .sw_config_out      (sw_config_out_0_1  ),
                .port0_in           (switch0_in_0_1     ),
                .port0_out          (switch0_out_0_1    ),
                .port1_in           (switch1_in_0_1     ),
                .port1_out          (switch1_out_0_1    ),
                .port2_in           (switch2_in_0_1     ),
                .port2_out          (switch2_out_0_1    ),
                .port3_in           (switch3_in_0_1     ),
                .port3_out          (switch3_out_0_1    ),
                .clk                (clk                ),
                .rst_n              (rst_n              )
    );

    switch_Prowess s_0_2 (
                .sw_config_in       (sw_config_in_0_2   ),
                .sw_config_out      (sw_config_out_0_2  ),
                .port0_in           (switch0_in_0_2     ),
                .port0_out          (switch0_out_0_2    ),
                .port1_in           (switch1_in_0_2     ),
                .port1_out          (switch1_out_0_2    ),
                .port2_in           (switch2_in_0_2     ),
                .port2_out          (switch2_out_0_2    ),
                .port3_in           (switch3_in_0_2     ),
                .port3_out          (switch3_out_0_2    ),
                .clk                (clk                ),
                .rst_n              (rst_n              )
    );

    switch_Prowess s_0_3 (
                .sw_config_in       (sw_config_in_0_3   ),
                .sw_config_out      (sw_config_out_0_3  ),
                .port0_in           (switch0_in_0_3     ),
                .port0_out          (switch0_out_0_3    ),
                .port1_in           (switch1_in_0_3     ),
                .port1_out          (switch1_out_0_3    ),
                .port2_in           (switch2_in_0_3     ),
                .port2_out          (switch2_out_0_3    ),
                .port3_in           (switch3_in_0_3     ),
                .port3_out          (switch3_out_0_3    ),
                .clk                (clk                ),
                .rst_n              (rst_n              )
    );

    switch_Prowess s_0_4 (
                .sw_config_in       (sw_config_in_0_4   ),
                .sw_config_out      (sw_config_out_0_4  ),
                .port0_in           (switch0_in_0_4     ),
                .port0_out          (switch0_out_0_4    ),
                .port1_in           (switch1_in_0_4     ),
                .port1_out          (switch1_out_0_4    ),
                .port2_in           (switch2_in_0_4     ),
                .port2_out          (switch2_out_0_4    ),
                .port3_in           (switch3_in_0_4     ),
                .port3_out          (switch3_out_0_4    ),
                .clk                (clk                ),
                .rst_n              (rst_n              )
    );

    switch_Prowess s_1_0 (
                .sw_config_in       (sw_config_in_1_0   ),
                .sw_config_out      (sw_config_out_1_0  ),
                .port0_in           (switch0_in_1_0     ),
                .port0_out          (switch0_out_1_0    ),
                .port1_in           (switch1_in_1_0     ),
                .port1_out          (switch1_out_1_0    ),
                .port2_in           (switch2_in_1_0     ),
                .port2_out          (switch2_out_1_0    ),
                .port3_in           (switch3_in_1_0     ),
                .port3_out          (switch3_out_1_0    ),
                .clk                (clk                ),
                .rst_n              (rst_n              )
    );

    switch_Prowess s_1_1 (
                .sw_config_in       (sw_config_in_1_1   ),
                .sw_config_out      (sw_config_out_1_1  ),
                .port0_in           (switch0_in_1_1     ),
                .port0_out          (switch0_out_1_1    ),
                .port1_in           (switch1_in_1_1     ),
                .port1_out          (switch1_out_1_1    ),
                .port2_in           (switch2_in_1_1     ),
                .port2_out          (switch2_out_1_1    ),
                .port3_in           (switch3_in_1_1     ),
                .port3_out          (switch3_out_1_1    ),
                .clk                (clk                ),
                .rst_n              (rst_n              )
    );

    switch_Prowess s_1_2 (
                .sw_config_in       (sw_config_in_1_2   ),
                .sw_config_out      (sw_config_out_1_2  ),
                .port0_in           (switch0_in_1_2     ),
                .port0_out          (switch0_out_1_2    ),
                .port1_in           (switch1_in_1_2     ),
                .port1_out          (switch1_out_1_2    ),
                .port2_in           (switch2_in_1_2     ),
                .port2_out          (switch2_out_1_2    ),
                .port3_in           (switch3_in_1_2     ),
                .port3_out          (switch3_out_1_2    ),
                .clk                (clk                ),
                .rst_n              (rst_n              )
    );

    switch_Prowess s_1_3 (
                .sw_config_in       (sw_config_in_1_3   ),
                .sw_config_out      (sw_config_out_1_3  ),
                .port0_in           (switch0_in_1_3     ),
                .port0_out          (switch0_out_1_3    ),
                .port1_in           (switch1_in_1_3     ),
                .port1_out          (switch1_out_1_3    ),
                .port2_in           (switch2_in_1_3     ),
                .port2_out          (switch2_out_1_3    ),
                .port3_in           (switch3_in_1_3     ),
                .port3_out          (switch3_out_1_3    ),
                .clk                (clk                ),
                .rst_n              (rst_n              )
    );

    switch_Prowess s_1_4 (
                .sw_config_in       (sw_config_in_1_4   ),
                .sw_config_out      (sw_config_out_1_4  ),
                .port0_in           (switch0_in_1_4     ),
                .port0_out          (switch0_out_1_4    ),
                .port1_in           (switch1_in_1_4     ),
                .port1_out          (switch1_out_1_4    ),
                .port2_in           (switch2_in_1_4     ),
                .port2_out          (switch2_out_1_4    ),
                .port3_in           (switch3_in_1_4     ),
                .port3_out          (switch3_out_1_4    ),
                .clk                (clk                ),
                .rst_n              (rst_n              )
    );

    switch_Prowess s_2_0 (
                .sw_config_in       (sw_config_in_2_0   ),
                .sw_config_out      (sw_config_out_2_0  ),
                .port0_in           (switch0_in_2_0     ),
                .port0_out          (switch0_out_2_0    ),
                .port1_in           (switch1_in_2_0     ),
                .port1_out          (switch1_out_2_0    ),
                .port2_in           (switch2_in_2_0     ),
                .port2_out          (switch2_out_2_0    ),
                .port3_in           (switch3_in_2_0     ),
                .port3_out          (switch3_out_2_0    ),
                .clk                (clk                ),
                .rst_n              (rst_n              )
    );

    switch_Prowess s_2_1 (
                .sw_config_in       (sw_config_in_2_1   ),
                .sw_config_out      (sw_config_out_2_1  ),
                .port0_in           (switch0_in_2_1     ),
                .port0_out          (switch0_out_2_1    ),
                .port1_in           (switch1_in_2_1     ),
                .port1_out          (switch1_out_2_1    ),
                .port2_in           (switch2_in_2_1     ),
                .port2_out          (switch2_out_2_1    ),
                .port3_in           (switch3_in_2_1     ),
                .port3_out          (switch3_out_2_1    ),
                .clk                (clk                ),
                .rst_n              (rst_n              )
    );

    switch_Prowess s_2_2 (
                .sw_config_in       (sw_config_in_2_2   ),
                .sw_config_out      (sw_config_out_2_2  ),
                .port0_in           (switch0_in_2_2     ),
                .port0_out          (switch0_out_2_2    ),
                .port1_in           (switch1_in_2_2     ),
                .port1_out          (switch1_out_2_2    ),
                .port2_in           (switch2_in_2_2     ),
                .port2_out          (switch2_out_2_2    ),
                .port3_in           (switch3_in_2_2     ),
                .port3_out          (switch3_out_2_2    ),
                .clk                (clk                ),
                .rst_n              (rst_n              )
    );

    switch_Prowess s_2_3 (
                .sw_config_in       (sw_config_in_2_3   ),
                .sw_config_out      (sw_config_out_2_3  ),
                .port0_in           (switch0_in_2_3     ),
                .port0_out          (switch0_out_2_3    ),
                .port1_in           (switch1_in_2_3     ),
                .port1_out          (switch1_out_2_3    ),
                .port2_in           (switch2_in_2_3     ),
                .port2_out          (switch2_out_2_3    ),
                .port3_in           (switch3_in_2_3     ),
                .port3_out          (switch3_out_2_3    ),
                .clk                (clk                ),
                .rst_n              (rst_n              )
    );

    switch_Prowess s_2_4 (
                .sw_config_in       (sw_config_in_2_4   ),
                .sw_config_out      (sw_config_out_2_4  ),
                .port0_in           (switch0_in_2_4     ),
                .port0_out          (switch0_out_2_4    ),
                .port1_in           (switch1_in_2_4     ),
                .port1_out          (switch1_out_2_4    ),
                .port2_in           (switch2_in_2_4     ),
                .port2_out          (switch2_out_2_4    ),
                .port3_in           (switch3_in_2_4     ),
                .port3_out          (switch3_out_2_4    ),
                .clk                (clk                ),
                .rst_n              (rst_n              )
    );

    switch_Prowess s_3_0 (
                .sw_config_in       (sw_config_in_3_0   ),
                .sw_config_out      (sw_config_out_3_0  ),
                .port0_in           (switch0_in_3_0     ),
                .port0_out          (switch0_out_3_0    ),
                .port1_in           (switch1_in_3_0     ),
                .port1_out          (switch1_out_3_0    ),
                .port2_in           (switch2_in_3_0     ),
                .port2_out          (switch2_out_3_0    ),
                .port3_in           (switch3_in_3_0     ),
                .port3_out          (switch3_out_3_0    ),
                .clk                (clk                ),
                .rst_n              (rst_n              )
    );

    switch_Prowess s_3_1 (
                .sw_config_in       (sw_config_in_3_1   ),
                .sw_config_out      (sw_config_out_3_1  ),
                .port0_in           (switch0_in_3_1     ),
                .port0_out          (switch0_out_3_1    ),
                .port1_in           (switch1_in_3_1     ),
                .port1_out          (switch1_out_3_1    ),
                .port2_in           (switch2_in_3_1     ),
                .port2_out          (switch2_out_3_1    ),
                .port3_in           (switch3_in_3_1     ),
                .port3_out          (switch3_out_3_1    ),
                .clk                (clk                ),
                .rst_n              (rst_n              )
    );

    switch_Prowess s_3_2 (
                .sw_config_in       (sw_config_in_3_2   ),
                .sw_config_out      (sw_config_out_3_2  ),
                .port0_in           (switch0_in_3_2     ),
                .port0_out          (switch0_out_3_2    ),
                .port1_in           (switch1_in_3_2     ),
                .port1_out          (switch1_out_3_2    ),
                .port2_in           (switch2_in_3_2     ),
                .port2_out          (switch2_out_3_2    ),
                .port3_in           (switch3_in_3_2     ),
                .port3_out          (switch3_out_3_2    ),
                .clk                (clk                ),
                .rst_n              (rst_n              )
    );

    switch_Prowess s_3_3 (
                .sw_config_in       (sw_config_in_3_3   ),
                .sw_config_out      (sw_config_out_3_3  ),
                .port0_in           (switch0_in_3_3     ),
                .port0_out          (switch0_out_3_3    ),
                .port1_in           (switch1_in_3_3     ),
                .port1_out          (switch1_out_3_3    ),
                .port2_in           (switch2_in_3_3     ),
                .port2_out          (switch2_out_3_3    ),
                .port3_in           (switch3_in_3_3     ),
                .port3_out          (switch3_out_3_3    ),
                .clk                (clk                ),
                .rst_n              (rst_n              )
    );

    switch_Prowess s_3_4 (
                .sw_config_in       (sw_config_in_3_4   ),
                .sw_config_out      (sw_config_out_3_4  ),
                .port0_in           (switch0_in_3_4     ),
                .port0_out          (switch0_out_3_4    ),
                .port1_in           (switch1_in_3_4     ),
                .port1_out          (switch1_out_3_4    ),
                .port2_in           (switch2_in_3_4     ),
                .port2_out          (switch2_out_3_4    ),
                .port3_in           (switch3_in_3_4     ),
                .port3_out          (switch3_out_3_4    ),
                .clk                (clk                ),
                .rst_n              (rst_n              )
    );

    switch_Prowess s_4_0 (
                .sw_config_in       (sw_config_in_4_0   ),
                .sw_config_out      (sw_config_out_4_0  ),
                .port0_in           (switch0_in_4_0     ),
                .port0_out          (switch0_out_4_0    ),
                .port1_in           (switch1_in_4_0     ),
                .port1_out          (switch1_out_4_0    ),
                .port2_in           (switch2_in_4_0     ),
                .port2_out          (switch2_out_4_0    ),
                .port3_in           (switch3_in_4_0     ),
                .port3_out          (switch3_out_4_0    ),
                .clk                (clk                ),
                .rst_n              (rst_n              )
    );

    switch_Prowess s_4_1 (
                .sw_config_in       (sw_config_in_4_1   ),
                .sw_config_out      (sw_config_out_4_1  ),
                .port0_in           (switch0_in_4_1     ),
                .port0_out          (switch0_out_4_1    ),
                .port1_in           (switch1_in_4_1     ),
                .port1_out          (switch1_out_4_1    ),
                .port2_in           (switch2_in_4_1     ),
                .port2_out          (switch2_out_4_1    ),
                .port3_in           (switch3_in_4_1     ),
                .port3_out          (switch3_out_4_1    ),
                .clk                (clk                ),
                .rst_n              (rst_n              )
    );

    switch_Prowess s_4_2 (
                .sw_config_in       (sw_config_in_4_2   ),
                .sw_config_out      (sw_config_out_4_2  ),
                .port0_in           (switch0_in_4_2     ),
                .port0_out          (switch0_out_4_2    ),
                .port1_in           (switch1_in_4_2     ),
                .port1_out          (switch1_out_4_2    ),
                .port2_in           (switch2_in_4_2     ),
                .port2_out          (switch2_out_4_2    ),
                .port3_in           (switch3_in_4_2     ),
                .port3_out          (switch3_out_4_2    ),
                .clk                (clk                ),
                .rst_n              (rst_n              )
    );

    switch_Prowess s_4_3 (
                .sw_config_in       (sw_config_in_4_3   ),
                .sw_config_out      (sw_config_out_4_3  ),
                .port0_in           (switch0_in_4_3     ),
                .port0_out          (switch0_out_4_3    ),
                .port1_in           (switch1_in_4_3     ),
                .port1_out          (switch1_out_4_3    ),
                .port2_in           (switch2_in_4_3     ),
                .port2_out          (switch2_out_4_3    ),
                .port3_in           (switch3_in_4_3     ),
                .port3_out          (switch3_out_4_3    ),
                .clk                (clk                ),
                .rst_n              (rst_n              )
    );

    switch_Prowess s_4_4 (
                .sw_config_in       (sw_config_in_4_4   ),
                .sw_config_out      (sw_config_out_4_4  ),
                .port0_in           (switch0_in_4_4     ),
                .port0_out          (switch0_out_4_4    ),
                .port1_in           (switch1_in_4_4     ),
                .port1_out          (switch1_out_4_4    ),
                .port2_in           (switch2_in_4_4     ),
                .port2_out          (switch2_out_4_4    ),
                .port3_in           (switch3_in_4_4     ),
                .port3_out          (switch3_out_4_4    ),
                .clk                (clk                ),
                .rst_n              (rst_n              )
    );

    switch_Prowess s_5_0 (
                .sw_config_in       (sw_config_in_5_0   ),
                .sw_config_out      (sw_config_out_5_0  ),
                .port0_in           (switch0_in_5_0     ),
                .port0_out          (switch0_out_5_0    ),
                .port1_in           (switch1_in_5_0     ),
                .port1_out          (switch1_out_5_0    ),
                .port2_in           (switch2_in_5_0     ),
                .port2_out          (switch2_out_5_0    ),
                .port3_in           (switch3_in_5_0     ),
                .port3_out          (switch3_out_5_0    ),
                .clk                (clk                ),
                .rst_n              (rst_n              )
    );

    switch_Prowess s_5_1 (
                .sw_config_in       (sw_config_in_5_1   ),
                .sw_config_out      (sw_config_out_5_1  ),
                .port0_in           (switch0_in_5_1     ),
                .port0_out          (switch0_out_5_1    ),
                .port1_in           (switch1_in_5_1     ),
                .port1_out          (switch1_out_5_1    ),
                .port2_in           (switch2_in_5_1     ),
                .port2_out          (switch2_out_5_1    ),
                .port3_in           (switch3_in_5_1     ),
                .port3_out          (switch3_out_5_1    ),
                .clk                (clk                ),
                .rst_n              (rst_n              )
    );

    switch_Prowess s_5_2 (
                .sw_config_in       (sw_config_in_5_2   ),
                .sw_config_out      (sw_config_out_5_2  ),
                .port0_in           (switch0_in_5_2     ),
                .port0_out          (switch0_out_5_2    ),
                .port1_in           (switch1_in_5_2     ),
                .port1_out          (switch1_out_5_2    ),
                .port2_in           (switch2_in_5_2     ),
                .port2_out          (switch2_out_5_2    ),
                .port3_in           (switch3_in_5_2     ),
                .port3_out          (switch3_out_5_2    ),
                .clk                (clk                ),
                .rst_n              (rst_n              )
    );

    switch_Prowess s_5_3 (
                .sw_config_in       (sw_config_in_5_3   ),
                .sw_config_out      (sw_config_out_5_3  ),
                .port0_in           (switch0_in_5_3     ),
                .port0_out          (switch0_out_5_3    ),
                .port1_in           (switch1_in_5_3     ),
                .port1_out          (switch1_out_5_3    ),
                .port2_in           (switch2_in_5_3     ),
                .port2_out          (switch2_out_5_3    ),
                .port3_in           (switch3_in_5_3     ),
                .port3_out          (switch3_out_5_3    ),
                .clk                (clk                ),
                .rst_n              (rst_n              )
    );

    switch_Prowess s_5_4 (
                .sw_config_in       (sw_config_in_5_4   ),
                .sw_config_out      (sw_config_out_5_4  ),
                .port0_in           (switch0_in_5_4     ),
                .port0_out          (switch0_out_5_4    ),
                .port1_in           (switch1_in_5_4     ),
                .port1_out          (switch1_out_5_4    ),
                .port2_in           (switch2_in_5_4     ),
                .port2_out          (switch2_out_5_4    ),
                .port3_in           (switch3_in_5_4     ),
                .port3_out          (switch3_out_5_4    ),
                .clk                (clk                ),
                .rst_n              (rst_n              )
    );

endmodule
