module output_device(
	input outp_3,
	input [27:0] out,
	output [7:0] led_a, led_b, led_c, led_d, led_e, led_f, led_g, led_h,
	output [7:0] seg_sel_out );

	// 出力する数値
	wire [27:0] val;
	// 各桁の数字
	wire [4:0] dig_num[0:7];

	// 7セグのインスタンス
	RX_7SEG seg_a(.data(dig_num[7]), .LED(led_a));
	RX_7SEG seg_b(.data(dig_num[6]), .LED(led_b));
	RX_7SEG seg_c(.data(dig_num[5]), .LED(led_c));
	RX_7SEG seg_d(.data(dig_num[4]), .LED(led_d));
	RX_7SEG seg_e(.data(dig_num[3]), .LED(led_e));
	RX_7SEG seg_f(.data(dig_num[2]), .LED(led_f));
	RX_7SEG seg_g(.data(dig_num[1]), .LED(led_g));
	RX_7SEG seg_h(.data(dig_num[0]), .LED(led_h));

	// out[15]は符号
	// 符号に応じて反転
	assign val = (out[27] == 1'b1) ? (~(out - 28'b1)) : out;
	// 符号を表示
	assign dig_num[7] = (out[27] == 1'b1) ? 5'd16 : 5'd31;
	// 16進数のときの各桁の数字を格納
	assign dig_num[6] = {1'b0, val[26:24]};
	assign dig_num[5] = {1'b0, val[23:20]};
	assign dig_num[4] = {1'b0, val[19:16]};
	assign dig_num[3] = {1'b0, val[15:12]};
	assign dig_num[2] = {1'b0, val[11:8]};
	assign dig_num[1] = {1'b0, val[7:4]};
	assign dig_num[0] = {1'b0, val[3:0]};
	// セレクタ
	assign seg_sel_out = {7'b0, outp_3};
endmodule
