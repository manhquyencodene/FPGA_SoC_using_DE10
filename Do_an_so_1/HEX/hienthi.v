module hienthi (
    // 1. Khai báo tín hiệu đầu vào (Input)
    input  wire        CLOCK_50, // Xung nhịp 50MHz từ bộ dao động trên board DE10-Standard

    // 2. Khai báo tín hiệu đầu ra (Output) kết nối với 6 LED 7 đoạn 
    // Mỗi LED cần 7 bit để điều khiển 7 thanh sáng/tối [cite: 7, 55, 56]
    output wire [6:0]  HEX0,
    output wire [6:0]  HEX1,
    output wire [6:0]  HEX2,
    output wire [6:0]  HEX3,
    output wire [6:0]  HEX4,
    output wire [6:0]  HEX5,
    
    // Khai báo tín hiệu đầu vào từ Switch
    input  wire [15:0] SW  
);

    // 3. Khởi tạo (Instantiate) module "system" từ Platform Designer
   system u0 (
    .clk_clk       (CLOCK_50),
    .hex0_export   (HEX0),   // ← CHỈ GIỮ NẾU CÓ hex0 trong Platform Designer!
    .hex1_export   (HEX1),
    .hex2_export   (HEX2),
    .hex3_export   (HEX3),
    .hex4_export   (HEX4),
    .hex5_export   (HEX5),
    .switch_export (SW[9:0])  // ← SỬA: chỉ lấy 10 bit
);

endmodule