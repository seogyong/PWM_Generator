//////////////////////////////////////////////////////////////////////////////////
// Author: Seogyong Jeong
// Affiliation: Samsung Electronics
// Email: seogyong86@gmail.com

// Create Date: 2023/11/01

// Tool Versions: Vivado 2023.2
// Module Name: PWM_Generator
// Target Devices: Arty A7-35

// Module Name: PWM_Generator

// Description: 

// Dependencies: 
// 
// Additional Comments:
// seperate the source code : "PWM_Generator.v" "Button_Debouncing.v" "define.v" 
//////////////////////////////////////////////////////////////////////////////////


// Debouncing module for push buttons on FPGA
module Button_Debouncing(
    input clk,
    input en,
    input signal,
    output single_pulse
    );
    
    wire Q1, Q2;
    
    DFF DFF1(clk, en, signal, Q1);
    DFF DFF2(clk, en, Q1, Q2); 
    assign single_pulse = Q1 & (~ Q2) & en;
endmodule


// D-FlipFlop
module DFF(
    input clk,
    input en,
    input D,
    output reg Q
    );

    always @(posedge clk) begin 
        if(en==1) // slow clock enable signal 
            Q <= D;
    end 
endmodule
