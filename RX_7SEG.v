module RX_7SEG(
	input [4:0] data,
	output [7:0] LED);

	function [7:0] decode;
	input [4:0] val;
	begin
		case (val)
			5'd0: decode = 8'b11111100;
			5'd1: decode = 8'b01100000;
			5'd2: decode = 8'b11011010;
			5'd3: decode = 8'b11110010;
			5'd4: decode = 8'b01100110;
			5'd5: decode = 8'b10110110;
			5'd6: decode = 8'b10111110;
			5'd7: decode = 8'b11100000;
			5'd8: decode = 8'b11111110;
			5'd9: decode = 8'b11110110;
			5'd10: decode = 8'b11101110;
			5'd11: decode = 8'b00111110;
			5'd12: decode = 8'b00011010;
			5'd13: decode = 8'b01111010;
			5'd14: decode = 8'b10011110;
			5'd15: decode = 8'b10001110;
			5'd16: decode = 8'b00000010; // minus
			default: decode = 8'b00000000;
		endcase
	end
	endfunction

	assign LED = decode(data);
endmodule