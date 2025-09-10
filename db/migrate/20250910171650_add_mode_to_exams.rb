class AddModeToExams < ActiveRecord::Migration[7.2]
  def change
    add_column :exams, :mode, :integer
  end
end
