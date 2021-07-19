module decoder (clk, sw, a, b, cnt, dir, mode);
	
	// Declaration
	input clk, sw, a, b;
	output cnt, dir; 
	output reg mode;
	
	// Essentials
	reg a_delayed, b_delayed;
	
	always @(posedge clk) a_delayed <= a;
	always @(posedge clk) b_delayed <= b;
	
	assign cnt = a ^ a_delayed ^ b ^ b_delayed;
	assign dir = a ^ b_delayed;
	
	always @(posedge sw) begin
		if(!mode)
			mode <= 1;
		else
			mode <= 0;
	end
	
endmodule
