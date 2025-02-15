module neg #(
    DATA_WIDTH = 16
)(
    input        [DATA_WIDTH - 1 : 0] in,
    output logic [DATA_WIDTH - 1 : 0] out
);

    always_comb begin
        if (in == 0) begin
            out = 0;
        end else if (in == {1'b1, 15'b0}) begin
            out = in;
        end else begin
            out = ~in + 1;
        end
    end

endmodule