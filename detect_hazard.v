module detect_hazard(
	input MemRead, //前命令のMemRead
	input [2:0] pre_Rt, //前命令のレジスタ書き込み先
	input [15:0] inst, //現在の命令
	output hazard //ハザード信号
);
  
  assign hazard = det_hazard(MemRead, pre_Rt, inst);
  
  function det_hazard;
	 input MemRead;
	 input [2:0] pre_Rt;
	 input [15:0] inst;
	  
	 if(MemRead) begin //LD->レジスタ読み出しなら1回ストール
	   if(inst[15:14] == 2'b11) begin 
		  if(inst[7:4] <= 4'b0110) begin 
		    det_hazard = (((pre_Rt == inst[13:11]) & (inst[3] == 1'b0)) | pre_Rt == inst[10:8])? 1'b1: 1'b0;
		  end else if(inst[7:4] == 4'b1101) begin
		    det_hazard = (pre_Rt == inst[13:11])? 1'b1: 1'b0;
		  end else if(inst[7:4] >= 4'b1000 & inst[7:4] <= 4'b1011) begin
		    det_hazard = (pre_Rt == inst[10:8])? 1'b1: 1'b0;
		  end else begin
		    det_hazard = 1'b0;
		  end
		end else if(inst[15:14] == 2'b00) begin
		  det_hazard = (pre_Rt == inst[10:8])? 1'b1: 1'b0;
	   end else if(inst[15:14] == 2'b01) begin
	     det_hazard = (pre_Rt == inst[13:11])? 1'b1: 1'b0;
	   end else begin
	     det_hazard = 1'b0;
	   end
	 end
  endfunction
  
endmodule