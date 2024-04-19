module ALU (input wire [15:0] in1, in2, //入力
            input wire [1:0] op1, //命令形式
            input wire [3:0] op3, //演算命令
				input wire [3:0] d, //シフト桁
				input wire reset, //リセット信号
				output wire [15:0] out, //演算結果
				output wire [3:0] szcv
				);
  
  wire flag, v0;
  wire [17:0] result;
  assign result = alu(in1,in2,op1,op3,d,reset);
  assign v0 = result[17];
  
  //右シフト系の命令の時は前者の値
  assign flag = (op3 == 4'b1010 | op3 == 4'b1011) ? result[0]: result[16];
  assign out  = (op3 == 4'b1010 | op3 == 4'b1011) ? result[16:1]: result[15:0];
  
  assign szcv[3] = out[15]; //S(sign)
  assign szcv[2] = (out == 16'd0) ? 1'b1 : 1'b0; //Z(zero)
  assign szcv[1] = flag; //C(carry)
  assign szcv[0] = (v0 == 1'b1)? 1'b0:
                   (in1[15] ^ in2[15] == 1'b0) ? 1'b0 :
						 (in1[15] ^ out[15] == 1'b0) ? 1'b0 : 1'b1; //V(overflow)
						 
function [17:0] alu;
  input [15:0] in_1, in_2;
  input [1:0] op_1;
  input [3:0] op_3, d_4;
  input rst;

  begin
	if(rst == 1'b0) begin //リセット
	   alu = 18'b0;
	end else begin
      case(op_3) 
	     4'b0000 : begin //加算(ADD)
		    alu[16:0] = (d_4[3] == 1'b1 && op_1 == 2'b11) 
			           ? {1'b0, in_1} + {14'b0, d[2:0]}
					     : {1'b0, in_1} + {1'b0, in_2};
			 alu[17] = 1'b0;
		  end
		  
		  4'b0001 : begin //減算(SUB)
		    alu[16:0] = (d_4[3] == 1'b1)
					     ? {1'b0, in_1} - {14'b0, d[2:0]}	// 即値演算のときはdは符号なし(3ケタ)
					     : {1'b0, in_1} + {1'b0, (~(in_2)+16'd1)};
			 alu[17] = 1'b0;
		  end
		  
		  4'b0010 : begin //論理積(AND)
		    alu[15:0] = (d_4[3] == 1'b1)
							 ? in_1 & {13'b0, d[2:0]}
							 : in_1 & in_2;
			 alu[16] = 1'b0;
			 alu[17] = 1'b1;
		  end
		  
		  4'b0011 : begin //論理和(OR)
		    alu[15:0] = (d_4[3] == 1'b1)
							 ? in_1 | {13'b0, d[2:0]}
							 : in_1 | in_2;
			 alu[16] = 1'b0;
			 alu[17] = 1'b1;
		  end
		  
		  4'b0100 : begin //排他的論理和(XOR)
		    alu[15:0] = (d_4[3] == 1'b1)
							 ? in_1 ^ {13'b0, d[2:0]}
							 : in_1 ^ in_2;
			 alu[16] = 1'b0;
			 alu[17] = 1'b1;
		  end
		  
		  4'b0101 : begin //比較演算(CMP)
		    alu[16:0] = (d_4[3] == 1'b1)
							 ? {1'b0, in_1} - {14'b0, d[2:0]}
							 : {1'b0, in_1} + {1'b0, (~(in_2)+16'd1)};
			 alu[17] = 1'b0;
		  end
		  
		  4'b0110 : begin //移動演算(MOV)
		    alu[15:0] = (d_4[3] == 1'b1)
							 ? {13'b0, d[2:0]}
							 : in_2;
			 alu[16] = 1'b0;
			 alu[17] = 1'b1;
		  end
		  
		  4'b1000 : begin //左論理シフト(SLL)
		    alu[16:0] = ({1'b0, in_1} << d_4);
			 alu[17] = 1'b1;
		  end
		  
		  4'b1001 : begin //左循環シフト(SLR)
		    alu[15:0] = (in_1 << d_4) | (in_1 >> (5'd16 - {1'b0,d_4}));
		    alu[16] = 0;
			 alu[17] = 1'b1;
		  end
		  
		  4'b1010 : begin //右論理シフト(SRL)
		    alu[16:0] = ({in_1, 1'b0} >> d_4);
			 alu[17] = 1'b1;
		  end
			 
		  4'b1011 : begin //右算術シフト(SRA)
			 alu[16:0] = ({in_1, 1'b0} >> d_4) | ({16{in_1[15]}} << (5'd16-{1'b0,d_4}));
		    alu[17] = 1'b1;
		  end
		  
		  default : begin
			 alu = 18'd0;
		  end
		endcase
	 end
  end
endfunction

endmodule