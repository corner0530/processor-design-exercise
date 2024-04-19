module chattering( // チャタリング防止モジュール
	input clock, // クロック
	input reset, // リセット
	input in, // 入力信号
	output reg out // 入力信号からチャタリングを除去した信号
);
	parameter ZERO = 16'b0000_0000_0000_0000;

	reg [15:0] count;//65536クロックに一度処理を行う
	
	always @(posedge clock or negedge reset) begin
		if (reset == 1'b0) begin
			count <= 16'd0;
		end else begin
			count <= count + 16'd1;
			if (count == ZERO) begin
				out <= in; 
			end
		end
	end

endmodule