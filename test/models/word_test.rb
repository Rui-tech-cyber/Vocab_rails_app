# == Schema Information
#
# Table name: words
#
#  id           :bigint           not null, primary key
#  meaning      :string
#  term         :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  word_book_id :bigint           not null
#
# Indexes
#
#  index_words_on_word_book_id  (word_book_id)
#
# Foreign Keys
#
#  fk_rails_...  (word_book_id => word_books.id)
#
require "test_helper"

class WordTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
