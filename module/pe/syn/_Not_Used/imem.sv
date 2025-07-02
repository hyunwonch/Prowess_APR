/*
 * @brief This module handles the signals related to the read from the program counter (PC) and internally handles all write signals.
 *        It only receives the valid signal for writing from the Program Launcher (PL).
 *
 * @details The purpose of this module is to manage the signals associated with reading from the program counter (PC) and handle all write signals internally.
 *          It is responsible for receiving the valid signal for writing from the Program Launcher (PL) and performing the necessary operations accordingly.
 *          This module ensures that all signals related to the read from the PC are properly managed and that only the valid signal for writing from the PL is considered.
 *
 * @note This module assumes that the signals related to the read from the PC are already provided and that the write signals are handled internally.
 *       It is important to ensure that the valid signal for writing from the PL is properly connected to this module for correct functionality.
 */
module imem #(
    parameter INST_WIDTH = 64,
    parameter INST_WORD = 32,
    parameter ID = 3
)(
    input                           clk,
    input                           rst_n,
    input                           valid_i,
    input [1:0]                     id_i,
    input                           w_switch_i,
    input                           r_switch_i,
    input [$clog2(INST_WORD)-1:0]   addr_r,
    input                           cen_r,
    input                           gwen_r,
    input [INST_WIDTH-1:0]          data_i,
    output logic [INST_WIDTH-1:0]   data_o
);


    // Write Signals
    logic [$clog2(INST_WORD)-1:0]   addr_w, addr_w_next;
    logic                           cen_w, cen_w_next;
    logic                           gwen_w, gwen_w_next;
    logic                           ptr_w, ptr_w_next;

    // Signals for each memory
    logic [$clog2(INST_WORD)-1:0]   addr1, addr2, addr3;
    logic                           cen1, cen2, cen3;
    logic                           gwen1, gwen2, gwen3;

    logic [INST_WIDTH-1:0]          data1, data2, data3;
    logic [INST_WIDTH-1:0]          out1, out2, out3;

    typedef enum logic [1:0] {FIRST, SECOND, THIRD} READ_STATE;

    READ_STATE state, state_next;

    always_comb begin
        ptr_w_next = ptr_w;
        cen_w_next = cen_w;
        gwen_w_next = gwen_w;
        addr_w_next = addr_w;
        if(valid_i & (id_i == ID)) begin
            if(w_switch_i) begin
                ptr_w_next    = ptr_w + 1'b1;
            end
            addr_w_next       = addr_w + 1'b1;
            cen_w_next        = 0;
            gwen_w_next       = 0;
        end
    end

    always_ff @(posedge clk or negedge rst_n) begin
        if(!rst_n) begin
            ptr_w   <= '0;
            cen_w   <= 1;
            gwen_w  <= 1;
            addr_w  <= '0;
        end
        else begin
            ptr_w   <= ptr_w_next;
            cen_w   <= cen_w_next;
            gwen_w  <= gwen_w_next;
            addr_w  <= addr_w_next;
        end
    end

    always_comb begin
        case(state)
            FIRST: begin
                if(r_switch_i) begin
                    state_next = SECOND;
                end
            end
            SECOND: begin
                if(r_switch_i) begin
                    state_next = THIRD;
                end
            end
            THIRD: begin
                if(r_switch_i) begin
                    state_next = FIRST;
                end
            end
            default: begin
                state_next = FIRST;
            end
        endcase
    end

    always_ff @(posedge clk or negedge rst_n) begin
        if(!rst_n) begin
            state <= THIRD;
        end
        else begin
            state <= state_next;
        end
    end



    // Write & Read State Machine
    always_comb begin
        case(state)
            FIRST: begin
                addr1 = addr_r;
                cen1 = cen_r;
                gwen1 = gwen_r;
                data_o = out1;
                data1 = data_i;
                if(ptr_w == 0) begin
                    addr2 = addr_w;
                    cen2 = cen_w;
                    gwen2 = gwen_w;
                end
                else begin
                    addr3 = addr_w;
                    cen3 = cen_w;
                    gwen3 = gwen_w;
                end
            end
            SECOND: begin
                addr2 = addr_r;
                cen2 = cen_r;
                gwen2 = gwen_r;
                data_o = out2;
                data2 = data_i;
                if(ptr_w == 0) begin
                    addr3 = addr_w;
                    cen3 = cen_w;
                    gwen3 = gwen_w;
                end
                else begin
                    addr1 = addr_w;
                    cen1 = cen_w;
                    gwen1 = gwen_w;
                end
            end
            THIRD: begin
                addr3 = addr_r;
                cen3 = cen_r;
                gwen3 = gwen_r;
                data_o = out3;
                data3 = data_i;
                if(ptr_w == 0) begin
                    addr1 = addr_w;
                    cen1 = cen_w;
                    gwen1 = gwen_w;
                end
                else begin
                    addr2 = addr_w;
                    cen2 = cen_w;
                    gwen2 = gwen_w;
                end
            end
            default: begin
                addr1 = addr_r;
                cen1 = cen_r;
                gwen1 = gwen_r;
                data_o = out1;
                data1 = data_i;
                if(ptr_w == 0) begin
                    addr2 = addr_w;
                    cen2 = cen_w;
                    gwen2 = gwen_w;
                end
                else begin
                    addr3 = addr_w;
                    cen3 = cen_w;
                    gwen3 = gwen_w;
                end
            end
        endcase
    end



    TS1N28HPCPUHDLVTB32X64M1SSO mem1 (
        .CLK            (clk),
        .A              (addr1),
        .D              (data1),
        .CEB            (cen1),
        .WEB            (gwen1),
        .Q              (out1),
        .SLP			('0),
        .SD				('0),
        .RTSEL			('0),
        .WTSEL			('0)
    );

    TS1N28HPCPUHDLVTB32X64M1SSO mem2 (
        .CLK            (clk),
        .A              (addr2),
        .D              (data2),
        .CEB            (cen2),
        .WEB            (gwen2),
        .Q              (out2),
        .SLP			('0),
        .SD				('0),
        .RTSEL			('0),
        .WTSEL			('0)
    );

    TS1N28HPCPUHDLVTB32X64M1SSO mem3 (
        .CLK            (clk),
        .A              (addr3),
        .D              (data3),
        .CEB            (cen3),
        .WEB            (gwen3),
        .Q              (out3),
        .SLP			('0),
        .SD				('0),
        .RTSEL			('0),
        .WTSEL			('0)
    );


endmodule