# simple_assembler
アセンブリ命令のテキストファイルを入力として読み込み，QuartusのRAMに対応する.mif形式の情報を出力します．

## ツール・バージョン
- Python 3.9.7

## 使用方法
```
$ python3 assembler.py input-file [output-file]
```

- output-fileを省略した場合は標準出力に出力されます

## 注意点など

- SIMPLEアーキテクチャの基本命令セットに即値演算を追加したものです．
