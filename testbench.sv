module tb_round_robin_arbiter;

    logic clk;
    logic rst;
    logic [3:0] req;
    logic grant_ack;
    logic [3:0] grant;
    logic grant_valid;
    round_robin_arbiter DUT (
        .clk(clk),
        .rst(rst),
        .req(req),
        .grant_ack(grant_ack),
        .grant(grant),
        .grant_valid(grant_valid)
    );
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end
    initial begin
        $dumpfile("round_robin.vcd");
        $dumpvars(0, tb_round_robin_arbiter);
        rst = 1;
        req = 4'b0000;
        grant_ack = 0;
        #10;
        rst = 0;
        $display(" ROUND ROBIN BUS ARBITER TEST ");
        req = 4'b1111;
        repeat (8) begin
            @(negedge clk);
            #1;
            $display("Time=%0t Request=%b Grant=%b Valid=%b",
                     $time, req, grant, grant_valid);
            grant_ack = 1;
            @(posedge clk);
            #1;
            grant_ack = 0;
        end
        @(negedge clk);
        req = 4'b1010;
        repeat (4) begin
            #1;
            $display("Time=%0t Request=%b Grant=%b",
                     $time, req, grant);
            grant_ack = 1;
            @(posedge clk);
            #1;
            grant_ack = 0;
            @(negedge clk);
        end
        req = 4'b0000;
        #10;
        $display("No requests - Bus idle");
        $display(" SIMULATION COMPLETED ");
        
        $finish;
    end
endmodule