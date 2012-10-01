class AddDateToTimeTracker < ActiveRecord::Migration
  def change
    add_column :time_trackers, :date, :date

  end
end
