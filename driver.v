module driver (clk, d, pwm);
 
	// Declaration
	input clk;
	input [7:0] d;
	output pwm;
	
	reg pwm_q, pwm_d;
	reg [19:0] ctr_q, ctr_d;
	assign pwm = pwm_q;
	
	always @(*) begin
		ctr_d = ctr_q + 1'b1;
		if (d + 9'd165 > ctr_q[19:8]) begin
			pwm_d = 1'b1;
		end else begin
			pwm_d = 1'b0;
		end
	end
	
	always @(posedge clk) begin
		ctr_q 	<= ctr_d;			
		pwm_q 	<= pwm_d;
	end
	
endmodule
