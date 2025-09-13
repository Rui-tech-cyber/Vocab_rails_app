require 'rails_helper'

RSpec.describe User, type: :model do
  it "名前・メール・パスワードがあれば有効" do
    user = User.new(name: "テスト太郎", email: "test@example.com", password: "password")
    expect(user).to be_valid
  end

  it "名前がなければ無効" do
    user = User.new(email: "test@example.com", password: "password")
    expect(user).not_to be_valid
  end

  it "メールがなければ無効" do
    user = User.new(name: "テスト太郎", password: "password")
    expect(user).not_to be_valid
  end
end
