module top (clk, r_sw, r_clk, r_dt, led, led_a, led_b, servo);
	
	// Declaration
	input clk, r_sw, r_clk, r_dt;
	output led_a, led_b, servo;
	output [7:0] led;
	
	// Filter
	wire sw, a, b;
	debouncer U1A(.clk(clk), .d(r_sw), .neg(sw));
	debouncer U1B(.clk(clk), .d(r_clk), .q(a));
	debouncer U1C(.clk(clk), .d(r_dt), .q(b));
	
	// Process Input
	wire cnt, dir, mode;
	decoder U2(.clk(clk), .sw(sw), .a(a), .b(b), .cnt(cnt), .dir(dir), .mode(mode));
	
	// Control Unit
	wire [7:0] position;
	cog U3(
		.clk(clk), 
		.cnt(cnt), .dir(dir), .mode(mode), 
		.q(position), 
		.level(led), 
		.m_set(led_a), .m_drv(led_b)
	);
	
	// Servo Driver
	driver U4(.clk(clk), .d(position), .pwm(servo));
	
endmodule
