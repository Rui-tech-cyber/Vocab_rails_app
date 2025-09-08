# == Schema Information
#
# Table name: exam_questions
#
#  id            :bigint           not null, primary key
#  question_text :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  exam_id       :bigint           not null
#  word_id       :bigint           not null
#
# Indexes
#
#  index_exam_questions_on_exam_id  (exam_id)
#  index_exam_questions_on_word_id  (word_id)
#
# Foreign Keys
#
#  fk_rails_...  (exam_id => exams.id)
#  fk_rails_...  (word_id => words.id)
#
class ExamQuestion < ApplicationRecord
  belongs_to :word
  belongs_to :exam

  has_many :exam_answers, dependent: :destroy
end
