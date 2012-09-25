FactoryGirl.define do
  
  factory :activity do
    title "random title"
    description "some random description here"
  end
  
  factory :time_tracker do 
  end
  
  factory :user do
    email "test@gmail.com"
    password "1234qwer"
    password_confirmation "1234qwer"
  end
  
end