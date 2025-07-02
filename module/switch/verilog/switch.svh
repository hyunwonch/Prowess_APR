`define MAX_COL  10
`define IMEM_ENTRY 8
`define DMEM_ENTRY 256
`define DATA_WIDTH    16
`define LOOP_NUM   8

typedef logic [3:0] FU_MODE;
typedef logic [`DATA_WIDTH - 1 : 0] H_DATA;
typedef logic [$clog2(`MAX_COL+1) - 1 : 0] COL_ID;
typedef logic [$clog2(`IMEM_ENTRY) - 1 : 0] IMEM_ADDR;
typedef logic [$clog2(`DMEM_ENTRY) - 1 : 0] DMEM_ADDR;
typedef logic [$clog2(`LOOP_NUM) - 1 : 0] LOOP_INDEX;
typedef struct packed {
   H_DATA                        r_data;
   H_DATA                        i_data;
} C_DATA;

typedef struct packed {
   logic                         valid;
   C_DATA                        c_data;
} DATA_BUS;

typedef struct packed {
   logic                         valid;
   COL_ID                        count;
   logic                         enable;
   logic    [2:0]                port_num;
   logic    [2:0]                src;
} SW_CONFIG;

typedef struct packed {
   logic                         valid;
   COL_ID                        count;
// 0: load program 1: load constant 2: start program 3: stop program
   logic    [1:0]                config_type;
   IMEM_ADDR                     pointer;
   logic    [31:0]               payload;
} PE_CONFIG;

typedef struct packed {
   logic                         valid;
   IMEM_ADDR                     pointer;
   logic    [31:0]               payload;
} LOAD_PROGRAM;

typedef struct packed {
   logic                         valid;
   logic                         enable;
   IMEM_ADDR                     pointer;
} COARSE_CONTROL;

typedef struct packed {
   logic                         valid;
   logic                         slot;
   C_DATA                        c_data;
} LOAD_CONSTANT;

typedef struct packed {
   logic                         valid;
   logic                         fu_enable;
   logic     [1:0]               config_type;
   FU_MODE                       mode;
   logic     [15:0]              payload;
   logic     [2:0]               srca;
   logic     [2:0]               srcb;
   logic     [2:0]               srcc;
   logic     [4:0]               dest;
} SCHEDULE;

typedef struct packed {
   logic                         valid;
   FU_MODE                       mode;
   logic     [4:0]               dest;
} FU_SCHEDULE;
