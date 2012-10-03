class RemoveDateFromTimeTrackers < ActiveRecord::Migration
  def up
    remove_column :time_trackers, :date
  end

  def down
    add_column :time_trackers, :date, :datetime
  end
end
