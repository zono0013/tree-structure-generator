# ディレクトリ構造ジェネレーター

このプロジェクトは、`tree`コマンドの出力をもとにディレクトリ構造を生成します。指定されたテキストファイルを解析し、対応するディレクトリやファイルをファイルシステムに作成します。

## 特徴

- `tree`コマンドの出力をテキストファイルから読み取る。
- 入力に基づいて階層的な構造のディレクトリを作成する。
- ネストされたディレクトリやファイルをサポート。

## 必要条件

- GNU Make
- `awk`

## 使用方法

1. リポジトリをクローンします:

   ```bash
   git clone https://github.com/zono0013/tree-structure-generator.git
   cd tree-structure-generator
   ```
2. `tree.txt`に`tree`コマンドの出力を入力します:
   オプションの`-fなどは付けない`
   **例: **
   ```
   tree > tree.txt
   ```


4. `Makefile`を実行します
    ```bash
   make create-dirs-mac FILE=tree.txt
   ```


