class Activity < ActiveRecord::Base
  attr_accessible :title, :description
  
  belongs_to :user
  has_many :time_trackers, order: :id, dependent: :destroy
  has_many :tasks, dependent: :destroy
  
  
  validates :title, :description, presence: true
  validates :title, length: {minimum: 2, maximum: 40}
  validates :description, length: {minimum: 10, maximum: 500}
  
  def clock_in
    time_tracker = time_trackers.create! clock_in: Time.zone.now
  end
  
  def clock_out
    last_time_tracker = time_trackers.last
    if last_time_tracker[:clock_in].to_date == Time.zone.now.to_date
      last_time_tracker.update_attribute :clock_out, Time.zone.now
    else
      last_time_tracker.update_attribute :clock_out, last_time_tracker[:clock_in].end_of_day
      add_days
    end
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
  
  def add_task!(task)
    tasks.create! description: task[:description], complete: false
    rescue ActiveRecord::RecordInvalid
    return false
  end
  
  def update_task!(task)
    task = tasks.find(task)
    task.update_attribute :complete, true
    rescue ActiveRecord::RecordNotFound
    return false
  end
  
  def incomplete_tasks
    tasks.select {|task| task if task.complete == false}.reverse
  end
  
  def complete_tasks
    tasks.select {|task| task if task.complete == true}.reverse
  end
  
  private
  
  def add_days
    array =  (((time_trackers.last.clock_in + 1.day).to_date)..(Date.today - 1.day)).to_a
    day2 = Date.today - 1.day
    array.each do |time|
      time = time.to_time
      time_trackers.create! clock_in: time, clock_out: time.end_of_day
    end
    time_trackers.create! clock_in: Time.zone.now.beginning_of_day, clock_out: Time.zone.now
  end
end

