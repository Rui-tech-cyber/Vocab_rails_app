class CreateExamQuestions < ActiveRecord::Migration[7.2]
  def change
    create_table :exam_questions do |t|
      t.references :word, null: false, foreign_key: true
      t.references :exam, null: false, foreign_key: true
      t.string :question_text

      t.timestamps
    end
  end
end
