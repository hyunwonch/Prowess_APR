`define MAX_COL  10

typedef logic [$clog2(`MAX_COL+1) - 1 : 0] COL_ID;

typedef struct packed {
   logic                         valid;
   COL_ID                        count;
   logic                         enable;
   logic    [2:0]                port_num;
   logic    [2:0]                src;
} SW_CONFIG;