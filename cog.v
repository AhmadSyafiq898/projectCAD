module cog (clk, cnt, dir, mode, q, level, m_set, m_drv);

	// Declaration
	input clk, cnt, dir, mode; 
	output reg [7:0] q; 
	output reg [7:0] level;
	output m_set, m_drv;
	
	// Level Status
	reg s;
	reg [7:0] speed;
	reg [2:0] buffer;
	
	always @(posedge clk) begin
		if(cnt) begin		
			buffer <= buffer + 1;
			if(buffer == 2'd3) begin
				
				if(!mode) begin
					if(dir)
						{level,s} <= {level[7:1],2'b11} << 1;
					else
						{s,level} <= {2'b00,level[6:0]} >> 1;					
				end else begin
					if(!dir) 
						q <= q+speed; 
					else
						q <= q-speed;
				end
				
				buffer <= 0;
			end			
		end
		
		case(level)
			8'd0:		speed <= 8'd0;
			8'd1:		speed <= 8'd1;
			8'd3:		speed <= 8'd2;
			8'd7:		speed <= 8'd3;
			8'd15:	speed <= 8'd7;
			8'd31:	speed <= 8'd15;
			8'd63:	speed <= 8'd31;
			8'd127:	speed <= 8'd63;
			8'd255:	speed <= 8'd127;
		endcase
	end
	
	assign led = level;
	assign m_set = mode;
	assign m_drv = ~mode;

endmodule
