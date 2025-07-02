module switch (
    input              clk,
    input              rst_n,
    input    SW_CONFIG sw_config_in,
    output   SW_CONFIG sw_config_out,
    input    DATA_BUS  port0_in,
    input    DATA_BUS  port1_in,
    input    DATA_BUS  port2_in,
    input    DATA_BUS  port3_in,
    output   DATA_BUS  port0_out,
    output   DATA_BUS  port1_out,
    output   DATA_BUS  port2_out,
    output   DATA_BUS  port3_out

);

    DATA_BUS port0_out_w;
    DATA_BUS port1_out_w;
    DATA_BUS port2_out_w;
    DATA_BUS port3_out_w;

    SW_CONFIG sw_config_out_w;

    logic [3:0][3:0] config_store, config_store_w;
    logic [3:0] config_enable_w, config_enable;

    always_comb begin
        sw_config_out_w     = 0;
        config_store_w      = config_store;
        config_enable_w     = config_enable;
        if (sw_config_in.valid == 1) begin
            if (sw_config_in.count == 0) begin
                config_enable_w[sw_config_in.port_num]  = sw_config_in.enable;
                config_store_w[sw_config_in.port_num]   = sw_config_in.src;
            end else begin
                sw_config_out_w.valid                   = 1;
                sw_config_out_w.count                   = sw_config_in.count - 1;
                sw_config_out_w.enable                  = sw_config_in.enable;
                sw_config_out_w.port_num                = sw_config_in.port_num;
                sw_config_out_w.src                     = sw_config_in.src;
            end
        end
    end

    always_comb begin
        port0_out_w.valid = 0;
        port0_out_w.c_data = port0_out.c_data;
        if (config_enable[0] == 1) begin
            if (config_store[0] == 0 && port0_in.valid == 1)        port0_out_w = port0_in;
            else if (config_store[0] == 1 && port1_in.valid == 1)   port0_out_w = port1_in;
            else if (config_store[0] == 2 && port2_in.valid == 1)   port0_out_w = port2_in;
            else if (config_store[0] == 3 && port3_in.valid == 1)   port0_out_w = port3_in;
        end
    end

    always_comb begin
        port1_out_w.valid = 0;
        port1_out_w.c_data = port1_out.c_data;
        if (config_enable[1] == 1) begin
            if (config_store[1] == 0 && port0_in.valid == 1)        port1_out_w = port0_in;
            else if (config_store[1] == 1 && port1_in.valid == 1)   port1_out_w = port1_in;
            else if (config_store[1] == 2 && port2_in.valid == 1)   port1_out_w = port2_in;
            else if (config_store[1] == 3 && port3_in.valid == 1)   port1_out_w = port3_in;
        end
    end
    always_comb begin
        port2_out_w.valid = 0;
        port2_out_w.c_data = port2_out.c_data;
        if (config_enable[2] == 1) begin
            if (config_store[2] == 0 && port0_in.valid == 1)        port2_out_w = port0_in;
            else if (config_store[2] == 1 && port1_in.valid == 1)   port2_out_w = port1_in;
            else if (config_store[2] == 2 && port2_in.valid == 1)   port2_out_w = port2_in;
            else if (config_store[2] == 3 && port3_in.valid == 1)   port2_out_w = port3_in;
        end
    end
    always_comb begin
        port3_out_w.valid = 0;
        port3_out_w.c_data = port3_out.c_data;
        if (config_enable[3] == 1) begin
            if (config_store[3] == 0 && port0_in.valid == 1)        port3_out_w = port0_in;
            else if (config_store[3] == 1 && port1_in.valid == 1)   port3_out_w = port1_in;
            else if (config_store[3] == 2 && port2_in.valid == 1)   port3_out_w = port2_in;
            else if (config_store[3] == 3 && port3_in.valid == 1)   port3_out_w = port3_in;
        end
    end


    always_ff @ (posedge clk or negedge rst_n) begin
        if (rst_n == 0) begin
            sw_config_out   <= 0;
            config_store    <= 0;
            config_enable   <= 0;
            port0_out       <= 0;
            port1_out       <= 0;
            port2_out       <= 0;
            port3_out       <= 0;
        end else begin
            sw_config_out   <= sw_config_out_w;
            config_store    <= config_store_w;
            config_enable   <= config_enable_w;
            port0_out       <= port0_out_w;
            port1_out       <= port1_out_w;
            port2_out       <= port2_out_w;
            port3_out       <= port3_out_w;
        end
    end

endmodule
