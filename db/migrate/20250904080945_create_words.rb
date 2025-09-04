class CreateWords < ActiveRecord::Migration[7.2]
  def change
    create_table :words do |t|
      t.string :term
      t.string :meaning
      t.references :word_book, null: false, foreign_key: true

      t.timestamps
    end
  end
end
