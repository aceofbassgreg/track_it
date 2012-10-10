class ActivityGroup < ActiveRecord::Base
  attr_accessible :title
  
  has_many :activity_groups
  belongs_to :activity_group
  has_many :activities, dependent: :destroy
  
  validates :title, presence: true

  def self.all_base
    all.select {|activity_group| activity_group if activity_group.activity_group_id.nil?}
  end
end
