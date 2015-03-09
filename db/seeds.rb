# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

if Rails.env.development?
  Jot.delete_all
  User.delete_all

  50.times do
    User.create(email: Faker::Internet.email)
  end

  User.all.flat_map {|user| [user] * 10 }.shuffle.each do |user|
    user.jots.create!(content: Faker::Hacker.say_something_smart)
  end
end
