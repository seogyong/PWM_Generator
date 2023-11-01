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


`define SLOW_CLK_CNT 4000  // 25000000 for 4Hz, This value should be larger than PWM_CNT
`define PWM_CNT 1000  // 1000 for 100kHz, 10 for 10MHz
`define DUTY_MAX 90
`define DUTY_MIN 10
