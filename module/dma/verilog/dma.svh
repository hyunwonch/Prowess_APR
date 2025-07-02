
`ifndef __PL_SVH__
`define __PL_SVH__


`define NUM_OF_ROWS 8
`define NUM_OF_COLS 8
`define NUM_OF_BRANCHES 4
`define PLCT_SIZE 16
`define ST_SIZE 8
`define PL_COMMAND_WIDTH 32

typedef struct packed {
    logic [$clog2(`NUM_OF_COLS)-1:0] pos_x;
    logic [2:0] interrupt_type;
    // logic [$clog2(`NUM_OF_ROWS)-1:0] pos_y;
} INTRPT_PKT_IN;

typedef struct packed {
    logic [$clog2(`NUM_OF_ROWS)-1:0] pos_y;
    INTRPT_PKT_IN intrpt_pkt_in;
} INTRPT_PKT_OUT;

// Interface
`define ST_ADDR 12
`define ST_DATA 32

`define SM_ADDR 12
`define SM_DATA 32

`define CMD_ADDR 11
`define CMD_DATA 256

`define INST_ADDR 12
`define INST_DATA 64

`define CTRL_ADDR 1
`define CTRL_DATA 32


parameter DATA_WIDTH = 32;
parameter DMA_ADDR = 9;
parameter INST_WIDTH = 64;


typedef enum logic[2:0] {
    RUNNING = 3'b001,
    INIT = 3'b010,
    WAIT = 3'b100
} KERNEL_STATE;


typedef struct packed {
    logic                  valid;
    logic [DATA_WIDTH-1:0] data;
} DATA_PKT;

typedef struct packed {
    logic [INST_WIDTH-1:0] inst;
    logic [ 2:0]           inst_conf;
} INST_PKT;

typedef union packed {
    logic [INST_WIDTH-1:0] inst;
    struct packed {
        logic [2:0] rst_control;
        logic [4:0] cb1_control;
        logic [4:0] cb2_control;
        logic [5:0] fu_control;
        logic [44:0] not_used;
    } manual;
    struct packed {
        logic        valid;
        logic [ 2:0] col_id;
        logic [ 9:0] addr;
        logic [ 9:0] length;
        logic [31:0] data;
        logic [ 7:0] not_used;
    } ingress;
    struct packed {
        logic        valid;
        logic [ 2:0] col_id;
        logic [ 9:0] addr;
        logic [ 9:0] length;
        logic [39:0] not_used;
    } egress;
} PE_REQ;


typedef struct packed {
    logic [2:0] pos_x;
    logic [2:0] pos_y;
} INTERRUPT_PACKET;

typedef struct packed {
    logic        valid;
    logic [ 2:0] interrupt;
} INTRPT_PKT;

typedef struct packed {
    DATA_PKT    data;
    INTRPT_PKT  interrupt;
} PE_RESP;

typedef struct packed {
    logic [DMA_ADDR-1:0] addr;
    logic [ 2:0]         id;
    logic                valid;
    logic [DMA_ADDR-1:0] length;
    logic [10:0]         delay;
} DMA_RPKT;

typedef struct packed {
    logic [DMA_ADDR-1:0]   addr;
    logic [ 2:0]           id;
    logic                  valid;
    logic [DATA_WIDTH-1:0] data_i;
} DMA_WPKT;

typedef struct packed {
    logic [2:0] id;
    logic       finish;
} DMA_RESP;

typedef struct packed {
    logic [DMA_ADDR-1:0]   addr;
    logic [DATA_WIDTH-1:0] data;
    logic                  cen;
    logic                  wen;
} MEM_PKT;


`endif // __PL_SVH__
