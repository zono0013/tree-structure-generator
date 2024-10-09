# ディレクトリ構造ジェネレーター

このプロジェクトは、`tree`コマンドの出力をもとにディレクトリ構造を生成します。指定されたテキストファイルを解析し、対応するディレクトリやファイルをファイルシステムに作成します。

## 特徴

- `tree`コマンドの出力をテキストファイルから読み取る。
- 入力に基づいて階層的な構造のディレクトリを作成する。
- ネストされたディレクトリやファイルをサポート。
- ディレクトリやファイルを作成するrootを`OUTPUT_DIR=./hoge`のように任意の位置に指定できる。
- DockerfileやMakefileなどの特殊なファイルは`RESERVED_FILES=hosts,Procfile`のように指定する必要がある。

## 必要条件

- GNU Make
- `awk`

## tree.txtのフォーマット
1. ディレクトリに/がない場合もok(通常の`tree`コマンドの出力)
   ```bash
   src
   ├── domain
   │   ├── entities
   └── server.ts
   ```

2. ディレクトリ後ろに`/`が入るのもok(`tree -F` の出力)
   ```bash
   src/
   ├── domain/
   │   ├── entities/
   └── server.ts
   ```

3. ファイルやディレクトリ名の後ろに空白やコメントがあってもok(AIなどが出力するtree)
   ```bash
   src/
   ├── domain/
   │   ├── entities/         # hogehoge
   └── server.ts         # hugahuga
   ```

## Usecase
- 複数の環境で同じディレクトリ構造を再現するため
- AIやQiitaなどのブログで書かれたtreeをディレクトリ構造として作成する時間短縮
- クリーンアーキテクチャなどのテンプレートを自動で作成できる

## 使用方法

1. リポジトリをクローンします:

   ```bash
   git clone https://github.com/zono0013/tree-structure-generator.git
   cd tree-structure-generator
   ```
2. `tree.txt`に`tree`コマンドの出力を入力します:
   
   オプションの`-f`は付けない
   
   **例:**
   ```
   tree > tree.txt
   ```


4. `Makefile`を実行します
    ```bash
   make create-dirs-mac FILE=tree.txt OUTPUT_DIR=./hoge RESERVED_FILES=hosts,Dockerfile
   ```
   `OUTPUT_DIR=./hoge RESERVED_FILES=hosts,Dockerfile`は任意。


