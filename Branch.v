module Branch(input wire [3:0] szcv, //条件コード
              input wire [2:0] cond, //比較命令の選択
				  input wire branch, //条件分岐命令なら1
				  input wire jump, //無条件分岐命令なら1
				  output wire op //分岐結果
				  );
  
  assign op = BRANCH(szcv, cond, branch, jump);
  
  function BRANCH;
    input [3:0] SZCV;
    input [2:0] COND;
    input br;
    input j;
    begin
      if(j) begin
	     BRANCH = 1'b1;
	   end else if(br) begin
        case(COND)
	       3'b000 : BRANCH = SZCV[2]; //BE
		    3'b001 : BRANCH = (SZCV[3] ^ SZCV[0]); //BLT
		    3'b010 : BRANCH = (SZCV[2] | (SZCV[3] ^ SZCV[0])); //BLE
		    3'b011 : BRANCH = ~(SZCV[2]); //BNE
		    default : BRANCH = 1'b0;
	     endcase
      end else begin
	     BRANCH = 1'b0;
	   end
    end
  endfunction

endmodule