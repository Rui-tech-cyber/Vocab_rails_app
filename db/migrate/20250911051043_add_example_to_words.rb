class AddExampleToWords < ActiveRecord::Migration[7.2]
  def change
    add_column :words, :example, :string
  end
end
