
module system (
	clk_clk,
	hex_hex0,
	hex_hex1,
	hex_hex2,
	reset_reset_n,
	switches_export);	

	input		clk_clk;
	output	[13:0]	hex_hex0;
	output	[13:0]	hex_hex1;
	output	[13:0]	hex_hex2;
	input		reset_reset_n;
	input	[31:0]	switches_export;
endmodule
