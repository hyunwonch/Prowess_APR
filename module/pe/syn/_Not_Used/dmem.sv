module dmem #(
    parameter BITS = 32,
    parameter ADDR = 9
)(

    input                       clk,
    input                       rst_n,
    input                       cen,
    input                       gwen,
    input [ADDR-1:0]            addr_r,
    input [ADDR-1:0]            addr_w,
    input [BITS-1:0]            data_i,

    output logic [BITS-1:0]     data_o
);

    /* TODO
        Below code is always writing something
        Need to change only read and write when in mode 3
        Does it need to get seperate gwen signal or add mode as a input so that DMEM module know what modes is
        But want to keep the module as basic
    */

    logic [BITS-1:0]    data1,data2;


    logic [BITS-1:0]    in1,in2,out1,out2;
    logic [ADDR-1:0]    addr1,addr2;

    logic cen1,cen2;
    logic gwen1,gwen2;

    assign cen1 = cen;
    assign cen2 = cen;

    assign in1 = data_i;
    assign in2 = data_i;



    always_comb begin
        if(addr_r[ADDR-1]) begin
            gwen1       = ~gwen;
            gwen2       = gwen;
            addr1       = addr_w;
            addr2       = addr_r;
            data_o      = out2;
        end else begin
            gwen1       = gwen;
            gwen2       = ~gwen;
            addr1       = addr_r;
            addr2       = addr_w;
            data_o      = out1;
        end
    end



    TS1N28HPCPUHDLVTB512X32M4SSO mem1 (
        .CLK            (clk),
        .A              (addr1),
        .D              (in1),
        .CEB            (cen1),
        .WEB            (gwen1),
        .Q              (out1),
        .SLP			('0),
        .SD				('0),
        .RTSEL			('0),
        .WTSEL			('0)
    );


    TS1N28HPCPUHDLVTB512X32M4SSO mem2 (
        .CLK            (clk),
        .A              (addr2),
        .D              (in2),
        .CEB            (cen2),
        .WEB            (gwen2),
        .Q              (out2),
        .SLP			('0),
        .SD				('0),
        .RTSEL			('0),
        .WTSEL			('0)
    );


    // always_ff @(posedge clk or negedge rst_n)
    // begin
    //     if(!rst_n) begin
    //         in_ff1      <= '0;
    //         in_ff2      <= '0;
    //         out         <= '0;
    //     end else begin
    //         in_ff1      <= in1;
    //         in_ff2      <= in2;
    //         out         <= out_next;
    //     end
    // end



endmodule