class AddTitleToExams < ActiveRecord::Migration[7.2]
  def change
    add_column :exams, :title, :string
  end
end
