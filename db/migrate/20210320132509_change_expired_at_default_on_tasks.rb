class ChangeExpiredAtDefaultOnTasks < ActiveRecord::Migration[5.2]
  def change
    change_column_default :tasks, :expired_at, from:'NOW()', to: nil
  end
end
