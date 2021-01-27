# アプリ概要

仏像とお寺と人が巡り合うことをコンセプトにしたSNS＆情報サイトです。

https://buddhagram.work/

右上の「ゲストログイン」ボタンをクリックすると、ゲストでログインした状態でご利用になれます。  
ログインすると、ユーザフォロー、いいね、コメント、タイムライン機能がご利用になれます。

# 使用技術

- フロントエンド
	- HTML / CSS / bootstrap / jQuery / Ajax
- バックエンド
	- Ruby on Rails
- 開発環境
	- MacOS / Docker / docker-compose / MariaDB
	- 【開発環境コンテナ構成】rails / mariadb / webpacker / chrome_driver（システムスペック用）
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
	- タイムライン
	- ゲストログイン
  
- **投稿機能**
	- 投稿一覧
	- いいね：Ajax
	- 投稿場所の追加：Ajax（場所の検索時）
	- コメント
	- ハッシュタグ（ハッシュタグをクリックすると専用ページを表示）：正規表現によるハッシュタグの検出

- **検索機能**
	- スポット検索
		- 周辺スポット検索：jQuery（ブラウザの位置情報から緯度/軽度の取得）/ gon[gem]
		- お寺の位置情報：geocoder[gem]
		- Google Mapの表示：Google Maps API / geocoder[gem]
	- キーワード検索機能
		- 仏像、スポット（地名や住所）、ハッシュタグ、ユーザの検索に対応
	- 検索結果表示：Ajax

- **全般**
	- ページネーション：pagy[gem]（ページネーション）
	- スクロールでページネーションの次のページを読み込み：jscroll（無限スクロール用 jQuery plugin）
	- 画像アップロード：AWS S3
	- 画像処理：active_storage_validations[gem] / image_processing[gem] / mini_magick[gem]


# 作成動機

私は旅行と仏像を見るのが好きで、以下の動機によってこのアプリを作成しました。（※仏教徒というわけではないので、宗教的な意味はありません。）

1. 周辺にどんな仏像やお寺があるのかすぐに知ることが出来たら便利
1. 仏像やお寺に特化した情報共有の場があると、興味を持つ人が増えたりして面白そう、自分も楽しい
1. 仏像やお寺に詳しくなりたい

これらの動機は以下の機能実装につながっています。

1. 現在地周辺スポット検索機能、キーワード検索機能
1. インスタグラムのようなSNS機能（写真や画像の投稿、いいね、コメント、ユーザフォロー）
1. 仏像、スポットの一覧機能

仏像やお寺好きの人々がつながる、今まで興味がなかった人でもその魅力に触れられる、そんなアプリがあったらいいなと思い作成しました。

# 構成図

# ER図
