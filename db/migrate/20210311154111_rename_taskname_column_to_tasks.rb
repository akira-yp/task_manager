class RenameTasknameColumnToTasks < ActiveRecord::Migration[5.2]
  def change
    rename_column :tasks, :task_name, :title
  end
end
