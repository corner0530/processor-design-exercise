module ALUcontroller(input wire [1:0] op1, //命令形式
                     input wire [3:0] op3_in, 
							output wire [3:0] op3_out //演算命令
							);
  
  
  assign op3_out = ALUcon(op1, op3_in);
  
  function [3:0] ALUcon;
    input [1:0] op1;
	 input [3:0] op3_in;
    case(op1)
	   2'b11 : //演算・入出力形式
		  ALUcon = op3_in;
		
		default :
		  ALUcon = 4'b0000;
    endcase
  endfunction
  
endmodule