class Task < ActiveRecord::Base
  belongs_to :activity
  
  validates :description, presence: true
  validates :description, length: {minimum: 2, maximum: 95}
  
end
