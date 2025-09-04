class ChengeUserIdOnExamAnswers < ActiveRecord::Migration[7.2]
  def change
    change_column_null :exam_answers, :user_id, false
  end
end
