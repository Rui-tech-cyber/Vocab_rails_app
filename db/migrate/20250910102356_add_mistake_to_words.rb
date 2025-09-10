class AddMistakeToWords < ActiveRecord::Migration[7.2]
  def change
    add_column :words, :mistake, :boolean
  end
end
