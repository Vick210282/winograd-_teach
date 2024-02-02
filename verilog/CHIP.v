//CHIP io for winograd
module CHIP (clk, rst, D, Z);

	input clk, rst;
	input [10*4-1:0] D;
	output [10*2-1:0] Z;

	wire i_clk, i_rst;
	wire [10*4-1:0] i_D;
	wire [10*2-1:0] i_Z;

	wire n_Logic0_, n_Logic1_;

	WC top (.rst(i_rst), .clk(i_clk), .D(i_D), .Z(i_Z));

	XMC ipad_CLK    ( .I(clk), .PU(n_Logic0_), .PD(n_Logic0_), .SMT(n_Logic0_), .O(i_clk) );
	XMC ipad_RESET_ ( .I(rst), .PU(n_Logic0_), .PD(n_Logic0_), .SMT(n_Logic0_), .O(i_rst) );

	XMC ipad_D0 ( .I(D[0]), .PU(n_Logic0_), .PD(n_Logic0_), .SMT(n_Logic0_), .O(i_D[0]) );
	XMC ipad_D1 ( .I(D[1]), .PU(n_Logic0_), .PD(n_Logic0_), .SMT(n_Logic0_), .O(i_D[1]) );
	XMC ipad_D2 ( .I(D[2]), .PU(n_Logic0_), .PD(n_Logic0_), .SMT(n_Logic0_), .O(i_D[2]) );
	XMC ipad_D3 ( .I(D[3]), .PU(n_Logic0_), .PD(n_Logic0_), .SMT(n_Logic0_), .O(i_D[3]) );
	XMC ipad_D4 ( .I(D[4]), .PU(n_Logic0_), .PD(n_Logic0_), .SMT(n_Logic0_), .O(i_D[4]) );
	XMC ipad_D5 ( .I(D[5]), .PU(n_Logic0_), .PD(n_Logic0_), .SMT(n_Logic0_), .O(i_D[5]) );
	XMC ipad_D6 ( .I(D[6]), .PU(n_Logic0_), .PD(n_Logic0_), .SMT(n_Logic0_), .O(i_D[6]) );
	XMC ipad_D7 ( .I(D[7]), .PU(n_Logic0_), .PD(n_Logic0_), .SMT(n_Logic0_), .O(i_D[7]) );
	XMC ipad_D8 ( .I(D[8]), .PU(n_Logic0_), .PD(n_Logic0_), .SMT(n_Logic0_), .O(i_D[8]) );
	XMC ipad_D9 ( .I(D[9]), .PU(n_Logic0_), .PD(n_Logic0_), .SMT(n_Logic0_), .O(i_D[9]) );
	XMC ipad_D10 ( .I(D[10]), .PU(n_Logic0_), .PD(n_Logic0_), .SMT(n_Logic0_), .O(i_D[10]) );
	XMC ipad_D11 ( .I(D[11]), .PU(n_Logic0_), .PD(n_Logic0_), .SMT(n_Logic0_), .O(i_D[11]) );
	XMC ipad_D12 ( .I(D[12]), .PU(n_Logic0_), .PD(n_Logic0_), .SMT(n_Logic0_), .O(i_D[12]) );
	XMC ipad_D13 ( .I(D[13]), .PU(n_Logic0_), .PD(n_Logic0_), .SMT(n_Logic0_), .O(i_D[13]) );
	XMC ipad_D14 ( .I(D[14]), .PU(n_Logic0_), .PD(n_Logic0_), .SMT(n_Logic0_), .O(i_D[14]) );
	XMC ipad_D15 ( .I(D[15]), .PU(n_Logic0_), .PD(n_Logic0_), .SMT(n_Logic0_), .O(i_D[15]) );
	XMC ipad_D16 ( .I(D[16]), .PU(n_Logic0_), .PD(n_Logic0_), .SMT(n_Logic0_), .O(i_D[16]) );
	XMC ipad_D17 ( .I(D[17]), .PU(n_Logic0_), .PD(n_Logic0_), .SMT(n_Logic0_), .O(i_D[17]) );
	XMC ipad_D18 ( .I(D[18]), .PU(n_Logic0_), .PD(n_Logic0_), .SMT(n_Logic0_), .O(i_D[18]) );
	XMC ipad_D19 ( .I(D[19]), .PU(n_Logic0_), .PD(n_Logic0_), .SMT(n_Logic0_), .O(i_D[19]) );
	XMC ipad_D20 ( .I(D[20]), .PU(n_Logic0_), .PD(n_Logic0_), .SMT(n_Logic0_), .O(i_D[20]) );
	XMC ipad_D21 ( .I(D[21]), .PU(n_Logic0_), .PD(n_Logic0_), .SMT(n_Logic0_), .O(i_D[21]) );
	XMC ipad_D22 ( .I(D[22]), .PU(n_Logic0_), .PD(n_Logic0_), .SMT(n_Logic0_), .O(i_D[22]) );
	XMC ipad_D23 ( .I(D[23]), .PU(n_Logic0_), .PD(n_Logic0_), .SMT(n_Logic0_), .O(i_D[23]) );
	XMC ipad_D24 ( .I(D[24]), .PU(n_Logic0_), .PD(n_Logic0_), .SMT(n_Logic0_), .O(i_D[24]) );
	XMC ipad_D25 ( .I(D[25]), .PU(n_Logic0_), .PD(n_Logic0_), .SMT(n_Logic0_), .O(i_D[25]) );
	XMC ipad_D26 ( .I(D[26]), .PU(n_Logic0_), .PD(n_Logic0_), .SMT(n_Logic0_), .O(i_D[26]) );
	XMC ipad_D27 ( .I(D[27]), .PU(n_Logic0_), .PD(n_Logic0_), .SMT(n_Logic0_), .O(i_D[27]) );
	XMC ipad_D28 ( .I(D[28]), .PU(n_Logic0_), .PD(n_Logic0_), .SMT(n_Logic0_), .O(i_D[28]) );
	XMC ipad_D29 ( .I(D[29]), .PU(n_Logic0_), .PD(n_Logic0_), .SMT(n_Logic0_), .O(i_D[29]) );
	XMC ipad_D30 ( .I(D[30]), .PU(n_Logic0_), .PD(n_Logic0_), .SMT(n_Logic0_), .O(i_D[30]) );
	XMC ipad_D31 ( .I(D[31]), .PU(n_Logic0_), .PD(n_Logic0_), .SMT(n_Logic0_), .O(i_D[31]) );
	XMC ipad_D32 ( .I(D[32]), .PU(n_Logic0_), .PD(n_Logic0_), .SMT(n_Logic0_), .O(i_D[32]) );
	XMC ipad_D33 ( .I(D[33]), .PU(n_Logic0_), .PD(n_Logic0_), .SMT(n_Logic0_), .O(i_D[33]) );
	XMC ipad_D34 ( .I(D[34]), .PU(n_Logic0_), .PD(n_Logic0_), .SMT(n_Logic0_), .O(i_D[34]) );
	XMC ipad_D35 ( .I(D[35]), .PU(n_Logic0_), .PD(n_Logic0_), .SMT(n_Logic0_), .O(i_D[35]) );
	XMC ipad_D36 ( .I(D[36]), .PU(n_Logic0_), .PD(n_Logic0_), .SMT(n_Logic0_), .O(i_D[36]) );
	XMC ipad_D37 ( .I(D[37]), .PU(n_Logic0_), .PD(n_Logic0_), .SMT(n_Logic0_), .O(i_D[37]) );
	XMC ipad_D38 ( .I(D[38]), .PU(n_Logic0_), .PD(n_Logic0_), .SMT(n_Logic0_), .O(i_D[38]) );
	XMC ipad_D39 ( .I(D[39]), .PU(n_Logic0_), .PD(n_Logic0_), .SMT(n_Logic0_), .O(i_D[39]) );

	YA2GSC opad_Z0 ( .I(i_Z[0]), .E(n_Logic1_), .E2(n_Logic1_), .E4(n_Logic1_), .E8(n_Logic1_), .SR(n_Logic1_), .O(Z[0]));
	YA2GSC opad_Z1 ( .I(i_Z[1]), .E(n_Logic1_), .E2(n_Logic1_), .E4(n_Logic1_), .E8(n_Logic1_), .SR(n_Logic1_), .O(Z[1]));
	YA2GSC opad_Z2 ( .I(i_Z[2]), .E(n_Logic1_), .E2(n_Logic1_), .E4(n_Logic1_), .E8(n_Logic1_), .SR(n_Logic1_), .O(Z[2]));
	YA2GSC opad_Z3 ( .I(i_Z[3]), .E(n_Logic1_), .E2(n_Logic1_), .E4(n_Logic1_), .E8(n_Logic1_), .SR(n_Logic1_), .O(Z[3]));
	YA2GSC opad_Z4 ( .I(i_Z[4]), .E(n_Logic1_), .E2(n_Logic1_), .E4(n_Logic1_), .E8(n_Logic1_), .SR(n_Logic1_), .O(Z[4]));
	YA2GSC opad_Z5 ( .I(i_Z[5]), .E(n_Logic1_), .E2(n_Logic1_), .E4(n_Logic1_), .E8(n_Logic1_), .SR(n_Logic1_), .O(Z[5]));
	YA2GSC opad_Z6 ( .I(i_Z[6]), .E(n_Logic1_), .E2(n_Logic1_), .E4(n_Logic1_), .E8(n_Logic1_), .SR(n_Logic1_), .O(Z[6]));
	YA2GSC opad_Z7 ( .I(i_Z[7]), .E(n_Logic1_), .E2(n_Logic1_), .E4(n_Logic1_), .E8(n_Logic1_), .SR(n_Logic1_), .O(Z[7]));
	YA2GSC opad_Z8 ( .I(i_Z[8]), .E(n_Logic1_), .E2(n_Logic1_), .E4(n_Logic1_), .E8(n_Logic1_), .SR(n_Logic1_), .O(Z[8]));
	YA2GSC opad_Z9 ( .I(i_Z[9]), .E(n_Logic1_), .E2(n_Logic1_), .E4(n_Logic1_), .E8(n_Logic1_), .SR(n_Logic1_), .O(Z[9]));
	YA2GSC opad_Z10 ( .I(i_Z[10]), .E(n_Logic1_), .E2(n_Logic1_), .E4(n_Logic1_), .E8(n_Logic1_), .SR(n_Logic1_), .O(Z[10]));
	YA2GSC opad_Z11 ( .I(i_Z[11]), .E(n_Logic1_), .E2(n_Logic1_), .E4(n_Logic1_), .E8(n_Logic1_), .SR(n_Logic1_), .O(Z[11]));
	YA2GSC opad_Z12 ( .I(i_Z[12]), .E(n_Logic1_), .E2(n_Logic1_), .E4(n_Logic1_), .E8(n_Logic1_), .SR(n_Logic1_), .O(Z[12]));
	YA2GSC opad_Z13 ( .I(i_Z[13]), .E(n_Logic1_), .E2(n_Logic1_), .E4(n_Logic1_), .E8(n_Logic1_), .SR(n_Logic1_), .O(Z[13]));
	YA2GSC opad_Z14 ( .I(i_Z[14]), .E(n_Logic1_), .E2(n_Logic1_), .E4(n_Logic1_), .E8(n_Logic1_), .SR(n_Logic1_), .O(Z[14]));
	YA2GSC opad_Z15 ( .I(i_Z[15]), .E(n_Logic1_), .E2(n_Logic1_), .E4(n_Logic1_), .E8(n_Logic1_), .SR(n_Logic1_), .O(Z[15]));
	YA2GSC opad_Z16 ( .I(i_Z[16]), .E(n_Logic1_), .E2(n_Logic1_), .E4(n_Logic1_), .E8(n_Logic1_), .SR(n_Logic1_), .O(Z[16]));
	YA2GSC opad_Z17 ( .I(i_Z[17]), .E(n_Logic1_), .E2(n_Logic1_), .E4(n_Logic1_), .E8(n_Logic1_), .SR(n_Logic1_), .O(Z[17]));
	YA2GSC opad_Z18 ( .I(i_Z[18]), .E(n_Logic1_), .E2(n_Logic1_), .E4(n_Logic1_), .E8(n_Logic1_), .SR(n_Logic1_), .O(Z[18]));
	YA2GSC opad_Z19 ( .I(i_Z[19]), .E(n_Logic1_), .E2(n_Logic1_), .E4(n_Logic1_), .E8(n_Logic1_), .SR(n_Logic1_), .O(Z[19]));

	TIE0 U1 ( .O(n_Logic0_) );
	TIE1 U2 ( .O(n_Logic1_) );

endmodule
