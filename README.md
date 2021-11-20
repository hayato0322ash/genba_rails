初期設定！！(完了したら消去！)

rails(6系)をインストールする　docker-compose buildの前に実行　

% docker-compose run web rails new . --force --no-deps --database=mysql --skip-test --webpacker

※rspecのために「--skip-test」で、Minitestをスキップ。
※「--webpacker」でwebpackerをインストール

↓

config/database.ymlをMySQL用に更新する

default: &default
  adapter: mysql2
  encoding: utf8mb4
  pool: <%= ENV.fetch("RAILS_MAX_THREADS") { 5 } %>
  username: <%= ENV.fetch("MYSQL_USERNAME", "root") %>
  password: <%= ENV.fetch("MYSQL_PASSWORD", "password") %>
  host: <%= ENV.fetch("MYSQL_HOST", "db") %>

development:
  <<: *default
  database: myapp_development

test:
  <<: *default
  database: myapp_test

production:
  <<: *default
  database: myapp_production
  username: myapp
  password: <%= ENV['MYAPP_DATABASE_PASSWORD'] %>


更新したら「docker-compose run web rails db:create」

↓

コンテナを起動させる

「docker-compose up」

---
---

README
- アプリケーションの概要
	- 1行で完結に書く
---
※この二つは合体させて書く

- アプリケーションの機能一覧
	- 記事投稿機能
	- 記事にコメントをつける機能
	- 認証機能
	- ページネーション機能
	- などの実装してある機能を簡潔に書く

- アプリケーション内で使用している技術一覧
	- インフラには何を使っているのか？
	- データベースは何を使っているのか？
	- セッション管理はどのようにおこなっているのか？
	- 画像アップロードはどういったライブラリを使っているのか？
	- デプロイはどのようにおこなっているのか？
	- などのポートフォリオに使った技術を記述する。
---
GitHubはスクロールしないとREADMEの全体が見えないので、上部に情報を詰め込む
