module switches
(
    input iClk,
    input iReset_n,
    input iChip_select_n,
    input iRead_n,
    input [31:0] iSwitches_data,
    output reg [31:0] oSwitches_reg
);

    always @(posedge iClk, negedge iReset_n)
    begin
        if (~iReset_n)
        begin
            oSwitches_reg <= 32'd0;
        end
        else
        begin
            if (~iChip_select_n & ~iRead_n)
            begin
                oSwitches_reg <= iSwitches_data;
            end
        end
    end

endmodule