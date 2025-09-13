class CreateExams < ActiveRecord::Migration[7.2]
  def change
    create_table :exams do |t|
      t.references :user, null: false, foreign_key: true
      t.references :word_book, null: false, foreign_key: true
      t.integer :score

      t.timestamps
    end
  end
end
