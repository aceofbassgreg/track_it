class CreateTimeTrackers < ActiveRecord::Migration
  def change
    create_table :time_trackers do |t|
      t.datetime :clock_in
      t.datetime :clock_out

      t.timestamps
    end
  end
end
