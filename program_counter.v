module program_counter (
	input clock, reset,
	input [15:0] DR,
	output [15:0] address);
	
	reg [15:0] val;
	assign address = val;
	
	always @(posedge clock or negedge reset) begin
		if(reset == 1'b0) begin
			val <= 16'b0;
		end else begin
			val <= DR;
		end
	end
	
endmodule