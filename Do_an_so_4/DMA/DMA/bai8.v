module bai8(
    input  CLOCK_50,    // Tín hiệu clock 50MHz từ board mạch [cite: 435]
    input  [0:0] KEY    // Tín hiệu reset từ nút nhấn KEY[0] [cite: 436, 437, 444]
);

    // Khởi tạo hệ thống Nios II đã generate từ Platform Designer [cite: 438]
    system Nios_system (
        .clk_clk       (CLOCK_50), // Kết nối nguồn xung clock [cite: 439, 440]
        .reset_reset_n (KEY[0])    // Kết nối tín hiệu reset (tích cực mức thấp) [cite: 444]
    );

endmodule