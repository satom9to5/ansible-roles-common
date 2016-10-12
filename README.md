# 変数の命名規則

- 単語の区切りはアンダースコア1文字で行う
- 大区分の区切りは「__」（アンダースコア2文字）で行う
- roleに記載してある/,-は全てアンダースコアに変換する。
  基本的な命名ルールは[変換後のrole名]__[変数名]。 
- 特殊な用途で使う変数は、大文字から始める。
  この場合の命名ルールは[用途名]__[role名]__[変数名]
  以下用途名の種類。
    Defaults: 使い回す変数の初期値。原則として処理終了後にこの値で初期化する。
    Register: registerで登録した変数。
    Fact: set_factで新たに登録した変数。