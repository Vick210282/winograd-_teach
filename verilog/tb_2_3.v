//tb for winograd
`timescale 1ns / 1ps
module tb;
reg  [10*4-1:0] D;
reg  clk, rst;
wire [10*2-1:0] Z;

WC DUT_WC(.clk(clk),
			.rst(rst),
			.D(D),
			.Z(Z)
			);

always #5 clk=~clk;
initial
begin
$fsdbDumpfile("WC.fsdb");
$fsdbDumpvars(0,DUT_WC);
end
initial

begin
clk = 0;
D = 0;
rst = 1;
#10 rst = 0;

D = 40'b0000000010_1111110110_0000000011_0000000100;

#60;
//input1 = [  2 -10   3   4]
//result1 = [37 15]
if (Z == 20'b0000100101_0000001111)
	begin
	$display("---------------------------------------------");
	$display("PASS !!");
	end
else
	begin
	$display("---------------------------------------------");
	$display("FAIL !!");
	end
#10;
D = 40'b1111101101_1111111010_0000000011_1111110111;

#60;
//input2 = [-19  -6   3  -9]
//result2 = [ -43 -138]

if (Z == 20'b1111010101_1101110110)
	begin
	$display("PASS !!");
	$display("---------------------------------------------");
	end
else
	begin
	$display("FAIL !!");
	$display("---------------------------------------------");
	end
#10;

#50 $finish;
end
endmodule
