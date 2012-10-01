FactoryGirl.define do
  
  factory :activity do
    title "random title"
    description "some random description here"
    user_id 1
  end
  
  factory :time_tracker do 
    clock_in                  Time.now
    clock_out                 Time.now
    activity_id               1
    date                      Date.today
  end
  
  factory :user do
    sequence(:email) {|n| "foo#{n}@example.com"}
    password "secret"
    password_confirmation "secret"
  end
  
end