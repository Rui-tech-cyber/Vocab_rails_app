class CreateExamAnswers < ActiveRecord::Migration[7.2]
  def change
    create_table :exam_answers do |t|
      t.references :exam, null: false, foreign_key: true
      t.references :word, null: false, foreign_key: true
      t.string :user_answer
      t.boolean :correct

      t.timestamps
    end
  end
end
