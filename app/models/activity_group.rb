class ActivityGroup < ActiveRecord::Base
  has_many :activity_groups
  belongs_to :activity_group
  has_many :activities, dependent: :destroy

  attr_accessible :title
  
  validates :title, presence: true

  def self.all_base
    all.select {|activity_group| activity_group if activity_group.at_base?}
  end
  
  def at_base?
    activity_group_id.nil?
  end
end
