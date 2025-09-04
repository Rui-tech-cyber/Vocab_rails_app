# == Schema Information
#
# Table name: exams
#
#  id           :bigint           not null, primary key
#  score        :integer
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
require "test_helper"

class ExamTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
