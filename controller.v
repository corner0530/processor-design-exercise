module controller(input wire [15:0] inst, //16ビット命令
                  output wire RegDst,RegWrite, ALUSrc, MemRead, MemWrite, MemtoReg, Branch, Jump, LI, Input, Output, Hlt, Calc,
						output wire [1:0] ALUOp);
						
  wire [1:0] op1;
  wire [2:0] op2;
  wire [3:0] op3;
  assign op1 = inst[15:14];
  assign op2 = inst[13:11];
  assign op3 = inst[7:4];
  
  assign RegDst = op1[1]; //書き込みレジスタがinst[10:8]なら1, inst[13:11]なら0
  assign RegWrite = ((op1 == 2'b11) & (op3 <= 4'b1100) & (op3 != 4'b0101)) | (op1 == 2'b00) | ((op1 == 2'b10) & (op2 == 3'b000));
  //レジスタ書き込みなら1
  assign ALUSrc = (op1 != 2'b11); //ALUの入力2が即値なら1, 読み出しデータなら0 
  assign MemRead = (op1 == 2'b00); //メモリ読み出しなら1
  assign MemWrite = (op1 == 2'b01); //メモリ書き込みなら1
  assign MemtoReg = (op1 == 2'b00); //書き込みデータがメモリなら1
  assign Branch = (op1 == 2'b10) & (op2 == 3'b111); //条件分岐命令なら1
  assign Jump = (op1 == 2'b10) & (op2 == 3'b100); //無条件分岐命令なら1
  assign LI = (op1 == 2'b10) & (op2 == 3'b000); //書き込みデータが即値なら1
  assign Input = (op1 == 2'b11) & (op3 == 4'b1100); //書き込みデータが外部入力なら1
  assign Output = (op1 == 2'b11) & (op3 == 4'b1101); //出力命令なら1
  assign Hlt = (op1 == 2'b11) & (op3 == 4'b1111); //停止命令なら1
  assign ALUOp = op1; //命令形式
  assign Calc = (op1 == 2'b11) & (op3 <= 4'b1011);
endmodule

