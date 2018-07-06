module ext_clk_gen (
	input 	wire 	sys_clk			,
	output	reg 	clk_out	
	);
	
	// Produce a 1MHz output clock by toggling the input clock every 50 ticks
	localparam HALF_COUNT = 50; // Gives a 50% duty-cycle
	reg [6:0] n;
	
	always@(posedge sys_clk) begin
	    clk_out = clk_out;
		n = n + 1;
		if (n >= HALF_COUNT) begin
			clk_out = ~clk_out;
			n = 0;
		end
	end	
	
endmodule