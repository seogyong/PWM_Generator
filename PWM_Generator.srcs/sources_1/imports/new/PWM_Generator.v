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

`include "./define.v"


module PWM_Generator(
     input clk,
     input increase_btn, decrease_btn,
     output reg out_PWM, out_PWM_LED
     );
     
     reg[10:0]  counter_PWM;
     reg[27:0]  counter_debounce;
     reg[6:0]   current_DUTY;
     reg        slow_clk_enable;
     wire       duty_inc, duty_dec;
    
    
     // debouncing FFs for increasing & decreasing button
    Button_Debouncing DUTY_INC(clk, slow_clk_enable, increase_btn, duty_inc);
    Button_Debouncing DUTY_DEC(clk, slow_clk_enable, decrease_btn, duty_dec);

    // debouncing setting
    always @(posedge clk) begin
        counter_debounce <= counter_debounce + 1'b1;
        if(counter_debounce >= `SLOW_CLK_CNT)
            counter_debounce <= 0;
    end
    always @(posedge clk) begin
        if (counter_debounce == `SLOW_CLK_CNT)
            slow_clk_enable <= 1'b1;
        else
            slow_clk_enable <= 1'b0;
     end
     
         
    // Create PWM output
    always @(posedge clk) begin
        counter_PWM <= counter_PWM + 1'b1;
        if(counter_PWM >= `PWM_CNT-1)
            counter_PWM <= 0;
    end
    always @(posedge clk) begin
        out_PWM_LED  <= out_PWM;
        if (counter_PWM == 0)
            out_PWM <= 1;
        else if (counter_PWM == `PWM_CNT*current_DUTY/100)
            out_PWM <= 0;
        else
            out_PWM  <= out_PWM;
     end
     
     
     // Change the duty-cycle
     always @(posedge clk) begin
        if(duty_inc==1 && current_DUTY < `DUTY_MAX)
            current_DUTY <= current_DUTY + 10;// increase duty cycle by 10%
        else if(duty_dec==1 && current_DUTY > `DUTY_MIN)
            current_DUTY <= current_DUTY - 10;//decrease duty cycle by 10%
     end
     
     initial begin
         counter_debounce <= 0;     // counter for slow clock enable signals
         counter_PWM <= 0;          // counter for PWM output signal
         current_DUTY <= 'd50;        // initial duty cycle is 50%
         $monitor($time, "  Current Duty = %d[%%]", current_DUTY);    
     end
     
endmodule

