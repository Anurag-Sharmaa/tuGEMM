`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 23.09.2024 11:17:38
// Design Name: 
// Module Name: tuGEMM_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module tuGEMM_tb();
reg clk=0;
reg rst;
reg [31:0] vector_a;
reg [31:0] vector_b;

tuGEMM uut (
clk,
rst,
vector_a,
vector_b
    );

always #5 clk = ~clk;

initial begin
 rst = 1;
 #10
 
 rst = 0;
// negative values
//vector_a = 32'b11001011001011000001111011110110; // negative values

//vector_b = 32'b11100111001011011100101000010010; // negative values


// positive values
//vector_a = 128'b00010000000011110000111000001101000011000000101100001010000010010000100000000111000001100000010100000100000000110000001000000001;
vector_a = 32'b00000100000000110000001000000001;
//vector_b = 128'b00000001000000100000010000000010000000100000001100000100000001010000010100000100000000110000001000000011000001000000001000000001;
vector_b = 32'b00001000000001110000011000000101;
//#1235
//$finish();
end



endmodule

//module tb();
//reg clk = 0;
//reg rst;
//reg [7:0]a;
//reg [7:0]b;
//wire [7:0] out;

//adder uut (
//clk,
// rst,
// a,
// b,
// out
//);

//always #5 clk = ~clk;

//initial begin
//rst = 1;
//#10
//rst = 0;
//a = 5;
//b = 2;
//#10
//a = 2;
//b= 2;
//end
//endmodule
