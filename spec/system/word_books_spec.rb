require "rails_helper"

RSpec.describe "WordBooks", type: :system do
  before do
    driven_by(:rack_test)

    @user = User.create!(
      name: "テストユーザー",
      email: "test@example.com",
      password: "password"
    )
  end

  it "ログインして単語帳を作成できる" do
    visit new_user_session_path
    fill_in "user_email", with: @user.email
    fill_in "user_password", with: @user.password
    click_button "ログイン"

    visit new_word_book_path
    fill_in "word_book_title", with: "Test Book"
    click_button "作成"

    expect(page).to have_content("Test Book")
  end

  it "単語帳に単語を追加できる" do
    word_book = WordBook.create!(title: "Test Book", user: @user)

    visit new_user_session_path
    fill_in "user_email", with: @user.email
    fill_in "user_password", with: @user.password
    click_button "ログイン"

    visit word_book_path(word_book)
    visit new_word_book_word_path(word_book)

    fill_in "word_term", with: "apple"
    fill_in "word_meaning", with: "りんご"
    click_button "保存"

    expect(page).to have_content("apple")
    expect(page).to have_content("りんご")
  end
end
