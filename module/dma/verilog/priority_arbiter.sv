
module priority_arbiter #(parameter N = 8)(
    input logic [N-1:0] req,
    output logic [N-1:0] gnt
);

    always_comb begin
        gnt = '0;
        for (int i=0; i<N; ++i) begin
            if(req[i]) begin
                gnt[i] = 1'b1;
                break;
            end
        end
    end

endmodule