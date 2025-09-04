# == Schema Information
#
# Table name: exam_answers
#
#  id          :bigint           not null, primary key
#  correct     :boolean
#  user_answer :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  exam_id     :bigint           not null
#  user_id     :bigint           not null
#  word_id     :bigint           not null
#
# Indexes
#
#  index_exam_answers_on_exam_id  (exam_id)
#  index_exam_answers_on_user_id  (user_id)
#  index_exam_answers_on_word_id  (word_id)
#
# Foreign Keys
#
#  fk_rails_...  (exam_id => exams.id)
#  fk_rails_...  (user_id => users.id)
#  fk_rails_...  (word_id => words.id)
#
class ExamAnswer < ApplicationRecord
  belongs_to :exam
  belongs_to :word

  validates :user_answer, presence: true
end
