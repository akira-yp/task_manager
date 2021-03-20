## モデル
- user
  - name :string
  - email :string
  - password_digest :string

- task
  - title :string
  - content :text
  - deadline :datetime
  - priority :integer
  - status :integer
  - user_id :integer

- label
  - label_name :string

- task_label
  - task_id :integer
  - label_id :integer

## herokuへのデプロイ手順
1. herokuにログインする
2. アセットプリコンパイルを実行
```
rails assets:precompile RAILS_ENV=production
```

3. gitにコミットする
4. 新しいアプリをherokuに作成する
```
heroku create --stack heroku-18
```
5. herokuにデプロイする
```
git push heroku master
```
6. データベースを移行する
```
heroku run rails db:migrate
```
