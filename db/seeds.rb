puts 'Creating user...'
user = User.create! first_name: 'Bruce', last_name: 'Wayne',
                    email: 'brunce@wayne.com', password: '12345678'
puts "User created successfully: #{user.email} / 12345678"

puts 'Creating reports...'
60.times do |index|
  Report.create! first_entry: '08:00', first_exit: '12:00',
                 second_entry: '14:00', second_exit: '18:00',
                 remote: '00:00', day: Date.today + index - 60,
                 user: user
end
puts 'Reports created successfully'
