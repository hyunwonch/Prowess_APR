/*
    [X] Read NUM_LENGTH of data
    [X] Start DMA after NUM_DELAY of cycle
    [ ] Check finish signal
    [ ] Verification
*/

module dma #(
    parameter DMA_ID = 5
)(
    input clk,
    input rst_n,

    input DMA_RPKT rpkt_i,
    input DMA_WPKT wpkt_i,
    input DMA_RESP res_i,

    output DMA_RPKT rpkt_o,
    output DMA_WPKT wpkt_o,
    output DMA_RESP res_o,

    output MEM_PKT mem_pkt
);

    DMA_RPKT rpkt_o_next, rpkt_internal, rpkt_internal_next;
    DMA_WPKT wpkt_o_next, wpkt_internal, wpkt_internal_next;
    DMA_RESP res_o_next;

    logic done_internal, done_internal_next;
    logic finish, finish_next;

    always_comb begin
        done_internal_next = done_internal;
        res_o_next = '0;
        if(finish || done_internal && res_i.finish) begin
            res_o_next = res_i;
            done_internal_next = 1'b1;
        end else if (res_i.finish) begin
            res_o_next = res_i;
            done_internal_next = 1'b0;
        end else if (finish || done_internal) begin
            res_o_next.id = DMA_ID;
            res_o_next.finish = 1'b1;
            done_internal_next = 1'b0;
        end else begin
            done_internal_next = 1'b0;
        end
    end

    always_comb begin
        rpkt_internal_next = '0;
        rpkt_o_next        = '0;
        if(rpkt_i.id == '0) begin
            rpkt_o_next          = '0;
            rpkt_internal_next   = rpkt_i;
        end else begin
            rpkt_o_next          = rpkt_i;
            rpkt_o_next.id       = rpkt_i.id - 1'b1;
        end
    end

    always_comb begin
        wpkt_internal_next   = '0;
        wpkt_o_next          = '0;
        if(wpkt_i.id == '0) begin
            wpkt_o_next          = '0;
            wpkt_internal_next   = wpkt_i;
        end else begin
            wpkt_o_next          = wpkt_i;
            wpkt_o_next.id       = wpkt_i.id - 1'b1;
        end
    end

    logic read_state_next, read_state;
    logic wait_state_next, wait_state;
    logic [DMA_ADDR-1:0] read_addr_next, read_addr;
    logic [10:0] delay_count_next, delay_count;

    always_comb begin
        read_addr_next = read_addr;
        if(read_state) begin
            read_addr_next = read_addr - 1'b1;
        end else if (rpkt_internal.valid) begin
            read_addr_next = rpkt_internal.addr;
        end
    end

    // Is it better to have FSM ?
    // Decouple write/read commands ?
    always_comb begin
        mem_pkt.cen = 1'b1;
        mem_pkt.wen = 1'b1;
        mem_pkt.data = '0;
        mem_pkt.addr = '0;
        read_state_next = 1'b0;
        finish_next = 1'b0;
        if(wpkt_internal.valid) begin
            mem_pkt.cen = 1'b0;
            mem_pkt.wen = 1'b0;
            mem_pkt.data = wpkt_internal.data_i;
            mem_pkt.addr = wpkt_internal.addr;
        end else if (read_state) begin
            if(read_addr == rpkt_internal.addr) begin
                mem_pkt.cen = 1'b1;
                mem_pkt.wen = 1'b1;
                mem_pkt.addr = read_addr;
                read_state_next = 1'b0;
                finish_next = 1'b1;
            end else begin
                mem_pkt.cen = 1'b0;
                mem_pkt.wen = 1'b1;
                mem_pkt.addr = read_addr;
                read_state_next = 1'b1;
            end
        end else if (wait_state) begin
            if(delay_count == 0) begin
                wait_state_next = 1'b0;
                read_state_next = 1'b1;
            end else begin
                delay_count_next = delay_count - 1'b1;
                wait_state_next = 1'b1;
                read_state_next = 1'b0;
            end
        end else if (rpkt_internal.valid) begin
            mem_pkt.cen = 1'b0;
            mem_pkt.wen = 1'b1;
            mem_pkt.addr = rpkt_internal.addr;
            if(rpkt_internal.delay == '0) begin
                read_state_next = 1'b1;
            end else begin
                wait_state_next = 1'b1;
            end
        end
    end


    always_ff @(posedge clk or negedge rst_n) begin
        if(!rst_n) begin
            rpkt_o          <= '0;
            res_o           <= '0;
            done_internal   <= '0;
            wpkt_o          <= '0;
            wpkt_internal   <= '0;
            rpkt_internal   <= '0;
            read_state      <= '0;
            wait_state      <= '0;
            read_addr       <= '0;
            delay_count     <= '0;
            finish          <= '0;
        end else begin
            rpkt_o          <= rpkt_o_next;
            res_o           <= res_o_next;
            done_internal   <= done_internal_next;
            wpkt_o          <= wpkt_o_next;
            wpkt_internal   <= wpkt_internal_next;
            rpkt_internal   <= rpkt_internal_next;
            read_state      <= read_state_next;
            wait_state      <= wait_state_next;
            read_addr       <= read_addr_next;
            delay_count     <= delay_count_next;
            finish          <= finish_next;
        end
    end


endmodule