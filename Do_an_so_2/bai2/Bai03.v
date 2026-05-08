module Bai03(

    input  wire        CLOCK_50,
    input  wire [1:0]  KEY,


    input  wire [9:0]  SW,

    output wire [6:0]  HEX0,
    output wire [6:0]  HEX1,
    output wire [6:0]  HEX2,
    output wire [6:0]  HEX3,
    output wire [6:0]  HEX4,
    output wire [6:0]  HEX5
);


    
    system NIOS_system (
        .clk_clk               (CLOCK_50),
        .reset_reset_n         (KEY[0]),
        .switches_export       ({22'd0, SW[9:0]}), 

        
        .hex_hex0          ({HEX1, HEX0}),
        .hex_hex1          ({HEX3, HEX2}),
        .hex_hex2	         ({HEX5, HEX4})
    );

endmodule