module wrapper #(
    parameter WIDTH = 256,
    parameter REQS  = 1
)(
    input  logic                 clk,
    input  logic                 rst_n,
    input  logic [WIDTH-1:0]     req,
    // Outputs from the two instantiated modules are kept separate.
    output logic [WIDTH-1:0]     arb_gnt,   // From priority_arbiter
    output logic [WIDTH-1:0]     psel_gnt,  // From psel_gen
    output logic [WIDTH*REQS-1:0] gnt_bus,   // From psel_gen
    output logic                 empty      // From psel_gen
);

    // Internal signals: Registered inputs and unregistered outputs from the
    // instantiated modules.
    logic [WIDTH-1:0]     req_reg;
    logic [WIDTH-1:0]     arb_gnt_int;
    logic [WIDTH-1:0]     psel_gnt_int;
    logic [WIDTH*REQS-1:0] gnt_bus_int;
    logic                 empty_int;

    // Register the input "req" on the rising edge of clk (with asynchronous reset)
    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n)
            req_reg <= '0;
        else
            req_reg <= req;
    end

    // Instantiate the priority arbiter module.
    priority_arbiter #(
        .N(WIDTH)
    ) u_priority_arbiter (
        .req(req_reg),
        .gnt(arb_gnt_int)
    );

    // Instantiate the psel_gen module.
    psel_gen #(
        .WIDTH(WIDTH),
        .REQS(REQS)
    ) u_psel_gen (
        .req(req_reg),
        .gnt(psel_gnt_int),
        .gnt_bus(),
        .empty()
    );

    // Register the outputs of the two modules before driving the wrapper outputs.
    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            arb_gnt <= '0;
            psel_gnt <= '0;
            // gnt_bus <= '0;
            // empty   <= 1'b0;
        end else begin
            arb_gnt <= arb_gnt_int;
            psel_gnt <= psel_gnt_int;
            // gnt_bus <= gnt_bus_int;
            // empty   <= empty_int;
        end
    end

endmodule
