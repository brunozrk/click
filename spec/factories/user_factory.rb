FactoryGirl.define do
  factory :user, class: User do
    first_name 'James'
    last_name 'Bond'
    email 'james@bond.com'
    password '12345678'
  end
end
