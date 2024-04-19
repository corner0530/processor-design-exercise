module Forwarding(
	input RegWrite3_4, // フェーズ3,4間に格納されているレジスタ書き込み信号
	input RegWrite4_5, // フェーズ4,5間に格納されているレジスタ書き込み信号
	input [2:0] wreg3_4, // フェーズ3,4間に格納されている書き込みレジスタ番号
	input [2:0] wreg4_5, // フェーズ4,5間に格納されている書き込みレジスタ番号
	input [5:0] rsrd2_3, // フェーズ2,3間に格納されている命令[13:8]
								// ALUに入力する二つのレジスタ番号
	output [1:0] ForwardA,ForwardB // 2bitフォワーディング制御信号
);

	assign ForwardA = FORWARD(RegWrite3_4,RegWrite4_5,wreg3_4,wreg4_5,rsrd2_3[5:3]);
	assign ForwardB = FORWARD(RegWrite3_4,RegWrite4_5,wreg3_4,wreg4_5,rsrd2_3[2:0]);
	
	function [1:0] FORWARD;
		input RegWrite3_4;
		input RegWrite4_5;
		input [2:0] wreg3_4;
		input [2:0] wreg4_5;
		input [2:0] ALUreg;
		
		begin
			if ((RegWrite3_4)&&(wreg3_4 == ALUreg)) begin
				FORWARD = 2'b10;
			end else if ((RegWrite4_5)&&(wreg4_5 == ALUreg)) begin
				FORWARD = 2'b01;
			end else begin
				FORWARD = 2'b00;
			end
		end
		
	endfunction

endmodule