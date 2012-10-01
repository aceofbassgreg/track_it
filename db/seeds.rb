# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Emanuel', :city => cities.first)

class TimeTrackerSeeder
  
  # generating seeds for the current week
  
  def initialize(date = Date.today)
    Activity.delete_all
    TimeTracker.delete_all
    @date = date
  end
  
  def populate(activity_name, day = :sunday)
    Activity.create!(title: "#{activity_name}", description: 'This is just a random description for a potential activity')
    
    (@date.beginning_of_week(day)..@date.end_of_week(day)).each do |day|
      (8..rand(10..16)).each do |i|
        a = day.strftime("%Y")
        b = day.strftime("%m")
        c = day.strftime("%d")
        TimeTracker.create!(clock_in: Time.new(a,b,c,i), clock_out: Time.new(a,b,c,i,i), date: day, activity_id: Activity.all.last.id)
      end
    end
  end
  
end

seed = TimeTrackerSeeder.new

seed.populate("School")
seed.populate("Martial Arts")
seed.populate("Sports")

#bad seeds