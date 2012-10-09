class CreateActivityGroups < ActiveRecord::Migration
  def change
    create_table :activity_groups do |t|
      t.string :title
      t.integer :user_id
      t.integer :activity_group_id

      t.timestamps
    end
  end
end
