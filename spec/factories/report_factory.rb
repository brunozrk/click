FactoryGirl.define do
  factory :report, class: Report do
    first_entry '08:00'
    first_exit '12:00'
    second_entry '14:00'
    second_exit '18:00'
    day Date.today
    association :user, factory: :user
  end

  factory :report_without_first_exit, class: Report do
    first_entry '08:00'
    day Date.today
    association :user, factory: :user
  end

  factory :report_without_second_exit, class: Report do
    first_entry '08:00'
    first_exit '12:00'
    second_entry '14:30'
    day Date.today
    association :user, factory: :user
  end

  factory :report_without_third_exit, class: Report do
    first_entry '08:00'
    first_exit '12:00'
    second_entry '14:30'
    second_exit '18:00'
    third_entry '19:00'
    day Date.today
    association :user, factory: :user
  end

  factory :full_report, class: Report do
    first_entry '08:00'
    first_exit '12:00'
    second_entry '14:30'
    second_exit '18:00'
    third_entry '19:00'
    third_exit '21:00'
    day Date.today
    association :user, factory: :user
  end

end
