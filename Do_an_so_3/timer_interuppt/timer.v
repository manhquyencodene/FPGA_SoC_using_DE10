module timer (
    input              CLOCK_50,    // Đầu vào xung clock 50MHz
    input       [0:0]  KEY,         // Cần thêm đầu vào KEY để làm Reset
    output wire [6:0]  HEX0,
    output wire [6:0]  HEX1,
    output wire [6:0]  HEX2,
    output wire [6:0]  HEX3,
    output wire [6:0]  HEX4,
    output wire [6:0]  HEX5
);

    // Khởi tạo hệ thống Nios II
    system Nios_system (
        .clk_clk                           (CLOCK_50), // Kết nối xung clock              
        // Kết nối tín hiệu từ Nios II ra các chân LED 7 đoạn vật lý
        .hex_0_external_connection_export  (HEX0), 
        .hex_1_external_connection_export  (HEX1), 
        .hex_2_external_connection_export  (HEX2), 
        .hex_3_external_connection_export  (HEX3), 
        .hex_4_external_connection_export  (HEX4), 
        .hex_5_external_connection_export  (HEX5)  
    );

endmodule