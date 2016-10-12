# 変数の命名規則

- 単語の区切りはアンダースコア1文字で行う
- 大区分の区切りは「__」（アンダースコア2文字）で行う
- roleに記載してある/,-は全てアンダースコアに変換する。
  基本的な命名ルールは[変換後のrole名]__[変数名]。 
- 特殊な用途で使う変数は、大文字から始める。
  この場合の命名ルールは[用途名]__[role名]__[変数名]
  以下用途名の種類。
    Register: registerで登録した変数。
    Fact: set_factで新たに登録した変数。
    Arg: playbookで渡した変数。

# 変数の初期化
- 一旦初期化した変数は、playbook内でset_factすると、その後その値で固定される。
　変数を使い回す場合は、set_factで書き換えない事。

# 変数のスコープ
Global, Play, Hostの３種類が存在する。
roleのdefaultsはPlayスコープ。roleを実行する度に初期化される様子。
参考： http://docs.ansible.com/ansible/playbooks_variables.html#variable-scopes
