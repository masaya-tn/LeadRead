# LeadRead

読書で得た知識の定着、行動の習慣化をサポートするアプリです。
<img width="1382" alt="スクリーンショット 2021-04-06 22 13 44" src="https://user-images.githubusercontent.com/61619091/113716647-c8993500-9725-11eb-816c-097c4099eebf.png">
<img width="1262" alt="スクリーンショット 2021-04-08 23 59 48" src="https://user-images.githubusercontent.com/61619091/114050293-1a2cf580-98c7-11eb-88a2-4e84e234c86f.png">
<img width="1291" alt="スクリーンショット 2021-04-09 0 03 23" src="https://user-images.githubusercontent.com/61619091/114050315-1ef1a980-98c7-11eb-998d-544c4cb6fc6a.png">
<img width="1254" alt="スクリーンショット 2021-04-09 0 03 32" src="https://user-images.githubusercontent.com/61619091/114050321-2022d680-98c7-11eb-8996-fc3590a808b2.png">


**URL:** http://54.249.203.140/
ゲストログイン機能あり

# 目的
せっかく読んだのに内容を忘れてしまい、結局読んだ意味がなくなってしまわないようにサポートする(具体的には以下) <br>
・内容を自分なりにまとめてアウトプットすることで知識の定着を図る <br>
・アクションプランを登録し行動の習慣化を目指す(アクションプラン確認メールが届くように設定できる) <br>
・読書会で、同じ本を読んだ人と語り合ってさらに知識を定着させる <br>

# 主な使用技術
・ruby 2.6.5

・Rails 5.2.3

・Rspec

・AWS(EC2,VPC)

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

# ER図
<img width="811" alt="スクリーンショット 2021-04-07 0 18 21" src="https://user-images.githubusercontent.com/61619091/113735004-ca1f2900-9736-11eb-9f1a-544cc5f614b2.png">

