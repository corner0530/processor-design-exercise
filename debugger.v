module debugger(
	input reset, clock,
	input [15:0] out, pc,
	input [3:0] szcv,
	output [7:0] led_a, led_b, led_c, led_d, led_e, led_f, led_g, led_h,
	output [7:0] seg_sel_out );

	// 出力する数値
	reg [15:0] val;
	// セレクタ
	reg [7:0] seg_sel;
	// 各桁の数字
	reg [4:0] dig_num[0:7];
	// 7セグ1つ1つのセレクタ(使用用途はない)
	wire [7:0] seg_sele;
	// 符号(1:負 0:正)
	reg sign;
	
	// 7セグのインスタンス
	RX_7SEG seg_a(.data(dig_num[7]), .LED(led_a));
	RX_7SEG seg_b(.data(dig_num[6]), .LED(led_b));
	RX_7SEG seg_c(.data(dig_num[5]), .LED(led_c));
	RX_7SEG seg_d(.data(dig_num[4]), .LED(led_d));
	RX_7SEG seg_e(.data(dig_num[3]), .LED(led_e));
	RX_7SEG seg_f(.data(dig_num[2]), .LED(led_f));
	RX_7SEG seg_g(.data(dig_num[1]), .LED(led_g));
	RX_7SEG seg_h(.data(dig_num[0]), .LED(led_h));
	
	assign seg_sel_out = seg_sel;
	
	always @(posedge clock or negedge reset) begin
		if (reset == 1'b0) begin
			val <= 0;
			sign <= 0;
			dig_num[7] <= 0;
			dig_num[6] <= 0;
			dig_num[5] <= 0;
			dig_num[4] <= 0;
			dig_num[3] <= 0;
			dig_num[2] <= 0;
			dig_num[1] <= 0;
			dig_num[0] <= 0;
		end else begin
			// セレクタによって選んだ出力値を代入
			if (seg_sel == 8'b0000_0010) begin
				sign <= szcv[3];
				val = (sign == 1'b1) ? (~(out - 16'b1)) : out;
			end else if (seg_sel == 8'b0000_1000) begin
				sign <= 0;
				val = pc;
			end else begin
				sign <= 0;
				val = {12'b0, szcv};
			end

			// 各桁の数字を代入
			if (seg_sel == 8'b0000_0010 || seg_sel == 8'b0000_1000) begin
				dig_num[7] = (val / 10000000 == 0) ? ((sign == 1'b1) ? 5'd16 : 5'd31) : val / 10000000;
				dig_num[6] = (val / 1000000 == 0) ? ((sign == 1'b1) ? 5'd16 : 5'd31) : (val % 10000000) / 1000000;
				dig_num[5] = (val / 100000 == 0) ? ((sign == 1'b1) ? 5'd16 : 5'd31) : (val % 1000000) / 100000;
				dig_num[4] = (val / 10000 == 0) ? ((sign == 1'b1) ? 5'd16 : 5'd31) : (val % 100000) / 10000;
				dig_num[3] = (val / 1000 == 0) ? ((sign == 1'b1) ? 5'd16 : 5'd31) : (val % 10000) / 1000;
				dig_num[2] = (val / 100 == 0) ? ((sign == 1'b1) ? 5'd16 : 5'd31) : (val % 1000) / 100;
				dig_num[1] = (val / 10 == 0) ? ((sign == 1'b1) ? 5'd16 : 5'd31) : (val % 100) / 10;
				dig_num[0] = val % 10;
			end else begin
				dig_num[7] = (val / 8'b10000000 == 0) ? ((sign == 1'b1) ? 5'd16 : 5'd31) : val / 8'b10000000;
				dig_num[6] = (val / 8'b1000000 == 0) ? ((sign == 1'b1) ? 5'd16 : 5'd31) : (val % 8'b10000000) / 8'b1000000;
				dig_num[5] = (val / 8'b100000 == 0) ? ((sign == 1'b1) ? 5'd16 : 5'd31) : (val % 8'b1000000) / 8'b100000;
				dig_num[4] = (val / 8'b10000 == 0) ? ((sign == 1'b1) ? 5'd16 : 5'd31) : (val % 8'b100000) / 8'b10000;
				dig_num[3] = (val / 8'b1000 == 0) ? ((sign == 1'b1) ? 5'd16 : 5'd31) : (val % 8'b10000) / 8'b1000;
				dig_num[2] = (val / 8'b100 == 0) ? ((sign == 1'b1) ? 5'd16 : 5'd31) : (val % 8'b1000) / 8'b100;
				dig_num[1] = (val / 8'b10 == 0) ? ((sign == 1'b1) ? 5'd16 : 5'd31) : (val % 8'b100) / 8'b10;
				dig_num[0] = val % 8'b10;/*
				dig_num[7] = val / 8'b10000000;
				dig_num[6] = (val % 8'b10000000) / 8'b1000000;
				dig_num[5] = (val % 8'b1000000) / 8'b100000;
				dig_num[4] = (val % 8'b100000) / 8'b10000;
				dig_num[3] = (val % 8'b10000) / 8'b1000;
				dig_num[2] = (val % 8'b1000) / 8'b100;
				dig_num[1] = (val % 8'b100) / 8'b10;
				dig_num[0] = val % 8'b10;*/
			end
		end
	end

	always @(negedge clock or negedge reset) begin
		if (reset == 1'b0) begin
			// 全て0に
			seg_sel <= 8'b1111_1111;
		end else begin
			// セレクタを動かす(ダイナミック点灯)
			if (seg_sel == 8'b0000_0010) seg_sel <= 8'b0000_1000;
			else if (seg_sel == 8'b0000_1000) seg_sel <= 8'b0010_0000;
			else seg_sel <= 8'b0000_0010;
		end
	end
	
endmodule