class Activity < ActiveRecord::Base
  attr_accessible :title, :description
  
  belongs_to :user
  has_many :time_trackers, dependent: :destroy
  
  
  validates :title, :description, presence: true
  validates :title, length: {minimum: 2, maximum: 15}
  validates :description, length: {minimum: 15, maximum: 300}
end
