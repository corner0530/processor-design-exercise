module processor(
	input clock,reset,exec, // クロック、リセット、実行・停止信号。reset,execは負論理
	input [15:0] in, // 機器からの入力
	/* 以下実機デバッグ時に使用 */
	output [7:0] LED_a, LED_b, LED_c, LED_d, LED_e, LED_f, LED_g, LED_h,//LEDへの出力
	output [7:0] SEL //セレクタ
	/* 以下シミュレーション時に使用 */
	/*// 実行・停止処理
	output exec_chrm_sim,
	output exec_pushed_sim,
	output EXECUTION_sim,
	output [1:0] STOP_sim, 
	// フェーズ1・命令フェッチ(IF)
	output [15:0] pcadr_sim,
	output [15:0] pc_1_sim,
	output [15:0] IR_1_sim,
	output [15:0] PC_1_sim,
	// フェーズ2・命令デコード&レジスタ読み出し(ID)
	output [15:0] pc_2_sim,
	output [15:0] ir_2_sim,
	output [1:0] op1_2_sim,
	output alus_2_sim,
	output rd_2_sim,
	output li_2_sim,
	output outp_2_sim,
	output calc_2_sim,
	output br_2_sim,
	output jump_2_sim,
	output mr_2_sim,
	output mw_2_sim,
	output inp_2_sim,
	output rw_2_sim,
	output mtr_2_sim,
	output hlt_sim,
	output hazard_sim,
	output [2:0] r_a_sim,
	output [2:0] r_b_sim,
	output [15:0] a_r_sim,
	output [15:0] b_r_sim,
	output br_rslt_sim,
	output [15:0] bradr_sim,
	output [15:0] AR_sim, BR_sim,
	output [6:0] EX_2_sim, 
	output [1:0] M_2_sim,
	output [2:0] WB_2_sim,
	output [13:0] IR_2_sim,
	// フェーズ3・命令実行(EX)
	output [1:0] op1_3_sim,
	output [3:0] op3_3_sim,
	output alus_3_sim,
	output rd_3_sim,
	output li_3_sim,
	output outp_3_sim,
	output [1:0] forwardA_sim,
	output [1:0] forwardB_sim,
	output [3:0] szcv_3_sim,
	output [15:0] rdrb_sim,
	output [15:0] rsra_sim,
	output [15:0] dr_3_sim,
	output [15:0] ext_d_sim,
	output [15:0] rsra_forward_sim,
	output [7:0] d_sim,
	output [3:0] ALUop3_sim,
	output [3:0] d_calc_sim,
	output [2:0] wreg3_sim,
	output [3:0] szcv_sim,
	output [15:0] DR_sim,
	output [15:0] AR_3_sim,
	output [1:0] M_3_sim,
	output [2:0] WB_3_sim,
	output [2:0] WREG_3_sim,
	output [5:0] IR_3_sim,
	output [3:0] SZCV_sim,
	output mr_4_sim,
	output mw_4_sim,
	output outp_4_sim,
	output [15:0] ar_4_sim,
	output [15:0] m_out_sim,
	output [15:0] MDR_sim,
	output [15:0] DR_4_sim,
	output [2:0] WB_4_sim,
	output [2:0] WREG_4_sim,
	output [15:0] pcout_sim,
	output [15:0] inst_sim,
	output [15:0] wdata_sim,
	output [2:0] r_w_sim,
	output inp_5_sim,
	output rw_5_sim,
	output mtr_5_sim,
	output [15:0] out_sim // 出力命令で出力する値
	output [27:0] out_sim // 出力命令で出力する値*/
);
	parameter POS = 1'b1;
	parameter NEG = 1'b0;
	parameter [15:0] nop = 16'b1100_0000_1110_0000;

