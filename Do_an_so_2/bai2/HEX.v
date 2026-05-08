module HEX(
    input  wire        iClk,
    input  wire        iRst_n,
    input  wire        iChipSelect,
    input  wire [1:0]  iAddress,
    input  wire        iWrite,
    input  wire [31:0] iWriteData,

    // 3 output registers, each 14-bit wide to control a pair of HEX displays
    output reg  [13:0] oHex_Sec,  // Controls HEX1 (Tens) and HEX0 (Ones)
    output reg  [13:0] oHex_Min,  // Controls HEX3 (Tens) and HEX2 (Ones)
    output reg  [13:0] oHex_Hour  // Controls HEX5 (Tens) and HEX4 (Ones)
);

function [6:0] decode_7seg;
    input [3:0] num;
    begin
        case (num)
            4'd0: decode_7seg = 7'b1000000;
            4'd1: decode_7seg = 7'b1111001;
            4'd2: decode_7seg = 7'b0100100;
            4'd3: decode_7seg = 7'b0110000;
            4'd4: decode_7seg = 7'b0011001;
            4'd5: decode_7seg = 7'b0010010;
            4'd6: decode_7seg = 7'b0000010;
            4'd7: decode_7seg = 7'b1111000;
            4'd8: decode_7seg = 7'b0000000;
            4'd9: decode_7seg = 7'b0010000;
            default: decode_7seg = 7'b1111111; 
        endcase
    end
endfunction

always @(posedge iClk or negedge iRst_n) begin
    if (!iRst_n) begin
        // Turn off all segments (Active Low)
        oHex_Sec  <= 14'b1111111_1111111;
        oHex_Min  <= 14'b1111111_1111111;
        oHex_Hour <= 14'b1111111_1111111;
    end 
    else if (iChipSelect && iWrite) begin
        case (iAddress)
            // Concatenate Tens [7:4] and Ones [3:0] into a 14-bit register
            2'd0: oHex_Sec  <= {decode_7seg(iWriteData[7:4]), decode_7seg(iWriteData[3:0])};
            2'd1: oHex_Min  <= {decode_7seg(iWriteData[7:4]), decode_7seg(iWriteData[3:0])};
            2'd2: oHex_Hour <= {decode_7seg(iWriteData[7:4]), decode_7seg(iWriteData[3:0])};
            default: ; 
        endcase
    end
end

endmodule

