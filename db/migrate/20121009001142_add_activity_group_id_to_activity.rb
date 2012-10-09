class AddActivityGroupIdToActivity < ActiveRecord::Migration
  def change
    add_column :activities, :activity_group_id, :integer
  end
end
