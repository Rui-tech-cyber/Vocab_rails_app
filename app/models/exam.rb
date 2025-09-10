# == Schema Information
#
# Table name: exams
#
#  id           :bigint           not null, primary key
#  mode         :integer
#  score        :integer
#  title        :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  user_id      :bigint           not null
#  word_book_id :bigint           not null
#
# Indexes
#
#  index_exams_on_user_id       (user_id)
#  index_exams_on_word_book_id  (word_book_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#  fk_rails_...  (word_book_id => word_books.id)
#
class Exam < ApplicationRecord
  enum mode: { en_to_jp: 0, jp_to_en: 1 }
  
  belongs_to :user
  belongs_to :word_book

  has_many :exam_questions, dependent: :destroy
  has_many :exam_answers, dependent: :destroy

end
