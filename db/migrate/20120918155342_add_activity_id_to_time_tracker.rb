class AddActivityIdToTimeTracker < ActiveRecord::Migration
  def change
    add_column :time_trackers, :activity_id, :integer
  end
end
