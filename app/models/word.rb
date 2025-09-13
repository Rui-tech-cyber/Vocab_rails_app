# == Schema Information
#
# Table name: words
#
#  id           :bigint           not null, primary key
#  example      :string
#  meaning      :string
#  mistake      :boolean
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
class Word < ApplicationRecord
  belongs_to :word_book

  has_many :exam_questions, dependent: :destroy
  has_many :exam_answers, dependent: :destroy

  validates :term, presence: true
  validates :meaning, presence: true

end
