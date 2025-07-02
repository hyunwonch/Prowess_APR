`define t1 4
`define bit_width_MX_1__in_reg_P_stages_M_1_P_out_reg_P_1 2

module FP_div_pip #(
    parameter sig_width = 10,
    parameter exp_width = 5,
    parameter ieee_compliance = 0,
    parameter faithful_round = 0,
    parameter op_iso_mode = 0,
    parameter id_width = 8,
    parameter in_reg = 0,
    parameter stages = 4,
    parameter out_reg = 0,
    parameter no_pm = 1,
    parameter rst_mode = 0
)(
    input                                   clk,
    input                                   rst_n,
    input [sig_width+exp_width : 0]         a,
    input [sig_width+exp_width : 0]         b,
    input [2 : 0]                           rnd,
    output logic [sig_width+exp_width : 0]  z,
    output logic [7 : 0]                    status,

    input                                   inst_launch,
    input [id_width-1 : 0]                  inst_launch_id,
    output logic                            pipe_full_inst,
    output logic                            pipe_ovf_inst,
    input                                   inst_accept_n,
    output logic                            arrive_inst,
    output logic [id_width-1 : 0]           arrive_id_inst,
    output logic                            push_out_n_inst,
    output logic [(`bit_width_MX_1__in_reg_P_stages_M_1_P_out_reg_P_1)-1 : 0] pipe_census_inst
);



    // Internal Registers for Input Flip-Flops
    logic [sig_width+exp_width : 0] a_reg, b_reg;
    logic [2 : 0] rnd_reg;
    logic inst_launch_reg;
    logic [id_width-1 : 0] inst_launch_id_reg;

    // Internal Registers for Output Flip-Flops
    logic [sig_width+exp_width : 0] z_reg;
    logic [7 : 0] status_reg;
    logic pipe_full_inst_reg, pipe_ovf_inst_reg, arrive_inst_reg, push_out_n_inst_reg;
    logic [id_width-1 : 0] arrive_id_inst_reg;
    logic [(`bit_width_MX_1__in_reg_P_stages_M_1_P_out_reg_P_1)-1 : 0] pipe_census_inst_reg;

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            a_reg               <= '0;
            b_reg               <= '0;
            rnd_reg             <= '0;
            inst_launch_reg     <= '0;
            inst_launch_id_reg  <= '0;
        end else begin
            a_reg               <= a;
            b_reg               <= b;
            rnd_reg             <= rnd;
            inst_launch_reg     <= inst_launch;
            inst_launch_id_reg  <= inst_launch_id;
        end
    end

    // Instance of DW_lp_piped_fp_div
    DW_lp_piped_fp_div #(sig_width,
                        exp_width,
                        ieee_compliance,
                        faithful_round,
                        op_iso_mode,
                        id_width,
                        in_reg,
                        stages,
                        out_reg,
                        no_pm,
                        rst_mode)
        U1 ( .clk(clk),
            .rst_n(rst_n),
            .a(a_reg),
            .b(b_reg),
            .rnd(rnd_reg),
            .z(z_reg),  // Connect directly to the output registers
            .status(status_reg),
            .launch(inst_launch_reg),
            .launch_id(inst_launch_id_reg),
            .pipe_full(pipe_full_inst_reg),
            .pipe_ovf(pipe_ovf_inst_reg),
            .accept_n(inst_accept_n),  // No flip-flop needed for this input-only signal
            .arrive(arrive_inst_reg),
            .arrive_id(arrive_id_inst_reg),
            .push_out_n(push_out_n_inst_reg),
            .pipe_census(pipe_census_inst_reg) );

    // Output flip-flops
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            z                   <= '0;
            status              <= '0;
            pipe_full_inst      <= '0;
            pipe_ovf_inst       <= '0;
            arrive_inst         <= '0;
            arrive_id_inst      <= '0;
            push_out_n_inst     <= '0;
            pipe_census_inst    <= '0;
        end else begin
            z                   <= z_reg;
            status              <= status_reg;
            pipe_full_inst      <= pipe_full_inst_reg;
            pipe_ovf_inst       <= pipe_ovf_inst_reg;
            arrive_inst         <= arrive_inst_reg;
            arrive_id_inst      <= arrive_id_inst_reg;
            push_out_n_inst     <= push_out_n_inst_reg;
            pipe_census_inst    <= pipe_census_inst_reg;
        end
    end

endmodule
