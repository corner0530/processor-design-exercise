module register (input clock, //書き込みのクロック
                 input wire [2:0] adr_a, adr_b, adr_w, //読み出しレジスタ1,2、書き込みレジスタ
					  input wire RegWrite, //制御信号、書き込みなら1
					  input wire [15:0] Din, //書き込みデータ
					  input reset, //リセット信号
					  output wire  [15:0] Dout1, Dout2 //読み出しデータ1,2
					  );

  reg [15:0] r[7:0];
  
  assign Dout1 = r[adr_a];
  assign Dout2 = r[adr_b];
  
  always @(negedge clock or negedge reset) begin
    if(reset == 1'b0) begin //リセット
	   r[0] <= 16'd0;
		r[1] <= 16'd0;
      r[2] <= 16'd0;
		r[3] <= 16'd0;
		r[4] <= 16'd0;
		r[5] <= 16'd0;
		r[6] <= 16'd0;
		r[7] <= 16'd0;
	 end else if(RegWrite) begin //書き込み
	   r[adr_w] <= Din;
	 end
  end
  
endmodule