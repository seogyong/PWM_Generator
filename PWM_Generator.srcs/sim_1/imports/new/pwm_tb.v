`timescale 1ns / 100ps

//////////////////////////////////////////////////////////////////////////////////
// Company: Samsung
// Engineer: seogyong Jeong
// 
// Create Date: 2022/07/06 22:50:16
// Design Name: Exam_2_PWM
// Module Name: PWM_Generator
// Project Name: Exam_2_PWM 
// Target Devices: Arty A7-35
// Tool Versions: Vivado 2022.1
// Description: 
// 
// Dependencies: 
// 
// Revision:0.02 - seperate "define.v"
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module PWM_Generator_tb;
    reg clk;
    reg increase_btn;
    reg decrease_btn;
    wire out_PWM;
      
PWM_Generator u_PWM(
    .clk(clk),
    .increase_btn(increase_btn), 
    .decrease_btn(decrease_btn), 
    .out_PWM(out_PWM)
 );


 // Create 100Mhz clock
initial begin
    clk <= 1'b1;
    forever
        #5 clk <= ~clk;
end 
 
 // Create button state
initial begin
    increase_btn <= 1'b0;
    decrease_btn <= 1'b0;
    #60000; 
    increase_btn = 1;       #1000;
    increase_btn = 0;       #1000; 
    increase_btn = 1;       #1500;
    increase_btn = 0;       #40000; 
    increase_btn = 1;       #40000;
    increase_btn = 0;       #30000; 
    increase_btn = 1;       #90000;
    increase_btn = 0;       #50000;
    decrease_btn = 1;       #40000;
    decrease_btn = 0;       #120000;
    
    repeat(10) begin
        decrease_btn = 1;   #80000;
        decrease_btn = 0;   #120000;
    end
end
endmodule