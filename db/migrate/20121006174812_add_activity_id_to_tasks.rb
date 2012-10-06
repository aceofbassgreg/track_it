class AddActivityIdToTasks < ActiveRecord::Migration
  def change
    add_column :tasks, :activity_id, :integer
  end
end
