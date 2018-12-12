module testbench;
    reg clk;

    initial begin
        // $dumpfile("testbench.vcd");
        // $dumpvars(0, testbench);

        #5 clk = 0;
        repeat (10000) begin
            #5 clk = 1;
            #5 clk = 0;
        end

        $display("OKAY");    
    end
   
    
    reg dinA;
    wire dinB;

    top uut (
        .clk (clk ),
        .a (dinA ),
        .b (dinB )
    );
    
    initial begin
		dinA <= 0;
		
		repeat (20000) #3 dinA = !dinA;
	end
	
	assert ff_test(.clk(clk), .test(dinB));
    
endmodule


module assert(input clk, input test);
    always @(posedge clk)
    begin
        if (test == 1)
        begin
            $display("ASSERTION FAILED in %m:",$time);
            //$finish;
        end
    end
endmodule
