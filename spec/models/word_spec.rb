require 'rails_helper'

RSpec.describe Word, type: :model do
  describe 'バリデーション' do
    let(:user) { User.create!(name: "テスト太郎", email: "test@example.com", password: "password") }
    let(:word_book) { WordBook.create!(title: "テスト用単語帳", user: user) }

    it '単語と意味があれば有効' do
      word = Word.new(term: "apple", meaning: "りんご", word_book: word_book)
      expect(word).to be_valid
    end

    it '単語がなければ無効' do
      word = Word.new(meaning: "りんご", word_book: word_book)
      expect(word).not_to be_valid
    end

    it '意味がなければ無効' do
      word = Word.new(term: "apple", word_book: word_book)
      expect(word).not_to be_valid
    end
  end
end