/* simulation */

	/*// 実行・停止処理
	assign exec_chrm_sim = exec_chrm;		// チャタリングを除去したexec信号 CHattering ReMoved
	assign exec_pushed_sim = exec_pushed;	// execが押されているかを格納
	assign EXECUTION_sim = EXECUTION;		// 実行中(1),停止中(0)
	assign STOP_sim = STOP;						// 停止時、各フェーズを順番に停止させる為の判定

	// フェーズ1・命令フェッチ(IF)
	assign pcadr_sim = pcadr;					// アドレス線。現在のＰＣの値
	assign pc_1_sim = pc_1; 					// 次のPCの値
	assign IR_1_sim = IR_1;						// 命令を格納
	assign PC_1_sim = PC_1;						// 次のPCを格納

	// フェーズ2・命令デコード&レジスタ読み出し(ID)
	//  制御線
	assign pc_2_sim = pc_2;						// PC値
	assign ir_2_sim = ir_2;						// 16bit命令
	//   フェーズ3で使用する制御線(EX) 5bit
	assign op1_2_sim = op1_2;					// ALUOp,		命令形式
	assign alus_2_sim = alus_2;				// ALUSrc,		ALUの入力2が即値なら1, 読み出しデータなら0
	assign rd_2_sim = rd_2;						// RegDst,		書き込みレジスタがinst[10:8]なら1, inst[13:11]なら0
	assign li_2_sim = li_2;						// LI,			書き込みデータが即値なら1
	assign outp_2_sim = outp_2;				// Output,		出力命令なら1
	assign calc_2_sim = calc_2;
	//   フェーズ4で使用する制御線(M) 5bit
	assign br_2_sim = br_2;						// Branch,		条件分岐命令なら1
	assign jump_2_sim = jump_2;				// Jump,			無条件分岐命令なら1
	assign mr_2_sim = mr_2;						// MemRead,		メモリ読み出しなら1
	assign mw_2_sim = mw_2;						// MemWrite,	メモリ書き込みなら1
	//   フェーズ5で使用する制御線(WB) 3bit
	assign inp_2_sim = inp_2;					// Input,		書き込みデータが外部入力なら1
	assign rw_2_sim = rw_2;						// RegWrite,	レジスタ書き込みなら1
	assign mtr_2_sim = mtr_2;					// MemtoReg,	書き込みデータがメモリなら1
	
	assign hlt_sim = hlt;						// Hlt,			停止命令なら1
	assign hazard_sim = hazard;            // ハザード信号、1ならストールさせる
	
	//  レジスタ入出力線
	assign r_a_sim = r_a;						// レジスタから読み出した値
	assign r_b_sim = r_b;						//
	assign b_r_sim = b_r;
	assign a_r_sim = a_r;
	assign br_rslt_sim = br_rslt;
	assign bradr_sim = bradr;
	//  レジスタ書き込み
	assign AR_sim = AR;							// 読み出しデータ
	assign BR_sim = BR;							//
	assign EX_2_sim = EX_2;						// 制御線
	assign M_2_sim = M_2;						//
	assign WB_2_sim = WB_2;						// 制御線WB
	assign IR_2_sim = IR_2;						// 命令の[13:0]
	// フェーズ3・命令実行(EX)
	//  制御線
	assign op1_3_sim = op1_3;					// ALUOp,	命令形式
	assign op3_3_sim = op3_3;					// op3
	assign alus_3_sim = alus_3;				// ALUSrc,	ALUの入力2が即値なら1, 読み出しデータなら0
	assign rd_3_sim = rd_3;						// RegDst,	書き込みレジスタがinst[10:8]なら1, inst[13:11]なら0
	assign li_3_sim = li_3;						// LI,		書き込みデータが即値なら1
	assign outp_3_sim = outp_3;				// Output,	出力命令なら1
	assign forwardA_sim = forwardA;
	assign forwardB_sim = forwardB;
	assign szcv_3_sim = szcv_3;

	assign rdrb_sim = rdrb;						// ALUへの入力
	assign rsra_sim = rsra;						//
	assign dr_3_sim = dr_3;						// ALUからの出力
	assign ext_d_sim = ext_d;					// 符号拡張したd
	assign rsra_forward_sim = rsra_forward;// フォワーディング処理したAR
	assign d_sim = d;								// IR[7:0]
	assign ALUop3_sim = ALUop3;					// 演算命令
	assign d_calc_sim = d_calc;				// IR[3:0]
	assign wreg3_sim = wreg_3;					// 書き込みレジスタ
	assign szcv_sim = szcv;						// 条件コード
	//  レジスタ書き込み
	assign DR_sim = DR; 							// 演算結果
	assign AR_3_sim = AR_3;						// メモリ書き込みデータAR
	assign M_3_sim = M_3;						// 制御線M
	assign WB_3_sim = WB_3;						// 制御線WB
	assign WREG_3_sim = WREG_3;				// 書き込みレジスタ
	assign IR_3_sim = IR_3;						// 命令のIR[13:8]
	assign SZCV_sim = SZCV;						// 条件コード

	// フェーズ4・メモリアクセス(MEM)
	assign mr_4_sim =	mr_4;						// MemRead,		メモリ読み出しなら1
	assign mw_4_sim =	mw_4;						// MemWrite,	メモリ書き込みなら1
	assign ar_4_sim = ar_4;						// メモリに書き込むデータ
	//  メモリ読み出し
	assign m_out_sim = m_out;					// データメモリからの出力線
	//  レジスタ書き込み
	assign MDR_sim = MDR;					   // メモリから読み出した値または外部入力
	assign DR_4_sim = DR_4;						// DR
	assign WB_4_sim = WB_4;						// 制御線WB
	assign WREG_4_sim = WREG_4;				// 書き込みレジスタ

	// フェーズ5・書き戻し(WB)
	//  プログラムカウンタの処理
	assign pcout_sim = pcout;						// PCに入る値
	//  命令読み出し(クロックの立ち下がりで読み出し)
	assign inst_sim = inst;						// 命令メモリからの出力線
	//  レジスタ書き込み
	assign wdata_sim = wdata;					// 書き込みデータ
	assign r_w_sim = r_w;						// 書き込みレジスタ
	assign inp_5_sim = inp_5;					// Input,		書き込みデータが外部入力なら1
	assign rw_5_sim = rw_5;						// RegWrite,	レジスタ書き込みなら1
	assign mtr_5_sim = mtr_5;					// MemtoReg,	書き込みデータがメモリなら1

	// 外部出力
	assign out_sim = out;						// 出力命令で出力する値

/* 実行・停止処理 */
	wire exec_chrm;	// チャタリングを除去したexec信号 CHattering ReMoved
	reg exec_pushed;	// execが押されているかを格納
	reg EXECUTION;		// 実行中(1),停止中(0)
	reg [1:0] STOP;	// 停止時、各フェーズを順番に停止させる為の判定


	// execのチャタリング除去
	chattering EXEC(
		.clock(clock),
		.reset(reset),
		.in(exec),
		.out(exec_chrm)
	);

	// 実行・停止条件
	always @(posedge clock or negedge reset) begin
		if (reset == NEG) begin
			EXECUTION <= 1'b1;
		end else if (hlt == POS) begin
			EXECUTION <= (hazard|flush)? EXECUTION: 1'b0; // 停止命令時にクロックが入ると停止
		end else if (!exec_chrm) begin
			if (exec_pushed == NEG) begin
				// execが押されていて，かつ前の処理時には押されていないときのみに
				// 起動・停止を入れ替える
				exec_pushed <= POS;
				EXECUTION <= ~EXECUTION;
			end
		end else begin
			// execが離されたら押されていない状態に変更
			exec_pushed <= NEG;
		end
	end

	// 停止時、各フェーズを順番に停止させる
	always @(posedge clock) begin
		if (EXECUTION) begin
			STOP <= 2'b00;
		end else if(STOP != 2'b11) begin
			STOP <= (STOP << 1) + 2'd1; // 00->01->11
		end else begin
			STOP <= STOP;
		end
	end


/* フェーズ1・命令フェッチ(IF) */
	wire [15:0] pcadr;	// アドレス線。現在のPCの値
	wire [15:0] pc_1;		// 次のPCの値

	// PCを＋1
	assign pc_1 = pcadr + 16'd1;
	
	// プログラムカウンタの処理
   wire [15:0] pcout;
	
	program_counter PC(
		.clock(clock),
		.reset(reset),
		.DR(pc_1),
		.address(pcout)
	);

	assign pcadr = (BR_RSLT)? BRADR:
					   (hazard|!EXECUTION)? pcout-16'd1: pcout; // ストールまたは停止ならPCのカウントアップを止める

	// 命令読み出し(クロックの立ち下がりで読み出し)
	wire [15:0] inst; // 命令メモリからの出力線

	ram1 INST_MEM(
		.data(16'd0),
		.wren(1'b0),
		.address(pcadr[11:0]),
		.clock(~clock),
		.q(inst)
	);

	// パイプラインレジスタ書き込み
	reg [15:0] IR_1; // 命令
	reg [15:0] PC_1; // 次のPC

	always @(posedge clock or negedge reset) begin
		if(reset == NEG)begin
			IR_1 <= nop;
			PC_1 <= 16'd0;
		end else if(!EXECUTION)begin
			IR_1 <= IR_1;
			PC_1 <= PC_1;
		end else begin
			IR_1 <= inst;
			PC_1 <= pc_1;
		end
	end


/* フェーズ2・命令デコード&レジスタ読み出し(ID) */
	// 制御線
	wire [15:0] pc_2;		// PC値
	wire [15:0] ir_2;		// 16bit命令

			//  フェーズ3で使用する制御線(EX) 7bit
	wire	[1:0] op1_2;	// ALUOp,		命令形式
	wire	alus_2,			// ALUSrc,		ALUの入力2が即値なら1, 読み出しデータなら0
			rd_2,				// RegDst,		書き込みレジスタがinst[10:8]なら1, inst[13:11]なら0
			li_2,				// LI,			書き込みデータが即値なら1
			outp_2,			// Output,		出力命令なら1
			calc_2,        // Calc,       演算命令なら1
			// フェーズ4で使用する制御線(M) 4bit
			br_2,				// Branch,		条件分岐命令なら1
			jump_2,			// Jump,			無条件分岐命令なら1
			mr_2,				// MemRead,		メモリ読み出しなら1
			mw_2,				// MemWrite,	メモリ書き込みなら1
			// フェーズ5で使用する制御線(WB) 3bit
			inp_2,			// Input,		書き込みデータが外部入力なら1
			rw_2,				// RegWrite,	レジスタ書き込みなら1
			mtr_2,			// MemtoReg,	書き込みデータがメモリなら1
			hlt;				// Hlt,			停止命令なら1
			
	wire  hazard;   // ハザード信号、1ならストールさせる

	assign pc_2 = PC_1;
	assign ir_2 = IR_1;

	//ハザード検出
	detect_hazard det_hazard(
	    .MemRead(M_2[1]),
		 .pre_Rt(wreg_3),
		 .inst(ir_2),
		 .hazard(hazard)
	);

	// 命令デコード
	controller CTL(
		.inst(ir_2),
		.ALUOp(op1_2),
		.ALUSrc(alus_2),
		.RegDst(rd_2),
		.LI(li_2),
		.Branch(br_2),
		.Jump(jump_2),
		.MemRead(mr_2),
		.MemWrite(mw_2),
		.Output(outp_2),
		.Input(inp_2),
		.RegWrite(rw_2),
		.MemtoReg(mtr_2),
		.Hlt(hlt),
		.Calc(calc_2)
	);

	// レジスタ入出力線
	wire [2:0] r_a, r_b;
	wire [15:0] a_r, b_r;// レジスタから読み出した値

	assign r_a = IR_1[13:11];
	assign r_b = IR_1[10:8];

	// 汎用レジスタ読み出し
	register REG(
		.clock(clock),// フェーズ5での書き込み(要確認)
		.adr_a(r_a),
		.adr_b(r_b),
		.adr_w(r_w),
		.RegWrite(rw_5),
		.Din(wdata),
		.reset(reset),
		.Dout1(a_r),
		.Dout2(b_r)
	);

	wire br_rslt;//条件分岐判定結果

	Branch branch(
		.szcv(szcv_3),
		.cond(IR_1[10:8]),
		.branch(br_2),
		.jump(jump_2),
		.op(br_rslt)
	);

	// 分岐先アドレス計算
	wire [15:0] bradr;
	assign bradr = pc_2 + {{9{ir_2[7]}}, ir_2[6:0]};

	// パイプラインレジスタ書き込み
	reg [15:0] AR, BR;	// 読み出しデータAR,BR
	reg [6:0] EX_2;            // 制御線EX
	reg [1:0] M_2;			      // 制御線M
	reg [2:0] WB_2;				// 制御線WB
	reg [13:0] IR_2;				// 命令の[13:0]
	reg BR_RSLT;               // 分岐判定結果
	reg [16:0] BRADR;          // 分岐先

	always @(posedge clock or negedge reset) begin
		if(reset == NEG)begin
			AR <= 16'd0;
			BR <= 16'd0;
			EX_2 <= {nop[15:14], 5'd0};
			M_2 <= 2'd0;
			WB_2 <= 3'd0;
			IR_2 <= nop[13:0];
			BR_RSLT <= 1'b0;
			BRADR <= 16'd0;
		end else if(!EXECUTION)begin
			AR <= AR;
			BR <= BR;
			EX_2 <= {EX_2[6:2], 1'b0, EX_2[0]};
			M_2 <= {M_2[1], 1'b0};
			WB_2 <= {WB_2[2], 1'b0, WB_2[0]};
			IR_2 <= IR_2;
			BR_RSLT <= 1'b0;
			BRADR <= BRADR;
		end else begin
			AR <= a_r;
			BR <= b_r;
			EX_2 <= (hazard|flush)? {op1_2, alus_2, rd_2, li_2, 1'b0, calc_2}: {op1_2, alus_2, rd_2, li_2, outp_2, calc_2};
			M_2 <= (hazard|flush)? {mr_2, 1'b0}: {mr_2, mw_2};
			WB_2 <= (hazard|flush)? {inp_2, 1'b0, mtr_2}: {inp_2, rw_2, mtr_2};
			IR_2 <= IR_1[13:0];
			BR_RSLT <= (hazard|flush)? 1'b0: br_rslt;
			BRADR <= bradr;
		end
	end


/* フェーズ3・命令実行(EX) */
	// 制御線
	wire [1:0] op1_3;		// ALUOp,	命令形式
	wire [3:0] op3_3;		// op3
	wire alus_3,			// ALUSrc,	ALUの入力2が即値なら1, 読み出しデータなら0
			rd_3,				// RegDst,	書き込みレジスタがinst[10:8]なら1, inst[13:11]なら0
			li_3,				// LI,		書き込みデータが即値なら1
			outp_3,			// Output,	出力命令なら1
			calc_3;        // Calc,    演算命令なら1
	wire [1:0] forwardA, forwardB; // ALUへのフォワーディング用制御線
	wire [3:0] szcv_3;   // 現在の条件コード
   wire flush;          // 分岐の際のフラッシュ信号

	assign op1_3 = EX_2[6:5];
	assign alus_3 = EX_2[4];
	assign rd_3 = EX_2[3];
	assign li_3 = EX_2[2];
	assign outp_3 = EX_2[1];
	assign calc_3 = EX_2[0];
	assign op3_3 = IR_2[7:4];
	assign szcv_3 = (calc_3)? szcv: SZCV; 
   assign flush = BR_RSLT; 

	wire [15:0] rdrb, rsra, // ALUへの入力
					dr_3, ext_d, // ALUからの出力、符号拡張したd
					rsra_forward; // フォワーディング処理したAR
	wire [7:0] d; 							// IR[7:0]
	wire [3:0] ALUop3, d_calc;	// 演算命令,IR[3:0]
	wire [2:0] wreg_3;					// 書き込みレジスタ
	wire [3:0] szcv; //条件コード

	//フォワーディングユニット
	Forwarding FORWARD(
		.RegWrite3_4(WB_3[1]),
		.RegWrite4_5(WB_4[1]),
		.wreg3_4(WREG_3),
		.wreg4_5(WREG_4),
		.rsrd2_3(IR_2[13:8]),
		.ForwardA(forwardA),
		.ForwardB(forwardB)
	);

	assign d = IR_2[7:0];
	assign d_calc = IR_2[3:0];
	assign ext_d = {{9{d[7]}}, d[6:0]};//dを符号拡張
	assign rdrb = (forwardB == 2'b10)? DR:(forwardB == 2'b01)? wdata: BR; 
	assign rsra_forward = (forwardA == 2'b10)? DR:(forwardA == 2'b01)? wdata: AR;
	assign rsra = (alus_3)? ext_d: rsra_forward;
	assign wreg_3 = (rd_3)? IR_2[10:8]: IR_2[13:11];

	ALUcontroller ALU_CTL(
		.op1(op1_3),
		.op3_in(op3_3),
		.op3_out(ALUop3)
	);

	ALU alu(
		.in1(rdrb),
		.in2(rsra),
		.op1(op1_3),
		.op3(ALUop3),
		.d(d_calc),
		.reset(reset),
		.out(dr_3),
		.szcv(szcv)
	);

	// パイプラインレジスタ書き込み
	reg [15:0] DR, AR_3;				// 演算結果、メモリ書き込みデータAR
	reg [1:0] M_3;						// 制御線M
	reg [2:0] WB_3, WREG_3;       // 制御線WB、書き込みレジスタ
	reg [5:0] IR_3;					// 命令のIR[13:8]
	reg [3:0] SZCV;               // 現在の条件コード

	always @(posedge clock or negedge reset) begin
		if(reset == NEG)begin
			DR <= 16'd0;
			AR_3 <= 16'd0;
			M_3 <= 2'd0;
			WB_3 <= 3'd0;
			WREG_3 <= 3'd0;
			SZCV <= 4'd0;
		end else if(STOP[0] == POS)begin
			DR <= DR;
			AR_3 <= AR_3;
			M_3 <= {M_3[1], 1'b0};
			WB_3 <= {WB_3[2], 1'b0, WB_3[0]};
			WREG_3 <= WREG_3;
			SZCV <= SZCV;
		end else begin
			DR <= (li_3)? ext_d: dr_3;
			AR_3 <= rsra_forward;
			M_3 <= M_2;
			WB_3 <= WB_2;
			WREG_3 <= wreg_3;
			SZCV <= (calc_3)? szcv: SZCV; // 演算命令なら条件コードを更新
		end
	end


/* フェーズ4・メモリアクセス(MEM) */
	wire  mr_4,			   // MemRead,		メモリ読み出しなら1
			mw_4;			   // MemWrite,	メモリ書き込みなら1
	wire [15:0] ar_4;	   // メモリに書き込むデータ

	assign mr_4 = M_3[1];
	assign mw_4 = M_3[0];
	assign ar_4 = AR_3;

	// メモリ読み出し
	wire [15:0] m_out; // データメモリからの出力線

	ram2 DATA_MEM(
		.data(ar_4),
		.wren(mw_4),
		.address(DR[11:0]),
		.clock(~clock),
		.q(m_out)
	);

	// パイプラインレジスタ書き込み
	reg [15:0] MDR, DR_4;	// メモリから読み出した値または外部入力、DR
	reg [2:0] WB_4, WREG_4;	// 制御線WB、書き込みレジスタ

	always @(posedge clock or negedge reset) begin
		if(reset == NEG)begin
			MDR <= 16'd0;
			DR_4 <= 16'd0;
			WB_4 <= 3'd0;
			WREG_4 <= 3'd0;
		end else if(STOP[1] == POS)begin
			MDR <= MDR;
			DR_4 <= DR_4;
			WB_4 <= {WB_4[2], 1'b0, WB_4[0]};
			WREG_4 <= WREG_4;
		end else begin
			MDR <= (mr_4)? m_out: in;
			DR_4 <= DR;
			WB_4 <= WB_3;
			WREG_4 <= WREG_3;
		end
	end

/* フェーズ5・書き戻し(WB) */
	// 汎用レジスタ書き込み
	wire [15:0] wdata;	// 書き込みデータ
	wire [2:0] r_w;		// 書き込みレジスタ
	wire inp_5,				// Input,		書き込みデータが外部入力なら1
		  rw_5,				// RegWrite,	レジスタ書き込みなら1
		  mtr_5;				// MemtoReg,	書き込みデータがメモリなら1

	assign inp_5 = WB_4[2];
	assign rw_5 = WB_4[1];
	assign mtr_5 = WB_4[0];
	assign wdata = (inp_5|mtr_5) ? MDR: DR_4;
	assign r_w = WREG_4;

/* カウンタ */
	reg [27:0] counter;
	always @(posedge clock or negedge reset) begin
		if(reset == NEG) begin
			counter <= 28'd0;
		end else if (STOP == 2'b11) begin
			counter <= counter;
		end else begin
			counter <= counter + 28'd1;
		end
	end

/* 外部出力 */
	reg [27:0] out; // 出力命令で出力する値
	// フェーズ3の途中(フェーズ2クロックの立ち下がり)で更新
	always @(negedge clock or negedge reset) begin
		if(reset == NEG)begin
			out <= 28'd0;
		end else if(STOP == 2'b11) begin
			out <= counter;
		end else if(outp_3) begin
			out <= {{12{rsra_forward[15]}}, rsra_forward};
		end else begin
			out <= out;
		end
	end

	/* 以下実機デバッグ時にどちらかを使用 */

	/*debugger OUTPUT(
		.reset(reset),
		.clock(clock),
		.out(out),
		.pc(pcout),
		.szcv(SZCV),
		.led_a(LED_a),
		.led_b(LED_b),
		.led_c(LED_c),
		.led_d(LED_d),
		.led_e(LED_e),
		.led_f(LED_f),
		.led_g(LED_g),
		.led_h(LED_h),
		.seg_sel_out(SEL)
	);*/

	output_device OUTPUT(
		.outp_3(outp_3 | (STOP == 2'b11)),
		.out(out),
		.led_a(LED_a),
		.led_b(LED_b),
		.led_c(LED_c),
		.led_d(LED_d),
		.led_e(LED_e),
		.led_f(LED_f),
		.led_g(LED_g),
		.led_h(LED_h),
		.seg_sel_out(SEL)
	);

endmodule
