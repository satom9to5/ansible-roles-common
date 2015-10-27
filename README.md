# ansible-playbook

serverspecのテストコード
test-kitchen + dockerの初期設定も含む

## test-kitchen + dockerのコマンド
### インストール
```
$ bundle install
```

### テスト用Dockerインスタンス作成
```
$ kitchen create
```

### Dockerインスタンスへのプロビジョニング開始
```
$ kitchen converge
```

### Dockerインスタンスへのテストコード（serverspec）実行
```
$ kitchen verify
```

※「kitchen setup」は、create + converge + verifyを一気に実行するコマンド

### Dockerインスタンス削除
```
$ kitchen destroy
```

### 作成されたDockerインスタンス一覧確認
```
$ kitchen list
```
