`timescale 1ns/1ps

module top (
    input  logic clk,
    input  logic rst_n,
    input logic [5:0] scan_in,
    input SW_CONFIG config_in,

    output logic DBG_CLK,
    output logic scan_out
);

    //-------------------------------------------------------------------------
    // Parameters
    //-------------------------------------------------------------------------
    parameter DATA_WIDTH = 32;
    parameter CONF       = 64+2+4;

    //-------------------------------------------------------------------------
    // Internal Signals
    //-------------------------------------------------------------------------
    // Configuration signals from program_launcher
    logic [CONF-1:0] pe_config_0, pe_config_1, pe_config_2, pe_config_3;
    SW_CONFIG        sw_config_0, sw_config_1, sw_config_2, sw_config_3, sw_config_4;

    // Signals connecting the DMA engines to the PE array ports.
    // We use 5-element arrays for left and right side connections.
    logic [DATA_WIDTH-1:0] pe_left_in  [0:5];  // Drives PE_array port_left_*_in
    logic [DATA_WIDTH-1:0] pe_left_out [0:5];  // Receives from PE_array port_left_*_out

    logic [DATA_WIDTH-1:0] pe_right_in  [0:5]; // Drives PE_array port_right_*_in
    logic [DATA_WIDTH-1:0] pe_right_out [0:5]; // Receives from PE_array port_right_*_out

    //-------------------------------------------------------------------------
    // Module Instantiations
    //-------------------------------------------------------------------------



    TS1N28HPCPUHDLVTB512X128M4SSO  cmd_mem_inst1 (
                .SLP    (1'b0),       // Not in sleep mode
                .SD     (1'b0),       // Not in shutdown
                .CLK    (clk),
                .CEB    (1'b0),       // Chip enabled (active low)
                .WEB    (1'b0),       // Write enabled (active low)
                .A      (),
                .D      (),
                .RTSEL  ('0),
                .WTSEL  ('0),
                .Q      ()
    );

    TS1N28HPCPUHDLVTB512X128M4SSO  cmd_mem_inst2 (
                .SLP    (1'b0),       // Not in sleep mode
                .SD     (1'b0),       // Not in shutdown
                .CLK    (clk),
                .CEB    (1'b0),       // Chip enabled (active low)
                .WEB    (1'b0),       // Write enabled (active low)
                .A      (),
                .D      (),
                .RTSEL  ('0),
                .WTSEL  ('0),
                .Q      ()
    );

    TS1N28HPCPUHDLVTB2048X64M4SSO  inst_cache_inst1 (
                .SLP    (1'b0),       // Not in sleep mode
                .SD     (1'b0),       // Not in shutdown
                .CLK    (clk),
                .CEB    (1'b0),       // Chip enabled (active low)
                .WEB    (1'b0),       // Write enabled (active low)
                .A      (),
                .D      (),
                .RTSEL  ('0),
                .WTSEL  ('0),
                .Q      ()
    );

    TS1N28HPCPUHDLVTB2048X64M4SSO  inst_cache_inst2 (
                .SLP    (1'b0),       // Not in sleep mode
                .SD     (1'b0),       // Not in shutdown
                .CLK    (clk),
                .CEB    (1'b0),       // Chip enabled (active low)
                .WEB    (1'b0),       // Write enabled (active low)
                .A      (),
                .D      (),
                .RTSEL  ('0),
                .WTSEL  ('0),
                .Q      ()
    );

    TS1N28HPCPUHDLVTB2048X64M4SSO  inst_cache_inst3 (
                .SLP    (1'b0),       // Not in sleep mode
                .SD     (1'b0),       // Not in shutdown
                .CLK    (clk),
                .CEB    (1'b0),       // Chip enabled (active low)
                .WEB    (1'b0),       // Write enabled (active low)
                .A      (),
                .D      (),
                .RTSEL  ('0),
                .WTSEL  ('0),
                .Q      ()
    );


    TS1N28HPCPUHDLVTB2048X32M4SSO  shared_mem_inst1 (
                .SLP    (1'b0),       // Not in sleep mode
                .SD     (1'b0),       // Not in shutdown
                .CLK    (clk),
                .CEB    (1'b0),       // Chip enabled (active low)
                .WEB    (1'b0),       // Write enabled (active low)
                .A      (),
                .D      (),
                .RTSEL  ('0),
                .WTSEL  ('0),
                .Q      ()
    );

    TS1N28HPCPUHDLVTB2048X32M4SSO  shared_mem_inst2 (
                .SLP    (1'b0),       // Not in sleep mode
                .SD     (1'b0),       // Not in shutdown
                .CLK    (clk),
                .CEB    (1'b0),       // Chip enabled (active low)
                .WEB    (1'b0),       // Write enabled (active low)
                .A      (),
                .D      (),
                .RTSEL  ('0),
                .WTSEL  ('0),
                .Q      ()
    );
    // Program Launcher
    // This module generates the PE configuration (pe_config_*) and software configuration (sw_config_*)
    // program_launcher u_program_launcher (
    //     .pe_config_0(pe_config_0),
    //     .pe_config_1(pe_config_1),
    //     .pe_config_2(pe_config_2),
    //     .pe_config_3(pe_config_3),
    //     .sw_config_0(sw_config_0),
    //     .sw_config_1(sw_config_1),
    //     .sw_config_2(sw_config_2),
    //     .clk(clk),
    //     .rst_n(rst_n)
    // );

    assign sw_config_0 = config_in;
    assign sw_config_1 = config_in;
    assign sw_config_2 = config_in;
    assign sw_config_3 = config_in;
    assign sw_config_4 = config_in;

    // PE Array instantiation
    PE_array_Prowess_5X4 #(
        .DATA_WIDTH(DATA_WIDTH),
        .CONF(CONF)
    ) u_PE_array (
        // Configuration connections from program_launcher
        .pe_config_0(pe_config_0),
        .pe_config_1(pe_config_1),
        .pe_config_2(pe_config_2),
        .pe_config_3(pe_config_3),

        .sw_config_0(sw_config_0),
        .sw_config_1(sw_config_1),
        .sw_config_2(sw_config_2),
        .sw_config_3(sw_config_3),
        .sw_config_4(sw_config_4),

        // Left port connections
        .port_left_0_in(pe_left_in[0]),
        .port_left_1_in(pe_left_in[1]),
        .port_left_2_in(pe_left_in[2]),
        .port_left_3_in(pe_left_in[3]),
        .port_left_4_in(pe_left_in[4]),
        .port_left_5_in(pe_left_in[5]),

        .port_left_0_out(pe_left_out[0]),
        .port_left_1_out(pe_left_out[1]),
        .port_left_2_out(pe_left_out[2]),
        .port_left_3_out(pe_left_out[3]),
        .port_left_4_out(pe_left_out[4]),
        .port_left_5_out(pe_left_out[5]),

        // Right port connections
        .port_right_0_in(pe_right_in[0]),
        .port_right_1_in(pe_right_in[1]),
        .port_right_2_in(pe_right_in[2]),
        .port_right_3_in(pe_right_in[3]),
        .port_right_4_in(pe_right_in[4]),
        .port_right_5_in(pe_right_in[5]),

        .port_right_0_out(pe_right_out[0]),
        .port_right_1_out(pe_right_out[1]),
        .port_right_2_out(pe_right_out[2]),
        .port_right_3_out(pe_right_out[3]),
        .port_right_4_out(pe_right_out[4]),
        .port_right_5_out(pe_right_out[5]),

        // Clock and Reset
        .clk(clk),
        .rst_n(rst_n)
    );

    // DMA Engine for the left side.
    // The DMA engine drives the PE_array left side inputs (pe_left_in) and receives the left side outputs (pe_left_out).
    dma_engine u_dma_left (
        .clk(clk),
        .rst_n(rst_n),
        // Outputs from DMA to the PE array (connect to port_left_*_in)
        .port_0_out(pe_left_in[0]),
        .port_1_out(pe_left_in[1]),
        .port_2_out(pe_left_in[2]),
        .port_3_out(pe_left_in[3]),
        .port_4_out(pe_left_in[4]),
        // Inputs to DMA from the PE array (connect to port_left_*_out)
        .port_0_in(pe_left_out[0]),
        .port_1_in(pe_left_out[1]),
        .port_2_in(pe_left_out[2]),
        .port_3_in(pe_left_out[3]),
        .port_4_in(pe_left_out[4])
    );

    // DMA Engine for the right side.
    // This instance connects to the right side ports of the PE array.
    dma_engine u_dma_right (
        .clk(clk),
        .rst_n(rst_n),
        // Outputs from DMA to the PE array (connect to port_right_*_in)
        .port_0_out(pe_right_in[0]),
        .port_1_out(pe_right_in[1]),
        .port_2_out(pe_right_in[2]),
        .port_3_out(pe_right_in[3]),
        .port_4_out(pe_right_in[4]),
        // Inputs to DMA from the PE array (connect to port_right_*_out)
        .port_0_in(pe_right_out[0]),
        .port_1_in(pe_right_out[1]),
        .port_2_in(pe_right_out[2]),
        .port_3_in(pe_right_out[3]),
        .port_4_in(pe_right_out[4])
    );

endmodule
