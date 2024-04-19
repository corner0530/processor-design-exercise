# プロセッサ設計演習の設計ファイル

## 参考サイト
http://isle3hw.kuis.kyoto-u.ac.jp/#processor

## 構成
- `assembler`: 本プロセッサのアセンブラ
  - `Radix_Sort.txt`: 応用プログラムとして作成した基数ソートのプログラム
- `ALU.v`: ALUの設計ファイル
- `ALUcontroller.v`: ALU制御部の設計ファイル
- `Branch.v`: 分岐回路の設計ファイル
- `chattering.v`: チャタリング除去回路の設計ファイル
- `controller.v`: 制御部の設計ファイル
- `debugger.v`: デバッグ用回路の設計ファイル
- `detect_hazard.v`: ハザード検出部の設計ファイル
- `Forwarding.v`: フォワーディング回路の設計ファイル
- `mif1.mif`: 命令メモリのRAMのデータファイル
- `mif2.mif`: データメモリのRAMのデータファイル
- `output_device.v`: 出力機器の設計ファイル
- `processor.qsf`: プロセッサのプロジェクトファイル
- `processor.qsf`: プロセッサのピン配置等が記録されているファイル
- `processor.sdc`: プロセッサのタイミング制約等が記録されているファイル
- `processor.v`: プロセッサ全体の設計ファイル
- `program_counter.v`: プログラムカウンタの設計ファイル
- `ram1.v`: 命令メモリの設計ファイル
- `ram2.v`: データメモリの設計ファイル
- `register.v`: レジスタの設計ファイル
- `RX_7SEG.v`: 出力機器・デバッグ用回路で使用するモジュールの設計ファイル

