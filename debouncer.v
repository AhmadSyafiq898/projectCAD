module debouncer (clk, d, q, pos, neg, value);
	 
	// Declaration
	input clk, d;
	output reg q;
	output pos, neg;
	output [3:0] value; 
  
	// Essentials
	reg sync_a;	always @(posedge clk) sync_a <= ~d;
	reg sync_b;	always @(posedge clk) sync_b <= sync_a;	 
	 
	reg [3:0] count;
	 
	wire idle = (q == sync_b);
	wire count_max = &count;
	 
	always @(posedge clk)
	if(idle)
		count <= 0;
	else begin
		count <= count + 4'd1;
		if(count_max) q <= ~q;
	end

	assign pos = ~idle & count_max & ~q;
	assign neg = ~idle & count_max & q;
   assign value = count;          
endmodule