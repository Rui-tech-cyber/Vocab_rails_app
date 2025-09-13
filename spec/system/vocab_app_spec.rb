require 'rails_helper'

RSpec.describe "VocabApp", type: :system do
  before do
    driven_by(:selenium_chrome_headless)
  end

  let(:user_email) { "test@example.com" }
  let(:user_password) { "password" }

  context "ユーザー登録" do
    it "新規登録ができる" do
      visit new_user_registration_path

      fill_in "ユーザー名", with: "テストユーザー"
      fill_in "メールアドレス", with: user_email
      fill_in "パスワード", with: user_password
      fill_in "パスワード確認", with: user_password
      click_button "登録する"

      expect(page).to have_content "アカウントを作成しました。"
    end
  end

  context "ログイン" do
    let!(:user) { User.create!(name: "テストユーザー", email: user_email, password: user_password, password_confirmation: user_password) }

    it "ログインできる" do
      visit new_user_session_path

      fill_in "メールアドレス", with: user_email
      fill_in "パスワード", with: user_password
      click_button "ログイン"

      expect(page).to have_content "ログインしました。"
    end
  end

  context "単語登録" do
    let!(:user) { User.create!(name: "テストユーザー", email: user_email, password: user_password, password_confirmation: user_password) }

    before do
      visit new_user_session_path
      fill_in "メールアドレス", with: user_email
      fill_in "パスワード", with: user_password
      click_button "ログイン"
    end

    it "単語が登録できる" do
      visit new_word_path 

      fill_in "単語", with: "apple"
      fill_in "意味", with: "りんご"
      click_button "登録"

      expect(page).to have_content "apple"
      expect(page).to have_content "りんご"
    end
  end
end
