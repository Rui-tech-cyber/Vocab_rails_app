require 'rails_helper'

RSpec.describe "WordBooks", type: :system do
  let(:user) { User.create!(name: "テスト太郎", email: "test@example.com", password: "password") }

  it "ログインして単語帳を作成し、単語を追加できる", js: true do
    # ------------------------------
    # ログイン
    # ------------------------------
    visit new_user_session_path
    fill_in "メールアドレス", with: user.email
    fill_in "パスワード", with: "password"
    click_button "ログイン"

    # ログイン後トップページ確認
    expect(page).to have_current_path(root_path)

    # ------------------------------
    # 単語帳作成ページへ
    # ------------------------------
    visit new_word_book_path
    expect(page).to have_content("新しい単語帳を作成")

    # ------------------------------
    # 単語帳作成
    # ------------------------------
    find("input[name='word_book[title]']").set("Test Book")
    click_button "作成"

    # JS 対応のため Capybara が自動で待機
    expect(page).to have_current_path(word_books_path)
    expect(page).to have_content("Test Book")

    # ------------------------------
    # 単語帳詳細ページに移動
    # ------------------------------
    click_link "Test Book"
    expect(page).to have_current_path(word_book_path(WordBook.last))
    expect(page).to have_content("Test Book")

    # ------------------------------
    # 単語追加リンク確認 & クリック
    # ------------------------------
    expect(page).to have_link("単語を追加")
    click_link "単語を追加"

    # ------------------------------
    # 単語入力フォーム
    # ------------------------------
    expect(page).to have_content("新しい単語を追加")
    find("input[name='word[term]']").set("apple")
    find("input[name='word[meaning]']").set("りんご")
    click_button "保存"

    # ------------------------------
    # 単語追加確認
    # ------------------------------
    expect(page).to have_content("apple")
    expect(page).to have_content("りんご")
  end
end
