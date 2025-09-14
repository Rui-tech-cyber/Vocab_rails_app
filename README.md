# Vocab(ボキャブ)

##  アプリ概要
本アプリは、英単語の学習を効率化するために作成した単語帳＆テストアプリです。
ユーザーは自分専用の単語帳を作成し、単語の登録・編集・削除を行うことができます。
また、登録済みの単語を使ってテストを実施し、正解数・不正解数を集計することができます。

###  データ元 
検索や単語追加には、NGSL、NAWL、TSL、BSLといった一般的に使用される頻度の高い単語をまとめたものを基にCSVに落とし込んで使用しています。
精度の高い参照元を利用しているため、安心して単語検索を行うことができます。

###  API非依存
Free Dictionary API などは使用せず、アプリ内で精度の高いCSVデータを参照しています。そのため、外部API特有の不正確な邦訳などを避けることができます。

###  データの特徴
出現頻度の高い単語から選定されているため、初学者でも素早い検索が可能で、効率的に学習することができます。


##  開発背景
私は英語学習を行う際、必ず「わからない単語を調べて」、別の英語学習アプリに「単語と意味を手入力」する必要がありました。
この作業には時間がかかり、英語学習をつまらなくさせる要因として悩まされてきました。 この無駄な時間をなくすことで、英語学習のサイクルを早め、学習効果をより高めることができると考えました。 そこで本アプリでは、入力作業を最小限に抑えてわからない単語をすぐに復習できる仕組みを整備することで、効率的に学習効果を高めることを目指しています。

---


##  デモ画像

1. トップページ
<img width="1440" height="699" alt="スクリーンショット 2025-09-13 12 05 25" src="https://github.com/user-attachments/assets/54b323c4-30c6-4b53-9f0b-f673f2c4d3fc" />

2. 単語帳一覧ページ
<img width="1440" height="699" alt="スクリーンショット 2025-09-13 12 07 34" src="https://github.com/user-attachments/assets/5c08809f-7ae4-4c2f-8f3e-e1ee813eea88" />

3. 単語追加・編集ページ
<img width="1440" height="697" alt="スクリーンショット 2025-09-13 12 10 28" src="https://github.com/user-attachments/assets/754876a3-5d35-448c-84d9-8679e98d21a7" />

4. テストページ
<img width="1440" height="698" alt="スクリーンショット 2025-09-13 12 12 02" src="https://github.com/user-attachments/assets/f48c746f-fbba-429f-b505-6f6b39925177" />

5. テスト結果ページ
<img width="1440" height="700" alt="スクリーンショット 2025-09-13 12 14 53" src="https://github.com/user-attachments/assets/ae914756-e663-4d59-9966-ddafd05e6b7c" />

---
##アプリurl

https://vocab-app-de1c3ab929a8.herokuapp.com/

---

##  使用技術
- Ruby 3.2.4
- Rails 7.2.2
- PostgreSQL
- Bootstrap 5
- Devise（ユーザー認証）
- RSpec（テスト）
- Turbo/Stimulus（フロント操作改善）

---

##  主な機能
### 単語帳機能
- 単語帳の作成・編集・削除
- 単語の追加・編集・削除(単語帳ごとに複数の単語を登録可能)
- 単語一覧でのモーダル削除確認

### テスト機能
- 英単語→日本語、日本語→英単語の2モード対応
- 回答結果を保存し、マイページで正解数・不正解数を表示
- 直前に作成したテストは自動で削除され、常に最新の単語帳でテスト可能
- 直前に受けたテストの日付を保存

### 検索機能
- 単語検索（部分一致）
- 検索結果から単語を任意の単語帳に追加可能
- 単語検索機能（CSV検索）を備えています。

---
##  ER図
<img width="453" height="176" alt="スクリーンショット 2025-09-13 14 36 05" src="https://github.com/user-attachments/assets/b3d70d6f-7c2e-4e88-82db-03ab73aca37c" />

###  User
- has_many :word_books
- has_many :exams
- has_many :exam_answers

###  WordBook
- belongs_to :user
- has_many :words
- has_one :exam

###  Word
- belongs_to :word_book
- has_many :exam_questions
- has_many :exam_answers

###  Exam
- belongs_to :user
- belongs_to :word_book（1対1）
- has_many :exam_questions
- has_many :exam_answers

###  ExamQuestion
- belongs_to :exam
- belongs_to :word

###  ExamAnswer
- belongs_to :exam
- belongs_to :word
- belongs_to :user

---

##  デモユーザ情報
- ユーザー名：test
- ユーザーアドレス：test@test.com
- pass：123456
