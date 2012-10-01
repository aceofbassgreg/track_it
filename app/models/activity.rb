class Activity < ActiveRecord::Base
  attr_accessible :title, :description
  
  belongs_to :user
  has_many :time_trackers, order: :id, dependent: :destroy
  
  
  validates :title, :description, presence: true
  validates :title, length: {minimum: 2, maximum: 15}
  validates :description, length: {minimum: 15, maximum: 300}
  
  def clock_in
    time_tracker = time_trackers.create! clock_in: Time.zone.now, date: Date.today
  end
  
  def clock_out
    last_time_tracker = time_trackers.last
    last_time_tracker.update_attribute :clock_out, Time.zone.now

  end
  
  def clocked_in?
    last_time_tracker = time_trackers.last
    return false if last_time_tracker.blank?
    last_time_tracker.clock_in and not last_time_tracker.clock_out
  end
  
  def clocked_out?
    last_time_tracker = time_trackers.last
    return false if last_time_tracker.nil?
    true if last_time_tracker.clock_out
  end
end
