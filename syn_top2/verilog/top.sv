`timescale 1ns/1ps

module top #(
    parameter DATA_WIDTH    = 32,
    parameter NUM_ROWS      = 5,
    parameter NUM_COLS      = 5,
    parameter CONF          = 64 + 2 + 4
)(
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
    localparam NUM_SW_CONFIG = NUM_COLS + 1;
    localparam DMA_PORTS     = NUM_ROWS + 1;

    //-------------------------------------------------------------------------
    // Configuration Signals
    //-------------------------------------------------------------------------
    logic [CONF-1:0] pe_config [0:NUM_COLS-1];
    SW_CONFIG        sw_config [0:NUM_SW_CONFIG-1];

    //-------------------------------------------------------------------------
    // Interconnect Signals between the PE array and the DMA engines
    //-------------------------------------------------------------------------
    // PE array ?left? and ?right? ports ? one per row.
    logic [DATA_WIDTH-1:0] pe_left_in  [0:DMA_PORTS-1];
    logic [DATA_WIDTH-1:0] pe_left_out [0:DMA_PORTS-1];
    logic [DATA_WIDTH-1:0] pe_right_in  [0:DMA_PORTS-1];
    logic [DATA_WIDTH-1:0] pe_right_out [0:DMA_PORTS-1];

    // Since in our design only DMA_PORTS rows (for example, rows 0 to DMA_PORTS-1) are connected to the DMA,
    // we create intermediate arrays for the DMA engine ports.
    logic [DATA_WIDTH-1:0] dma_left_port_out [0:DMA_PORTS-1];
    logic [DATA_WIDTH-1:0] dma_left_port_in  [0:DMA_PORTS-1];

    logic [DATA_WIDTH-1:0] dma_right_port_out [0:DMA_PORTS-1];
    logic [DATA_WIDTH-1:0] dma_right_port_in  [0:DMA_PORTS-1];

    //-------------------------------------------------------------------------
    // Module Instantiations
    //-------------------------------------------------------------------------

    TS1N28HPCPUHDLVTB512X64M4SSO  cmd_mem_inst1 (
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

    TS1N28HPCPUHDLVTB512X64M4SSO  cmd_mem_inst2 (
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

    TS1N28HPCPUHDLVTB2048X64M4SSO  inst_cache_inst4 (
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



    //-------------------------------------------------------------------------
    // Assign software configuration signals
    //-------------------------------------------------------------------------
    genvar i;
    generate
        for (i = 0; i < NUM_SW_CONFIG; i = i + 1) begin : sw_config_assign
            assign sw_config[i] = config_in;
        end
    endgenerate

    generate
        for (i = 0; i < NUM_COLS; i = i + 1) begin : pe_config_assign
            assign pe_config[i] = scan_in;
        end
    endgenerate

    //-------------------------------------------------------------------------
    // Connect DMA engine signals to the PE array signals
    //-------------------------------------------------------------------------
    generate
        for (i = 0; i < DMA_PORTS; i = i + 1) begin : dma_left_conn
            assign pe_left_in[i]        = dma_left_port_out[i];
            assign dma_left_port_in[i]  = pe_left_out[i];
        end
    endgenerate

    generate
        for (i = 0; i < DMA_PORTS; i = i + 1) begin : dma_right_conn
            assign pe_right_in[i]       = dma_right_port_out[i];
            assign dma_right_port_in[i] = pe_right_out[i];
        end
    endgenerate

    //-------------------------------------------------------------------------
    // Module Instantiations
    //-------------------------------------------------------------------------

    // PE Array instantiation
    PE_array_Prowess #(
        .DATA_WIDTH(DATA_WIDTH),
        .NUM_ROWS(NUM_ROWS),
        .NUM_COLS(NUM_COLS),
        .CONF(CONF)
    ) u_PE_array (
        .pe_config    (pe_config),    // Array of size NUM_COLS
        .sw_config    (sw_config),    // Array of size NUM_SW_CONFIG
        .port_left_in (pe_left_in),   // Array of size NUM_ROWS
        .port_left_out(pe_left_out),  // Array of size NUM_ROWS
        .port_right_in(pe_right_in),  // Array of size NUM_ROWS
        .port_right_out(pe_right_out),// Array of size NUM_ROWS
        .clk          (clk),
        .rst_n        (rst_n)
    );

    dma_engine #(
        .DATA_WIDTH(DATA_WIDTH),
        .DMA_PORTS(DMA_PORTS)
    ) u_dma_left (
        .clk      (clk),
        .rst_n    (rst_n),
        .port_out (dma_left_port_out), // Drives PE_array left ports (for rows 0 to DMA_PORTS-1)
        .port_in  (dma_left_port_in)   // Receives from PE_array left ports
    );

    dma_engine #(
        .DATA_WIDTH(DATA_WIDTH),
        .DMA_PORTS(DMA_PORTS)
    ) u_dma_right (
        .clk      (clk),
        .rst_n    (rst_n),
        .port_out (dma_right_port_out), // Drives PE_array right ports (for rows 0 to DMA_PORTS-1)
        .port_in  (dma_right_port_in)   // Receives from PE_array right ports
    );


endmodule
