require 'rails_helper'

RSpec.describe "Users", type: :request do
  let(:user) { FactoryBot.create(:user) }

  describe "ユーザー登録" do
    it "有効な情報で登録できる" do
      post user_registration_path, params: { user: { name: "Test", email: "test2@example.com", password: "password", password_confirmation: "password" } }
      expect(response).to redirect_to(root_path) 
    end

    it "無効な情報では登録できない" do
      post user_registration_path, params: { user: { name: "", email: "", password: "123", password_confirmation: "456" } }
      expect(response.body).to include("保存に失敗しました")
    end
  end

  describe "ログイン・ログアウト" do
    it "有効な情報でログインできる" do
      post user_session_path, params: { user: { email: user.email, password: user.password } }
      expect(response).to redirect_to(root_path)
    end

    it "ログアウトできる" do
      sign_in user
      delete destroy_user_session_path
      expect(response).to redirect_to(root_path)
    end
  end
end
