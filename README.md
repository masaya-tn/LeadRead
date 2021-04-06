# LeadRead

読書で得た知識の定着、行動の習慣化をサポートするアプリです。
<img width="1382" alt="スクリーンショット 2021-04-06 22 13 44" src="https://user-images.githubusercontent.com/61619091/113716647-c8993500-9725-11eb-816c-097c4099eebf.png">
<img width="1278" alt="スクリーンショット 2021-04-06 22 51 56" src="https://user-images.githubusercontent.com/61619091/113724075-f33abc00-972c-11eb-9101-c0e84fb9d569.png">
<img width="1189" alt="スクリーンショット 2021-04-06 23 04 03" src="https://user-images.githubusercontent.com/61619091/113724084-f46be900-972c-11eb-8c99-0b9b6aa66aaa.png">
<img width="1220" alt="スクリーンショット 2021-04-06 23 07 47" src="https://user-images.githubusercontent.com/61619091/113724086-f5047f80-972c-11eb-95b2-606bec5f6ac0.png">

**URL:** http://54.249.203.140/
ゲストログイン機能あり

# 目的
せっかく読んだのに内容を忘れてしまい、結局読んだ意味がなくなってしまわないようにサポートする(具体的には以下)
・内容を自分なりにまとめてアウトプットすることで知識の定着を図る
・アクションプランを登録し行動の習慣化を目指す(アクションプラン確認メールが届くように設定できる)
・読書会で、同じ本を読んだ人と語り合ってさらに知識を定着させる

# 主な使用技術
・ruby 2.6.5
・Rails 5.2.3
・Rspec
・AWS
  ・EC2
  ・VPC

# 機能一覧
・ログイン機能(devise)

・アウトプットcrud

・アクションプランcrud

・読書会crud

・いいね(ajax)

・フォロー(ajax)

・読書会申請機能(ajax)

・読書会参加承認機能(ajax)

・書籍検索機能(GoogleBooksAPI)

・アウトプット、読書会検索機能(ransack)

・ページネーション(kaminari)

・twitterログイン

・ゲストログイン

・通知機能

・メッセージ機能
