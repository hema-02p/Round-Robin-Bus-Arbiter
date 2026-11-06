module round_robin_arbiter (
    input  logic       clk,
    input  logic       rst,
    input  logic [3:0] req,
    input  logic       grant_ack,
    output logic [3:0] grant,
    output logic       grant_valid
);
    logic [1:0] priority_ptr;
    integer i;
    integer candidate;
    integer winner;
    always_comb begin
        grant       = 4'b0000;
        grant_valid = 1'b0;
        winner      = -1;
        for (i = 0; i < 4; i = i + 1) begin
            candidate = (priority_ptr + i) % 4;
            if (!grant_valid && req[candidate]) begin
                grant[candidate] = 1'b1;
                grant_valid      = 1'b1;
                winner            = candidate;
            end
        end
    end
    always_ff @(posedge clk or posedge rst) begin
        if (rst) begin
            priority_ptr <= 2'b00;
        end
        else if (grant_ack && grant_valid) begin
            priority_ptr <= (winner + 1) % 4;
        end
    end
endmodule