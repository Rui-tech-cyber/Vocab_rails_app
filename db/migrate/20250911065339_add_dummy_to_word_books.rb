class AddDummyToWordBooks < ActiveRecord::Migration[7.2]
  def change
    add_column :word_books, :dummy, :boolean, default: false, null: false
  end
end
