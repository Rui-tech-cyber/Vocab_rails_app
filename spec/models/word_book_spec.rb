require 'rails_helper'

RSpec.describe WordBook, type: :model do
  let(:user) { User.create!(name: "テスト太郎", email: "test@example.com", password: "password") }

  it "タイトルがあれば有効" do
    word_book = WordBook.new(title: "My Book", user: user)
    expect(word_book).to be_valid
  end

  it "タイトルがなければ無効" do
    word_book = WordBook.new(title: nil, user: user)
    expect(word_book).not_to be_valid
  end
end
