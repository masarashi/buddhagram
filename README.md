<div align="center">
<img width="600" alt="top_page" src="https://user-images.githubusercontent.com/69148986/105990159-744e5500-60e5-11eb-802f-06ca3f43c202.png">
</div>

# アプリ概要

### Buddhagram 仏像とお寺と人が巡り合うことをコンセプトにしたSNS+情報サイト

アクセスURL

https://buddhagram.work/

ログインせずにご利用になれます。

右上の「ゲストログイン」ボタンをクリックすると、ゲストでログインします。  
ログインすると、投稿、ユーザフォロー、いいね、コメント、タイムラインなどSNS機能がご利用になれます。

### Buddhagram で提供すること

1. 周辺にどんな仏像やお寺があるのかすぐに知ることが出来る（周辺スポット検索機能）
1. 仏像やお寺に特化した体験をシェア出来る（投稿、いいね、コメント、ユーザフォロー機能）
1. 仏像やお寺について知ることが出来る（仏像/スポット一覧機能）

# 使用技術

- フロントエンド
	- HTML / CSS / bootstrap / jQuery / Ajax
- バックエンド
	- Ruby on Rails
- 開発環境
	- MacOS / Docker / docker-compose / MariaDB
	- 【開発環境コンテナ構成】rails / MariaDB / webpacker / chrome_driver（システムスペック用）
- 本番環境
	- AWS（EC2 / RDS for MariaDB / S3 / ELB / Route53 / ACM）/ Docker / docker-compose / nginx
	- 【本番環境コンテナ構成】rails / nginx

- その他
	- テストコード：RSpec[gem] / capybara[gem] / FactoryBot[gem]
	- コードチェック：rubocop[gem] / bullet[gem]（N+1問題の検出）
	- セキュリティチェック：brakeman[gem]
	- デモデータ登録：seed / faker[gem]

- バージョン情報
	- MacOS Catalina 10.15.7
	- ruby 2.7.1
	- rails 6.0.3.4
	- docker 19.03.13
	- docker-compose 1.27.4

# 機能一覧

- 機能：使用技術

- **ユーザ機能**：devise[gem]
	- ユーザフォロー：Ajax（フォロー/アンフォローボタン）
	- タイムライン（自分とフォローしているユーザの投稿を表示）
	- ゲストログイン
  
- **投稿機能**
	- 投稿一覧（みんなの投稿、プロフィールページに自分の投稿）
	- いいね：Ajax
	- 投稿場所の紐付け：Ajax（場所の検索時）
	- コメント
	- ハッシュタグ：正規表現によるハッシュタグの検出（ハッシュタグをクリックすると専用ページを表示）
	- 複数画像の表示：slick（スライダー用のプラグイン）

- **検索機能**
	- 周辺スポット検索
		- ブラウザの位置情報を取得し現在地から近いスポットを表示：jQuery / gon[gem]
		- お寺の位置情報：geocoder[gem]
		- Google Mapの表示：Google Maps API / geocoder[gem]
	- キーワード検索
		- 仏像、スポット（地名や住所）、ハッシュタグ、ユーザを対象に検索
		- 検索結果表示：Ajax

- **全般**
	- ページネーション：pagy[gem]（ページネーション）
	- スクロールに応じてデータを表示：jscroll（無限スクロール用プラグイン）
	- 画像アップロード：Active Storage / AWS S3
	- 画像処理：active_storage_validations[gem] / image_processing[gem] / mini_magick[gem]

# 構成図

![network](https://user-images.githubusercontent.com/69148986/105991143-cba0f500-60e6-11eb-9802-c56f52c5bd89.jpg)

# ER図

![er](https://user-images.githubusercontent.com/69148986/105989858-0bff7380-60e5-11eb-89b1-29d04b205821.jpg)
